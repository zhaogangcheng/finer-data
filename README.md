# finer-data

## Introduction

This repository contains a corpus of Finnish technology related news
articles with a manually prepared named entity annotation. The text
material was extracted from the archives of Digitoday, a Finnish
online technology news source (www.digitoday.fi). The corpus consists
of 953 articles (193,742 word tokens) with six named entity classes
(organization, location, person, product, event, and date). The corpus
is available for research purposes and can be readily used for
development of NER systems for Finnish.

In addition, the repository contains the Digitoday (in-domain) and
Wikipedia (out-of-domain) evaluation sets employed in the article

"A Finnish News Corpus for Named Entity Recognition"

along with the system predictions.

## Experiments

The directory experiments contains the predictions of systems FiNER, Gungor-NN, and Sohrab-NN in the paper "A Finnish News Corpus for Named Entity Recognition" on the Digitoday and Wikipedia test sets.

FiNER:

```
urn.fi/urn:nbn:fi:lb-2018091301
```

Gungor-NN:

```
@InProceedings{C18-1177,
  author = 	"Gungor, Onur
		and Uskudarli, Suzan
		and Gungor, Tunga",
  title = 	"Improving Named Entity Recognition by Jointly Learning to Disambiguate Morphological Tags",
  booktitle = 	"Proceedings of the 27th International Conference on Computational Linguistics",
  year = 	"2018",
  publisher = 	"Association for Computational Linguistics",
  pages = 	"2082--2092",
  location = 	"Santa Fe, New Mexico, USA",
  url = 	"http://aclweb.org/anthology/C18-1177"
}
```

Sohrab-NN:

``` 
@InProceedings{D18-1309,
  author = 	"Sohrab, Mohammad Golam
		and Miwa, Makoto",
  title = 	"Deep Exhaustive Model for Nested Named Entity Recognition",
  booktitle = 	"Proceedings of the 2018 Conference on Empirical Methods in Natural Language Processing",
  year = 	"2018",
  publisher = 	"Association for Computational Linguistics",
  pages = 	"2843--2849",
  location = 	"Brussels, Belgium",
  url = 	"http://aclweb.org/anthology/D18-1309"
}
```

## License 

[CC BY-ND-NC 1.0](https://creativecommons.org/licenses/by-nd-nc/1.0/fi/legalcode)
