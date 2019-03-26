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


## Source setup script
if (!exists(".setup_sourced")) source("setup.R")


#-----------------------------------------------------------------

# function to tidy sheets in multiple sheet years for individual table 13  

tidy_tax_i13sheet <- function(sheet, skip, col_names, path) {
  print(paste0("processing sheet ", sheet))
  
  types <- c("Couple Families",
             "Lone-Parent Families",
             "Census Families In Low Income",
             "Non-Family Persons",
             "All family units" )
  
  #process sheets/clean column headers
  
  sheet_13_colnames <- read_xls(path, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
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
    unite(sheet_col_names) %>% 
    mutate(sheet_col_names = mutate_col_names(sheet_col_names)) %>%
    select(sheet_col_names) %>% 
    pull()

  # generate data.table with fixed sheet column names
sheet_13_colnames = str_replace_all(sheet_13_colnames, "\\|\\|", "|")

  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheet_13_colnames,
               .name_repair = "unique") %>%
    tibble::add_column(year = sheet, .before = 1) 
  
  # filter out only BC Geographies
  
  tidy_df <- tidy_df %>% filter(str_detect(`postal|area|`, "^V") |
                                  str_detect(`postal|area|`, "^9") | 
                                  str_detect(`postal|area|`, "^59[0-9]{3}") & `level|of|geo|` == "31" |
                                  str_detect(`postal|area|`, "^59[0-9]{4}") & `level|of|geo|` == "21" | 
                                  str_detect(`postal|area|`, "^515[0-9]{3}") & `level|of|geo|` == "51" |
                                  `level|of|geo|` == "11" |
                                  `level|of|geo|` == "12") 
  
  
  return(list("data" = tidy_df, "sheet" = sheet))
}


#-----------------------------------------------------------------

## function that lists all the xls files with '2004_to_2015' designation in the data-tidy folder 

list_input_files <- function(input_folder) {
  files <- list.files(input_folder, pattern = "*.xls", full.names = TRUE)  
  return(files[grep("_2004_to_2015_", files)]) 
}

#-----------------------------------------------------------------

## function that applies takes each tidy sheet and assigns a year as a prefix to its name (takes the name from get_file_year function)
## It then saves all the tidied sheets into a temporary "accumulate" folder with IND as part of file name

save_tidy_sheet <- function(tidy_sheet, tidy_folder, path) {
  sheet = tidy_sheet$sheet
  tidy = tidy_sheet$data
  file_year <- get_file_year(path)
  write_csv(tidy, paste0(tidy_folder, "/accumulate/", file_year, "-IND-", sheet, ".csv"))
  return(tidy)
}

#-----------------------------------------------------------------

## function that reiteratively takes one sheet from each of IND files for table 13, cleans the column headers according to tidy_tax_i13sheet function, and applies save function to all files
## bi-directional function communicating with 'save_tidy_sheet' and 'tidy_tax_i13sheet' functions

clean_taxfile <- function(filepath, tidy_folder){
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_i13sheet, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
}

#-----------------------------------------------------------------

## function that takes applies the tidy_tax_i13sheet function to all sheets and then the save_tidy_sheet function to all sheets
## bidirectional function communicating with 'tidy_tax_i13sheet' and 'save_tidy_sheet' functions

merge_taxfile <- function(tidy_folder) {
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_i13sheet, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
  
}

#-----------------------------------------------------------------

## function that takes merged csvs for sheet13 for all years for individuals and outputs them as one csv in the data-tidy folder
## this bidirectional function calls 'merge_subfolder' and 'merged_taxfile' functions
## and assigns the suffix 'merge_13_IND' to saved csvs

merge_taxfiles <- function(tidy_folder, output_folder) {
  sub_folders <- get_sub_folders(tidy_folder) 
  for (sub_folder in sub_folders[-1]) {
    merged_taxfile <- merge_subfolder(sub_folder)
    write_csv(merged_taxfile, paste0(output_folder, "/", "merge_13_IND.csv"))
  }
}


