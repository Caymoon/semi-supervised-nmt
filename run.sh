#!/bin/bash

mkdir ~/data
cd /workspace/OpenNMT-py

# Preprocessing
python ~/split_parallel_corpus.py

head -n 20 ~/data/source.train.txt > ~/data/source.valid.txt
head -n 20 ~/data/target.train.txt > ~/data/target.valid.txt

cp /data/input.txt ~/data/source.test.txt
cp /data/corpus1.txt ~/data/source.mono.txt
head -n 50000 /data/corpus2.txt > ~/data/target.mono.txt

# Forward Translation
python preprocess.py -train_src ~/data/source.train.txt -train_tgt ~/data/target.train.txt -valid_src ~/data/source.valid.txt -valid_tgt ~/data/target.valid.txt -save_data ~/data/demo

python train.py -data ~/data/demo -save_model ~/demo-model -epochs 13 -batch_size=64 -gpuid 0

NEWEST_MODEL=$(ls -Ct ~ | awk '{print $1}' | head -n1)
python translate.py -model ~/$NEWEST_MODEL -src ~/data/source.mono.txt -output ~/data/target.backtranslated.txt -replace_unk -verbose -gpu 0

# Augmenting the parallel corpus
cat ~/data/source.mono.txt >> ~/data/source.train.txt
cat ~/data/target.backtranslated.txt >> ~/data/target.train.txt

# Backward Translation
python preprocess.py -train_src ~/data/source.train.txt -train_tgt ~/data/target.train.txt -valid_src ~/data/source.valid.txt -valid_tgt ~/data/target.valid.txt -save_data ~/data/demo

python train.py -data ~/data/demo -save_model ~/demo-model -epochs 13 -batch_size=64 -gpuid 0

NEWEST_MODEL=$(ls -Ct ~ | awk '{print $1}' | head -n1)
python translate.py -model ~/$NEWEST_MODEL -src ~/data/source.test.txt -output /output/output.txt -replace_unk -verbose -gpu 0
