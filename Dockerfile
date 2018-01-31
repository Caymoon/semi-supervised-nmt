FROM tensorflow/tensorflow

RUN apt-get update && apt-get install git wget -y

RUN git clone https://github.com/saparina/language-style-transfer.git
RUN wget https://raw.githubusercontent.com/saparina/babel/master/babel-train.sh?token=AVTxeFN29PgCAEqg8HId0DE-KzHajt_Iks5aeu8DwA%3D%3D -O babel-train.sh && chmod +x babel-train.sh
RUN pip install nltk
RUN wget https://raw.githubusercontent.com/saparina/babel/master/divide.py?token=AVTxeO7gSeW22PfKWqWaMyZwtKz-hw-hks5aevPGwA%3D%3D -O divide.py && chmod +x divide.py
RUN mv divide.py /notebooks/data/divide.py
