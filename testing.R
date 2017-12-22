# This file is for testing Medline Functions from the file RMedlineFunctions.R

# load libraries ------

source("RMedlineFunctions.R")
library(RISmed)
library(ggplot2)
library(dplyr)
library(RSQLite)

# Get initial metadata for a query x ---

x = 'reproducibility[ti]'
data <- RetrieveArticleData(x,2010,2016,4000)
data_meta <- RetrieveArticleMetadata(data)

# ArticlesFreqYear

ArticlesFreqYear(data_meta)



# PMStatusByYearPlot -------
# Working

PMStatusByYearPlot(data)

# publication type
# need to turn this into a usable function
# graph and export datafile

PubType <- PublicationType(data)

# JournalTitles

jtitles <- JournalTitles(data)

# Get MeSH NOT WORKING YET

LibrarianMeSH <- Mesh(librarian)
LibrarianMeSH <- as.data.frame(LibrarianMeSH)

require(reshape2)
LibrarianMeSH <- rownames(LibrarianMeSH) 
melt(LibrarianMeSH)



# resources used ------
# https://www.r-bloggers.com/how-to-search-pubmed-with-rismed-package-in-r/
# https://datascienceplus.com/search-pubmed-with-rismed/
# https://amunategui.github.io/pubmed-query/

# Junk playing around area -----

res <- EUtilsSummary("myasthenia gravis", type="esearch", db="pubmed", datetype='pdat', mindate=1990, maxdate=2017, retmax=4000)

QueryCount(res)        

# Get full data

rawdate<-ArticleTitle(EUtilsGet(res))

year <- YearPubmed(EUtilsGet(res))

auths<-Author(EUtilsGet(res))


# plot number of articles in each year

date()
count<-table(year)
count<-as.data.frame(count)
names(count)<-c("Year", "Counts")

ggplot(count, aes(x = year, y = Freq)) +
  geom_bar(stat = "identity")



# Okay, go back and do basic retrieval based on https://amunategui.github.io/pubmed-query/
# This works

search_topic <- 'myasthenia gravis'

search_query <- EUtilsSummary(search_topic, retmax=2500, mindate=1990, maxdate=2016)

search_query_small <- EUtilsSummary(search_topic, retmax=100, mindate=1990, maxdate=2016)

summary(search_query)

QueryId(search_query)

records<- EUtilsGet(search_query)

records_small<- EUtilsGet(search_query_small)

class(records)

str(records)

pubmed_data <- data.frame('Title'=ArticleTitle(records),'Abstract'=AbstractText(records),"Year"=YearPubmed(records),'Cited'=Cited(records))


pubmed_data_small <- data.frame('Title'=ArticleTitle(records_small),'Abstract'=AbstractText(records_small),"Year"=YearPubmed(records_small),'Cited'=Cited(records_small))

# visulize pubmed_data

ggplot(pubmed_data, aes(x = Year, y = Cited)) +
  geom_bar(stat = "identity")

pubmed_data %>%
  group_by(Year) %>%
  summarise(sum(Cited)) 
ggplot(pubmed_data, aes(x = Year, y = Cited)) +
  geom_bar(stat = "identity")

