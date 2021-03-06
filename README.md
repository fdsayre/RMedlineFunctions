# RMedlineFunctions

RMedlineFunctions is intended to be a set of reusable functions for accessing, manipulating, and visualizing data from medline/pubmed via the R library RISmed (https://cran.r-project.org/web/packages/RISmed/index.html). 

This project is in early development.

An example using RNotebook can be found here: https://fdsayre.github.io/RMedlineFunctions/ReproExample.nb.html


Future development:
- Compare a set of PMIDs against a search
- Map country publushed to world map
- Map country of affiliation to world map? 
- Find common MeSH across a search set (e.g. what MeSH are present in all results?)
- Find minimum MeSH/Keywords to retrieve a set of results
- Recommend additional MeSH and search terms based on existing set
- Find collaborators/co-authors in search set
- Create network graphs based co-athorship 
- Compare a set of PMIDs against a search for sensitivity/specificity
- Export results in various formats
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

## Function: MapPubsPerCountry
Maps number of publications published in a journal in a country
x = medline data file
y = metadata file with PMID as "ID"

## Function: GetMeSH ----------
Gets list of all MeSH Descriptors and Qualifiers
Very messy, includes redundant ID columns and lots of NAs

## Function: CountMeSH
Returns a sorted list of MeSH Descriptors (no qualifiers yet) in decending order
x = output df from the GetMeSH function 