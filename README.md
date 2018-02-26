# Solution for DeepHach.Babel

## Main task

The main goal of hackathon was **semi-supervised Machine Translation**: Machine Translation which makes use not only from (often scarce) parallel data, but also from (potentially unlimited) untranslated texts in source and target languages. 

## Datasets

Participants had one language pair for testing (Russian-English), one secret pair for scoring in first days of school and another secret pair for final scores. 

All datasets had same structure:
- 50k parallel sentences
- 1M non-parallel sentences in two languages

## Our solution

Our best solution used backtranslation and FastText embeddings. We also tried different approaches, but unsupervised NMT required more memory and more time that we had. Full description are available in poster file.

We had to use docker for competition, that's why our solution was designed as set of scripts from this repository and Gist.

## See more

More information about hackathon: [official site](http://babel.tilda.ws/) 

