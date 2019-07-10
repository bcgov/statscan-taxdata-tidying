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

## Make new directories if they do not exist


if (!exists(here("tests/data-test"))) dir.create(here("tests/data-test"), showWarnings = FALSE)
if (!exists(here("/tests/data-test/fam"))) dir.create(here("tests/data-test/fam"), showWarnings = FALSE)
if (!exists(here("/tests/data-test/ind"))) dir.create(here("tests/data-test/ind"), showWarnings = FALSE)
if (!exists(here("/tests/data-test/ind13"))) dir.create(here("tests/data-test/ind13"), showWarnings = FALSE)



# Steps to validation -----------------------------------------------------

# - Regenerate all the tidied data for all of Canada
# - Choose and import random raw data file and then import corresponding tidied data
# - Sort and compare several different columns



# Regenerate all the tidied data for all of Canada ------------------------

## Load functions
source("ind-clean.R")
source("tests/test-helpers.R")

## Runs functions
## Calling functions for cleaning and saving Family CSV taxfiles for all data
clean_taxfiles_ind("data-raw/ind", "tests/data-test/ind", filter_BC = FALSE)


# Choose and import random raw data file and then import correspon --------

## Chose a random family data file
set.seed(42)
(random_path <- sample(list_input_files_ind(here("data-raw/ind/")), 1))
random_sheet <- sample(c("1", "2", "3A", "3B", "3C", "4", "5A", "5B", "5C", "6"), 1)

## Read in random sheet
raw <- read_excel(random_path, sheet = random_sheet, skip = 4, col_names = FALSE)
## Always four trailing rows with no data. Removing them here
raw <- raw[1:(nrow(raw)-4),]

## Parse random raw to get corresponding tidied
file_year <- substr(basename(random_path), 1,4)
tidied_path <- list.files(path = file.path("tests/data-test/ind", random_sheet), pattern = file_year, full.names = TRUE)

tidy <- read_csv(tidied_path, col_types = tidy_spec_from_raw(raw))



# Sort and compare several different columns ------------------------------

col <- names(tidy)[!names(tidy) %in% "year"]

comparisons <- map_dfr(col, ~compare_raw_to_tidy(.x, raw, tidy))

## comparisons minus characters
comparisons[!is.na(comparisons$valid),]

# Take all numeric columns read in with readr::read_csv and check if there any decimal places
tidy_ind_path <-  list.files("tests/data-test/ind", pattern = ".csv", recursive = TRUE, full.names = TRUE)
map_dfr(tidy_ind_path, check_numeric_cols_for_rounding)
