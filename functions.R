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

# source setup script
if (!exists(".setup_sourced")) source(here::here("setup.R"))

#-------------------------------------------------------------------------------

## Function to clean column sheet names 

mutate_col_names <- function(sheet_col_names) {
  sheet_col_names = str_trim(sheet_col_names)
  sheet_col_names = str_replace_all(sheet_col_names, "_NA_NA|_NA", "") # strip out introduced NAs
  sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|"))
  sheet_col_names = str_replace_all(sheet_col_names, "_", "|")
  sheet_col_names = str_replace_all(sheet_col_names, "\\|\\|", "|")
  sheet_col_names = str_replace_all(sheet_col_names, "na|na||", "")
  sheet_col_names = str_replace_all(sheet_col_names, "change\\|\\d{4}-\\d{4}", "range|last|5years") #deals with changing dates of 5 yr windows
  return(sheet_col_names)
}

#-------------------------------------------------------------------------------

## Function to get year from xls file name 

get_file_year <- function(path) {
  # find file_year
  pathbase <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
  
  # assign file_year to d 
  file_year <- pathbase %>% stringr::str_extract("^[0-9]{4}")
  return(file_year)
}

#-------------------------------------------------------------------------------

## Function that returns a list of all working directories in the data-tidy folder

get_sub_folders <- function(tidy_folder) {
  return(list.dirs(tidy_folder))
}

#-------------------------------------------------------------------------------

## Function that takes the list of all tidied processed csv sheets in each subfolder 
## and merge them according to sheet number
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

#-------------------------------------------------------------------------------

## Function to clean, merge, and output the tidy sheets

clean_merge_write <- function(input_folder, tidy_folder, output_folder) {
  clean_taxfiles(input_folder, tidy_folder)
  merge_taxfiles(tidy_folder, output_folder)
}

#-------------------------------------------------------------------------------

.functions_sourced <- TRUE



