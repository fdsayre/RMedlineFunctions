# These functions use the library RISmed
# https://cran.r-project.org/web/packages/RISmed/RISmed.pdf
# The idea is to extend RISmed by building a standard set
# of functions for commonly done tasks


# function: RetrieveArticleData ------
# retrieve list of PMIDs and then basic article metadata
# x <- 'search query'
# y = mindate
# z = maxdate
# a = maxrecords

RetrieveArticleData <- function(x,y,z,a) {
  f_search_query <- EUtilsSummary(x, retmax=a, mindate=y, maxdate=z)
  pubmed_data <- EUtilsGet(f_search_query)
  return(pubmed_data)
}

# function: RetrieveArticleMetadata-----
# from initial datafile, get metadata, including Title, Abstract, Year
# This creates a usable dataframe for analysis
# x = pubmed_data

RetrieveArticleMetadata <- function(x) {
  pubmed_metadata <- data.frame('Title'=ArticleTitle(x),'Abstract'=AbstractText(x),"Year"=YearPubmed(x))
  return(pubmed_metadata)
}

# function: GraphArticlesFreqYears
# from initial datafile, create a graph a graph of the number of articles published each year
# x = data frame with 'Year' variable

ArticlesFreqYear <-function(x) {
  ArticlesFreqPerYear <- count(x, vars=Year)
  ArticlesFreqPerYear_Plot <- ggplot(ArticlesFreqPerYear, aes(x = vars, y = n)) +
    geom_bar(stat = "identity")
  return(ArticlesFreqPerYear_Plot)
}

## Function: JournalTitles -----
# Journal Titles

JournalTitles <- function(x) {
  Jtitles <- ISOAbbreviation(x)
  Jtitles <- as.data.frame(Jtitles)
  return(Jtitles)
  
}

# Function: PMStatusByYearPlot-------
# Create a stacked bar plot of Pubmed Status by year
# x = pubmed datafile


PMStatusByYearPlot <- function(x) {
  PMStatusYear <- data.frame('Year'=YearPubmed(x),'PubStatus'= PublicationStatus(x))
  gPMStatusYear_Plot <- ggplot(PMStatusYear, aes(x = Year, fill = PubStatus)) +
    geom_bar()
  return(gPMStatusYear_Plot)
}



### function: Retrieve MeSH-----



## grant ID--------

#Grants <- GrantID(records)
#Grants <- as.data.frame(na.omit(Grants))



#ISO <- ISOAbbreviation(records)
#ISO <- as.data.frame(na.omit(ISO))

# PubmedStatusData-------
# Get data file with PM Status

#PMStatus <- PublicationStatus(records)
#PMStatus <- as.data.frame(PMStatus)

#ggplot(PMStatus, aes(x = PMStatus)) +
#  geom_bar()


# Function to find common MeSH across a search set, e.g. what MeSH are present in all results?



# Function to compare a set of PMIDs against a search


