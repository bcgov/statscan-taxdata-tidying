# Data Source

This is an example data file which houses all xlsx tables from Statistics Canada.

The R scripts take  xlsx files and convert them into a machine readable csv file.

To work with the data using R scripts, simply change "path to the project" to include an appropriate path extension name.

```{r }

#load income data into R

setwd("path to the project")
getwd()
dir.wrk <- "path to the project"
dir.wrk <- getwd()


# locate individual xlsx
file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx") # this extension means that the excel sheet has 13 sub-sheets

# or locate family xlsx
file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx") # this extension means that the excel sheet has 18 sub-sheets

```