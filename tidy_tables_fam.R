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
  
  if(sheet == "7") {
    
    sheetcolnames <- read_xls(filepath, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
      t() %>% 
      as_tibble(.name_repair = ~ c("one", "two", "three"))
    
    sheetcolnames$three[141] <- "$'000"
    sheetcolnames$three[144] <- "$'000"
    sheetcolnames$three[142] <- "EDR"
    sheetcolnames$three[145] <- "$EDR"
    
    sheetcolnames <- sheetcolnames %>% 
      fill(one, two) %>%  # fill empty cells
      unite(sheet_col_names) %>% 
      mutate(sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|")),
             sheet_col_names = paste("F", sheet = sheet, sheet_col_names, sep = '|'),
             sheet_col_names = str_replace(sheet_col_names, "_na_na|_na", "")) %>% 
      select(sheet_col_names) %>% 
      pull()
    
  }
  
  else {
  
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
  
  }
  
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheetcolnames,
               .name_repair = "unique") %>%
    tibble::add_column(year = file_year, .before = 1) 
  
  write_csv(tidy_df, paste0("data-tidy/", file_year, "-FAM-", sheet, ".csv"))
  
  return(tidy_df)
}


#-------------------------------------------------------------------------------

## example Table F .xls file
filename <- "2016_Family_Tables_1_to_18_Canada.xls"
filefolder <- "data-raw/fam"
filepath <- here(filefolder, filename)

## get sheet names from example Table F .xls file
sheets <- excel_sheets(filepath)

## read one sheet by sheet name 
F_test <- tidy_tax_fam("7", path = filepath)

## inspecting column names for duplicates (when )
nocols <- colnames(F_test)
dups <- unique(colnames(F_test))
compare <- F_test %>% select(contains(".."))


## Read in and add names to all sheets at once
tidy_fam_sheets <- filepath %>%
  excel_sheets() %>%
  set_names() %>% 
  map(tidy_tax_fam, path = filepath)


# ## Save all sheets as individual CSVs
# tidy_sheets %>%
#   names(.) %>%
#   walk(~ write_csv(tidy_sheets[[.]], paste0("data-tidy/", "2016", "-FAM-", ., ".csv")))


#--------------------------------------------------------------------
## Fix sheet 7  column names
filename <- "2016_Family_Tables_1_to_18_Canada.xls"
filefolder <- "data-raw/fam"
filepath <- here(filefolder, filename)

sheet_7_colnames <- read_xls(filepath, sheet = "7", skip = 1, col_names = FALSE, n_max = 3) %>%
  t() %>% 
  as_tibble(.name_repair = ~ c("one", "two", "three"))

sheet_7_colnames$three[141] <- "$'000"
sheet_7_colnames$three[144] <- "$'000"
sheet_7_colnames$three[142] <- "EDR"
sheet_7_colnames$three[145] <- "$EDR"
  
sheet_7_colnames <- sheet_7_colnames %>% 
  fill(one, two) %>%  # fill empty cells
  unite(sheet_col_names) %>% 
  mutate(sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|")),
         sheet_col_names = paste("F", sheet = "7", sheet_col_names, sep = '|'),
         sheet_col_names = str_replace(sheet_col_names, "_na_na|_na", "")) %>% 
  select(sheet_col_names) %>% 
  pull()


# read in sample xlsx data and use new column names

sheet_7_data <- read_xls(filepath, sheet = "7",
                       col_names = sheet_7_colnames)
colnames(sheet_7_data)


#--------------------------------------------------------------------


###########
## TO DO ##
###########

## Add in the filtering of BC rows into the function

## Add loop to read all files

filefolder <- "data-raw"
files <- list.files(filefolder, pattern = "*.xls", full.names = TRUE)  # creates the list of all the xls files in the directory
ldf <- list() # creates a list
for (k in 1:length(filepath)){
  ldf[[k]] <- read_xls(filepath[k], col_names =TRUE, col_types = NULL, skip = 0)
}

str(ldf[[1]]) 




data <- filepath %>%
  map(excel_sheets) %>%    # read in all the file sheets individually, using
  # the function excel_sheets() from the readxl package
  reduce(rbind)        # reduce with rbind into one dataframe
data


## Add loop to read and bind csv by table

filefolder <- "data-tidy"
files <- list.files(filefolder, pattern = "*.csv", full.names = TRUE)  # creates the list of all the xls files in the directory
list_of_csv <- lapply(files, read.csv)
big_object <- do.call('rbind', list_of_csv)

write.csv(
  fileData,
  paste0(filepath,"/",Sys.Date(),"FAM.csv", row.names = FALSE)
  

