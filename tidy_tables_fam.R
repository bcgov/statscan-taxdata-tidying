# Copyright 2019 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

library(dplyr)
library(readxl)
library(purrr)
library(readr)
library(here)
library(tidyr)
library(stringr)
library(tibble)


## Function to read in each sheet from Table F xls file, clean column names,
## and export df in a list object


tidy_tax_fam <- function(sheet, skip, col_names, path) {
  
  pathbase <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
  
  file_year <- pathbase %>% stringr::str_extract("^[0-9]{4}")
  
  if (sheet %in% c("2", "3A", "3B", "3C", "13", "14A", "14B")) {
    tempcols <- c("one", "two")
  } else tempcols <- c("one", "two", "three")
  
  sheetcolnames <- path %>%
    read_excel(sheet = sheet, skip = 1, n_max = 3, col_names = FALSE) %>%
    t() %>% 
    as_tibble(.name_repair = ~ tempcols) %>% 
    fill(tempcols) %>% 
    unite(sheet_col_names) %>% 
    mutate(sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|")),
           sheet_col_names = paste("F", sheet, sheet_col_names, sep = '|'),
           sheet_col_names = str_replace(sheet_col_names, "_na_na|_na", "")) %>% 
    select(sheet_col_names) %>% 
    pull()
  
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheetcolnames,
               .name_repair = "unique") %>%
    tibble::add_column(year = file_year, .before = 1) 
  
  # write_csv(tidy_df, paste0("data-tidy/", pathbase, "-", sheet, ".csv"))
  
  return(tidy_df)
}



## example Table I .xls file
filename <- "2016_Family_Tables_1_to_18_Canada.xls"
filefolder <- "data-raw/fam"
filepath <- here(filefolder, filename)

## get sheet names from example Table I .xls file
sheets <- excel_sheets(filepath)

## read one sheet by sheet name 
F_test <- tidy_tax_fam("7", path = filepath)

## inspecting column names for duplicates (when )
nocols <- colnames(F_test)
dups <- unique(colnames(F_test))
compare <- F_test %>% select(contains(".."))


## Read in and add names to all sheets at once
tidy_sheets <- filepath %>%
  excel_sheets() %>%
  set_names() %>% 
  map(tidy_tax_fam, path = filepath)


## Save all sheets as individual CSVs
tidy_sheets %>%
  names(.) %>%
  walk(~ write_csv(tidy_sheets[[.]], paste0("data-tidy/", "2016_Family_BC", "-", ., ".csv")))

#--------------------------------------------------------------------

## read sheet 7 by sheet name 
## Function to read in each sheet from Table F-07 xls file, clean column names,
## and export df in a list object

filename <- "2016_Family_Tables_1_to_18_Canada.xls"
filefolder <- "data-raw"
filepath <- here(filefolder, filename)

my_custom_name_repair <- read_xls(filepath, sheet = 12, skip = 1, col_names = FALSE, n_max = 3) %>%
  t() %>% 
  as_tibble(.name_repair = ~ c("one", "two", "three")) %>% 
  fill(one, two, three) %>%  # fill empty cells
  mutate(sheet14_col_names = paste("F-07", one, two, three, sep = '_'),
         sheet14_col_names = str_replace(sheet14_col_names, "_NA_NA|_NA", ""),
         sheet14_col_names = str_replace_all(sheet14_col_names, c(" |/|'|"), "")) %>% 
  select(sheet14_col_names) %>% 
  pull()
my_custom_header_repair <- str_replace_all(as.character(my_custom_name_repair), c(" |/|'|"), "")




# read in sample xlsx data and use new column names

sheet_data <- read_xls(filepath, sheet = 12,
                       col_names = my_custom_header_repair)
colnames(sheet_data)
colnames(sheet_data) <- as.character(colnames(sheet_data))

#OR
colClean <- function(x){
  colnames(x) <- gsub(".", "", perl=TRUE, colnames(x))
}
colClean(sheet_data)
colnames(sheet_data)









#--------------------------------------------------------------------





###########
## TO DO ##
###########

## Need to make one off column_name vector for F-07 as the approach used 
## does not work with header design of the tables (i.e. cannot paste contents to get unique names)
## Add in the filtering of BC rows into the function


