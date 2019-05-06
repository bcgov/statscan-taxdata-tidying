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

## Source setup, function, and ind-clean-13 scripts
#if (!exists(".setup_sourced")) source(here::here("setup.R"))
#if (!exists(".functions_sourced")) source(here("functions.R"))
if (!exists(".ind_clean_13_sourced")) source(here("ind-clean-13.R"))

#-------------------------------------------------------------------------------

## function that takes applies the tidy_tax_i13sheet function to all sheets and then the save_tidy_sheet function to all sheets
## bidirectional function communicating with 'tidy_tax_i13sheet' and 'save_tidy_sheet' functions

merge_taxfile_13_ <- function(tidy_folder) {
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_i13sheet, path = filepath) %>%
    map(save_tidy_sheet_13, tidy_folder = tidy_folder, path = filepath)
  
}

#-------------------------------------------------------------------------------

## Function that returns a list of all files in the data-tidy folder

get_sub_files_13 <- function(tidy_folder) {
  return(list.files(tidy_folder))
}

#-------------------------------------------------------------------------------

## Function that takes the list of all tidied processed csv sheets in each subfolder 
## and merge them according to sheet number
## the function returns one merged csv for each file 

merge_subfile_13 <- function(subfile) {
  print(paste0("processing ", subfile))
  csv_files <- list.files(subfile, pattern = "*.csv", full.names = TRUE) %>% 
    lapply(function(file){
      read.csv(file = file, header = TRUE,  check.names = FALSE)
    }) 
  big_object <- do.call(plyr::rbind.fill, csv_files)
  return(big_object)
}

#-------------------------------------------------------------------------------

## Function returns one merged csv by merging all files in tidyfolder

merge_taxfiles_13 <- function(tidy_folder, output_folder) {
  subfiles <- get_sub_files_13(tidy_folder) 
  for (subfile in subfiles[-1]) {
    merged_taxfile <- merge_subfile_13(subfile)
    write.csv(merged_taxfile, paste0(output_folder, "/", "merge_13_IND.csv"))
  }
}

#-------------------------------------------------------------------------------

## Function that cross-talks with clean taxfiles and merge taxfiles and designates folders to each

clean_merge_write_13 <- function(input_folder, tidy_folder, output_folder) {
  clean_taxfiles_13(input_folder, tidy_folder)
  merge_taxfiles_13(tidy_folder, output_folder)
}

#-------------------------------------------------------------------------------

## Calling folders (works upwards) and communicate with clean_merge_write functions based on 3 designated data folders

clean_merge_write_13("data-raw", "data-tidy", "data-output")

