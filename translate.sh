pip install ipdb

WORK_DIR="/notebooks"
cd $WORK_DIR

mkdir tmp
mkdir data

cd /data/
python divide.py
cd $WORK_DIR

# Preprocessing
cp /data/corpus1.txt $WORK_DIR/data/corpus.train.0
cp /data/corpus2.txt $WORK_DIR/data/corpus.train.1
cp /data/train_src.txt $WORK_DIR/data/corpus.test.0
cp /data/train_tgt.txt $WORK_DIR/data/corpus.test.1
cp /data/input.txt $WORK_DIR/data/corpus.test

cd $WORK_DIR/language-style-transfer/code

# Training
python2 style_transfer.py --train $WORK_DIR/data/corpus.train --vocab $WORK_DIR/tmp/corpus.vocab --model $WORK_DIR/tmp/model --batch_size 32 --max_epochs 1

# Inference
python2 style_transfer.py --test $WORK_DIR/data/corpus.test --output $WORK_DIR/tmp/sentiment.test --vocab $WORK_DIR/tmp/corpus.vocab --model $WORK_DIR/tmp/model --batch_size 32
