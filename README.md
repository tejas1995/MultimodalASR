# MultimodalASR
Conf files and scripts for training and decoding ASR models described in Findings of EMNLP 2020 paper: [Fine-Grained Grounding for Multimodal Speech Recognition](https://arxiv.org/abs/2010.02384)

## Setup

### Installation

Clone this fork of the [nmtpytorch](https://github.com/tejas1995/nmtpytorch) repo, and create a new conda environment using the following command:
```
conda env create -f environment.yml
```

This will create an environment called `nmtpy`, which you need to activate before training ASR models and decoding using them.

### Downloading Data

Download the following data files into the `data` directory and extract them:

```
# Audio features (fbanks)
wget http://islpc21.is.cs.cmu.edu/ramons/fbank_feats.tar.gz ; tar -xzf fbank_feats.tar.gz ; rm fbank_feats.tar.gz

# Visual features (global + object proposals)
wget http://islpc21.is.cs.cmu.edu/ramons/visual_feats.tar.gz ; tar -xzf visual_feats.tar.gz ; rm visual_feats.tar.gz

# Text files
wget http://islpc21.is.cs.cmu.edu/ramons/text_files.tar.gz ; tar -xzf text_files.tar.gz ; rm text_files.tar.gz

# Model checkpoints
wget http://islpc21.is.cs.cmu.edu/ramons/models.tar.gz ; tar -xzf models.tar.gz ; rm models.tar.gz
```

## Training ASR models

Within each folder in `src/conf`, there are config files for training unimodal (`asr`) and multimodal (`mag, maop`) ASR models. For each model, there is one config file for training a model on clean speech, and one on RandWordMask augmented speech. To train a particular model on a particular type of speech input, you need to modify the `data_path` option in the corresponding config file to `<project_dir>/data`. You can then train a model using the command: 
```
nmtpy train -C <conf_file>
```

## Testing ASR models

To decode a trained ASR model, you need to set certain arguments as instructed in `src/decode_trained_model.sh` and run it.
