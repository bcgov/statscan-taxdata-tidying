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

# load dependencies

pkgs <-c("plyr", "janitor", "tibble", "stringr", "tidyr", "here", "readr", "purrr", "readxl", "dplyr")
check <- sapply(pkgs,require,warn.conflicts = TRUE,character.only = TRUE)
if(any(!check)){
  pkgs.missing <- pkgs[!check]
  install.packages(pkgs.missing)
  check <- sapply(pkgs.missing,require,warn.conflicts = TRUE, character.only = TRUE)
}

#-----------------------------------------------------------------

# function to clean column sheet names  
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

# function to tidy sheets in multiple sheet years for individual table 13  

tidy_tax_i13sheet <- function(sheet, skip, col_names, path) {
  print(paste0("proceesing sheet ", sheet))
  
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


list_input_files <- function(input_folder) {
  files <- list.files(input_folder, pattern = "*.xls", full.names = TRUE)  
  return(files[grep("_IND_", files)]) 
}

save_tidy_sheet <- function(tidy_sheet, tidy_folder, path) {
  sheet = tidy_sheet$sheet
  tidy = tidy_sheet$data
  file_year <- get_file_year(path)
  write_csv(tidy, paste0(tidy_folder, "/accumulate/", file_year, "-IND-", sheet, ".csv"))
  return(tidy)
}

clean_taxfile <- function(filepath, tidy_folder){
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_i13sheet, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
}

clean_taxfiles <- function(input_folder, tidy_folder) {
  files <- list_input_files(input_folder)
  for (file in files) {
    clean_taxfile(file, tidy_folder)
  }
  
}

merge_taxfile <- function(tidy_folder) {
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_i13sheet, path = filepath) %>%
    map(save_tidy_sheet, tidy_folder = tidy_folder, path = filepath)
  
}

get_sub_folders <- function(tidy_folder) {
  return(list.dirs(tidy_folder))
}

merge_subfolder <- function(sub_folder) {
  print(paste0("processing ", sub_folder))
  csv_files <- list.files(sub_folder, pattern = "*.csv", full.names = TRUE) %>% 
    lapply(function(file){
      read.csv(file = file, header = TRUE,  check.names = FALSE)
    }) 
  big_object <- do.call(plyr::rbind.fill, csv_files)
  return(big_object)
  
}

merge_taxfiles <- function(tidy_folder, output_folder) {
  sub_folders <- get_sub_folders(tidy_folder) 
  for (sub_folder in sub_folders[-1]) {
    merged_taxfile <- merge_subfolder(sub_folder)
    write_csv(merged_taxfile, paste0(output_folder, "/", "merge_13_IND.csv"))
  }
}

clean_merge_write <- function(input_folder, tidy_folder, output_folder) {
 clean_taxfiles(input_folder, tidy_folder)
  merge_taxfiles(tidy_folder, output_folder)
}

#-----------------------------------------------------------------

clean_merge_write("data-raw", "data-tidy", "data-output")
