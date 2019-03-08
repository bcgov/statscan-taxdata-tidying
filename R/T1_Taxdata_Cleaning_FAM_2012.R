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

######################################

#For Tables in Families income data
#load income data into R
setwd("~/Desktop/StatCan_IncomeTax_Tidying/Family tables 2013 to 2015")
getwd()
dir.wrk <- "~/Desktop/StatCan_IncomeTax_Tidying/Family tables 2013 to 2015"
dir.wrk <- getwd()

#load libraries
library(data.table)
library(openxlsx)
library(dplyr)
library(stringr)

---------------------------

  
  #read file path for individual income table 1 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2012_Family_Tables_19_20_New_LIM.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 1, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Census_Fam_0_Child",	"Census_Fam_1_Child",	"Census_Fam_2_Child",	"Census_Fam_3_Child",	"Census_Fam_Total",	"Census_Fam_Persons_0_Child",	"Census_Fam_Persons_1_Child",	"Census_Fam_Persons_2_Child",	"Census_Fam_Persons_3_Child",	"Census_Fam_Persons_Total",	"Census_Fam_0_17_Persons_0_Child",	"Census_Fam_0_17_Persons_1_Child",	"Census_Fam_0_17_Persons_2_Child",	"Census_Fam_0_17_Persons_3_Child",	"Census_Fam_0_17_Persons_Total",	"Census_Fam_18_64_Persons_0_Child",	"Census_Fam_18_64_Persons_1_Child", "Census_Fam_18_64_Persons_2_Child",	"Census_Fam_18_64_Persons_3_Child",	"Census_Fam_18_64_Persons_Total",	"Census_Fam_65P_Persons_0_Child",	"Census_Fam_65P_Persons_1_Child",	"Census_Fam_65P_Persons_2_Child",	"Census_Fam_65P_Persons_3_Child",	"Census_Fam_65P_Persons_Total",	"Couple_Fam_0_Child",	"Couple_Fam_1_Child",	"Couple_Fam_2_Child",	"Couple_Fam_3_Child",	"Couple_Fam_Total",	"Couple_Fam_Persons_0_Child",	"Couple_Fam_Persons_1_Child",	"Couple_Fam_Persons_2_Child",	"Couple_Fam_Persons_3_Child",	"Couple_Fam_Persons_Total",	"Couple_Fam_0_17_Persons_0_Child",	"Couple_Fam_0_17_Persons_1_Child",	"Couple_Fam_0_17_Persons_2_Child",	"Couple_Fam_0_17_Persons_3_Child",	"Couple_Fam_0_17_Persons_Total",	"Couple_Fam_18_64_Persons_0_Child",	"Couple_Fam_18_64_Persons_1_Child",	"Couple_Fam_18_64_Persons_2_Child",	"Couple_Fam_18_64_Persons_3_Child",	"Couple_Fam_18_64_Persons_Total",	"Couple_Fam_65P_Persons_0_Child",	"Couple_Fam_65P_Persons_1_Child",	"Couple_Fam_65P_Persons_2_Child",	"Couple_Fam_65P_Persons_3_Child",	"Couple_Fam_65P_Persons_Total",	"LoneParent_Fam_1_Child",	"LoneParent_Fam_2_Child",	"LoneParent_Fam_3_Child", "LoneParent_Fam_Total",	"LoneParent_Fam_Persons_1_Child", "LoneParent_Fam_Persons_2_Child",	"LoneParent_Fam_Persons_3_Child",	"LoneParent_Fam_Persons_Total",	"LoneParent_Fam_Persons_0_17_1_Child",	"LoneParent_Fam_Persons_0_17_2_Child",	"LoneParent_Fam_Persons_0_17_3_Child",	"LoneParent_Fam_Persons_0_17_Total",	"LoneParent_Fam_Persons_18_64_1_Child",	"LoneParent_Fam_Persons_18_64_2_Child",	"LoneParent_Fam_Persons_18_64_3_Child",	"LoneParent_Fam_Persons_18_64_Total",	"LoneParent_Fam_Persons_65P_1_Child",	"LoneParent_Fam_Persons_65P_2_Child",	"LoneParent_Fam_Persons_65P_3_Child",	"LoneParent_Fam_Persons_65P_Total",	"Non_Fam_0_Child",	"Non_Fam_Total", "Non_Fam_Persons_0_Child",	"Non_Fam_Persons_Total",	"Non_Fam_Persons_0_17_0_Child",	"Non_Fam_Persons_0_17_Total",	"Non_Fam_Persons_18_64_0_Child",	"Non_Fam_Persons_18_64_Total",	"Non_Fam_Persons_65P_0_Child",	"Non_Fam_Persons_65P_Total",	"AllFam_0_Child",	"AllFam_1_Child",	"AllFam_2_Child",	"AllFam_3_Child", "AllFam_Total",	"AllFam_Persons_0_Child",	"AllFam_Persons_1_Child",	"AllFam_Persons_2_Child",	"AllFam_Persons_3_Child", 	"AllFam_Persons_Total",	"AllFam_0_17_Persons_0_Child",	"AllFam_0_17_Persons_1_Child",	"AllFam_0_17_Persons_2_Child",	"AllFam_0_17_Persons_3_Child",	"AllFam_0_17_Persons_Total",	"AllFam_18_64_Persons_0_Child",	"AllFam_18_64_Persons_1_Child",	"AllFam_18_64_Persons_2_Child",	"AllFam_18_64_Persons_3_Child",	"AllFam_18_64_Persons_Total",	"AllFam_65P_Persons_0_Child",	"AllFam_65P_Persons_1_Child",	"AllFam_65P_Persons_2_Child",	"AllFam_65P_Persons_3_Child",	"AllFam_65P_Persons_Total")

