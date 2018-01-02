# Librarian Example Analysis 

# load libraries ------

source("RMedlineFunctions.R")
library(RISmed)
library(ggplot2)
library(dplyr)


# set out query, can be anything you would search in pubmed.gov's simple search. 

query = 'librarian[ti]'


# get the basic article metadata from that data

librarian <- RetrieveArticleData(query,2000,2016,30000)
librarian_meta <- RetrieveArticleMetadata(librarian)

# get most article metadata from that data

librarian_most_meta <- RetrieveMostArticleMetadata(librarian)

# graphing pubs per year (meta data file)

ArticlesFreqYear(librarian_meta)

# Look at Pubmed Status by year (base data file)

PMStatusByYearPlot(librarian)

# Journal Titles (base data file)

librarian_journals <- JournalTitlesFreq(librarian_most_meta$Journal)


# Graph Top 5 Journal Titles Freq Graph (meta data file with Journal variable selected)

JournalTitlesTop5Graph(librarian_most_meta)

librarian_j_freq_graph
