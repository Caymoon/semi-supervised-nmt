FROM tensorflow/tensorflow

RUN apt-get update && apt-get install git wget -y

RUN git clone https://github.com/saparina/language-style-transfer.git
RUN wget https://raw.githubusercontent.com/saparina/babel/master/babel-train.sh?token=AVTxeDqA3sGdIn3Li_bSSPSDYMNzr-t4ks5aevtcwA%3D%3D -O babel-train.sh && chmod +x babel-train.sh
RUN pip install nltk
RUN wget https://raw.githubusercontent.com/saparina/babel/master/divide.py?token=AVTxeHGlYiO-PBfSPD91H_YAYWG9NTFPks5aevt0wA%3D%3D -O divide.py && chmod +x divide.py
