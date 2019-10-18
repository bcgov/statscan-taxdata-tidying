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


## Run 3 data wrangling scripts in order:


# family ------------------------------------------------------------------

## Load functions
source("fam-clean.R")

## Runs functions
## Calling functions for cleaning and saving Family CSV taxfiles
clean_taxfiles_fam("data-raw/fam", "data-tidy/fam")

## Calling function for merging and saving 1 CSV per family taxfile table
merge_taxfiles_fam("data-tidy/fam", "data-output")



# Individual --------------------------------------------------------------

source("ind-clean.R")

## Calling function for cleaning taxfiles
clean_taxfiles_ind("data-raw/ind", "data-tidy/ind")

## Calling function for merging and saving 1 CSV per individual taxfile table
merge_taxfiles_ind("data-tidy/ind", "data-output")


# Individual Table 13 -----------------------------------------------------

source("ind-clean-13.R")

## Calling function for cleaning taxfiles
clean_taxfiles_13("data-raw/ind13", "data-tidy/ind13")

## Map over tidy sheets and bind rows to make one Table 13
## Write out IND Table 13 CSV

ind13_path <- here("data-tidy/ind13")   
ind13_files <- dir(ind13_path, pattern = "*.csv") 

table13 <- ind13_files %>%
  map(~ read_csv(file.path(ind13_path, .))) %>% 
  reduce(rbind)

write_csv(table13, here("data-output/13_IND.csv"),  na = "X")



