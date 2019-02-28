# Data Source

This is an example data file which houses all xlsx tables from Statistics Canada.

The R scripts take  xlsx files and convert them into a machine readable csv file.

To work with the data using R scripts, simply change "path to the project" to include an appropriate path extension name.

```{r }

#load library dependencies
library(here)
here()

#load tax data into R
# locate individual xlsx
here("IND_Data", "2015_IND_Tables_1_to_13_Canada.xlsx") 

# or locate family xlsx
here("FAM_Data",  "2015_Family_Tables_1_to_18_Canada.xlsx") 

```