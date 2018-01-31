FROM tensorflow/tensorflow

RUN apt-get update && apt-get install git wget -y

RUN git clone https://github.com/saparina/language-style-transfer.git
RUN wget https://raw.githubusercontent.com/saparina/babel/master/babel-train.sh?token=AVTxeFN29PgCAEqg8HId0DE-KzHajt_Iks5aeu8DwA%3D%3D -O babel-train.sh && chmod +x babel-train.sh
RUN pip install nltk
RUN wget https://raw.githubusercontent.com/saparina/babel/master/divide.py?token=AVTxeJZXBSHe0b5010clFZ_udvmbvZx0ks5aeu6mwA%3D%3D -b divide.py -O /data/divide.py && chmod +x /data/divide.py
