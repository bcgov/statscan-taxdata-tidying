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

#############################################
## I-13 2004_to_2015_IND_Table_13.xls file
############################################

library(dplyr)
library(readxl)
library(purrr)
library(readr)
library(here)
library(tidyr)
library(stringr)
library(tibble)


tidy_tax_i13sheet <- function(sheet, skip, col_names, path) {
  
  types <- c("Couple Families",
             "Lone-Parent Families",
             "Census Families In Low Income",
             "Non-Family Persons",
             "All family units" )
  
  sheet_13_colnames <- read_xls(filepath, sheet = sheet, skip = 1, col_names = FALSE, n_max = 3) %>%
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
    unite(sheet_13_colnames) %>% 
    mutate(sheet_13_colnames = tolower(str_replace_all(sheet_13_colnames, "\\s", "|")),
           sheet_13_colnames = paste("I|13", sheet_13_colnames, sep = '|'),
           sheet_13_colnames = str_replace_all(sheet_13_colnames, "_na_na|_na", "")) %>% 
    select(sheet_13_colnames) %>% 
    pull()
  
  
  tidy_df <- path %>%
    read_excel(sheet = sheet, skip = 4,
               col_names = sheet_13_colnames,
               .name_repair = "unique") %>%
    tibble::add_column(year = sheet, .before = 1) 
  
   write_csv(tidy_df, paste0("data-tidy/", sheet, "-I13", ".csv"))
  
  return(tidy_df)
}



## 2004-2015 I13 .xls file
filename <- "2004_to_2015_IND_Table_13.xls"
filefolder <- "data-raw"
filepath <- here(filefolder, filename)

## get sheet names from file
sheets <- excel_sheets(filepath)

## read one sheet by sheet name 
test <- tidy_tax_i13sheet("2004", path = filepath)


## Read in and add names to all sheets at once
tidy_13_sheets <- filepath %>%
  excel_sheets() %>%
  set_names() %>% 
  map(tidy_tax_i13sheet, path = filepath)


##################################
## Filtering BC rows
##################################

bcfoo <- I_test %>% filter(!grepl("^9", `I|1|postal|area`) &
                             !grepl("^V", `I|1|postal|area`) &
                             `I|1|level|of_geo` != 11 &
                             `I|1|level|of_geo` != 12)

bcfoo2 <- bcfoo %>% filter(`I|1|place|name_geo` %in% locs)



locs <- c("ALBERNI-CLAYOQUOT",
          "ABBOTSFORD", "ABBOTSFORD - MISSION", "BURNABY NORTH-SEYMOUR", "BURNABY SOUTH", "BULKLEY-NECHAKO", 
          "CAPITAL", "CARIBOO", "CARIBOO", "CARIBOO-PRINCE GEORGE", "CENTRAL COAST", "CENTRAL KOOTENAY",
          "CENTRAL OKANAGAN", "CENTRAL OKANAGAN-SIMILKAMEEN-NICOLA", "CHILLIWACK", "CHILLIWACK-HOPE", "CLOVERDALE-LANGLEY CITY",
          "COLUMBIA-SHUSWAP", "COQUITLAM-PORT COQUITLAM", "COURTENAY-ALBERNI", "COWICHAN VALLEY",
          "COWICHAN-MALAHAT-LANGFORD", "DELTA", "EAST KOOTENAY", "ESQUIMALT-SAANICH-SOOKE", "FLEETWOOD-PORT KELLS", "FRASER VALLEY",
          "FRASER-FORT GEORGE", "GREATER VANCOUVER", "KAMLOOPS", "KAMLOOPS-THOMPSON-CARIBOO",
          "KELOWNA", "KELOWNA-LAKE COUNTRY", "KITIMAT-STIKINE", "KOOTENAY",
          "KOOTENAY BOUNDARY","KOOTENAY-COLUMBIA",
          "LANGLEY-ALDERGROVE", "LOWER MAINLAND--SOUTHWEST",
          "NANAIMO", "NANAIMO-LADYSMITH",
          "NEW WESTMINSTER-BURNABY", "NORTH COAST",
          "NORTH ISLAND-POWELL RIVER","NORTH OKANAGAN",
          "NORTH OKANAGAN-SHUSWAP", "NORTH VANCOUVER",
          "NORTHEAST","NORTHERN ROCKIES",
          "OKANAGAN-SIMILKAMEEN", "PARKSVILLE",
          "PEACE RIVER", "PITT MEADOWS-MAPLE RIDGE",
          "POWELL RIVER", "PRINCE GEORGE",
          "PRINCE GEORGE-PEACE RIVER-NORTHERN ROCKIES", "PRINCE RUPERT",
          "RICHMOND CENTRE", "SAANICH-GULF ISLANDS",
          "SKEENA-BULKLEY VALLEY", "SKEENA-QUEEN CHARLOTTE",
          "SOUTH OKANAGAN-WEST KOOTENAY", "SOUTH OKANAGAN-WEST KOOTENAY",
          "SQUAMISH-LILLOOET", "STEVESTON-RICHMOND EAST", "STIKINE", "STRATHCONA", "SUNSHINE COAST", "SURREY CENTRE",
          "SURREY-NEWTON", "TERRACE", "THOMPSON--OKANAGAN", "THOMPSON-NICOLA", "VANCOUVER CENTRE", "VANCOUVER EAST", "VANCOUVER GRANVILLE", "VANCOUVER ISLAND AND COAST",
          "VANCOUVER KINGSWAY", "VANCOUVER QUADRA", "VANCOUVER SOUTH","VICTORIA", "WEST VANCOUVER-SUNSHINE COAST-SEA TO SKY COUNTRY")

dat1.new <- subset(dat1[dat1$Geo_Level == "11" | dat1$Geo_Level == "12",])
dat2.new <- dat1[,names(dat1) %in% locs]
dat3.new <-subset(dat1, grepl("^V", Postal_Area))
dat4.new <-subset(dat1, grepl("^9", Postal_Area))

df <- rbind(dat1.new, dat2.new, dat3.new, dat4.new)

df <- distinct(df)

# check for duplicates in df #2480 rows
foo <- df[duplicated(df),] #766 duplicate rows
df2 <- unique(df) # filter out duplicates == 1714 rows



