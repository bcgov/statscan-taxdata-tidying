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
# Family tax data tidying function for each sheet depending on sheet number

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
  #generate data.table with fixed sheet column names
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheetcolnames,
               .name_repair = "unique") %>%
    tibble::add_column(year = file_year, .before = 1) 
  
  #filter out only BC Geographies
  tidy_df <- tidy_df %>% filter(str_detect(`postal|area`, "^V") |
                                  str_detect(`postal|area`, "^9") | 
                                  str_detect(`postal|area`, "^59[0-9]{3}") & `level|of|geo` == "31" |
                                  str_detect(`postal|area`, "^59[0-9]{4}") & `level|of|geo` == "21" | 
                                  str_detect(`postal|area`, "^515[0-9]{3}") & `level|of|geo` == "51" |
                                  `level|of|geo` == "11" |
                                  `level|of|geo` == "12") 
  
  # clean out the extra decimal places introduced by reading xls into R
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
## Function that lists all the xls files with 'Family' designation in the data-tidy/fam folder 

list_input_files_fam <- function(input_folder) {
  files <- list.files(input_folder, pattern = "*.xls", full.names = TRUE)  
  return(files[grep("_Family_", files)]) 
}


#-------------------------------------------------------------------------------
## Function that takes each tidy sheet and assigns a year as a prefix to its name
## (takes the name from get_file_year function)
## It then saves all the tidied sheets into data-tidy/fam folder with FAM as part of file name

save_tidy_sheet_fam <- function(tidy_sheet, tidy_folder, path) {
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
## Function that takes one sheet from each family file, cleans the column headers 
## according to tidy_tax_fam function, and saves with 'save_tidy_sheet_fam' and 'tidy_tax_fam' functions

clean_taxfile_fam <- function(filepath, tidy_folder){
  tidy_sheets <- filepath %>%
    excel_sheets() %>%
    set_names() %>% 
    map(tidy_tax_fam, path = filepath) %>%
    map(save_tidy_sheet_fam, tidy_folder = tidy_folder, path = filepath)
}


#-------------------------------------------------------------------------------
## Function for taking the list of all xls files in the data-raw/fam folder 
## and implement clean_taxfile_fam() for cleaning column header and saving 
## resulting CSVs in data-tidy/fam folders

clean_taxfiles_fam <- function(input_folder, tidy_folder) {
  files <- list_input_files_fam(input_folder)
  for (file in files) {
    clean_taxfile_fam(file, tidy_folder)
  }
}


#-------------------------------------------------------------------------------
## Calling functions for cleaning and saving Family CSV taxfiles
clean_taxfiles_fam("data-raw/fam", "data-tidy/fam")

#-------------------------------------------------------------------------------
## Function writes one merged family csv per Table by merging all files in data-tidy/fam subfolders

merge_taxfiles_fam <- function(tidy_folder, output_folder) {
  sub_folders <- get_sub_folders(tidy_folder) 
  for (sub_folder in sub_folders[-1]) {
    merged_taxfile <- merge_subfolder(sub_folder)
    write_csv(merged_taxfile, paste0(output_folder, "/", basename(sub_folder), "_FAM.csv"))
  }
}


#-------------------------------------------------------------------------------
## Calling function for merging and saving 1 CSV per family taxfile table
merge_taxfiles_fam("data-tidy/fam", "data-output")


