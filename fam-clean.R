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


## Source setup and function scripts

if (!exists(".setup_sourced")) source(here::here("setup.R"))
if (!exists(".functions_sourced")) source(here:("functions.R"))

#-------------------------------------------------------------------------------

# tax data tidying function for each sheet depending on sheet number

tidy_tax_fam <- function(sheet, path) {
  
  print(paste0("processing ", sheet, " of ", path))
  file_year <- get_file_year(path)
  
  # process table 7/clean column headers
  if(sheet == "7") {
    
    sheetcolnames <- read_xls(path, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
      t() %>% 
      as_tibble(.name_repair = ~ c("one", "two", "three"))
    
    sheetcolnames$three[141] <- "$'000"
    sheetcolnames$three[144] <- "$'000"
    sheetcolnames$three[142] <- "EDR"
    sheetcolnames$three[145] <- "$EDR"
    
    sheetcolnames <- sheetcolnames %>% 
      fill(one, two) %>%  # fill empty cells
      unite(sheet_col_names) %>% 
      mutate(sheet_col_names = mutate_col_names(sheet_col_names)) %>%
      select(sheet_col_names) %>% 
      pull()
    
  }
  
  else {
    
    #process other sheets/clean column headers
    
    if (sheet %in% c("2", "3A", "3B", "3C", "13", "14A", "14B")) {
      tempcols <- c("one", "two")
    } else tempcols <- c("one", "two", "three")
    
    sheetcolnames <- path %>%
      read_excel(sheet = sheet, skip = 1, n_max = 3, col_names = FALSE) %>%
      t() %>% 
      as_tibble(.name_repair = ~ tempcols) %>% 
      fill(tempcols) %>% 
      unite(sheet_col_names) %>% 
      mutate(sheet_col_names = mutate_col_names(sheet_col_names)) %>%
      select(sheet_col_names) %>% 
      pull()
    
  }
  # generate data.table with fixed sheet column names
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheetcolnames,
               .name_repair = "unique") %>%
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

#-------------------------------------------------------------------------------

## Function that lists all the xls files with 'Family' designation in the data-tidy folder 

list_input_files <- function(input_folder) {
  files <- list.files(input_folder, pattern = "*.xls", full.names = TRUE)  
  return(files[grep("_Family_", files)]) 
}

#-------------------------------------------------------------------------------

## Function that applies takes each tidy sheet and assigns a year as a prefix to its name (takes the name from get_file_year function)
## It then saves all the tidied sheets into data-tidy folder with FAM as part of file name

save_tidy_sheet <- function(tidy_sheet, tidy_folder, path) {
  sheet = tidy_sheet$sheet
  tidy = tidy_sheet$data
  file_year <- get_file_year(path)
  if (!(dir.exists(paste0(tidy_folder, "/", sheet)))) {
    dir.create(paste0(tidy_folder, "/", sheet))
    
  }
  write_csv(tidy, paste0(tidy_folder, "/", sheet, "/", file_year, "-FAM-", sheet, ".csv"))
  return(tidy)
}

#-------------------------------------------------------------------------------
## Function that reiteratively takes one sheet from each family file, cleans the column headers according to tidy_tax_fam function, and applies save function to all files
## bi-directional function communicating with 'save_tidy_sheet' and 'tidy_tax_fam' functions

clean_taxfile <- function(filepath, tidy_folder){
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_fam, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
}

#-------------------------------------------------------------------------------
## Calling function for cleaning taxfiles

clean_taxfiles("data-raw/fam", "data-tidy")
#-------------------------------------------------------------------------------

## Establish connection to current script

.fam_clean_sourced <- TRUE