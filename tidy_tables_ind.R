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


## Function to read in each sheet from Table I xls file, clean column names,
## and export df in a list object

tidy_tax_ind <- function(sheet, skip, col_names, path) {
  
  pathbase <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
  
  file_year <- pathbase %>% stringr::str_extract("^[0-9]{4}")
  
  if(sheet == "8") {
    
    sheetcolnames <- read_xls(filepath, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
      t() %>% 
      as_tibble(.name_repair = ~ c("one", "three")) %>% 
      mutate(two = case_when(one == "$'000" ~ "$'000", TRUE ~ NA_character_),
             one = case_when(two == "$'000" ~ NA_character_, TRUE ~ one)) %>% 
      select(one, two, three) %>% 
      fill(one, three) %>%  # fill empty cells
      unite(sheet_col_names) %>% 
      mutate(sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|")),
             sheet_col_names = paste("I", sheet, sheet_col_names, sep = '|'),
             sheet_col_names = str_replace(sheet_col_names, "_na_na|_na", "")) %>% 
      select(sheet_col_names) %>% 
      pull()
    
  }
  
  else if(sheet == "13") {
    
    types <- c("Couple Families",
               "Lone-Parent Families",
               "Census Families In Low Income",
               "Non-Family Persons",
               "All family units" )
    
    sheetcolnames <- read_xls(filepath, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
      t() %>% 
      as_tibble(.name_repair = ~ c("one", "three", "four")) %>% 
      mutate(two = NA) %>% 
      select(one, two, three, four) %>% 
      mutate(two = case_when(str_detect(three, "0-17") ~ "0-17",
                             str_detect(three, "18-64") ~ "18-64",
                             str_detect(three, "65 +") ~ "65+",
                             one %in% types ~ "all_ages",
                             TRUE ~ NA_character_)) %>% 
      fill(one, two, three) %>%  # fill empty cells
      unite(sheetcolnames) %>% 
      mutate(sheetcolnames = tolower(str_replace_all(sheetcolnames, "\\s", "|")),
             sheetcolnames = paste("I", sheet, sheetcolnames, sep = '|'),
             sheetcolnames = str_replace_all(sheetcolnames, "_na_na|_na", "")) %>% 
      select(sheetcolnames) %>% 
      pull()

  } else {
  
  
  if (sheet %in% c("3A", "3B", "3C", "9")) {
    tempcols <- c("one", "two")
  } else tempcols <- c("one", "two", "three")
  
  sheetcolnames <- path %>%
    read_excel(sheet = sheet, skip = 1, n_max = 3, col_names = FALSE) %>%
    t() %>% 
    as_tibble(.name_repair = ~ tempcols) %>% 
    fill(tempcols) %>% 
    unite(sheet_col_names) %>% 
    mutate(sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|")),
           sheet_col_names = paste("I", sheet, sheet_col_names, sep = '|'),
           sheet_col_names = str_replace(sheet_col_names, "_na_na|_na", "")) %>% 
    select(sheet_col_names) %>% 
    pull()
  
  }
  
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheetcolnames,
               .name_repair = "unique") %>%
    tibble::add_column(year = file_year, .before = 1) 
  
   write_csv(tidy_df, paste0("data-tidy/", file_year, "-I", sheet, ".csv"))
  
  return(tidy_df)
}


#-------------------------------------------------------------------------------

## example Table I .xls file
filename <- "2015_IND_Tables 1_to_13_Canada.xls"
filefolder <- "data-raw/ind"
filepath <- here(filefolder, filename)

## get sheet names from example Table I .xls file
sheets <- excel_sheets(filepath)

## read one sheet by sheet name 
I_test <- tidy_tax_ind("2", path = filepath)

## inspecting column names for duplicates (when )
nocols <- colnames(I_test)
dups <- unique(colnames(I_test))
compare <- I_test %>% select(contains(".."))


## Read in and add names to all sheets at once
tidy_sheets <- filepath %>%
  excel_sheets() %>%
  set_names() %>% 
  map(tidy_tax_ind, path = filepath)


## Save all sheets as individual CSVs
tidy_sheets %>%
  names(.) %>%
  walk(~ write_csv(tidy_sheets[[.]], paste0("data-tidy/", "2015", "-I", ., ".csv")))


#--------------------------------------------------------------------


## Fix sheet 8 column names

filename <- "2015_IND_Tables 1_to_13_Canada.xls"
filefolder <- "data-raw/ind"
filepath <- here(filefolder, filename)

sheets <- excel_sheets(filepath)

sheet_8_colnames <- read_xls(filepath, sheet = "8", skip = 1, col_names = FALSE, n_max = 3) %>%
  t() %>% 
  as_tibble(.name_repair = ~ c("one", "three")) %>% 
  mutate(two = case_when(one == "$'000" ~ "$'000", TRUE ~ NA_character_),
         one = case_when(two == "$'000" ~ NA_character_, TRUE ~ one)) %>% 
  select(one, two, three) %>% 
  fill(one, three) %>%  # fill empty cells
  unite(sheet_8_colnames) %>% 
  mutate(sheet_8_colnames = tolower(str_replace_all(sheet_8_colnames, "\\s", "|")),
         sheet_8_colnames = paste("I", sheet = "8", sheet_8_colnames, sep = '|'),
         sheet_8_colnames = str_replace(sheet_8_colnames, "_na_na|_na", "")) %>% 
  select(sheet_8_colnames) %>% 
  pull()


# read in sample xlsx data and use new column names

sheet_8_data <- read_xls(filepath, sheet = "8", skip = 4,
                         col_names = sheet_8_colnames)

colnames(sheet_8_data)

#--------------------------------------------------------------------
  
## Fix sheet 13 column names

types <- c("Couple Families",
           "Lone-Parent Families",
           "Census Families In Low Income",
           "Non-Family Persons",
           "All family units" )

sheet_13_colnames <- read_xls(filepath, sheet = "13", skip = 1, col_names = FALSE, n_max = 3) %>%
  t() %>% 
  as_tibble(.name_repair = ~ c("one", "three", "four")) %>% 
  mutate(two = NA) %>% 
  select(one, two, three, four) %>% 
  mutate(two = case_when(str_detect(three, "0-17") ~ "0-17",
                         str_detect(three, "18-64") ~ "18-64",
                         str_detect(three, "65 +") ~ "65+",
                         one %in% types ~ "all_ages",
                         TRUE ~ NA_character_)) %>% 
  fill(one, two, three) %>%  # fill empty cells
  unite(sheet_13_colnames) %>% 
  mutate(sheet_13_colnames = tolower(str_replace_all(sheet_13_colnames, "\\s", "|")),
         sheet_13_colnames = paste("I", sheet = "13", sheet_13_colnames, sep = '|'),
         sheet_13_colnames = str_replace_all(sheet_13_colnames, "_na_na|_na", "")) %>% 
  select(sheet_13_colnames) %>% 
  pull()


# read in sample xlsx data and use new column names

sheet_13_data <- read_xls(filepath, sheet = "13", skip = 4,
                         col_names = sheet_13_colnames)

colnames(sheet_13_data)


## inspecting column names for duplicates (when )
nocols <- colnames(sheet_8_data)
dups <- unique(colnames(sheet_8_data))
compare <- sheet_8_data %>% select(contains(".."))




#--------------------------------------------------------------------
#future state
## Function to read all xls data files for individuals
# find all file names with Canada in the name
  filefolder <- "data-raw"
  files <- dir(filefolder, pattern = ".xls")
  file.path <- here(filefolder, files)
  
  
  data <- file.path %>%
    map(excel_sheets) %>%    # read in all the file sheets individually, using
    # the function excel_sheets() from the readxl package
    reduce(rbind)        # reduce with rbind into one dataframe
  data
  