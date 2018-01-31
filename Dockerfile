FROM tensorflow/tensorflow:1.4.1-gpu

RUN apt-get update && apt-get install git wget -y

RUN git clone https://github.com/saparina/language-style-transfer.git
RUN wget https://gist.github.com/strawberrypie/9b6093c99161d5f59dc0424360ae83dd/raw -O babel-train.sh && chmod +x babel-train.sh
RUN pip install nltk
