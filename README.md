# MultimodalASR
Conf files and scripts for training and decoding ASR models described in Findings of EMNLP 2020 paper: [Fine-Grained Grounding for Multimodal Speech Recognition](https://arxiv.org/abs/2010.02384)

## Setup

### Installation

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

## Testing ASR models
