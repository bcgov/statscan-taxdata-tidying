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

# load package dependencies
library(here)
library(dplyr)

# chose the file location
# here("file path to data folder") 

# load data by referring to 01.load.R scripts
# Since the data is at federal Canada level, we need to extract BC Geographies out
# extract the BC geographical concepts in data tables

locs <- c("ALBERNI-CLAYOQUOT",
          "ABBOTSFORD", "ABBOTSFORD - MISSION", "BURNABY NORTH-SEYMOUR", "BURNABY SOUTH", "BULKLEY-NECHAKO", 
          "CAPITAL", "CARIBOO", "CARIBOO", "CARIBOO-PRINCE GEORGE", "CENTRAL COAST", "CENTRAL KOOTENAY",
          "CENTRAL OKANAGAN", "CENTRAL OKANAGAN-SIMILKAMEEN-NICOLA", "CHILLIWACK", "CHILLIWACK-HOPE", "CLOVERDALE-LANGLEY CITY",
          "COLUMBIA-SHUSWAP", "COMOX VALLEY", "COQUITLAM-PORT COQUITLAM", "COURTENAY-ALBERNI", "COWICHAN VALLEY",
          "COWICHAN-MALAHAT-LANGFORD", "CRANBROOK", "DELTA", "EAST KOOTENAY", "ESQUIMALT-SAANICH-SOOKE", "FLEETWOOD-PORT KELLS", "FRASER VALLEY",
          "FRASER-FORT GEORGE", "GREATER VANCOUVER", "KAMLOOPS", "KAMLOOPS-THOMPSON-CARIBOO",
          "KELOWNA", "KELOWNA-LAKE COUNTRY", "KITIMAT-STIKINE", "KOOTENAY",
          "KOOTENAY BOUNDARY","KOOTENAY-COLUMBIA",
          "LANGLEY-ALDERGROVE", "LOWER MAINLAND--SOUTHWEST", "MISSION-MATSQUI-FRASER CANYON", "MOUNT WADDINGTON",
          "NANAIMO", "NANAIMO-LADYSMITH", "NECHAKO",
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

# check for duplicated rows and remove them (assign to re-new df)
df <- distinct(df)


# Output the sub-sheets generated into a .csv format file 
write.table(df, file ="2015_Individuals_Table_1_BC.csv", sep = ",", row.names = FALSE)
