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
if (!exists(".setup_sourced")) source(here::here("R/setup.R"))
if (!exists(".functions_sourced")) source(here::here("R/functions.R"))


#-------------------------------------------------------------------------------
# Function to tidy individual table 13 provided in one file with multiple sheets by year 

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
  
  #generate data.table with fixed sheet column names
  sheet_13_colnames = str_replace_all(sheet_13_colnames, "\\|\\|", "|")
  
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheet_13_colnames,
               .name_repair = "unique") %>%
    tibble::add_column(year = sheet, .before = 1) 
  
  #filter out only BC Geographies
  tidy_df <- tidy_df %>% filter(str_detect(`postal|area`, "^V") |
                                  str_detect(`postal|area`, "^9") | 
                                  str_detect(`postal|area`, "^59[0-9]{3}") & `level|of|geo` == "31" |
                                  str_detect(`postal|area`, "^59[0-9]{4}") & `level|of|geo` == "21" | 
                                  str_detect(`postal|area`, "^515[0-9]{3}") & `level|of|geo` == "51" |
                                  `level|of|geo` == "11" |
                                  `level|of|geo` == "12") 
  
  tidy_df1 <- tidy_df %>%
    filter(`level|of|geo` == 61) %>%
    mutate(`postal|area` = formatC(as.numeric(`postal|area`), format="f", digits=2))
  
  tidy_df2 <- tidy_df %>%
    filter(`level|of|geo` != 61)
  
  tidy_df <- bind_rows(tidy_df1, tidy_df2) %>%
    arrange(desc(year))
  
  return(list("data" = tidy_df, "sheet" = sheet))
}


#-------------------------------------------------------------------------------
## Function that lists all the xls files with '2004_to_2015' designation in the data-raw folder 

list_input_files_13 <- function(input_folder) {
  files <- list.files(input_folder, pattern = "*.xls", full.names = TRUE)  
  return(files[grep("2004_to_2015_", files)]) 
}

list_input_files_13("data-raw/ind13")


#-------------------------------------------------------------------------------
## Function that applies takes each tidy sheet and assigns a year as a prefix to its name (takes the name from get_file_year function)
## It then saves all the tidied sheets into a temporary folder with IND and sheet as part of file name

save_tidy_sheet_13 <- function(tidy_sheet, tidy_folder, path) {
  sheet = tidy_sheet$sheet
  tidy = tidy_sheet$data
  file_year <- get_file_year(path)

  write_csv(tidy, paste0(tidy_folder, "/", "IND-", sheet, ".csv"))
  return(tidy)
}


#-------------------------------------------------------------------------------
## Function that takes one sheet from each of IND files for table 13, cleans the column headers according to tidy_tax_i13sheet function, and applies save function to all files
## bi-directional function communicating with 'save_tidy_sheet' and 'tidy_tax_i13sheet' functions

clean_taxfile_13 <- function(filepath, tidy_folder){
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_i13sheet, path = filepath) %>%
    map(save_tidy_sheet_13, tidy_folder = tidy_folder, path = filepath)
}


#-------------------------------------------------------------------------------
## Function for taking the list of all xls files in the data-raw folder 
## and implement clean_taxfile() for cleaning column header and saving 
## resulting CSVs in data-tidy folders

clean_taxfiles_13 <- function(input_folder, tidy_folder) {
  files <- list_input_files_13(input_folder)
  for (file in files) {
    clean_taxfile_13(file, tidy_folder)
  }
  
}

#-------------------------------------------------------------------------------
## Calling function for cleaning taxfiles
clean_taxfiles_13("data-raw/ind13", "data-tidy/ind13")


#-------------------------------------------------------------------------------
## Map over tidy sheets and bind rows to make one Table 13
## Write out IND Table 13 CSV

ind13_path <- here("data-tidy/ind13")   
ind13_files <- dir(ind13_path, pattern = "*.csv") 

table13 <- ind13_files %>%
  map(~ read_csv(file.path(ind13_path, .))) %>% 
  reduce(rbind)

write_csv(table13, here("data-output/13_IND.csv"))



