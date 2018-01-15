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

RUN wget -O ~/OpenNMT/translate.sh https://gist.githubusercontent.com/Khakhulin/2109cf96401a53fc6bed6256b4a57da8/raw/0fd0375491512dabcef99f32cf6168aa2eec8408/translate.sh
RUN chmod a+x ~/OpenNMT/translate.sh

RUN mkdir /data
RUN mkdir /output

CMD ["./translate.sh"]
