
Sys.setenv(TAR = "/bin/tar")
devtools::install_github("sillasgonzaga/lexiconPT")
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
summary(escrava_isaura)

# construindo um único dataset
df <- bind_rows(alienista, escrava_isaura)

# ajustar dataset para agrupar por livro e formatar o dtaframe para que só tenha linha por livro
df_corpus <- df %>% group_by(book_name) %>% summarise(text = paste0(text, sep = "", collapse = ". "))

dim(df_corpus)

# criando corpus
corpus <- quanteda::corpus(df_corpus$text, docnames= df_corpus$book_name)

summary(corpus)

# criando DTF
corpus_dfm <- dfm(corpus, remove_punct = TRUE, remove = quanteda::stopwords("portuguese"), groups = df_corpus$book_name)

# analisando as palavras mais comuns no geral por livro
dfm_sort(corpus_dfm)

## ocorrencias da palavra viagem
dfm_select(corpus_dfm, "viagem")

## para saber o contexto em que essa palavra aparece 
kwic(corpus, "viagem") %>% head()

## para saber as palavras mais usadas 
topfeatures(corpus_dfm, groups = df_corpus$book_name)

## verificar a similaridade entre os documentos
corpus_simil <- textstat_simil(corpus_dfm, method = "correlation", margin ="documents")

 round(corpus_simil, 3)
 
 ## veridicar a distancia (euclidiana)
 corpus_dist <- textstat_dist(corpus_dfm, method = "euclidean",margin ="documents")
 
 round(corpus_dist, 3)
 
 
 
 


