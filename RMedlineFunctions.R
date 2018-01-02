# These functions use the library RISmed
# https://cran.r-project.org/web/packages/RISmed/RISmed.pdf
# The idea is to extend RISmed by building a standard set
# of functions for commonly done tasks


# function: RetrieveArticleData ------

RetrieveArticleData <- function(x,y,z,a) {
  f_search_query <- EUtilsSummary(x, retmax=a, mindate=y, maxdate=z)
  pubmed_data <- EUtilsGet(f_search_query)
  return(pubmed_data)
}

# function: RetrieveArticleMetadata-----


RetrieveArticleMetadata <- function(x) {
  pubmed_metadata <- data.frame('Title'=ArticleTitle(x),'Abstract'=AbstractText(x),"Year"=YearPubmed(x))
  return(pubmed_metadata)
}

# function: RetrieveMostArticleMetadata-----

RetrieveMostArticleMetadata <- function(x) {
  pubmed_most_metadata <- data.frame('Title'=ArticleTitle(x),'Abstract'=AbstractText(x),"Year"=YearPubmed(x),'PubStatus'= PublicationStatus(x),"Journal"=ISOAbbreviation(x), "ID"=ArticleId(x))
  return(pubmed_most_metadata)
}


# function: GraphArticlesFreqYears ---------

ArticlesFreqYear <-function(x) {
  ArticlesFreqPerYear <- count(x, vars=Year)
  ArticlesFreqPerYear_Plot <- ggplot(ArticlesFreqPerYear, aes(x = vars, y = n)) +
    geom_bar(stat = "identity")
  return(ArticlesFreqPerYear_Plot)
}

## Function: JournalTitlesFreq -----

JournalTitlesFreq <- function(x) {
  journal_freq_list <- table(unlist(x$Journal))
  journal_freq <- as.data.frame(journal_freq_list)
  return(journal_freq)
}

## Function: Journal5TitlesFreqGraph -----

JournalTitlesTop5Graph <- function(x) {
  journal_freq_list <- table(unlist(x$Journal))
  journal_freq <- as.data.frame(journal_freq_list)
  journal_freq <- top_n(journal_freq, 5)
  journal_freq_plot <- ggplot(journal_freq, aes(x = Var1, y = Freq)) +
    geom_bar(stat = "identity")
  return(journal_freq_plot)
  }


# Function: PMStatusByYearPlot-------


PMStatusByYearPlot <- function(x) {
  PMStatusYear <- data.frame('Year'=YearPubmed(x),'PubStatus'= PublicationStatus(x))
  gPMStatusYear_Plot <- ggplot(PMStatusYear, aes(x = Year, fill = PubStatus)) +
    geom_bar()
  return(gPMStatusYear_Plot)
}


# Function: Top Authors Per Search ---- 

GetAuthorsFlatList <- function(x) {
  authors <- Author(x)
  LastFirst <- sapply(authors, function(x)paste(x$LastName,x$ForeName))
  authors<-as.data.frame(sort(table(unlist(LastFirst)), dec=TRUE))
  return(authors)
}


# In process -----------



#Function: Top Co-Authors Per Search


#function: Retrieve MeSH



## retrieve grant IDs

#Grants <- GrantID(records)
#Grants <- as.data.frame(na.omit(Grants))



#ISO <- ISOAbbreviation(records)
#ISO <- as.data.frame(na.omit(ISO))

# PubmedStatusData
# Get data file with PM Status

#PMStatus <- PublicationStatus(records)
#PMStatus <- as.data.frame(PMStatus)

#ggplot(PMStatus, aes(x = PMStatus)) +
#  geom_bar()


# Function to find common MeSH across a search set, e.g. what MeSH are present in all results?



# Function to compare a set of PMIDs against a search


### Function: map country of publication ------


### map country of affiliation

## ven diagram

### view search details