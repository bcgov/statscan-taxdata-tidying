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

# Function to clean column names for IND files
mutate_col_names <- function(sheet_col_names) {
  sheet_col_names = str_replace_all(sheet_col_names, "_NA_NA|_NA", "")
  sheet_col_names = tolower(str_replace_all(sheet_col_names, "\\s", "|"))
  sheet_col_names = str_replace_all(sheet_col_names, "_", "|")
  return(sheet_col_names)
}


## Tax data tidying function for individual tables 
## (uses get_file_year() from setup.R)
tidy_tax_ind <- function(sheet, path) {

  print(paste0("processing ", sheet, " of ", path))
  file_year <- get_file_year(path)
  
  #process sheet 8/clean column headers
  
  if(sheet == "8") {
    
    sheetcolnames <- read_xls(path, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
      t() %>% 
      as_tibble(.name_repair = ~ c("one", "three")) %>% 
      mutate(two = case_when(one == "$'000" ~ "$'000", TRUE ~ NA_character_),
             one = case_when(two == "$'000" ~ NA_character_, TRUE ~ one)) %>% 
      select(one, two, three) %>% 
      fill(one, three) %>%  # fill empty cells
      unite(sheet_col_names) %>% 
      mutate(sheet_col_names = mutate_col_names(sheet_col_names)) %>%
      select(sheet_col_names) %>% 
      pull()
  }
  
  #process sheet 13/clean column headers
  else if(sheet == "13") {
    
    types <- c("Couple Families",
               "Lone-Parent Families",
               "Census Families In Low Income",
               "Non-Family Persons",
               "All family units" )
    
    sheetcolnames <- read_xls(path, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
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
  }
    
  else {
    
    #process sheet 3A, 3B, 3C, 9 and other sheets/clean column headers
    
    if (sheet %in% c("3A", "3B", "3C", "9")) {
      tempcols <- c("one", "two") 
    } else tempcols <- c("one", "two", "three")
    
    sheetcolnames <- path %>%
      read_excel(sheet = sheet, skip = 1, n_max = 3, col_names = FALSE) %>%
      t() %>% 
      as_tibble(.name_repair = ~ tempcols) %>% 
      fill(tempcols) %>% 
      unite(sheet_col_names) %>% 
      mutate(sheet_col_names = mutate_col_names(sheet_col_names)) %>%
      mutate(sheet_col_names = str_replace(sheet_col_names, "l.o.g.", "level|of|geo")) %>% 
      select(sheet_col_names) %>% 
      pull()
  }
  
  # generate data.table with fixed sheet column names
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheetcolnames,
               .name_repair = "unique") %>%
    remove_empty_rows() %>% 
    tibble::add_column(year = file_year, .before = 1)  
  
  # filter out only BC Geographies
  tidy_df <- tidy_df %>% filter(str_detect(`postal|area`, "^V") |
                                  str_detect(`postal|area`, "^9") | 
                                  str_detect(`postal|area`, "^59[0-9]{3}") & `level|of|geo` == "31" |
                                  str_detect(`postal|area`, "^59[0-9]{4}") & `level|of|geo` == "21" | 
                                  str_detect(`postal|area`, "^515[0-9]{3}") & `level|of|geo` == "51" |
                                  `level|of|geo` == "11" |
                                  `level|of|geo` == "12") 

  return(list("data" = tidy_df, "sheet" = sheet))
}

#######################
## TESTING SNIPPET ####
#######################

## Example Table I .xls file
filename <- "2002_IND_Tables 1_to_7_Canada.xls"
filefolder <- "data-raw/ind"
filepath <- here(filefolder, filename)

## Read one sheet by sheet name
I_test <- tidy_tax_ind("7A", path = filepath)

## Read in and add names to all sheets at once
tidy_sheets <- filepath %>%
  excel_sheets() %>%
  set_names() %>%
  map(tidy_tax_ind, path = filepath)


#-----------------------------------------------------------------

## Function that lists all the xls files with 'IND' designation
## in a destination` folder 
list_input_files <- function(input_folder) {
  files <- list.files(input_folder, pattern = "*.xls", full.names = TRUE)  
  return(files[grep("_IND_", files)]) 
}

list_input_files("data-raw/ind")

#-----------------------------------------------------------------

## Function to save each tidied CSV sheet to a table folder with year as a filename prefix  
##  (takes the name using the get_file_year() from setup.R) and IND as part of filename

save_tidy_sheet <- function(tidy_sheet, tidy_folder, path) {
  sheet = tidy_sheet$sheet
  tidy = tidy_sheet$data
  file_year <- get_file_year(path)
  if (!(dir.exists(paste0(tidy_folder, "/", sheet)))) {
    dir.create(paste0(tidy_folder, "/", sheet))
 
  }
  write_csv(tidy, paste0(tidy_folder, "/", sheet, "/", file_year, "-IND-", sheet, ".csv"))
  return(tidy)
}


#-----------------------------------------------------------------

## Function that iterates over each IND xls file and
## imports each sheet using clean column headers according to tidy_tax_ind(), saves
## each sheet with save_tidy_sheet()'


clean_taxfile <- function(filepath, tidy_folder){
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_ind, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
}


clean_taxfiles("data-raw/ind", "data-tidy")

#### 2002 Table 7A not working: last 2 columns empty, so when read in w/o headers
#### these are dropped by read_excel and then the column name vector is too long




#-----------------------------------------------------------------

## function that takes applies the tidy_tax_ind function to all sheets and applies 
## the save_tidy_sheet function to all sheets
## bidirectional function communicating with 'tidy_tax_ind' and 'save_tidy_sheet' functions

merge_taxfile <- function(tidy_folder) {
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_ind, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
  
}

#-----------------------------------------------------------------

## function that takes the merged IND csvs and outputs them as one csv in the data-tidy folder
## this bidirectional function calls 'merge_subfolder' and 'merged_taxfile' functions
## and assigns the suffix 'IND' to saved csvs

merge_taxfiles <- function(tidy_folder, output_folder) {
  sub_folders <- get_sub_folders(tidy_folder) 
  for (sub_folder in sub_folders[-1]) {
  merged_taxfile <- merge_subfolder(sub_folder)
  write_csv(merged_taxfile, paste0(output_folder, "/", basename(sub_folder), "_IND.csv"))
  }
}


