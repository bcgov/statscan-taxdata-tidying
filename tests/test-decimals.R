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
if (!exists(".setup_sourced")) source(here::here("R", "setup.R"))
if (!exists(".functions_sourced")) source(here("R", "functions.R"))

#-------------------------------------------------------------------------------

# Take a random table from cleanedup files 
# and test for decimal places

random_table <- sample(list.files(here("data-output"),  pattern = "*.csv"), 1)
TableX <- data.table::fread(here::here("data-output", random_table))
glimpse(TableX) 

#-------------------------------------------------------------------------------

## For any random table:
# function to find number of characters in postal|area field for all postal codes
# note: census tracts are not included
char_counts<-function(x){stopifnot(class(x)=="character")
  x<-gsub("(.*)(\\.)|([0]*$)","",x)
  nchar(x)
}

x <- char_counts(TableX$`postal|area`)
y <- as.data.frame(x)
range(y$x) 

# explore where the characters are coming from in TableX
TableX$`postal|area`[1] # the census tracts ara not picked up by this function
TableX$`postal|area`[780]
TableX$`postal|area`[989]

pa_count <- data.frame(Group=TableX$`postal|area`, col=nchar(TableX$`postal|area`))
range(pa_count$col)
#-------------------------------------------------------------------------------

## For any random table:
# to find number of characters after '.' in postal|area field related to census tracts
TableX_ct <- as.data.frame(na.omit(sub("^[^.]*", "", TableX$`postal|area`)))
glimpse(TableX_ct)
colnames(TableX_ct) <- "CTs"
levels(TableX_ct$CTs)

#-------------------------------------------------------------------------------


## For any random table:
# explore a random column in TableX and count the decimal places
# e.g. check for a particular column and count range of characters per row
range(nchar(gsub("(.*\\.)|([0]*$)", "", as.character(TableX$`male|partners|in|couple|families|cctb|$'000`)))) # note: column names are unique for each table

# or: calculate the number of characters of every string in all the rows of a column 
z <- data.frame(Group=TableX$`male|partners|in|couple|families|cctb|$'000`, col=nchar(TableX$`male|partners|in|couple|families|cctb|$'000`))
range(z$col)

#-------------------------------------------------------------------------------