dat1 <- na.omit(dat1)

#Extract the BC subset of the data in table 1


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
#Output the generated table 1

write.table(df, file ="2012_Family_Table_19_New_LIM.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 1 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2012_Family_Tables_19_20_New_LIM.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 2, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Census_Fam_lowInc_0_Child",	"Census_lowInc_Fam_1_Child",	"Census_Fam_lowInc_2_Child",	"Census_Fam_lowInc_3_Child",	"Census_Fam_lowInc_Total",	"Census_Fam_AfterTax_Median_LowInc_0_Child",	"Census_Fam_AfterTax_Median_LowInc_1_Child",	"Census_Fam_AfterTax_Median_LowInc_2_Child",	"Census_Fam_AfterTax_Median_LowInc_3_Child",	"Census_Fam_AfterTax_Median_LowInc_Total",	
                 "Couple_Fam_LowInc_0_Child",	"Couple_Fam_LowInc_1_Child",	"Couple_Fam_LowInc_2_Child",	"Couple_Fam_LowInc_3_Child",	"Couple_Fam_LowInc_Total",	"Couple_Fam_LowInc_Median_AfterTax_0_Child",	"Couple_Fam_LowInc_Median_AfterTax_1_Child", "Couple_Fam_LowInc_Median_AfterTax_2_Child",	"Couple_Fam_LowInc_Median_AfterTax_3_Child",	"Couple_Fam_LowInc_Median_AfterTax_Total",	
                 "LoneParent_LowInc_1_Child",	"LoneParent_LowInc_2_Child",	"LoneParent_LowInc_3_Child",	"LoneParent_LowInc_Total", "LoneParent_LowInc_Median_AfterTax_1_Child",	"LoneParent_LowInc_Median_AfterTax_2_Child",	"LoneParent_LowInc_Median_AfterTax_3_Child",	"LoneParent_LowInc_Median_AfterTax_Total",
                 "NonFam_LowInc_0_Child", "NonFam_LowInc_Total", "NonFam_LowInc_Median_AfterTax_0_Child", "NonFam_LowInc_Median_AfterTax_Total", 
                 "All_Fam_LowInc_0_Child",  "All_Fam_LowInc_1_Child",  "All_Fam_LowInc_2_Child",  "All_Fam_LowInc_3_Child",  "All_Fam_LowInc_Total", "All_Fam_LowInc_Median_AfterTax_0_Child",  "All_Fam_LowInc_Median_AfterTax_1_Child",  "All_Fam_LowInc_Median_AfterTax_2_Child",  "All_Fam_LowInc_Median_AfterTax_3_Child",  "All_Fam_LowInc_Median_AfterTax_Total")
dat1 <- na.omit(dat1)

#Extract the BC subset of the data in table 2


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
#Output the generated table 2

write.table(df, file ="2012_Family_Table_20_New_LIM.csv", sep = ",", row.names = FALSE)


---------------------------
  
  #combine/merge all subsheets into one table

df1 <- read.table(file ="2012_Family_Table_19_New_LIM.csv", sep = ",")
df2 <- read.table(file ="2012_Family_Table_20_New_LIM.csv", sep = ",")


DFs <- data.frame(cbind(df1, df2[,6:ncol(df2)], col.names = T))

View(DFs)

write.table(DFs, file ="2012_Family_Table_19_20_LIM.csv", sep = ",", row.names = FALSE, col.names = TRUE)

---------------------------
  
  
  
  