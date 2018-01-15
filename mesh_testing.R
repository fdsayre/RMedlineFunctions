# File for testing MeSH related analysis

# get articleIDs and MeSH combined
MedList2 = mapply(cbind, "ID"=ArticleId(data),Mesh(data),SIMPLIFY = FALSE) #This works to get ID and MESH in same list

# transition to dataframe
MeSH_df <- ldply(MedList2, data.frame) #jesus this worked

# Count MeSH occurances but includes qualifiers
# Works
MeSH_counts <- count(MeSH_df, vars="Heading")

# Count where type = Descriptor
# Works

MeSH_counts <- MeSH_df %>%
  filter(Type == "Descriptor") %>%
  count(., vars="Heading")

# sort decending order on freq
#works
MeSH_counts_sorted <- arrange(MeSH_counts, -freq)


# display results
#works
library(gridExtra)
library(grid)

MeSH_counts_head <- head(MeSH_counts_sorted)
grid.table(MeSH_counts_head)


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
  MeSH_counts <- MeSH_df %>%
    filter(Type == "Descriptor") %>%
    count(., vars="Heading")
  MeSH_counts_sorted <- arrange(MeSH_counts, -freq)
  return(MeSH_counts_sorted)
}
  
  