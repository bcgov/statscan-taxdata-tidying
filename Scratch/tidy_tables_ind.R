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

library(dplyr)
library(readxl)
library(purrr)
library(readr)
library(here)
library(tidyr)
library(stringr)

tidy_tax_ind <- function(sheet, skip, col_names, path) {
  
  pathbase <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
  
  if (sheet %in% c("3A", "3B", "3C", "8", "9")) {
    tempcols <- c("one", "two")
  } else tempcols <- c("one", "two", "three")
                     
  sheetcolnames <- path %>%
    read_excel(sheet = sheet, skip = 1, n_max = 3, col_names = FALSE) %>%
    t() %>% 
    as_tibble(.name_repair = ~ tempcols) %>% 
    fill(tempcols) %>% 
    unite(sheet_col_names) %>% 
    mutate(sheet_col_names = paste("I", sheet, sheet_col_names, sep = '_'),
           sheet_col_names = str_replace(sheet_col_names, "_NA_NA|_NA", "")) %>% 
    select(sheet_col_names) %>% 
    pull()
  
  tidy_df <- path %>% read_excel(sheet = sheet, skip = 4, col_names = sheetcolnames) 
  
  output <- list(tidy_df)
  
  write_csv(tidy_df, paste0("tmp/", pathbase, "-", sheet, ".csv"))
  
  return(output)
  
}


filename <- "2015_IND_Tables 1_to_13_Canada.xls"
filefolder <- "Data/ind"
filepath <- here(filefolder, filename)

# Get sheet names and positions from .xls file
sheets <- excel_sheets(filepath)

# read sheet name 8
I_2015 <- tidy_tax_ind("3A", path = filepath)
foo <- I_2015[[1]]

# read all sheets
filepath %>%
  excel_sheets() %>%
  set_names() %>% 
  map(tidy_tax_ind, path = filepath)
