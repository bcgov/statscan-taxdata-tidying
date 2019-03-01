#Copyright 2019 Province of British Columbia
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

#-------------------------------------------------------------------------------------------------

# File Encryption
# load library dependencies
remotes::install_github("ropensci/cyphr", upgrade = FALSE)
library(here)

# To do anything we first need a key:
key <- cyphr::key_sodium(sodium::keygen())

# load and encrypt file
here("file path")
cyphr::encrypt_file("2015_Family_Table_19.csv", key, "2015_Family_Table_19.encrypted.csv")

# the file is encripted now
# let's decrypt to test
cyphr::decrypt_file("2015_Family_Table_19.encrypted.csv", key, "2015_Family_Table_19.clear.csv")
