#!/bin/sh

# suffix of source language
SRC=en

# suffix of target language
TRG=de

# Path to moses decoder: https://github.com/moses-smt/mosesdecoder
mosesdecoder=/path/to/mosesdecoder

# preprocess
cat /data/input.txt | \
$mosesdecoder/scripts/tokenizer/normalize-punctuation.perl -l $SRC | \
$mosesdecoder/scripts/tokenizer/tokenizer.perl -l $SRC -penn | \
$mosesdecoder/scripts/recaser/truecase.perl -model ~/OpenNMT/truecase-model.$SRC >  /data/input.txt.moses

# translate
cd ~/OpenNMT
th translate.lua -model ./onmt_baseline_wmt15-all.en-de_epoch13_7.19_release.t7  -src /data/input.txt.moses -output /output/output.txt.moses -batch_size 64

# postprocess
cat /output/output.txt.moses | \
sed 's/\@\@ //g' | \
$mosesdecoder/scripts/recaser/detruecase.perl | \
$mosesdecoder/scripts/tokenizer/detokenizer.perl -l $TRG > /output/output.txt
