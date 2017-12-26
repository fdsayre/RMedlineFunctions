# This file is for testing various Functions from the file RMedlineFunctions.R
# This is not meant to be a tutorial. A future tutorial file will be created. 

# load libraries ------

source("RMedlineFunctions.R")
library(RISmed)
library(ggplot2)
library(dplyr)

# Get initial medline data for a query ---
# set of fields you can use for a search 
# http://libguides.utoledo.edu/searchingpubmed/tags

query = 'librarian[ti]'
libraryiandata <- RetrieveArticleData(query,2005,2016,10000)
librariandata_meta <- RetrieveMostArticleMetadata(libraryiandata)

# leys try getting pubmed commons comments

x = 'has_user_comments[Filter]'
data <- RetrieveArticleData(x,2010,2016,4000)
data_meta <- RetrieveArticleMetadata(data)


# TESTING: ArticlesFreqYear-----

ArticlesFreqYear(librariandata_meta)


# PMStatusByYearPlot -------

PMStatusByYearPlot(libraryiandata)

# publication type
# need to turn this into a usable function
# graph and export datafile

PubType <- PublicationType(libraryiandata)
PubType <- as.table(PubType)

# Article ID

ID <- ArticleId(libraryiandata)
str(ID)
ID-table <- as.table(ID) #NOPE

# JournalTitles

jtitles <- JournalTitles(data)

# try to get a count of journal titles and then graph it

Jtitles <- ISOAbbreviation(libraryiandata)
Jtitles <- as.data.frame(Jtitles)
jtitlesfreq <- count(jtitles, vars=Jtitles)

# better
sysrev_journals <- count(sysrev_merged, vars=Journal)

ggplot(sysrev_journals, aes(x = vars, y = n)) +
  geom_tufteboxplot()

# Do something with citation data

ggplot(librariandata_meta, aes(x = Year, y = Cited)) +
  geom_point()

ggplot(librariandata_meta, aes(x = Year, y = Cited)) +
  geom_jitter()

ggplot(librariandata_meta, aes(x = Year, y = Cited)) +
  geom_count()

ggplot(librariandata_meta, aes(x = Year, y = Cited, group_by(Year))) +
  geom_tufteboxplot()

librariandata_meta$avgcited <-

# Get MeSH NOT WORKING YET

LibrarianMeSH <- Mesh(data)
LibrarianMeSH <- as.data.frame(LibrarianMeSH)

df <- as.data.frame.list(LibrarianMeSH, row.names = NULL)

# other way noy work
require(reshape2)
LibrarianMeSH <- rownames(LibrarianMeSH) 
melt(LibrarianMeSH)

# do something with authors ------

# get authors list in flat format

# get authors - later need to integrate this into article metadata function
authors <- Author(data)

LastFirst<-sapply(authors, function(x)paste(x$LastName,x$ForeName))
auths<-as.data.frame(sort(table(unlist(LastFirst)), dec=TRUE))

AuthorTest <- data.frame('Title'=ArticleTitle(data),'Abstract'=AbstractText(data),"Year"=YearPubmed(data),'Author'=Author(data))

# Map country data ----

data_country <- Country(data)
data_country <- as.data.frame(data_country)
country_table <- table(data_country)
country_df <- as.data.frame(country_table)

library(rworldmap)
library(ggplot2)
library(ggthemes)
library(maps)

map.world <- map_data(map="world")
map.merged <- merge(map.world,country_df,by='region')

ggplot() +
  geom_map(data=map.merged, map=map.merged, aes(map_id=region, x=long, y=lat))

ggplot() +
  geom_map(data=map.merged, map=map.merged, aes(map_id=region, x=long, y=lat), fill="white", colour="black", size=0.25) +
  geom_map(data=country_df, map=map.world, aes(map_id=region, fill=Freq), color="white", size=0.25) +
  scale_fill_gradient(low = "#132B43", high = "#56B1F7", name="Number of Articles in Pubmed") +
  coord_equal() # works but ugle

ggplot() +
  geom_map(data=map.merged, map=map.merged, aes(map_id=region, x=long, y=lat), fill="white", colour="black", size=0.25) +
  geom_map(data=map.merged, map=map.world, aes(map_id=region, fill=Freq), color="white", size=0.25) +
  scale_fill_gradient(low = "#132B43", high = "#56B1F7", name="Number of Articles in Pubmed") +
  coord_equal() # works but ugle
scale_fill_gradient(low = "green", high = "brown3", guide = "colourbar") +
  
ggplot() +
  geom_map(data=map.world, map=map.world, aes(map_id=region, x=long, y=lat), fill="white", colour="black", size=0.25) +
  geom_map(data=country_df, map=map.world, aes(map_id=region, fill=Freq), size=0.25) +
  scale_fill_gradient(low = "green", high = "brown3", guide = "colourbar") +
  coord_equal()


# this is looking better
# the world of systematic reviews
ggplot(country_df, aes(map_id=region)) + 
  geom_map(aes(fill = Freq), map = map.world, color='black', size=0.3) + 
  expand_limits(x = map.world$long, y = map.world$lat) +
  theme_few()+
  theme(legend.position = "bottom",
        axis.ticks = element_blank(), 
        axis.title = element_blank(), 
        axis.text =  element_blank()) +
  scale_fill_gradient(low = "#132B43", high = "#56B1F7", name="Number of Articles in Pubmed") +
  guides(fill = guide_colorbar(barwidth = 10, barheight = .5))

# this is looking better
# another try with map.merged
# still no USA
ggplot(map.merged, aes()) + 
  geom_map(aes(map_id=region, fill = Freq), map = map.merged, color='black', size=0.3) + 
  expand_limits(x = map.merged$long, y = map.merged$lat) +
  theme_few()+
  theme(legend.position = "bottom",
        axis.ticks = element_blank(), 
        axis.title = element_blank(), 
        axis.text =  element_blank()) +
  scale_fill_gradient(low = "#132B43", high = "#56B1F7", name="Number of Articles in Pubmed") +
  guides(fill = guide_colorbar(barwidth = 10, barheight = .5))



# another try 
colnames(country_df) <- c('region', 'Freq')

WorldData <- map_data('world')
WorldTotal <- merge(WorldData,country_df,by='region')

ggplot(WorldTotal, aes(map_id=region)) + 
  geom_map(aes(fill = Freq), map = map.world, color='black', size=0.3) + 
  expand_limits(x = WorldTotal$long, y = WorldTotal$lat) +
  theme_few()+
  theme(legend.position = "bottom",
        axis.ticks = element_blank(), 
        axis.title = element_blank(), 
        axis.text =  element_blank()) +
  scale_fill_gradient(low = "#132B43", high = "#56B1F7", name="Number of Articles in Pubmed") +
  guides(fill = guide_colorbar(barwidth = 10, barheight = .5))


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




pubmed_data_small <- data.frame('Title'=ArticleTitle(records_small),'Abstract'=AbstractText(records_small),"Year"=YearPubmed(records_small),'Cited'=Cited(records_small))

# visulize pubmed_data

ggplot(pubmed_data, aes(x = Year, y = Cited)) +
  geom_bar(stat = "identity")

pubmed_data %>%
  group_by(Year) %>%
  summarise(sum(Cited)) 
ggplot(pubmed_data, aes(x = Year, y = Cited)) +
  geom_bar(stat = "identity")


