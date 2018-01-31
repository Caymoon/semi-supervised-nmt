p = open('parallel_corpus.txt','r')
corp0 = open('train_src.txt','w')
corp1 = open('train_tgt.txt','w')

for line in p:
    corp0.write(line.split('\t')[0].strip() + '\n')
    corp1.write(line.split('\t')[1].strip() + '\n')
