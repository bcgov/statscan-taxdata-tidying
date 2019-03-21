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

### BC GEO from 2016 Census ###
# download BC Geo csv from STATCAN's website: https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/download-telecharger/comp/page_dl-tc.cfm?Lang=E&
# load table: Geo_starting_row_BRITISH_COLUMBIA_CSV.csv into R

folder <- "geo-conversions"
filename <- "Geo_starting_row_BRITISH_COLUMBIA_CSV.csv"
filepath <-  here(folder, filename)


bcgeo <- fread(filepath)
locs2016 <- bcgeo$`Geo Name` #assign geo names from Census 2016 to a new list for filtering 


# filtering for BC Geos (based on data inspection)

locs <- c("59001", "591023", "597051", "59002",
          "59003", "591017", "515950","595041", "59004",
          "591045","594003","593035", "59005", "59006",
          "59007", "593039","591026","59008", "59009",
          "591019", "59010", "59011", "594001", "59026",
          "59012", "592009", "595053", "592015", "59013",
          "59014","596049","515940", "594005", "59015",
          "59016", "515920", "59017", "591043", "591021",
          "59018", "515970","59019", "515960", "59037",
          "593037", "59020", "59021","515980", "598059",
          "593007", "598055", "59022", "59023", "591027",
          "59024", "59025", "59027", "59028", "596047",
          "59029", "59030", "592031", "59031", "597057",
          "591024", "592029", "59032", "59033", "515930",
          "593033", "59034", "59035", "59036", "515910",
          "59038", "59039", "59040", "59041", "59042")

dat1.new <- subset(dat1[dat1$Geo_Level == "11" | dat1$Geo_Level == "12",])
dat2.new <- dat1[,names(dat1) %in% locs] #OR dat2.new <- dat1[,names(dat1) %in% locs2016]
dat3.new <-subset(dat1, grepl("^V", Postal_Area))
dat4.new <-subset(dat1, grepl("^9", Postal_Area))

df <- rbind(dat1.new, dat2.new, dat3.new, dat4.new)

df <- distinct(df)
