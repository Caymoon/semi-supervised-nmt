FROM opennmt/opennmt:latest

RUN sudo apt-get update && \
sudo apt-get install -y wget git sed 

RUN mkdir -p /path/to
WORKDIR /path/to/

# Install mosesdecoder
RUN git clone https://github.com/moses-smt/mosesdecoder

# Install openNMT
RUN git clone https://github.com/OpenNMT/OpenNMT /root/OpenNMT
WORKDIR /root/OpenNMT

RUN curl -o ~/OpenNMT/onmt_baseline_wmt15-all.en-de_epoch13_7.19_release.t7  https://s3.amazonaws.com/opennmt-models/onmt_baseline_wmt15-all.en-de_epoch13_7.19_release.t7
RUN wget -O ~/OpenNMT/truecase-model.en http://data.statmt.org/rsennrich/wmt16_systems/en-de/truecase-model.en

RUN wget -O ~/OpenNMT/translate.sh https://raw.githubusercontent.com/saparina/babel/master/translate.sh?token=AVTxeCa_Ayo26JJtDHdyY_Knqd6px1Q8ks5aZhYLwA%3D%3D
RUN chmod a+x ~/OpenNMT/translate.sh

RUN mkdir /data
RUN mkdir /output

CMD ["./translate.sh"]
