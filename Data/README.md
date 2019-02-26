# Data Source

This is an example data file which houses all xlsx tables from Statistics Canada.

The R scripts take  xlsx files and convert them into a machine readable csv file.

To work with the data using R scripts, simply change file input line to include an appropriate data file name.

```{r }

# locate individual xlsx
file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx") 

# or locate family xlsx
file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx") 

```