# RMedlineFunctions
A set of functions and examples for accessing and using medline/pubmed data in R via RISmed

A project to build a set of reusable functions for accessing, manipulating, and visualizing data from medline/pubmed via the library RISmed in R. 

Very early in the development process. 

Currently:
- RetrieveArticleData
- RetrieveArticleMetadata
- GraphArticlesFreqYears
- JournalTitles
- PMStatusByYearPlot

Future work:
- Find common MeSH across a search set, e.g. what MeSH are present in all results?
- Recommend additional MeSH and search terms based on existing set
- Find top authors for a search set
- Find collaborators per search set
- Create network graphs based on various search sets
- Compare a set of PMIDs against a search

Todo:
- expand README to include descriptions of each function and how to use them
- add examples.R script with working example
- create rnotebook for examples.R
- remove playingaround file

