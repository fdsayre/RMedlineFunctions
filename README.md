# RMedlineFunctions

A project to build a set of reusable functions for accessing, manipulating, and visualizing data from medline/pubmed via the library RISmed in R. 

This project is in early development.

Currently:
- RetrieveArticleData: Get medline data 
- RetrieveArticleMetadata: Get basic article metadata from medline data
- RetrieveMostArticleMetadata: Get (most) article metadata from medline data
- GraphArticlesFreqYears: create graph of article frequency by year
- JournalTitles: Get list of journal titles (In process)
- PMStatusByYearPlot: Get Status by year (In process) (from article metadata)

Future development:
- Find top authors for a search set
- Compare a set of PMIDs against a search
- Map country publushed to world map
- Map country of affiliation to world map

Long-term future development: 
- Find common MeSH across a search set (e.g. what MeSH are present in all results?)
- Recommend additional MeSH and search terms based on existing set
- Find collaborators per search set
- Create network graphs based on various search sets
<<<<<<< HEAD
=======
- Compare a set of PMIDs against a search
- build functions to export results in various formats
  - csv
  - bibtex

Todo:
- expand README to include descriptions of each function and how to use them
- add examples.R script with working example
- create rnotebook for examples.R
- remove playingaround file

# Functions

## Function: RetrieveArticleData ----
Retrieve a set of article data in medline format (usually not approrpiate for direct analysis)
x = 'search query'
y = mindate, e.g. 1990
z = maxdate, e.g. 2010
a = maxrecords, e.g. 1000

## Function: RetrieveArticleMetadata----
From initial datafile created with RetrieveArticleData function get article level metadata, including Title, Abstract, Year, in a dataframe suitable for analysis
x = pubmed_data


## Function: RetrieveMostArticleMetadata----
From initial datafile created with RetrieveArticleData function get article level metadata, including  Title, Abstract, Year, Pubstatus, and Journal, in a dataframe suitable for analysis
Not included: Citation, Pubtype
x = pubmed_data

## Function: GraphArticlesFreqYears ----
From initial datafile, create a graph of the number of articles published each year
x = data frame with 'Year' variable

## Function: JournalTitles -----
Get Journal Titles for an initial pubmed dataset
TODO: make this a table witha  count

## Function: PMStatusByYearPlot-------
Create a stacked bar plot of Pubmed Status by year
x = pubmed datafile