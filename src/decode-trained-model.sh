#!/bin/bash
### for XSede comet cluster (slurm) ###
### submit sbatch ---ignore-pbs *.sh
#SBATCH --export=ALL
#SBATCH --nodes=1
#SBATCH --job-name=decode
#SBATCH --output=./log_decode/%j-decoder

eval_dir=/project/ocean/tsriniva/Flickr8k-Audio/emnlp_experiments/eval_scripts/

folder_path = /project/ocean/tsriniva/MultimodalASR/                # CHANGE TO YOUR OWN PATH!

feats_type=object

### SET model_name ACCORDING TO WHICHEVER MODLE YOU WANT TO USE
# model_name=asr
# model_name=mag
model_name=maop

model_path=${folder_path}/src/conf/${model_name}
multimodal=true                                                     # Set to true if we're using multimodal ASR (i.e. mag/maop) else false

### SET data_type ACCORDING TO THE TRAINING DATA OF THE MODEL YOU WANT TO TEST
# data_type=clean
data_type=randommask_augment


### SET decode_split to false if you are decoding the test split mentioned in the conf file of the trained model, to true otherwise
decode_split=true
# decode_split=false

### USE THIS IF YOU WANT TO DECODE A MODEL YOU'VE TRAINED YOURSELF, ELSE UNCOMMENT THE SECOND-LAST LINE
ckpt_dir=${folder_path}/src/conf/exp/asr-${data_type}/${model_name}-${data_type}
ckpt=$(find ${ckpt_dir} | grep best.wer.ckpt)
ckpt=$(readlink -f ${ckpt})
#ckpt=${folder_path}/models/flickr_trained_models/traindata_${data_type}/${model_name}.ckpt
echo ${ckpt}

data_dir=${folder_path}/data

### ACTIVATE NMTPY ENVIRONMENT
source /home/tsriniva/anaconda2/bin/activate nmtpy

if [ "$decode_split" = true ]; then

    for split in dev test
    do
        mkdir ${folder_path}/outputs_${split}

        for dataset in ${split}_silence_nouns ${split}_silence_verbs ${split}_silence_places ${split}_silence_adjectives ${split}_silence_colors ${split}_silence_adverbs ${split}_silence_cardinals 
        #for dataset in ${split}_randommask_clean ${split}_randommask_20perc ${split}_randommask_40perc ${split}_randommask_60perc
        do
            speech_dir = ${data_dir}/fbank_feats/data/${dataset}

            if [ "$multimodal" = true]; then
                #feats_path=/project/ocean/tsriniva/Flickr8k-Audio/data/images/object_feats/${split}-resnet50-avgpool-r224-c224.npy     # UNCOMMENT IF model_name=mag
                feats_path=/project/ocean/tsriniva/Flickr8k-Audio/data/images/bounding_boxes/${split}_bboxes.txt                        # UNCOMMENT IF model_name=maop
            fi

            if [ "$multimodal" = true ]; then
                src=en_speech:${speech_dir},feats:${feats_path}
            else
                src=en_speech:${speech_dir}
            fi

            if [ "$split" = dev ]; then
                conf_split=val
            else
                conf_split=$split
            fi
            nmtpy translate ${ckpt} -s ${conf_split} -S ${src} -k 5 -o ${folder_path}/${outputs_prefix}_${split}/${model_name}-${data_type}-${dataset}.out

        done
    done
else
    for split in dev test
    do
        mkdir ${folder_path}/outputs_${split}

        if [ "$split" = dev ]; then
            conf_split=val
        else
            conf_split=$split
        fi
        nmtpy translate ${ckpt} -s ${conf_split} -k 5 -o ${folder_path}/outputs_${split}/${model_name}-${data_type}.out 
   done 
fi
