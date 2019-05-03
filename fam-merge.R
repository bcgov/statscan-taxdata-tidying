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


## Source setup, function, and fam-clean scripts

if (!exists(".setup_sourced")) source(here::here("setup.R"))
if (!exists(".functions_sourced")) source(here:("functions.R"))
if (!exists(".fam_clean_sourced")) source(here:("fam-clean.R"))

#-------------------------------------------------------------------------------

## function that takes applies the tidy_tax_fam function to all sheets and then the save_tidy_sheet function to all sheets
## bidirectional function communicating with 'tidy_tax_fam' and 'save_tidy_sheet' functions

merge_taxfile <- function(tidy_folder) {
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_fam, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
  
}

#-------------------------------------------------------------------------------

## Function that takes the list of all tidied processed csv sheets in each subfolder 
## and merge them according to sheet number
## the function returns one merged csv for each file 

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

## Function returns one merged csv by merging all files in subfolders

merge_taxfiles <- function(tidy_folder, output_folder) {
  sub_folders <- get_sub_folders(tidy_folder) 
  for (sub_folder in sub_folders[-1]) {
    merged_taxfile <- merge_subfolder(sub_folder)
    write_csv(merged_taxfile, paste0(output_folder, "/", basename(sub_folder), "_FAM.csv"))
  }
}

#-------------------------------------------------------------------------------

## Function that cross-talks with clean taxfiles and merge taxfiles and designates folders to each

clean_merge_write <- function(input_folder, tidy_folder, output_folder) {
  clean_taxfiles(input_folder, tidy_folder)
  merge_taxfiles(tidy_folder, output_folder)
}

#-------------------------------------------------------------------------------

## Calling folders (works upwards) and communicate with clean_merge_write functions based on 3 designated data folders

clean_merge_write("data-raw", "data-tidy", "data-output")