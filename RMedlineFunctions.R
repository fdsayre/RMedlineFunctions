
# function: RetrieveArticleData ------
# https://www.statmethods.net/management/userfunctions.html

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
# from initial datafile, including Title, Abstract, Year
# x = pubmed_data

RetrieveArticleMetadata <- function(x) {
  pubmed_metadata <- data.frame('Title'=ArticleTitle(f_records),'Abstract'=AbstractText(f_records),"Year"=YearPubmed(f_records))
  return(pubmed_metadata)
}

# function: ArticlesFreqYes
# Graph a graph of the number of articles published each year
# x = data frame with 'Year' variable

ArticlesFreqYear <-function(x) {
  ArticlesFreqPerYear <- count(x, vars=Year)
  ArticlesFreqPerYear_Plot <- ggplot(ArticlesFreqPerYear, aes(x = vars, y = n)) +
    geom_bar(stat = "identity")
  return(ArticlesFreqPerYear_Plot)
}

### function: Retrieve MeSH-----

#MeSH <- Mesh(records)

#MeSH_Table <- as.data.frame(MeSH)

## grant ID--------

#Grants <- GrantID(records)
#Grants <- as.data.frame(na.omit(Grants))

## Journal Titles------

#ISO <- ISOAbbreviation(records)
#ISO <- as.data.frame(na.omit(ISO))

# PubmedStatus-------

#PMStatus <- PublicationStatus(records)
#PMStatus <- as.data.frame(PMStatus)

#ggplot(PMStatus, aes(x = PMStatus)) +
#  geom_bar()

# PubmedStatusByYear-------

#PMStatusYear <- data.frame('Year'=YearPubmed(records),'PubStatus'= PublicationStatus(records))

#ggplot(PMStatusYear, aes(x = Year, fill = PubStatus)) +
#  geom_bar()
