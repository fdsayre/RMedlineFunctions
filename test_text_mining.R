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
