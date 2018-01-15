#!/bin/sh
FROM pytorch/pytorch:latest


RUN apt-get update && apt-get install -y \
	cmake \
	git \
	python \
	python3 \
	vim \
	nano \
	python-dev \
	python-pip \
	python-pygraphviz \
	xml-twig-tools \
	wget \
	sed\
	curl

RUN pip install --upgrade pip

RUN pip install numpy numexpr cython theano tables bottle bottle-log tornado cffi librosa Pillow pyrouge six tqdm torchtext>=0.2.1 future 

RUN mkdir -p /path/to
WORKDIR /path/to/

# Install mosesdecoder
RUN git clone https://github.com/moses-smt/mosesdecoder

# Install openNMT
RUN git clone https://github.com/OpenNMT/OpenNMT-py.git
WORKDIR /root/OpenNMT

RUN `curl -o ~/OpenNMT/demo-model2_acc_55.34_ppl_8.89_e13.pt  http://download1041.mediafire.com/nnazs6ca5vxg/1nirpipcxdvyi9h/demo-model2_acc_55.34_ppl_8.89_e13.pt`
RUN wget -O ~/OpenNMT/translate.py http://download1475.mediafire.com/apdrrl2idjrg/qa5egr2mvjd7vwm/translate.py


RUN wget -O ~/OpenNMT/translate.sh http://download1084.mediafire.com/p7m12cyr968g/kf2qt73d6x6u1b7/run_translate.sh

RUN chmod a+x ~/OpenNMT/translate.sh

RUN mkdir /data
RUN mkdir /output

CMD ["./translate.sh"]

