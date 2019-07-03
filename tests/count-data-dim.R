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

## Load setup script
source("R/setup.R")

# assign file paths

IND_path <- list.files(here("data-output"), pattern = "IND.*csv")
print(IND_path)

FAM_path <- list.files(here("data-output"), pattern = "FAM.*csv")
print(FAM_path)

#-------------------------------------------------------------------------------
# finding columns and rows for one file at a time
nrow(data.table::fread(here("data-output", "1_IND.csv")))
ncol(data.table::fread(here("data-output", "1_IND.csv")))
#-------------------------------------------------------------------------------

# function to read files in batches for all individuals

read_csv_files <- IND_path %>%
    map(function(x) nrow(data.table::fread(file.path(here("data-output"), x)))) %>%
    reduce(rbind)

x <- read_csv_files
class(x)

read_csv_files <- IND_path %>%
  map(function(y) ncol(data.table::fread(file.path(here("data-output"), y)))) %>%
  reduce(rbind)

y <- read_csv_files
class(y)
#-------------------------------------------------------------------------------

# write out the table summary for individuals
IND <- cbind(x,y)
colnames(IND) <- c("rows", "columns")
rownames(IND) <- IND_path

write.csv(IND, here("docs", "individual_tables_summary.csv"))
#-------------------------------------------------------------------------------

# function to read files in batches for families

read_csv_files <- FAM_path %>%
  map(function(x) nrow(data.table::fread(file.path(here("data-output"), x)))) %>%
  reduce(rbind)

h <- read_csv_files
class(h)

read_csv_files <- FAM_path %>%
  map(function(y) ncol(data.table::fread(file.path(here("data-output"), y)))) %>%
  reduce(rbind)

z <- read_csv_files
class(z)
#-------------------------------------------------------------------------------

# write out the table summary for families
FAM <- cbind(h,z)
colnames(FAM) <- c("rows", "columns")
rownames(FAM) <- FAM_path

write.csv(FAM, here("docs","families_tables_summary.csv"))

#-------------------------------------------------------------------------------

# finding year range of each csv 
unique(data.table::fread(here("data-output", "1_IND.csv"))$year)

# or
data.table::fread(here("data-output", "1_IND.csv")) %>%
  select(year) %>%
  unique() %>%
  reduce(rbind)

#-------------------------------------------------------------------------------

# function to get the years of individual data frames

IND_years <- list.files(here("data-output"), pattern = "IND.*csv")
print(IND_years)

ind_file_names <- function(path) {
  get_file_name <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
}

read_ind_files <- function(path) {
  file <- path %>% 
  map(function(x) data.table::setnames(data.table::fread(x), c("table", "year"))) %>% 
    select(table <- s)
  
  merged_table <- do.call(plyr::rbind.fill, file) 
  write_csv(merged_table, here("docs", "individual_table_years.csv"))
}

s <- ind_file_names(IND_years)
i <- read_ind_files(IND_years)
#-------------------------------------------------------------------------------

# function to get the years of family data frames

FAM_years <- list.files(here("data-output"), pattern = "FAM.*csv") 
print(FAM_years)

fam_file_names <- function(path) {
  get_file_name <- path %>%
    basename() %>%
    tools::file_path_sans_ext()
}

read_fam_files <- function(path) {
  file <- path %>% 
    map(function(x) data.table::setnames(data.table::fread(x), c("table", "year"))) %>% 
    select(table <- r)
  
  merged_table <- do.call(plyr::rbind.fill, file) 
  write_csv(merged_table, here("docs", "family_table_years.csv"))
}

r <- fam_file_names(FAM_years)
w <- read_fam_files(FAM_years)

  