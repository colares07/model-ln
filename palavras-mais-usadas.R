Sys.setenv(TAR = "/bin/tar")
devtools::install_github("sillasgonzaga/literaturaBR")

# libs 
library(literaturaBR)
library(quanteda)
library(tidyverse)

# configuracao
quanteda_options(print_dfm_max_ndoc =50L)

# carregar dados 
data("alienista")
data("escrava_isaura")

summary(alienista)

# analise basica - criando corpus
df_corpus <- alienista %>% summarise(text = paste0(text, sep = "", collapse= ". "))
corpus <- quanteda::corpus(df_corpus)
summary(corpus)

# FM - matriz frequencia documentos
corpus_dfm <- dfm(corpus, remove_punct = TRUE, remove=quanteda::stopwords("portuguese"))

# vetificar as palavras mais utilizadas no texto
dfm_sort(corpus_dfm)