# Systematic Reviews Analysis 

# load libraries ------

source("RMedlineFunctions.R")
library(RISmed)
library(ggplot2)
library(dplyr)


# set out query, can be anything you would search in pubmed.gov's simple search. 

query = 'systematic review[pt]'


# Option one, just get the data from 2016 (line 1), then get the basic article metadata from that data

sysrevdata2016 <- RetrieveArticleData(query,2016,2016,30000)
sysrevdata2016_meta <- RetrieveArticleMetadata(sysrevdata2016)

# Option two, lets get a ton of data from 2014-2016. This is very slow

sysrevdata20142016 <- RetrieveArticleData(query,2014,2016,90000)
sysrevdata20142016_meta <- RetrieveArticleMetadata(sysrevdata20142016)

# alternative method to above would be to get data for each individual year and then merge the data files as below, this might work better for large searches like this
# merging individual metadata files generated above

sysrev_merged <- rbind(sysrevdata2012_meta, sysrevdata2013_meta, sysrevdata2014_meta, sysrevdata2015_meta, sysrevdata2016_meta) 

# graphing pubs per year

ArticlesFreqYear(sysrevdata20142016_meta)

# Look at Pubmed Status by year

PMStatusByYearPlot(sysrev_merged)

