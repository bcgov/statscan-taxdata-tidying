# Copyright 2020 Province of British Columbia
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



library(tidyverse)
library(writexl)



files <- list.files("data-output", pattern = "*.csv", full.names = TRUE)

summarise_output <- function(file) {
  outputs <- readr::read_csv(file)
  name <- basename(file)
  data.frame(
    File_Name = "Stats Cda; 2004_2016_Family_BC",
    FieldName = colnames(outputs),
    FieldLength = NA,
    DataType = map_chr(outputs, typeof),
    Field_Format = "field names separated by pipes",
    IDD_Classification = name,
    Field_Description = "Table F-1 Family data  -  Summary census family income table",
    stringsAsFactors = FALSE
  ) %>%
    mutate(DataType = case_when(
      DataType == "double" ~ "numeric",
      DataType == "character" ~ "string",
      TRUE ~ DataType
    ))
}

all_files_meta <- map_dfr(files, summarise_output)
write_xlsx(all_files_meta, "docs/DIP_Statscan_20200611.xlsx")

## Some 
## use map_chr instead of sapply as it is safer with respect to outputs (vapply would also work)
## extracted everything into one function and then iterated on a file to file basis. Easier to debug in the future
## allow for other column type than just strings and numbers
## outputting an excel file and using a named object instead of .Last.value

# merge_outputs <- function(outputs) {
#   print(paste0("processing ", outputs))
#   csv_files <- list.files(outputs, pattern = "*.csv", full.names = TRUE) %>% 
#     lapply(function(file){
#       outputs <- read_csv(file = file)
#       name <- basename(file)
#       df <- data.frame(File_Name = "Stats Cda; 2004_2016_Family_BC",
#                        FieldName = colnames(outputs), 
#                        FieldLength = NA,
#                        DataType = sapply(outputs, typeof), 
#                        Field_Format = "field names separated by pipes",
#                        IDD_Classification = name,
#                        Field_Description = "Table F-1 Family data  -  Summary census family income table",
#                        stringsAsFactors = FALSE) %>% 
#         mutate(DataType = case_when (
#           DataType == "double" ~ "numeric",
#           DataType == "character" ~ "string",
#           TRUE ~ "NA")
#         )
#     }) 
#   big_object <- do.call(plyr::rbind.fill, csv_files)
#   return(big_object)
# }
# 
# merge_outputs("data-output")
# write_csv(.Last.value, "docs/DIP_Statscan_20200609.csv")

