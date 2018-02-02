#!/bin/bash

mkdir ~/data
cd /workspace/OpenNMT-py

# Preprocessing
python ~/split_parallel_corpus.py

#Embeddings
python ~/embeddings.py
cat ~/data/src_vectors >> ~/data/all_vectors

head -n 20 ~/data/source.train.txt > ~/data/source.valid.txt
head -n 20 ~/data/target.train.txt > ~/data/target.valid.txt

cp /data/input.txt ~/data/source.test.txt
cp /data/corpus1.txt ~/data/source.mono.txt
head -n 50000 /data/corpus2.txt > ~/data/target.mono.txt

# Forward Translation
python preprocess.py -train_src ~/data/target.train.txt -train_tgt ~/data/source.train.txt -valid_src ~/data/target.valid.txt -valid_tgt ~/data/source.valid.txt -save_data ~/data/demo_tr

python tools/embeddings_to_torch.py -emb_file ~/data/all_vectors -dict_file ~/data/demo_tr.vocab.pt -output_file ~/data/embeddings

python train.py -data ~/data/demo_tr  -save_model ~/demo-model -epochs 50 -batch_size=64 -gpuid 0 -word_vec_size 300 -encoder_type brnn -pre_word_vecs_enc ~/data/embeddings.enc.pt -global_attention mlp -optim adam

NEWEST_MODEL=$(ls -Ct ~ | awk '{print $1}' | head -n1)
python translate.py -model ~/$NEWEST_MODEL -src ~/data/target.mono.txt -output ~/data/source.backtranslated.txt -replace_unk -verbose -gpu 0

rm -rf ~/data/demo_tr*
rm -rf ~/demo-model*
rm ~/data/embeddings*

# Augmenting the parallel corpus
cat ~/data/source.backtranslated.txt >> ~/data/source.train.txt
cat ~/data/target.mono.txt >> ~/data/target.train.txt
# Backward Translation
python preprocess.py -train_src ~/data/source.train.txt -train_tgt ~/data/target.train.txt -valid_src ~/data/source.valid.txt -valid_tgt ~/data/target.valid.txt -save_data ~/data/demo

python tools/embeddings_to_torch.py -emb_file ~/data/all_vectors -dict_file ~/data/demo.vocab.pt -output_file ~/data/embeddings

python train.py -data ~/data/demo -save_model ~/model  -epochs 50 -batch_size=64 -gpuid 0 -word_vec_size 300 -encoder_type brnn -pre_word_vecs_enc ~/data/embeddings.enc.pt -global_attention mlp -optim adam

NEWEST_MODEL=$(ls -Ct ~ | awk '{print $1}' | head -n1)
python translate.py -model ~/$NEWEST_MODEL -src ~/data/source.test.txt -output /output/output.txt -replace_unk -verbose -gpu 0




