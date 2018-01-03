# RMedlineFunctions

This is a project to build a set of reusable functions for accessing, manipulating, and visualizing data from medline/pubmed via the R library RISmed (https://cran.r-project.org/web/packages/RISmed/index.html). 

This project is in early development.

A use example using RNotebook can be found here: https://fdsayre.github.io/RMedlineFunctions/MGExample.nb.html 

A second example using RNotebook can be found here: https://fdsayre.github.io/RMedlineFunctions/LibrarianExample.nb.html


Currently:
- RetrieveArticleData: Get medline data 
- RetrieveArticleMetadata: Get basic article metadata from medline data
- RetrieveMostArticleMetadata: Get (most) article metadata from medline data
- GraphArticlesFreqYears: create graph of article frequency by year
- JournalTitles: Get list of journal titles (In process)
- PMStatusByYearPlot: Get Status by year (In process) (from article metadata)
- Top Authors: Get list of authors and freqency they appear in a search set
- GetCitationData: get data on the number of times each article has been cited. 
- PlotCitations: create a scatterplot (actually this uses jitter) of citations
- PlotCitationsBar: Create a bar chart of cumulative citations by year of publication

Future development:
- Compare a set of PMIDs against a search
- Map country publushed to world map
- Map country of affiliation to world map? 

Long-term future development: 
- Find common MeSH across a search set (e.g. what MeSH are present in all results?)
- Recommend additional MeSH and search terms based on existing set
- Find collaborators per search set
- Create network graphs based on various search sets
- Compare a set of PMIDs against a search
- build functions to export results in various formats
  - csv
  - bibtex


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

## Function: JournalTitlesTop5Graph ----
Get a graph of the top 5 journal titles for a search using a article meta file

## Function: PMStatusByYearPlot-------
Create a stacked bar plot of Pubmed Status by year
x = pubmed datafile

## Function: Top Authors ---- 
Create a data frame of authors and their frequency from a base data file


