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


## Install & Load packages (project dependencies)

pkgs <-c("plyr", "janitor", "tibble", "stringr", "tidyr", "here", "readr", "purrr", "readxl", "dplyr")
check <- sapply(pkgs,require,warn.conflicts = TRUE,character.only = TRUE)
if(any(!check)) {
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing, require, warn.conflicts = TRUE, character.only = TRUE)
}

#----------------------------------------------------------------------------------------------------

## Function to get year from file name 

get_file_year <- function(path) {
  # find file_year
  pathbase <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
  
  # assign file_year to d 
  file_year <- pathbase %>% stringr::str_extract("^[0-9]{4}")
  return(file_year)
}

#----------------------------------------------------------------------------------------------------

## Function to clean column sheet names  (for most sheets)

mutate_col_names <- function(sheet_col_names) {
  sheet_col_names = str_trim(sheet_col_names)
  sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|"))
  sheet_col_names = str_replace_all(sheet_col_names, "_", "|")
  sheet_col_names = str_replace_all(sheet_col_names, "na|na||", "")
  sheet_col_names = str_replace_all(sheet_col_names, "\\|\\|", "|")
  sheet_col_names = str_replace_all(sheet_col_names, "change\\|\\d{4}-\\d{4}", "range|last|5years")
  return(sheet_col_names)
}

#-----------------------------------------------------------------

## function for taking the list of all files in the data-raw dorlder and send them to clean_taxfile function for cleaning column header

clean_taxfiles <- function(input_folder, tidy_folder) {
  files <- list_input_files(input_folder)
  for (file in files) {
    clean_taxfile(file, tidy_folder)
  }
}

#-----------------------------------------------------------------

## function that returns a list of all working directories in the data-tidy folder

get_sub_folders <- function(tidy_folder) {
  return(list.dirs(tidy_folder))
}

#-----------------------------------------------------------------

## function that takes the list of all tidied processed csv sheets in each subfolder and merge them according to sheet number
## the function returns one merged csv for each 

merge_subfolder <- function(sub_folder) {
  print(paste0("processing ", sub_folder))
  csv_files <- list.files(sub_folder, pattern = "*.csv", full.names = TRUE) %>% 
    lapply(function(file){
      read.csv(file = file, header = TRUE,  check.names = FALSE)
    }) 
  big_object <- do.call(plyr::rbind.fill, csv_files)
  return(big_object)
}

#-----------------------------------------------------------------


## function to clean, merge, and output the tidy sheets (bi-directional communication function)
## takes data from folders assigned by clean_merge_write below
## communicates upwards with two other functions: clean_taxfiles and merge_taxfiles

clean_merge_write <- function(input_folder, tidy_folder, output_folder) {
  clean_taxfiles(input_folder, tidy_folder)
  merge_taxfiles(tidy_folder, output_folder)
}

#-----------------------------------------------------------------

## Calling folders (works upwards) and communicate with clean_merge_write functions based on 3 designated data folders
clean_merge_write("data-raw", "data-tidy", "data-output")

#-----------------------------------------------------------------

## Invisible header object
.setup_sourced <- TRUE
