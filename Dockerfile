FROM strawberrypie/pytorch-cuda8:v0.3 

RUN git clone https://github.com/OpenNMT/OpenNMT-py.git && cd OpenNMT-py && pip install -r requirements.txt && python setup.py install
RUN curl -s -L https://gist.githubusercontent.com/saparina/4ff9fa105f69705627e9a7f134c58654/raw/ec7513cc2b10ea3c713e971ac29cd65313f4a9eb/embeddings.py -o ~/embeddings.py && chmod +x ~/embeddings.py 
RUN curl -s -L https://raw.githubusercontent.com/saparina/fafel2_embed_more/master/run.sh?token=AVTxeMCOfI8F_nQeRHBeNMXW7fMHMY_-ks5affUuwA%3D%3D -o ~/run.sh && chmod +x ~/run.sh
RUN curl -s -L https://gist.github.com/strawberrypie/ba1f630f17d59f71862417565ceaa6f8/raw -o ~/split_parallel_corpus.py && chmod +x ~/split_parallel_corpus.py
RUN pip install gensim nltk
RUN python -m nltk.downloader punkt
