# These functions use the library RISmed
# https://cran.r-project.org/web/packages/RISmed/RISmed.pdf
# The idea is to extend RISmed by building a standard set of functions for searching and discplaying pubmed results


# function: RetrieveArticleData ------

RetrieveArticleData <- function(x,y,z,a) {
  f_search_query <- EUtilsSummary(x, retmax=a, mindate=y, maxdate=z)
  pubmed_data <- EUtilsGet(f_search_query)
  return(pubmed_data)
}

# function: RetrieveArticleMetadata-----


RetrieveArticleMetadata <- function(x) {
  pubmed_metadata <- data.frame('Title'=ArticleTitle(x),'Abstract'=AbstractText(x),"Year"=YearPubmed(x), "ID"=ArticleId(x))
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



# Function: GetCitationData
# x = base medline datafile
# y = metadata file with ID = PMID

GetCitationData <- function(x, y) {
  citations <- Cited(x)
  citationsdf <- stack(citations) # works
  mergedmetadata <- merge(y, citationsdf, by.x = 'ID', by.y = 'ind')
  return(mergedmetadata)
  
}

# Function: PlotCitations
# given citation in metadata file with citations = 'values'

PlotCitations <- function(x) {
citedplot <- ggplot(x, aes(x = Year, y = values)) +
    geom_jitter()
  return(citedplot)
  
}

# Function: PlotCitationsBar 
# Plot citations grouped by year as bar graph

PlotCitationsBar <- function(x) {
  
  groupeddata <- x %>% 
    group_by(Year)
    citedbarplot <- ggplot(groupeddata, aes(x = Year, y = values)) +
    geom_bar(stat = "identity")
  return(citedbarplot)
}


# Function: MapPubsPerCountry
# Maps number of publications published in a journal in a country
# x = medline data file
# y = metadata file with PMID as "ID"

MapPubsPerCountry <- function(x, y) {

data_country_frame <- data.frame("ID"=ArticleId(x),"Country"=Country(x))

article_metadata <- merge(y, data_country_frame, by="ID")
  
map_table <- table(article_metadata$Country)
map_df <- as.data.frame(map_table)
  
map_df$Var1[map_df$Var1=="England"] <- "United Kingdom"
  
map_df$Var1[map_df$Var1=="China (Republic : 1949- )"] <- "China"
  
malMap <- joinCountryData2Map(map_df, joinCode = "NAME", nameJoinColumn = "Var1", verbose = TRUE)
  
  mapCountryData(malMap, nameColumnToPlot="Freq", catMethod = "pretty", missingCountryCol = gray(.8), colourPalette = "heat")
  
  
}
  
# Function: GetMeSH ----------
# Gets list of all MeSH Descriptors and Qualifiers
# Very messy, includes redundant ID columns and lots of NAs

GetMeSH <- function(x) {
  MeSHDFList = mapply(cbind, "ID"=ArticleId(x),Mesh(x),SIMPLIFY = FALSE) 
  MeSH_df <- ldply(MeSHDFList, data.frame) 
  return(MeSH_df)
}

# Function: CountMeSH
# x = output df from the GetMeSH function 

CountMeSH <- function(x) {
  MeSH_counts <- x %>%
    filter(Type == "Descriptor") %>%
    count(., vars="Heading")
  MeSH_counts_sorted <- arrange(MeSH_counts, -freq)
  return(MeSH_counts_sorted)
}

