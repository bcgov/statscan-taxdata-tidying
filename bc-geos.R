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



#load libraries and dependencies
library(here)
library(data.table)
library(stringr)
library(dplyr)
library(tidyr)

# the code is divided into 3 parts based on three iterations, part 1 contains the final code implemented in tidying tables

#--------------------------------------------------------------------------------------------------------------

### Part 1. BC Geo extraction code ###
# reiteration of code in part 2 

# examine data.frame for NA's
I_test <- I_test[!is.na(I_test$`I|2|postal|area`),]
  

                              
## 1A. extract all geographical concepts in BC
bc_filter <- I_test %>% filter(str_detect(`I|2|postal|area`, "^V") |
                        str_detect(`I|2|postal|area`, "^9") | 
                        str_detect(`I|2|postal|area`, "^59[0-9]{3}") & `I|2|level|of|geo` == "31" |
                        str_detect(`I|2|postal|area`, "^59[0-9]{4}") & `I|2|level|of|geo` == "21" | 
                        str_detect(`I|2|postal|area`, "^515[0-9]{3}") & `I|2|level|of|geo` == "51" |
                        `I|2|level|of|geo` == "11" |
                        `I|2|level|of|geo` == "12")

  
# 1B. Counter test:
# extract all Canada-wide geographical concepts that are NOT in BC
not_bc_filter <-  I_test %>% filter(str_detect(`I|2|postal|area`, "^V", negate = TRUE) &
                                  str_detect(`I|2|postal|area`, "^9", negate = TRUE) & 
                                    str_detect(`I|2|postal|area`, "^59[0-9]{3}", negate = TRUE) & `I|2|level|of|geo` != "31" &
                                    str_detect(`I|2|postal|area`, "^59[0-9]{4}", negate = TRUE) & `I|2|level|of|geo` != "21" &
                                    str_detect(`I|2|postal|area`, "^515[0-9]{3}", negate = TRUE) & `I|2|level|of|geo` != "51" &
                                  `I|2|level|of|geo` != "11" &
                                  `I|2|level|of|geo` != "12")

# e.g. test whether level of geo for 11, 12, 31, 21, and 51 are still present
unique(not_bc_filter$`I|2|level|of|geo`) #they aren't
