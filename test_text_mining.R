# text mining and analysis testing


# topic analysis ---- 

library(topicmodels)

# get abstracts into character strings in df
Abstracts <- as.data.frame(AbstractText(data))
Abstracts <- data.frame(lapply(Abstracts, as.character), stringsAsFactors=FALSE)



library(tidytext)
Abstract_Tokens <- Abstracts %>%
  unnest_tokens(word, AbstractText.data.)

Abstract_Tokens <- unnest_tokens(Abstracts, word, AbstractText.data.)

lda <- LDA(Abstract_Tokens, k = 2, control = list(seed = 1234))

# from https://rpubs.com/jflowers/235239

library(dplyr)
library(RISmed)
if(!require(wordcloud))install.packages("wordcloud")
library(wordcloud)
library(tidytext)
library(tidyr)
library(ggplot2)
if(!require(tm))install.packages("tm")
library(tm)
if(!require(topicmodels))install.packages("topicmodels")
library(topicmodels)
if(!require(viridis))install.packages("viridis")
suppressPackageStartupMessages(library(viridis))


abstracts2 <- data.frame(title = ArticleTitle(data),                        abstract = AbstractText(data), 
                        journal = Title(data),
                        pmid = PMID(data), 
                        year = YearPubmed(data))


abstracts2 <- abstracts2 %>% mutate(abstract = as.character(abstract))

word_freq <- abstracts2 %>%
  unnest_tokens(word, abstract) %>%
  anti_join(stop_words) %>%
  count(vars = "word") 
# all above works

word_freq %>%
  with(wordcloud(word, n, min.freq = 10, max.words = 1000, colors = brewer.pal(8, "Dark2")), scale = c(8,.3), per.rot = 0.4)

word_freq %>%
  with

word_freq %>%
  with(wordcloud(bigram, n, max.words = 1000, random.order = FALSE, colors = brewer.pal(9, "Set1"), scale = c(8, 0.3)), per.rot = 0.4)


# new turorial

set.seed(1234)
badidea <- wordcloud(words = word_freq$word, freq = word_freq$freq, min.freq = 10, max.words=100, random.order=FALSE, scale = c(8,.3), per.rot = 0.4, colors=brewer.pal(8, "Dark2"))

warnings()
