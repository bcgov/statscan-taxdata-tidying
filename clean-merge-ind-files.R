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
  check <- sapply(pkgs.missing,require,warn.conflicts = TRUE,character.only = TRUE)
}

#-----------------------------------------------------------------

# function to tidy sheets in one year individual files 


get_file_year <- function(path) {
  # find file_year
  pathbase <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
  
  # assign file_year
  file_year <- pathbase %>% stringr::str_extract("^[0-9]{4}")
  return(file_year)
}

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


# tax data tidying function
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
    
    #process sheet 7A,B,C for some years as necessary (note the errors and implement when running code)/clean column headers
  } # else if (sheet %in% c("7A", "7B", "7C")) {
    #tempcols <- c("one", "two", "three")
    
    #  sheetcolnames <- path %>%
     # read_excel(sheet = sheet, skip = 1, n_max = 3, col_names = FALSE) %>%
    #  t() %>% 
    #  as_tibble(.name_repair = ~ tempcols) %>% 
    #  slice(1:(n()-2)) %>%
     # fill(tempcols) %>% 
    #  unite(sheet_col_names) %>% 
    #      mutate(sheet_col_names = mutate_col_names(sheet_col_names)) %>%
      #select(sheet_col_names) %>%
      #pull()
 # }
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
  if (!(dir.exists(paste0(tidy_folder, "/", sheet)))) {
    dir.create(paste0(tidy_folder, "/", sheet))
 
  }
  write_csv(tidy, paste0(tidy_folder, "/", sheet, "/", file_year, "-IND-", sheet, ".csv"))
  return(tidy)
}

clean_taxfile <- function(filepath, tidy_folder){
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_ind, path = filepath) %>%
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
    map(tidy_tax_ind, path = filepath) %>%
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
  write_csv(merged_taxfile, paste0(output_folder, "/", basename(sub_folder), "_IND.csv"))
  }
}

clean_merge_write <- function(input_folder, tidy_folder, output_folder) {
  clean_taxfiles(input_folder, tidy_folder)
  merge_taxfiles(tidy_folder, output_folder)
}

#-----------------------------------------------------------------

clean_merge_write("data-raw", "data-tidy", "data-output")


