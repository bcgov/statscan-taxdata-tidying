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
setwd("~/Data/FAM")
getwd()
dir.wrk <- "~/Data/FAM"
dir.wrk <- getwd()

#load libraries
library(data.table)
library(openxlsx)
library(dplyr)
library(stringr)

---------------------------
  
  #read file path for individual income table 1 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 1, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Taxfiler_Number", "Taxfiler_Age_0_14", "Taxfiler_Age_15_64", "Taxfiler_Age_65P", "Taxfiler_Age_Total",	"All_Families", "All_Fam_Median_Total_Income", "All_Fam_Persons_Median_Income", "All_Fam_No_Persons", "Couple_FAM", "Couple_FAM_Median_Total_Income", "Couple_FAM_Person_Median_Total_Income", "Couple_FAM_Person", "Lone_Parent_FAM", "Lone_Parent_FAM_Median_Total_Income", "Lone_Parent_FAM_Person_Median_Total_Income", "Lone_Parent_FAM_Person", "Non_FAM", "Non_FAM_Median_Total_Income", "Non_FAM_Person_Median_Total_Income", "All_FAM_EI", 	"All_FAM_Median_EI", "Non_FAM_EI", "Non_FAM_Median_EI", "Couple_FAM_Dual_EI", "Couple_FAM_Median_Dual_EI", "Couple_FAM_SingleMale_EI", "Couple_FAM_SingleMale_Median_EI",  "Couple_FAM_SingleFemale_EI", "Couple_FAM_SingleFemale_Median_EI", "Govnt_Transfers_All_Fam", "Govnt_Transfers_All_Fam_Median",	"Govnt_Transfers_Non_Fam", "Govnt_Transfers_Non_Fam_Median", "LaborIncome_Fam", "LaborIncome_receiveEI_Fam", "LaborIncome_Median_EI", "LaborIncome_Non_Fam", "LaborIncome_Non_Fam_receiveEI", "LaborIncome_Non_Fam_Median")
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

write.table(df, file ="2015_Family_Table_1_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 2 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 2, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Parents_CoupleFam_0_4",	"Parents_CoupleFam_5_9",	"Parents_CoupleFam_10_14",	"Parents_CoupleFam_15_19",	"Parents_CoupleFam_20_24",	"Parents_CoupleFam_25_29",	"Parents_CoupleFam_30_34",	"Parents_CoupleFam_35_39",	"Parents_CoupleFam_40_44",	"Parents_CoupleFam_45_49",	"Parents_CoupleFam_50_54",	"Parents_CoupleFam_55_59",	"Parents_CoupleFam_60_64",	"Parents_CoupleFam_65_69",	"Parents_CoupleFam_70_74",	"Parents_CoupleFam_75_79",	"Parents_CoupleFam_80_84",	"Parents_CoupleFam_85P",	"Parents_CoupleFam_Total",	"Parents_CoupleFam_Percent_Taxfiler_Dependent",	"Children_CoupleFam_0_4",	"Children_CoupleFam_5_9",	"Children_CoupleFam_10_14",	"Children_CoupleFam_15_19",	"Children_CoupleFam_20_24",	"Children_CoupleFam_25_29",	"Children_CoupleFam_30_34",	"Children_CoupleFam_35_39",	"Children_CoupleFam_40_44",	"Children_CoupleFam_45_49",	"Children_CoupleFam_50_54",	"Children_CoupleFam_55_59",	"Children_CoupleFam_60_64",	"Children_CoupleFam_65_69",	"Children_CoupleFam_70_74",	"Children_CoupleFam_75_79",	"Children_CoupleFam_80_84",	"Children_CoupleFam_85P",	"Children_CoupleFam_Total", "Children_CoupleFam_Percent_Taxfiler_Dependent", "Parents_LoneParentFam_0_4",	"Parents_LoneParentFam_5_9",	"Parents_LoneParentFam_10_14",	"Parents_LoneParentFam_15_19",	"Parents_LoneParentFam_20_24",	"Parents_LoneParentFam_25_29",	"Parents_LoneParentFam_30_34",	"Parents_LoneParentFam_35_39",	"Parents_LoneParentFam_40_44",	"Parents_LoneParentFam_45_49",	"Parents_LoneParentFam_50_54",	"Parents_LoneParentFam_55_59",	"Parents_LoneParentFam_60_64",	"Parents_LoneParentFam_65_69",	"Parents_LoneParentFam_70_74",	"Parents_LoneParentFam_75_79",	"Parents_LoneParentFam_80_84",	"Parents_LoneParentFam_85P",	"Parents_LoneParentFam_Total",	"Parents_LoneParentFam_Percent_Taxfiler_Dependent",	"Children_LoneParentFam_0_4",	"Children_LoneParentFam_5_9",	"Children_LoneParentFam_10_14",	"Children_LoneParentFam_15_19",	"Children_LoneParentFam_20_24",	"Children_LoneParentFam_25_29",	"Children_LoneParentFam_30_34",	"Children_LoneParentFam_35_39",	"Children_LoneParentFam_40_44",	"Children_LoneParentFam_45_49",	"Children_LoneParentFam_50_54",	"Children_LoneParentFam_55_59",	"Children_LoneParentFam_60_64",	"Children_LoneParentFam_65_69",	"Children_LoneParentFam_70_74",	"Children_LoneParentFam_75_79",	"Children_LoneParentFam_80_84",	"Children_LoneParentFam_85P",	"Children_LoneParentFam_Total",	"Children_LoneParentFam_Percent_Taxfiler_Dependent",	"Persons_NonFam_0_4",	"Persons_NonFam_5_9",	"Persons_NonFam_10_14",	"Persons_NonFam_15_19",	"Persons_NonFam_20_24",	"Persons_NonFam_25_29",	"Persons_NonFam_30_34",	"Persons_NonFam_35_39",	"Persons_NonFam_40_44",	"Persons_NonFam_45_49",	"Persons_NonFam_50_54",	"Parents_CoupleFam_55_59",	"Persons_NonFam_60_64",	"Persons_NonFam_65_69",	"Persons_NonFam_70_74",	"Persons_NonFam_75_79",	"Persons_NonFam_80_84",	"Persons_NonFam_85P",	"Persons_NonFam_Total",	"Persons_NonFam_Percent_Taxfiler_Dependent",	"All_Persons_0_4",	"All_Persons_5_9",	"All_Persons_10_14",	"All_Persons_15_19",	"All_Persons_20_24",	"All_Persons_25_29",	"All_Persons_30_34",	"All_Persons_35_39",	"All_Persons_40_44",	"All_Persons_45_49",	"All_Persons_50_54",	"All_Persons_55_59",	"All_Persons_60_64",	"All_Persons_65_69",	"All_Persons_70_74",	"All_Persons_75_79",	"All_Persons_80_84",	"All_Persons_85P",	"All_Persons_Total",	"All_Persons_Percent_Taxfiler_Dependent",	"Percent_All_Persons_0_4",	"Percent_All_Persons_5_9",	"Percent_All_Persons_10_14",	"Percent_All_Persons_15_19",	"Percent_All_Persons_20_24",	"Percent_All_Persons_25_29",	"Percent_All_Persons_30_34",	"Percent_All_Persons_35_39", "Percent_All_Persons_40_44",	"Percent_All_Persons_45_49",	"Percent_All_Persons_50_54",	"Percent_All_Persons_55_59",	"Percent_All_Persons_60_64",	"Percent_All_Persons_65_69",	"Percent_All_Persons_70_74",	"Percent_All_Persons_75_79",	"Percent_All_Persons_80_84",	"Percent_All_Persons_85P",	"Percent_All_Persons_Total",	"All_Persons_AverageAe")
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

write.table(df, file ="2015_Family_Table_2_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  
  #read file path for individual income table 3 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 3, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "CoupleFam_0_Child_OlderParent_0_24",	"CoupleFam_0_Child_OlderParent_25_34",	"CoupleFam_0_Child_OlderParent_35_44",	"CoupleFam_0_Child_OlderParent_45_54",	"CoupleFam_0_Child_OlderParent_55_64",	"CoupleFam_0_Child_OlderParent_65P",	"CoupleFam_0_Child_OlderParent_Total",	"CoupleFam_0_Child_OlderParent_MedianTotal_Income",	"CoupleFam_1_Child_OlderParent_0_24",	"CoupleFam_1_Child_OlderParent_25_34",	"CoupleFam_1_Child_OlderParent_35_44",	"CoupleFam_1_Child_OlderParent_45_54",	"CoupleFam_1_Child_OlderParent_55_64",	"CoupleFam_1_Child_OlderParent_65P",	"CoupleFam_1_Child_OlderParent_Total",	"CoupleFam_1_Child_OlderParent_MedianTotal_Income",	"CoupleFam_2_Child_OlderParent_0_24",	"CoupleFam_2_Child_OlderParent_25_34",	"CoupleFam_2_Child_OlderParent_35_44",	"CoupleFam_2_Child_OlderParent_45_54",	"CoupleFam_2_Child_OlderParent_55_64",	"CoupleFam_2_Child_OlderParent_65P",	"CoupleFam_2_Child_OlderParent_Total",	"CoupleFam_2_Child_OlderParent_MedianTotal_Income",	"CoupleFam_3_Child_OlderParent_0_24",	"CoupleFam_3_Child_OlderParent_25_34",	"CoupleFam_3_Child_OlderParent_35_44",	"CoupleFam_3_Child_OlderParent_45_54",	"CoupleFam_3_Child_OlderParent_55_64",	"CoupleFam_3_Child_OlderParent_65P",	"CoupleFam_3_Child_OlderParent_Total",	"CoupleFam_3_Child_OlderParent_MedianTotal_Income",	"AllFam_OlderParent_0_24",	"AllFam_OlderParent_25_34",	"AllFam_OlderParent_35_44",	"AllFam_OlderParent_45_54",	"AllFam_OlderParent_55_64",	"AllFam_OlderParent_65P",	"AllFam_OlderParent_Total",	"AllFam_OlderParent_MedianTotal_Income",	"AllFam_AvgSize_OlderParent_0_24",	"AllFam_AvgSize_OlderParent_25_34",	"AllFam_AvgSize_OlderParent_35_44",	"AllFam_AvgSize_OlderParent_45_54",	"AllFam_AvgSize_OlderParent_55_64",	"AllFam_AvgSize_OlderParent_65P",	"AllFam_AvgSize_OlderParent_Total",	"AllFam_AvgSize_MedianTotal_Income",	"AllFam_WithChild_AvgSize_OlderParent_0_24",	"AllFam_WithChild_AvgSize_OlderParent_25_34",	"AllFam_WithChild_AvgSize_OlderParent_35_44",	"AllFam_WithChild_AvgSize_OlderParent_45_54",	"AllFam_WithChild_AvgSize_OlderParent_55_64",	"AllFam_WithChild_AvgSize_OlderParent_65P",	"AllFam_AvgSize_OlderParent_Total",	"AllFam_AvgSize_MedianTotal_Income")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 3

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

#Output the generated table 3

write.table(df, file ="2015_Family_Table_3A_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  #read file path for individual income table 4 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 4, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "LoneParentFam_1_Child_0_24",	"LoneParentFam_1_Child_25_34",	"LoneParentFam_1_Child_35_44",	"LoneParentFam_1_Child_45_54",	"LoneParentFam_1_Child_55_64",	"LoneParentFam_1_Childt_65P",	"LoneParentFam_1_Child_Total",	"LoneParentFam_1_Child_MedianTotal_Income",	"LoneParentFam_2_Child_0_24",	"LoneParentFam_2_Child_25_34",	"LoneParentFam_2_Child_35_44",	"LoneParentFam_2_Child_45_54",	"LoneParentFam_2_Child_55_64",	"LoneParentFam_2_Child_65P",	"LoneParentFam_2_Child_Total",	"LoneParentFam_2_Child_MedianTotal_Income",	"LoneParentFam_3_Child_0_24",	"LoneParentFam_3_Child_25_34",	"LoneParentFam_3_Child_35_44",	"LoneParentFam_3_Child_45_54",	"LoneParentFam_3_Child_55_64",	"LoneParentFam_3_Child_65P",	"LoneParentFam_3_Child_Total",	"LoneParentFam_3_Child_MedianTotal_Income",	"MaleLoneParent_0_24",	"MaleLoneParent_25_34",	"MaleLoneParent_35_44",	"MaleLoneParent_45_54",	"MaleLoneParentt_55_64",	"MaleLoneParent_65P",	"MaleLoneParent_Total",	"MaleLoneParent_MedianTotal_Income", "FemaleLoneParent_0_24",	"FemaleLoneParent_25_34",	"FemaleLoneParent_35_44",	"FemaleLoneParent_45_54",	"FemaleLoneParentt_55_64",	"MaleLoneParent_65P",	"FemaleLoneParent_Total",	"FemaleLoneParent_MedianTotal_Income", "AllLoneParent_0_24",	"AllLoneParent_25_34",	"AllLoneParent_35_44",	"AllLoneParent_45_54",	"AllLoneParentt_55_64",	"AllLoneParent_65P",	"AllLoneParent_Total",	"AllLoneParent_MedianTotal_Income", "AllloneFam_AvgSize_0_24",	"AllloneFam_AvgSize_OlderParent_25_34",	"AllFam_AvgSize_35_44",	"AllloneFam_AvgSize_45_54",	"AllloneFam_AvgSize_55_64",	"AllloneFam_AvgSize_65P",	"AllloneFam_AvgSize_Total",	"AllloneFam_AvgSize_MedianTotal_Income") 
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 4

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


#Output the generated table 4

write.table(df, file ="2015_Family_Table_3B_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 5 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 5, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "AllFam_0_Child_OlderParent_0_24",	"AllFam_0_Child_OlderParent_25_34",	"AllFam_0_Child_OlderParent_35_44",	"AllFam_0_Child_OlderParent_45_54",	"AllFam_0_Child_OlderParent_55_64",	"AllFam_0_Child_OlderParent_65P",	"AllFam_0_Child_OlderParent_Total",	"AllFam_0_Child_OlderParent_MedianTotal_Income",	"AllFam_1_Child_OlderParent_0_24",	"AllFam_1_Child_OlderParent_25_34",	"AllFam_1_Child_OlderParent_35_44",	"AllFam_1_Child_OlderParent_45_54",	"AllFam_1_Child_OlderParent_55_64",	"AllFam_1_Child_OlderParent_65P",	"AllFam_1_Child_OlderParent_Total",	"AllFam_1_Child_OlderParent_MedianTotal_Income",	"AllFam_2_Child_OlderParent_0_24",	"AllFam_2_Child_OlderParent_25_34",	"AllFam_2_Child_OlderParent_35_44",	"AllFam_2_Child_OlderParent_45_54",	"AllFam_2_Child_OlderParent_55_64",	"AllFam_2_Child_OlderParent_65P",	"AllFam_2_Child_OlderParent_Total",	"AllFam_2_Child_OlderParent_MedianTotal_Income",	"AllFam_3_Child_OlderParent_0_24",	"AllFam_3_Child_OlderParent_25_34",	"AllFam_3_Child_OlderParent_35_44",	"AllFam_3_Child_OlderParent_45_54",	"AllFam_3_Child_OlderParent_55_64",	"AllFam_3_Child_OlderParent_65P",	"AllFam_3_Child_OlderParent_Total",	"AllFam_3_Child_OlderParent_MedianTotal_Income",	"AllFam_Couple_Lone_OlderParent_0_24",	"AllFam_Couple_Lone_OlderParent_25_34",	"AllFam_Couple_Lone_OlderParent_35_44",	"AllFam_Couple_Lone_OlderParent_45_54",	"AllFam_Couple_Lone_OlderParent_55_64",	"AllFam_Couple_Lone_OlderParent_65P",	"AllFam_Couple_Lone_OlderParent_Total",	"AllFam_Couple_Lone_OlderParent_MedianTotal_Income",	"AllFam_Couple_Lone_AvgSize_OlderParent_0_24",	"AllFam_Couple_Lone_AvgSize_OlderParent_25_34",	"AllFam_Couple_Lone_AvgSize_OlderParent_35_44",	"AllFam_Couple_Lone_AvgSize_OlderParent_45_54",	"AllFam_Couple_Lone_AvgSize_OlderParent_55_64",	"AllFam_Couple_Lone_AvgSize_OlderParent_65P",	"AllFam_Couple_Lone_AvgSize_OlderParent_Total",	"AllFam_Couple_Lone_AvgSize_MedianTotal_Income",	"AllFam_Couple_Lone_WithChild_AvgSize_OlderParent_0_24",	"AllFam_Couple_Lone_WithChild_AvgSize_OlderParent_25_34",	"AllFam_Couple_Lone_WithChild_AvgSize_OlderParent_35_44",	"AllFam_Couple_Lone_WithChild_AvgSize_OlderParent_45_54",	"AllFam_Couple_Lone_WithChild_AvgSize_OlderParent_55_64",	"AllFam_Couple_Lone_WithChild_AvgSize_OlderParent_65P",	"AllFam_Couple_Lone_AvgSize_OlderParent_Total",	"AllFam_Couple_Lone_AvgSize_MedianTotal_Income")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 5

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


#Output the generated table 5

write.table(df, file ="2015_Family_Table_3C_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 6 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 6, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "CoupleFam_0_24_Income_Less_10K", "CoupletFam_0_24_Income_10K",	"CoupleFam_0_24_Income_15K",	"CoupleFam_0_24_Income_20K",	"CoupleFam_0_24_Income_25K",	"CoupleFam_0_24_Income_30K",	"CoupleFam_0_24_Income_35K",	"CoupleFam_0_24_Income_40K",	"CoupleFam_0_24_Income_45K",	"CoupleFam_0_24_Income_50K", "CoupleFam_0_24_Income_60K",	"CoupleFam_0_24_Income_70K", "CoupleFam_0_24_Income_75K",	 "CoupleFam_0_24_Income_80K", "CoupleFam_0_24_Income_90K", "CoupleFam_0_24_Income_100K", "CoupleFam_0_24_Income_150K", "CoupleFam_0_24_Income_200K", "CoupleFam_0_24_Income_250K", "CoupleFam_0_24_Income_Total", "CoupleFam_0_24_Income_Total_Median",
                 "CoupleFam_25_34_Income_Less_10K", "CoupletFam_25_34_Income_10K",	"CoupleFam_25_34_Income_15K",	"CoupleFam_25_34_Income_20K",	"CoupleFam_25_34_Income_25K",	"CoupleFam_25_34_Income_30K",	"CoupleFam_25_34_Income_35K",	"CoupleFam_25_34_Income_40K",	"CoupleFam_25_34_Income_45K",	"CoupleFam_25_34_Income_50K", "CoupleFam_25_34_Income_60K",	"CoupleFam_25_34_Income_70K", "CoupleFam_25_34_Income_75K",	 "CoupleFam_25_34_Income_80K", "CoupleFam_25_34_Income_90K", "CoupleFam_25_34_Income_100K", "CoupleFam_25_34_Income_150K", "CoupleFam_25_34_Income_200K", "CoupleFam_25_34_Income_250K", "CoupleFam_25_34_Income_Total", "CoupleFam_25_34_Income_Total_Median",
                 "CoupleFam_35_44_Income_Less_10K", "CoupletFam_35_44_Income_10K",	"CoupleFam_35_44_Income_15K",	"CoupleFam_35_44_Income_20K",	"CoupleFam_35_44_Income_25K",	"CoupleFam_35_44_Income_30K",	"CoupleFam_35_44_Income_35K",	"CoupleFam_35_44_Income_40K",	"CoupleFam_35_44_Income_45K",	"CoupleFam_35_44_Income_50K", "CoupleFam_35_44_Income_60K",	"CoupleFam_35_44_Income_70K", "CoupleFam_35_44_Income_75K",	 "CoupleFam_35_44_Income_80K", "CoupleFam_35_44_Income_90K", "CoupleFam_35_44_Income_100K", "CoupleFam_35_44_Income_150K", "CoupleFam_35_44_Income_200K", "CoupleFam_35_44_Income_250K", "CoupleFam_35_44_Income_Total", "CoupleFam_35_44_Income_Total_Median",
                 "CoupleFam_45_54_Income_Less_10K", "CoupletFam_45_54_Income_10K",	"CoupleFam_45_54_Income_15K",	"CoupleFam_45_54_Income_20K",	"CoupleFam_45_54_Income_25K",	"CoupleFam_45_54_Income_30K",	"CoupleFam_45_54_Income_35K",	"CoupleFam_45_54_Income_40K",	"CoupleFam_45_54_Income_45K",	"CoupleFam_45_54_Income_50K", "CoupleFam_45_54_Income_60K",	"CoupleFam_45_54_Income_70K", "CoupleFam_45_54_Income_75K",	 "CoupleFam_45_54_Income_80K", "CoupleFam_45_54_Income_90K", "CoupleFam_45_54_Income_100K", "CoupleFam_45_54_Income_150K", "CoupleFam_45_54_Income_200K", "CoupleFam_45_54_Income_250K", "CoupleFam_45_54_Income_Total", "CoupleFam_45_54_Income_Total_Median",
                 "CoupleFam_55_64_Income_Less_10K", "CoupletFam_0_24_Income_10K",	"CoupleFam_0_24_Income_15K",	"CoupleFam_0_24_Income_20K",	"CoupleFam_0_24_Income_25K",	"CoupleFam_0_24_Income_30K",	"CoupleFam_0_24_Income_35K",	"CoupleFam_0_24_Income_40K",	"CoupleFam_0_24_Income_45K",	"CoupleFam_0_24_Income_50K", "CoupleFam_0_24_Income_60K",	"CoupleFam_0_24_Income_70K", "CoupleFam_0_24_Income_75K",	 "CoupleFam_0_24_Income_80K", "CoupleFam_0_24_Income_90K", "CoupleFam_0_24_Income_100K", "CoupleFam_0_24_Income_150K", "CoupleFam_0_24_Income_200K", "CoupleFam_0_24_Income_250K", "CoupleFam_0_24_Income_Total", "CoupleFam_0_24_Income_Total_Median",
                 "CoupleFam_65P_Income_Less_10K", "CoupletFam_65P_Income_10K",	"CoupleFam_65P_Income_15K",	"CoupleFam_65P_Income_20K",	"CoupleFam_65P_Income_25K",	"CoupleFam_65P_Income_30K",	"CoupleFam_65P_Income_35K",	"CoupleFam_65P_Income_40K",	"CoupleFam_65P_Income_45K",	"CoupleFam_65P_Income_50K", "CoupleFam_65P_Income_60K",	"CoupleFam_65P_Income_70K", "CoupleFam_65P_Income_75K",	 "CoupleFam_65P_Income_80K", "CoupleFam_65P_Income_90K", "CoupleFam_65P_Income_100K", "CoupleFam_65P_Income_150K", "CoupleFam_65P_Income_200K", "CoupleFam_65P_Income_250K", "CoupleFam_65P_Income_Total", "CoupleFam_65P_Income_Total_Median", "CoupleFam_Income_Less_10K", "CoupletFam_Income_10K",	"CoupleFam_Income_15K",	"CoupleFam_Income_20K",	"CoupleFam_Income_25K",	"CoupleFam_Income_30K",	"CoupleFam_Income_35K",	"CoupleFam_Income_40K",	"CoupleFam_Income_45K",	"CoupleFam_Income_50K", "CoupleFam_Income_60K",	"CoupleFam_Income_70K", "CoupleFam_Income_75K",	 "CoupleFam_Income_80K", "CoupleFam_Income_90K", "CoupleFam_Income_100K", "CoupleFam_Income_150K", "CoupleFam_Income_200K", "CoupleFam_Income_250K", "CoupleFam_Income_Total", "CoupleFam_Income_Total_Median")


dat1 <- na.omit(dat1)

#Extract the BC subset of the data in table 6

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


#Output the generated table 6

write.table(df, file ="2015_Family_Table_4A_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 7 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 7, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "LoneParentFam_0_24_Income_Less_5K",	"LoneParentFam_0_24_Income_5K",	"LoneParentFam_0_24_Income_10K",	"LoneParentFam_0_24_Income_15K",	"LoneParentFam_0_24_Income_20K",	"LoneParentFam_0_24_Income_25K",	"LoneParentFam_0_24_Income_30K",	"LoneParentFam_0_24_Income_35K",	"LoneParentFam_0_24_Income_40K",	"LoneParentFam_0_24_Income_45K",	"LoneParentFam_0_24_Income_50K", "LoneParentFam_0_24_Income_60K",	"LoneParentFam_0_24_Income_75K",	"LoneParentFam_0_24_Income_100K",	"LoneParentFam_0_24_Income_Total",	"LoneParentFam_0_24_Income_Median",	"LoneParentFam_25_34_Income_Less_5K",	"LoneParentFam_25_34_Income_5K",	"LoneParentFam_25_34_Income_10K",	"LoneParentFam_25_34_Income_15K",	"LoneParentFam_25_34_Income_20K",	"LoneParentFam_25_34_Income_25K",	"LoneParentFam_25_34_Income_30K",	"LoneParentFam_25_34_Income_35K",	"LoneParentFam_25_34_Income_40K",	"LoneParentFam_25_34_Income_45K", "LoneParentFam_25_34_Income_50K",	"LoneParentFam_25_34_Income_60K",	"LoneParentFam_25_34_Income_75K",	"LoneParentFam_25_34_Income_100K", "LoneParentFam_25_34_Income_Total",	"LoneParentFam_25_34_Income_Median",	"LoneParentFam_35_44_Income_Less_5K",	"LoneParentFam_35_44_Income_5K",	"LoneParentFam_35_44_Income_10K",	"LoneParentFam_35_44_Income_15K", "LoneParentFam_35_44_Income_20K",	"LoneParentFam_35_44_Income_25K",	"LoneParentFam_35_44_Income_30K", "LoneParentFam_35_44_Income_35K",	"LoneParentFam_35_44_Income_40K",	"LoneParentFam_35_44_Income_45K",	"LoneParentFam_35_44_Income_50K",	"LoneParentFam_35_44_Income_60K",	"LoneParentFam_35_44_Income_75K",	"LoneParentFam_35_44_Income_100K",	"LoneParentFam_35_44_Income_Total",	"LoneParentFam_35_44_Income_Median",	"LoneParentFam_45_54_Income_Less_5K",	"LoneParentFam_45_54_Income_5K",	"LoneParentFam_45_54_Income_10K",	"LoneParentFam_45_54_Income_15K",	"LoneParentFam_45_54_Income_20K",	"LoneParentFam_45_54_Income_25K",	"LoneParentFam_45_54_Income_30K",	"LoneParentFam_45_54_Income_35K",	"LoneParentFam_45_54_Income_40K",	"LoneParentFam_45_54_Income_45K",	"LoneParentFam_45_54_Income_50K",	"LoneParentFam_45_54_Income_60K",	"LoneParentFam_45_54_Income_75K",	"LoneParentFam_45_54_Income_100K",	"LoneParentFam_45_54_Income_Total",	"LoneParentFam_45_54_Income_Median",	"LoneParentFam_55_64_Income_Less_5K",	"LoneParentFam_55_64_Income_5K",	"LoneParentFam_55_64_Income_10K",	"LoneParentFam_55_64_Income_15K",	"LoneParentFam_55_64_Income_20K",	"LoneParentFam_55_64_Income_25K",	"LoneParentFam_55_64_Income_30K",	"LoneParentFam_55_64_Income_35K",	"LoneParentFam_55_64_Income_40K",	"LoneParentFam_55_64_Income_45K",	"LoneParentFam_55_64_Income_50K",	"LoneParentFam_55_64_Income_60K",	"LoneParentFam_55_64_Income_75K",	"LoneParentFam_55_64_Income_100K",	"LoneParentFam_55_64_Income_Total",	"LoneParentFam_55_64_Income_Median",	"LoneParentFam_65P_Income_Less_5K",	"LoneParentFam_65P_Income_5K",	"LoneParentFam_65P_Income_10K",	"LoneParentFam_65P_Income_15K",	"LoneParentFam_65P_Income_20K",	"LoneParentFam_65P_Income_25K",	"LoneParentFam_65P_Income_30K",	"LoneParentFam_65P_Income_35K",	"LoneParentFam_65P_Income_40K",	"LoneParentFam_65P_Income_45K",	"LoneParentFam_65P_Income_50K",	"LoneParentFam_65P_Income_60K",	"LoneParentFam_65P_Income_75K",	"LoneParentFam_65P_Income_100K",	"LoneParentFam_65P_Income_Total",	"LoneParentFam_65P_Income_Median",	"LoneParentFam_Total_Income_Less_5K",	"LoneParentFam_Total_Income_5K",	"LoneParentFam_Total_Income_10K",	"LoneParentFam_Total_Income_15K",	"LoneParentFam_Total_Income_20K",	"LoneParentFam_Total_Income_25K",	"LoneParentFam_Total_Income_30K",	"LoneParentFam_Total_Income_35K",	"LoneParentFam_Total_Income_40K",	"LoneParentFam_Total_Income_45K",	"LoneParentFam_Total_Income_50K",	"LoneParentFam_Total_Income_60K", "LoneParentFam_Total_Income_75K",	"LoneParentFam_Total_Income_100K",	"LoneParentFam_Total_Income_Total",	"LoneParentFam_Total_Income_Median")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 7

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


#Output the generated table 7

write.table(df, file ="2015_Family_Table_4B_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  
  #read file path for individual income table 8 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 8, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "NonFam_0_24_Income_Less_5K",	"NonFam_0_24_Income_5K",	"NonFam_0_24_Income_10K",	"NonFam_0_24_Income_15K",	"NonFam_0_24_Income_20K",	"NonFam_0_24_Income_25K",	"NonFam_0_24_Income_30K",	"NonFam_0_24_Income_35K",	"NonFam_0_24_Income_40K",	"NonFam_0_24_Income_45K",	"NonFam_0_24_Income_50K", "NonFam_0_24_Income_60K",	"NonFam_0_24_Income_75K",	"NonFam_0_24_Income_100K",	"NonFam_0_24_Income_Total",	"NonFam_0_24_Income_Median",	"NonFam_25_34_Income_Less_5K",	"NonFam_25_34_Income_5K",	"NonFam_25_34_Income_10K",	"NonFam_25_34_Income_15K",	"NonFam_25_34_Income_20K",	"NonFam_25_34_Income_25K",	"NonFam_25_34_Income_30K",	"NonFam_25_34_Income_35K",	"NonFam_25_34_Income_40K",	"NonFam_25_34_Income_45K", "NonFam_25_34_Income_50K",	"NonFam_25_34_Income_60K",	"NonFam_25_34_Income_75K",	"NonFam_25_34_Income_100K", "NonFam_25_34_Income_Total",	"NonFam_25_34_Income_Median",	"NonFam_35_44_Income_Less_5K",	"NonFam_35_44_Income_5K",	"NonFam_35_44_Income_10K",	"NonFam_35_44_Income_15K", "NonFam_35_44_Income_20K",	"NonFam_35_44_Income_25K",	"NonFam_35_44_Income_30K", "NonFam_35_44_Income_35K",	"NonFam_35_44_Income_40K",	"NonFam_35_44_Income_45K",	"NonFam_35_44_Income_50K",	"NonFam_35_44_Income_60K",	"NonFam_35_44_Income_75K",	"NonFam_35_44_Income_100K",	"NonFam_35_44_Income_Total",	"NonFam_35_44_Income_Median",	"NonFam_45_54_Income_Less_5K",	"NonFam_45_54_Income_5K",	"NonFam_45_54_Income_10K",	"NonFam_45_54_Income_15K",	"NonFam_45_54_Income_20K",	"NonFam_45_54_Income_25K",	"NonFam_45_54_Income_30K",	"NonFam_45_54_Income_35K",	"NonFam_45_54_Income_40K",	"NonFam_45_54_Income_45K",	"NonFam_45_54_Income_50K",	"NonFam_45_54_Income_60K",	"NonFam_45_54_Income_75K",	"NonFam_45_54_Income_100K",	"NonFam_45_54_Income_Total",	"NonFam_45_54_Income_Median",	"NonFam_55_64_Income_Less_5K",	"NonFam_55_64_Income_5K",	"NonFam_55_64_Income_10K",	"NonFam_55_64_Income_15K",	"NonFam_55_64_Income_20K",	"NonFam_55_64_Income_25K",	"NonFam_55_64_Income_30K",	"NonFam_55_64_Income_35K",	"NonFam_55_64_Income_40K",	"NonFam_55_64_Income_45K",	"NonFam_55_64_Income_50K",	"NonFam_55_64_Income_60K",	"NonFam_55_64_Income_75K",	"NonFam_55_64_Income_100K",	"NonFam_55_64_Income_Total",	"NonFam_55_64_Income_Median",	"NonFam_65P_Income_Less_5K",	"NonFam_65P_Income_5K",	"NonFam_65P_Income_10K",	"NonFam_65P_Income_15K",	"NonFam_65P_Income_20K",	"NonFam_65P_Income_25K",	"NonFam_65P_Income_30K",	"NonFam_65P_Income_35K",	"NonFam_65P_Income_40K",	"NonFam_65P_Income_45K",	"NonFam_65P_Income_50K",	"NonFam_65P_Income_60K",	"NonFam_65P_Income_75K",	"NonFam_65P_Income_100K",	"NonFam_65P_Income_Total",	"NonFam_65P_Income_Median",	"NonFam_Total_Income_Less_5K",	"NonFam_Total_Income_5K",	"NonFam_Total_Income_10K",	"NonFam_Total_Income_15K",	"NonFam_Total_Income_20K",	"NonFam_Total_Income_25K",	"NonFam_Total_Income_30K",	"NonFam_Total_Income_35K",	"NonFam_Total_Income_40K",	"NonFam_Total_Income_45K",	"NonFam_Total_Income_50K",	"NonFam_Total_Income_60K", "NonFam_Total_Income_75K",	"NonFam_Total_Income_100K",	"NonFam_Total_Income_Total",	"NonFam_Total_Income_Median")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 8

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


#Output the generated table 8

write.table(df, file ="2015_Family_Table_4C_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 9 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 9, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "CoupleFam_0_Child_Income_Less_10K",	"CoupleFam_0_Child_Income_10K", "CoupleFam_0_Child_Income_15K", "CoupleFam_0_Child_Income_20K", "CoupleFam_0_Child_Income_25K", "CoupleFam_0_Child_Income_30K", "CoupleFam_0_Child_Income_35K", "CoupleFam_0_Child_Income_40K", "CoupleFam_0_Child_Income_45K", "CoupleFam_0_Child_Income_50K", "CoupleFam_0_Child_Income_60K", "CoupleFam_0_Child_Income_70K", "CoupleFam_0_Child_Income_75K", "CoupleFam_0_Child_Income_80K", "CoupleFam_0_Child_Income_90K", "CoupleFam_0_Child_Income_100K", "CoupleFam_0_Child_Income_150K", "CoupleFam_0_Child_Income_200K", "CoupleFam_0_Child_Income_250K", "CoupleFam_0_Child_Income_Total", "CoupleFam_0_Child_Income_Total_Median", "CoupleFam_1_Child_Income_Less_10K",	"CoupleFam_1_Child_Income_10K", "CoupleFam_1_Child_Income_15K", "CoupleFam_1_Child_Income_20K", "CoupleFam_1_Child_Income_25K", "CoupleFam_1_Child_Income_30K", "CoupleFam_1_Child_Income_35K", "CoupleFam_1_Child_Income_40K", "CoupleFam_1_Child_Income_45K", "CoupleFam_1_Child_Income_50K", "CoupleFam_1_Child_Income_60K", "CoupleFam_1_Child_Income_70K", "CoupleFam_1_Child_Income_75K", "CoupleFam_1_Child_Income_80K", "CoupleFam_1_Child_Income_90K", "CoupleFam_1_Child_Income_100K", "CoupleFam_1_Child_Income_150K", "CoupleFam_1_Child_Income_200K", "CoupleFam_1_Child_Income_250K", "CoupleFam_1_Child_Income_Total", "CoupleFam_1_Child_Income_Total_Median", "CoupleFam_2_Child_Income_Less_10K",	"CoupleFam_2_Child_Income_10K", "CoupleFam_2_Child_Income_15K", "CoupleFam_2_Child_Income_20K", "CoupleFam_2_Child_Income_25K", "CoupleFam_2_Child_Income_30K", "CoupleFam_2_Child_Income_35K", "CoupleFam_2_Child_Income_40K", "CoupleFam_2_Child_Income_45K", "CoupleFam_2_Child_Income_50K", "CoupleFam_2_Child_Income_60K", "CoupleFam_2_Child_Income_70K", "CoupleFam_2_Child_Income_75K", "CoupleFam_2_Child_Income_80K", "CoupleFam_2_Child_Income_90K", "CoupleFam_2_Child_Income_100K", "CoupleFam_2_Child_Income_150K", "CoupleFam_2_Child_Income_200K", "CoupleFam_2_Child_Income_250K", "CoupleFam_2_Child_Income_Total", "CoupleFam_2_Child_Income_Total_Median", "CoupleFam_3_Child_Income_Less_10K",	"CoupleFam_3_Child_Income_10K", "CoupleFam_3_Child_Income_15K", "CoupleFam_3_Child_Income_20K", "CoupleFam_3_Child_Income_25K", "CoupleFam_3_Child_Income_30K", "CoupleFam_3_Child_Income_35K", "CoupleFam_3_Child_Income_40K", "CoupleFam_3_Child_Income_45K", "CoupleFam_3_Child_Income_50K", "CoupleFam_3_Child_Income_60K", "CoupleFam_3_Child_Income_70K", "CoupleFam_3_Child_Income_75K", "CoupleFam_3_Child_Income_80K", "CoupleFam_3_Child_Income_90K", "CoupleFam_3_Child_Income_100K", "CoupleFam_3_Child_Income_150K", "CoupleFam_3_Child_Income_200K", "CoupleFam_3_Child_Income_250K", "CoupleFam_3_Child_Income_Total", "CoupleFam_3_Child_Income_Total_Median", "CoupleFam_Total_Income_Less_10K",	"CoupleFam_Total_Income_10K", "CoupleFam_Total_Income_15K", "CoupleFam_Total_Income_20K", "CoupleFam_Total_Income_25K", "CoupleFam_Total_Income_30K", "CoupleFam_Total_Income_35K", "CoupleFam_Total_Income_40K", "CoupleFam_Total_Income_45K", "CoupleFam_Total_Income_50K", "CoupleFam_Total_Income_60K", "CoupleFam_Total_Income_70K", "CoupleFam_Total_Income_75K", "CoupleFam_Total_Income_80K", "CoupleFam_Total_Income_90K", "CoupleFam_Total_Income_100K", "CoupleFam_Total_Income_150K", "CoupleFam_Total_Income_200K", "CoupleFam_Total_Income_250K", "CoupleFam_Total_Income_Total", "CoupleFam_Total_Income_Total_Median")

dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 9
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


#Output the generated table 9

write.table(df, file ="2015_Family_Table_5A_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  #read file path for individual income table 10 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 10, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "LoneParent_1_Child_Income_Less_5K",	"LoneParent_1_Child_Income_5K", "LoneParent_1_Child_Income_10K", "LoneParent_1_Child_Income_15K", "LoneParent_1_Child_Income_20K", "LoneParent_1_Child_Income_25K", "LoneParent_1_Child_Income_30K", "LoneParent_1_Child_Income_35K", "LoneParent_1_Child_Income_40K", "LoneParent_1_Child_Income_45K", "LoneParent_1_Child_Income_50K", "LoneParent_1_Child_Income_60K", "LoneParent_1_Child_Income_75K", "LoneParent_1_Child_Income_100K", "LoneParent_1_Child_Income_Total", "LoneParent_1_Child_Income_Total_Median", "LoneParent_2_Child_Income_Less_5K",	"LoneParent_Child_Income_5K", "LoneParent_Child_Income_10K", "LoneParent_2_Child_Income_15K", "LoneParent_2_Child_Income_20K", "LoneParent_2_Child_Income_25K", "LoneParent_2_Child_Income_30K", "LoneParent_2_Child_Income_35K", "LoneParent_2_Child_Income_40K", "LoneParent_2_Child_Income_45K", "LoneParent_2_Child_Income_50K", "LoneParent_2_Child_Income_60K", "LoneParent_2_Child_Income_75K", "LoneParent_2_Child_Income_100K", "LoneParent_2_Child_Income_Total", "LoneParent_2_Child_Income_Total_Median", "LoneParent_3_Child_Income_Less_5K",	"LoneParent_3_Child_Income_5K", "LoneParent_3_Child_Income_10K",  "LoneParent_3_Child_Income_15K", "LoneParent_3_Child_Income_20K", "LoneParent_3_Child_Income_25K", "LoneParent_3_Child_Income_30K", "LoneParent_3_Child_Income_35K", "LoneParent_3_Child_Income_40K", "LoneParent_3_Child_Income_45K", "LoneParent_3_Child_Income_50K", "LoneParent_3_Child_Income_60K", "LoneParent_3_Child_Income_75K", "LoneParent_3_Child_Income_100K", "LoneParent_3_Child_Income_Total", "LoneParent_3_Child_Income_Total_Median", "LoneParent_Total_Income_Less_5K",	"LoneParent_Total_Income_5K", "LoneParent_Total_Income_10K",  "LoneParent_Total_Income_15K", "LoneParent_Total_Income_20K", "LoneParent_Total_Income_25K", "LoneParent_Total_Income_30K", "LoneParent_Total_Income_35K", "LoneParent_Total_Income_40K", "LoneParent_Total_Income_45K", "LoneParent_Total_Income_50K", "LoneParent_Total_Income_60K", "LoneParent_Total_Income_75K", "LoneParent_Total_Income_100K", "LoneParent_Total_Income_Total", "LoneParent_Total_Income_Total_Median")

dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 10

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



#Output the generated table 10

write.table(df, file ="2015_Family_Table_5B_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  #read file path for individual income table 11 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 11, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "CoupleFam_EI", "CoupleFam_EI_Dollar", "CoupleFam_Wage_Salary_Commission", "CoupleFam_Wage_Salary_Commission_Dollar", "CoupleFam_Self_Emp", "CoupleFam_Self_Emp_Dollar", "CoupleFam_Self_Emp_FarmFish", "CoupleFam_Self_Emp_FarmFish_Dollar", "CoupleFam_Other_Self_Emp", "CoupleFam_Other_Self_Emp_Dollar","CoupleFam_Investment", "CoupleFam_Investment_Dollar","CoupleFam_GovtTransfer", "CoupleFam_GovtTransfer_Dollar","CoupleFam_Emp_Ins", "CoupleFam_Emp_Ins_Dollar","CoupleFam_OAS_NET_FedSupp", "CoupleFam_OAS_NET_FedSupp_Dollar","CoupleFam_CPP_QPP", "CoupleFam_CPP_QPP_Dollar","CoupleFam_CCTB", "CoupleFam_CCTB_Dollar","CoupleFam_GST_HST", "CoupleFam_GST_HST_Dollar","CoupleFam_WorkerComp", "CoupleFam_WorkerComp_Dollar","CoupleFam_Social_Asst", "CoupleFam_Social_Asst_Dollar","CoupleFam_ProvTaxCred", "CoupleFam_ProvTaxCred_Dollar","CoupleFam_OtherGvtTransfer", "CoupleFam_OtherGvtTransfer_Dollar","CoupleFam_PrivPension", "CoupleFam_PrivPension_Dollar","CoupleFam_RRSP", "CoupleFam_RRSP_Dollar","CoupleFam_Other_Income", "CoupleFam_Other_Income_Dollar","CoupleFam_Total_Income", "CoupleFam_Total_Income_Dollar",
                 "LoneParentFam_EI", "LoneParentFam_EI_Dollar", "LoneParentFam_Wage_Salary_Commission", "LoneParentFam_Wage_Salary_Commission_Dollar", "LoneParentFam_Self_Emp", "LoneParentFam_Self_Emp_Dollar", "LoneParentFam_Self_Emp_FarmFish", "LoneParentFam_Self_Emp_FarmFish_Dollar", "LoneParentFam_Other_Self_Emp", "LoneParentFam_Other_Self_Emp_Dollar","LoneParentFam_Investment", "LoneParentFam_Investment_Dollar","LoneParentFam_GovtTransfer", "LoneParentFam_GovtTransfer_Dollar","LoneParentFam_Emp_Ins", "LoneParentFam_Emp_Ins_Dollar","LoneParentFam_OAS_NET_FedSupp", "LoneParentFam_OAS_NET_FedSupp_Dollar","LoneParentFam_CPP_QPP", "LoneParentFam_CPP_QPP_Dollar","LoneParentFam_CCTB", "LoneParentFam_CCTB_Dollar","LoneParentFam_GST_HST", "LoneParentFam_GST_HST_Dollar","LoneParentFam_WorkerComp", "LoneParentFam_WorkerComp_Dollar","LoneParentFam_Social_Asst", "LoneParentFam_Social_Asst_Dollar","LoneParentFam_ProvTaxCred", "LoneParentFam_ProvTaxCred_Dollar","LoneParentFam_OtherGvtTransfer", "LoneParentFam_OtherGvtTransfer_Dollar","LoneParentFam_PrivPension", "LoneParentFam_PrivPension_Dollar","LoneParentFam_RRSP", "LoneParentFam_RRSP_Dollar","LoneParentFam_Other_Income", "LoneParentFam_Other_Income_Dollar","LoneParentFam_Total_Income", "LoneParentFam_Total_Income_Dollar",
                 "NonFam_EI", "NonFam_EI_Dollar", "NonFam_Wage_Salary_Commission", "NonFam_Wage_Salary_Commission_Dollar", "NonFam_Self_Emp", "NonFam_Self_Emp_Dollar", "NonFam_Self_Emp_FarmFish", "NonFam_Self_Emp_FarmFish_Dollar", "NonFam_Other_Self_Emp", "NonFam_Other_Self_Emp_Dollar","NonFam_Investment", "NonFam_Investment_Dollar","NonFam_GovtTransfer", "NonFam_GovtTransfer_Dollar","NonFam_Emp_Ins", "NonFam_Emp_Ins_Dollar","NonFam_OAS_NET_FedSupp", "NonFam_OAS_NET_FedSupp_Dollar","NonFam_CPP_QPP", "NonFam_CPP_QPP_Dollar","NonFam_CCTB", "NonFam_CCTB_Dollar","NonFam_GST_HST", "NonFam_GST_HST_Dollar","NonFam_WorkerComp", "NonFam_WorkerComp_Dollar","NonFam_Social_Asst", "NonFam_Social_Asst_Dollar","NonFam_ProvTaxCred", "NonFam_ProvTaxCred_Dollar","NonFam_OtherGvtTransfer", "NonFam_OtherGvtTransfer_Dollar","NonFam_PrivPension", "NonFam_PrivPension_Dollar","NonFam_RRSP", "NonFam_RRSP_Dollar","NonFam_Other_Income", "NonFam_Other_Income_Dollar","NonFam_Total_Income", "NonFam_Total_Income_Dollar",
                 "Total_CFF_LPF_NPF_EI", "Total_CFF_LPF_NPF_EI_Dollar", "Total_CFF_LPF_NPF_Wage_Salary_Commission", "Total_CFF_LPF_NPF_Wage_Salary_Commission_Dollar", "Total_CFF_LPF_NPF_Self_Emp", "Total_CFF_LPF_NPF_Self_Emp_Dollar", "Total_CFF_LPF_NPF_Self_Emp_FarmFish", "Total_CFF_LPF_NPF_Self_Emp_FarmFish_Dollar", "Total_CFF_LPF_NPF_Other_Self_Emp", "Total_CFF_LPF_NPF_Other_Self_Emp_Dollar","Total_CFF_LPF_NPF_Investment", "Total_CFF_LPF_NPF_Investment_Dollar","Total_CFF_LPF_NPF_GovtTransfer", "Total_CFF_LPF_NPF_GovtTransfer_Dollar","Total_CFF_LPF_NPF_Emp_Ins", "Total_CFF_LPF_NPF_Emp_Ins_Dollar","Total_CFF_LPF_NPF_OAS_NET_FedSupp", "Total_CFF_LPF_NPF_OAS_NET_FedSupp_Dollar","Total_CFF_LPF_NPF_CPP_QPP", "Total_CFF_LPF_NPF_CPP_QPP_Dollar","Total_CFF_LPF_NPF_CCTB", "Total_CFF_LPF_NPF_CCTB_Dollar","Total_CFF_LPF_NPF_GST_HST", "Total_CFF_LPF_NPF_GST_HST_Dollar","Total_CFF_LPF_NPF_WorkerComp", "Total_CFF_LPF_NPF_WorkerComp_Dollar","Total_CFF_LPF_NPF_Social_Asst", "Total_CFF_LPF_NPF_Social_Asst_Dollar","Total_CFF_LPF_NPF_ProvTaxCred", "Total_CFF_LPF_NPF_ProvTaxCred_Dollar","Total_CFF_LPF_NPF_OtherGvtTransfer", "Total_CFF_LPF_NPF_OtherGvtTransfer_Dollar","Total_CFF_LPF_NPF_PrivPension", "Total_CFF_LPF_NPF_PrivPension_Dollar","Total_CFF_LPF_NPF_RRSP", "Total_CFF_LPF_NPF_RRSP_Dollar","Total_CFF_LPF_NPF_Other_Income", "Total_CFF_LPF_NPF_Other_Income_Dollar","Total_CFF_LPF_NPF_Total_Income", "Total_CFF_LPF_NPF_Total_Income_Dollar")

dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 11
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


#Output the generated table 11

write.table(df, file ="2015_Family_Table_6_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 12 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 12, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "CoupleFam_GovtTransfers_Num", "CoupleFam_GovtTransfers_Dollars", "CoupleFam_GovtTransfers_Median", "CoupleFam_GovtTransfers_EDR", "CoupleFam_GovtTransfers_ProvIndex", "CoupleFam_GovtTransfers_CanIndex", "CoupleFam_EI", "CoupleFam_EI_Dollar", "CoupleFam_Emp_Insurance", "CoupleFam_Emp_Insurance_Dollar", "CoupleFam_Emp_Insurance_EDR", "CoupletFam_GST_HST", "CoupleFam_GST_HST_Dollar", "CoupleFam_GST_HST_EDR", "CoupleFam_CCTB", "CoupleFam_CCTB_Dollar", "CoupleFam_CCTB_EDR", "CoupleFam_OAS_NetFedSupp", "CoupleFam_OAS_NetFedSupp_Dollar", "CoupleFam_OAS_NetFedSupp_EDR", "CoupleFam_CPP_QPP", "CoupleFam_CPP_QPP_Dollar", "CoupleFam_CPP_QPP_EDR", "CoupleFam_WorkerComp", "CoupleFam_WorkerComp_Dollar", "CoupleFam_WorkerComp_EDR", "CoupleFam_SoclAsst", "CoupleFam_SoclAsst_Dollar", "CoupleFam_SoclAsst_EDR", "CoupleFam_ProvTaxCred", "CoupleFam_ProvTaxCred_Dollar", "CoupleFam_ProvTaxCred_EDR", "CoupleFam_OtherGovtTransfer", "CoupleFam_OtherGovtTransfer_Dollar", "CoupleFam_OtherGovtTransfer_EDR", "Males_CoupleFam_GovTransfer", "Males_CoupleFam_GovTransfer_Dollar", "Males_CoupleFam_GovTransfer_Median", "Males_CoupleFam_GovTransfer_EDR", "Males_CoupleFam_GovTransfer_ProvIndex", "Males_CoupleFam_GovTransfer_CanIndex", "Males_CoupleFam_EI", "Males_CoupleFam_EI_Dollar", "Males_CoupleFam_Empl_Ins", "Males_CoupleFam_Empl_Ins_Dollar", "Males_CoupleFam_Empl_Ins_EDR", "Males_CoupleFam_GST_HST", "Males_CoupleFam_GST_HST_Dollar", "Males_CoupleFam_GST_HST_EDR", "Males_CoupleFam_CCTB", "Males_CoupleFam_CCTB_Dollar", "Males_CoupleFam_CCTB_EDR", "Males_CoupleFam_OAS_NetFedSupp", "Males_CoupleFam_OAS_NetFedSupp_Dollar", "Males_CoupleFam_OAS_NetFedSupp_EDR", 
                 "Males_CoupleFam_CPP_QPP", "Males_CoupleFam_CPP_QPP_Dollar", "Males_CoupleFam_CPP_QPP_EDR", "Males_CoupleFam_WorkersComp", "Males_CoupleFam_WorkersComp_Dollar", "Males_CoupleFam_WorkersComp_EDR", "Males_CoupleFam_Soc_Asst", "Males_CoupleFam_Soc_Asst_Dollar", "Males_CoupleFam_Soc_Asst_EDR", "Males_CoupleFam_ProvTaxCred", "Males_CoupleFam_ProvTaxCred_Dollar", "Males_CoupleFam_ProvTaxCred_EDR", "Males_CoupleFam_OtherGovtTransfer", "Males_CoupleFam_OtherGovtTransfer_Dollar", "Males_CoupleFam_OtherGovtTransfer_EDR", 
                 "Females_CoupleFam_GovTransfer", "Females_CoupleFam_GovTransfer_Dollar", "Females_CoupleFam_GovTransfer_Median", "Females_CoupleFam_GovTransfer_EDR", "Females_CoupleFam_GovTransfer_ProvIndex", "Females_CoupleFam_GovTransfer_CanIndex", "Females_CoupleFam_EI", "Females_CoupleFam_EI_Dollar", "Females_CoupleFam_Empl_Ins", "Females_CoupleFam_Empl_Ins_Dollar", "Females_CoupleFam_Empl_Ins_EDR", "Females_CoupleFam_GST_HST", "Females_CoupleFam_GST_HST_Dollar", "Females_CoupleFam_GST_HST_EDR", "Females_CoupleFam_CCTB", "Females_CoupleFam_CCTB_Dollar", "Females_CoupleFam_CCTB_EDR", "Females_CoupleFam_OAS_NetFedSupp", "Females_CoupleFam_OAS_NetFedSupp_Dollar", "Females_CoupleFam_OAS_NetFedSupp_EDR", 
                 "Females_CoupleFam_CPP_QPP", "Females_CoupleFam_CPP_QPP_Dollar", "Females_CoupleFam_CPP_QPP_EDR", "Females_CoupleFam_WorkersComp", "Females_CoupleFam_WorkersComp_Dollar", "Females_CoupleFam_WorkersComp_EDR", "Females_CoupleFam_Soc_Asst", "Females_CoupleFam_Soc_Asst_Dollar", "Females_CoupleFam_Soc_Asst_EDR", "Females_CoupleFam_ProvTaxCred", "Females_CoupleFam_ProvTaxCred_Dollar", "Females_CoupleFam_ProvTaxCred_EDR", "Females_CoupleFam_OtherGovtTransfer", "Females_CoupleFam_OtherGovtTransfer_Dollar", "Females_CoupleFam_OtherGovtTransfer_EDR", 
                 "Children_CoupleFam_GovTransfer", "Children_CoupleFam_GovTransfer_Dollar", "Children_CoupleFam_GovTransfer_Median", "Children_CoupleFam_GovTransfer_EDR", "Children_CoupleFam_GovTransfer_ProvIndex", "Children_CoupleFam_GovTransfer_CanIndex", "Children_CoupleFam_EI", "Children_CoupleFam_EI_Dollar", "Children_CoupleFam_Empl_Ins", "Children_CoupleFam_Empl_Ins_Dollar", "Children_CoupleFam_Empl_Ins_EDR", "Children_CoupleFam_GST_HST", "Children_CoupleFam_GST_HST_Dollar", "Children_CoupleFam_GST_HST_EDR", "Children_CoupleFam_CCTB", "Children_CoupleFam_CCTB_Dollar", "Children_CoupleFam_CCTB_EDR", "Children_CoupleFam_OAS_NetFedSupp", "Children_CoupleFam_OAS_NetFedSupp_Dollar", "Children_CoupleFam_OAS_NetFedSupp_EDR", 
                 "Children_CoupleFam_CPP_QPP", "Children_CoupleFam_CPP_QPP_Dollar", "Children_CoupleFam_CPP_QPP_EDR", "Children_CoupleFam_WorkersComp", "Children_CoupleFam_WorkersComp_Dollar", "Children_CoupleFam_WorkersComp_EDR", "Children_CoupleFam_Soc_Asst", "Children_CoupleFam_Soc_Asst_Dollar", "Children_CoupleFam_Soc_Asst_EDR", "Children_CoupleFam_ProvTaxCred", "Children_CoupleFam_ProvTaxCred_Dollar", "Children_CoupleFam_ProvTaxCred_EDR", "Children_CoupleFam_OtherGovtTransfer", "Children_CoupleFam_OtherGovtTransfer_Dollar", "Children_CoupleFam_OtherGovtTransfer_EDR", 
                 "AllPersons_GovTransfer", "AllPersons_GovTransfer_Dollar", "AllPersons_GovTransfer_Median", "AllPersons_GovTransfer_EDR", "AllPersons_GovTransfer_ProvIndex", "AllPersons_GovTransfer_CanIndex", "AllPersons_EI", "AllPersons_EI_Dollar", "AllPersons_Empl_Ins", "AllPersons_Empl_Ins_Dollar", "AllPersons_Empl_Ins_EDR", "AllPersons_GST_HST", "AllPersons_GST_HST_Dollar", "AllPersons_GST_HST_EDR", "AllPersons_CCTB", "AllPersons_CCTB_Dollar", "AllPersons_CCTB_EDR", "AllPersons_OAS_NetFedSupp", "AllPersons_OAS_NetFedSupp_Dollar", "AllPersons_OAS_NetFedSupp_EDR", 
                 "AllPersons_CPP_QPP", "AllPersons_CPP_QPP_Dollar", "AllPersons_CPP_QPP_EDR", "AllPersons_WorkersComp", "AllPersons_WorkersComp_Dollar", "AllPersons_WorkersComp_EDR", "AllPersons_Soc_Asst", "AllPersons_Soc_Asst_Dollar", "AllPersons_Soc_Asst_EDR", "AllPersons_ProvTaxCred", "AllPersons_ProvTaxCred_Dollar", "AllPersons_ProvTaxCred_EDR", "AllPersons_OtherGovtTransfer", "AllPersons_OtherGovtTransfer_Dollar", "AllPersons_OtherGovtTransfer_EDR")

dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 12

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


#Output the generated table 12

write.table(df, file ="2015_Family_Table_7_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 13 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 13, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "LoneParentFam_GovtTransfers_Num", "LoneParentFam_GovtTransfers_Dollars", "LoneParentFam_GovtTransfers_Median", "LoneParentFam_GovtTransfers_EDR", "LoneParentFam_GovtTransfers_ProvIndex", "LoneParentFam_GovtTransfers_CanIndex", "LoneParentFam_EI", "LoneParentFam_EI_Dollar", 
                 "LoneParentFam_Emp_Insurance", "LoneParentFam_Emp_Insurance_Dollar", "LoneParentFam_Emp_Insurance_EDR", "LoneParentFam_GST_HST", "LoneParentFam_GST_HST_Dollar", "LoneParentFam_GST_HST_EDR", "LoneParentFam_CCTB", "LoneParentFam_CCTB_Dollar", "LoneParentFam_CCTB_EDR", "LoneParentFam_OAS_NetFedSupp", "LoneParentFam_OAS_NetFedSupp_Dollar", "LoneParentFam_OAS_NetFedSupp_EDR", 
                 "LoneParentFam_CPP_QPP", "LoneParentFam_CPP_QPP_Dollar", "LoneParentFam_CPP_QPP_EDR", 
                 "LoneParentFam_WorkerComp", "LoneParentFam_WorkerComp_Dollar", "LoneParentFam_WorkerComp_EDR", "LoneParentFam_SoclAsst", "LoneParentFam_SoclAsst_Dollar", "LoneParentFam_SoclAsst_EDR", 
                 "LoneParentFam_ProvTaxCred", "LoneParentFam_ProvTaxCred_Dollar", "LoneParentFam_ProvTaxCred_EDR", "LoneParentFam_OtherGovtTransfer", "LoneParentFam_OtherGovtTransfer_Dollar", "LoneParentFam_OtherGovtTransfer_EDR", 
                 "Parents_LPF_GovTransfer", "Parents_LPF_GovTransfer_Dollar", "Parents_LPF_GovTransfer_Median", "Parents_LPF_GovTransfer_EDR", "Parents_LPF_GovTransfer_ProvIndex", "Parents_LPF_GovTransfer_CanIndex", "Parents_LPF_EI", "Parents_LPF_EI_Dollar", "Parents_LPF_Empl_Ins", "Parents_LPF_Empl_Ins_Dollar", "Parents_LPF_Empl_Ins_EDR", "Parents_LPF_GST_HST", "Parents_LPF_GST_HST_Dollar", "Parents_LPF_GST_HST_EDR", "Parents_LPF_CCTB", "Parents_LPF_CCTB_Dollar", "Parents_LPF_CCTB_EDR", 
                 "Parents_LPF_OAS_NetFedSupp", "Parents_LPF_OAS_NetFedSupp_Dollar", "Parents_LPF_OAS_NetFedSupp_EDR", "Parents_LPF_CCP_QPP_No", "Parents_LPF_CCP_QPP_Dollar", "Parents_LPF_CCP_QPP_EDR", 
                 "Parents_LPF_WorkersComp", "Parents_LPF_WorkersComp_Dollar", "Parents_LPF_WorkersComp_EDR", "Parents_LPF_Soc_Asst", "Parents_LPF_Soc_Asst_Dollar", "Parents_LPF_Soc_Asst_EDR", "Parents_LPF_ProvTaxCred", "Parents_LPF_ProvTaxCred_Dollar", "Parents_LPF_ProvTaxCred_EDR", "Parent_LPF_OtherGovtTransfer", "Parents_LPF_OtherGovtTransfer_Dollar", "Parents_LPF_OtherGovtTransfer_EDR", 
                 "Children_LPF_GovTransfer", "Children_LPF_GovTransfer_Dollar", "Children_LPF_GovTransfer_Median", "Children_LPF_GovTransfer_EDR", "Children_LPF_GovTransfer_ProvIndex", "Children_LPF_GovTransfer_CanIndex", "Children_LPF_EI", "Children_LPF_EI_Dollar", "Children_LPF_Empl_Ins", "Children_LPF_Empl_Ins_Dollar", "Children_LPF_Empl_Ins_EDR", "Children_LPF_GST_HST", "Children_LPF_GST_HST_Dollar", "Children_LPF_GST_HST_EDR", "Children_LPF_CCTB", "Children_LPF_CCTB_Dollar", "Children_LPF_CCTB_EDR", 
                 "Children_LPF_OAS_NetFedSupp", "Children_LPF_OAS_NetFedSupp_Dollar", "Children_LPF_OAS_NetFedSupp_EDR", "Children_LPF_CPP_QPP", "Children_LPF_CPP_QPP_Dollar", "Children_LPF_CPP_QPP_EDR", 
                 "Children_LPF_WorkersComp", "Children_LPF_WorkersComp_Dollar", "Children_LPF_WorkersComp_EDR", "Children_LPF_Soc_Asst", "Children_LPF_Soc_Asst_Dollar", "Children_LPF_Soc_Asst_EDR", "Children_LPF_ProvTaxCred", "Children_LPF_ProvTaxCred_Dollar", "Children_LPF_ProvTaxCred_EDR", "Children_LPF_OtherGovtTransfer", "Children_LPF_OtherGovtTransfer_Dollar", "Children_LPF_OtherGovtTransfer_EDR", 
                 "NonFam_GovTransfer", "NonFam_GovTransfer_Dollar", "NonFam_GovTransfer_Median", "NonFam_GovTransfer_EDR", "NonFam_GovTransfer_ProvIndex", "NonFam_GovTransfer_CanIndex", "NonFam_EI", "NonFam_EI_Dollar", "NonFam_Empl_Ins", "NonFam_Empl_Ins_Dollar", "NonFam_Empl_Ins_EDR", "NonFam_GST_HST", "NonFam_GST_HST_Dollar", "NonFam_GST_HST_EDR", "NonFam_CCTB", "NonFam_CCTB_Dollar", "NonFam_CCTB_EDR", 
                 "NonFam_OAS_NetFedSupp", "NonFam_OAS_NetFedSupp_Dollar", "NonFam_OAS_NetFedSupp_EDR", "NonFam_CPP_QPP_No", "NonFam_CPP_QPP_Dollar", "NonFam_CPP_QPP_EDR",
                 "NonFam_WorkersComp", "NonFam_WorkersComp_Dollar", "NonFam_WorkersComp_EDR", "NonFam_Soc_Asst", "NonFam_Soc_Asst_Dollar", "NonFam_Soc_Asst_EDR", "NonFam_ProvTaxCred", "NonFam_ProvTaxCred_Dollar", "NonFam_ProvTaxCred_EDR", "NonFam_OtherGovtTransfer", "NonFam_OtherGovtTransfer_Dollar", "NonFam_OtherGovtTransfer_EDR",
                 "All_persons_GovTrans_Tax_Dep_No", "All_persons_GovTrans_Tax_Dep_Dollar", "All_persons_GovTrans_Tax_Dep_Median", "All_persons_GovTrans_Tax_Dep_EDR", "All_persons_GovTrans_Tax_Dep_ProvIndex", "All_persons_GovTrans_Tax_Dep_CanIndex", 
                 "All_persons_EI_Tax_Dep_No", "All_persons_EI_Tax_Dep_Dollar", "All_persons_Emp_Ins_Tax_Dep_No", "All_persons_Emp_Ins_Tax_Dep_Dollar", "All_persons_Emp_Ins_Tax_Dep_EDR", "All_persons_GST_HST_Tax_Dep_No", "All_persons_GST_HST_Tax_Dep_Dollar", "All_persons_GST_HST_Tax_Dep_EDR", "All_persons_CCTB_Tax_Dep_No", "All_persons_CCTB_Tax_Dep_Dollar", "All_persons_CCTB_Tax_Dep_EDR",
                 "All_persons_OAS_NetFedSupp_Tax_Dep_No", "All_persons_OAS_NetFedSupp_Tax_Dep_Dollar", "All_persons_OAS_NetFedSupp_Tax_Dep_EDR",  "All_persons_CPP_QPP_Tax_Dep_No", "All_persons_CPP_QPP_Tax_Dep_Dollar", "All_persons_CPP_QPP_Tax_Dep_EDR",
                 "All_persons_workers_Ins_Tax_Dep_No", "All_persons_workers_Ins_Tax_Dep_Dollar", "All_persons_workers_Ins_Tax_Dep_EDR",  "All_persons_Soc_Ins_Tax_Dep_No", "All_persons_Soc_Ins_Tax_Dep_Dollar", "All_persons_Soc_Ins_Tax_Dep_EDR",
                 "All_persons_ProvTax_Tax_Dep_No", "All_persons_ProvTax_Tax_Dep_Dollar", "All_persons_ProvTax_Tax_Dep_EDR",  "All_persons_OtherGovTransf_Tax_Dep_No", "All_persons_OtherGovTransf_Tax_Dep_Dollar", "All_persons_OtherGovTransf_Tax_Dep_EDR"
)
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 13
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


#Output the generated table 13

write.table(df, file ="2015_Family_Table_8_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 14 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 14, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "CoupleFam_Num",	"CoupleFam_Total_Income",	"CoupleFam_Total_Income_Dollar_000",	"CoupleFam_Total_Income_Median",	"CoupleFam_Total_Income_ProvIndex",	"CoupleFam_Total_Income_CanIndex",	"CoupleFam_Labour_Income",	"CoupleFam_Labour_Income_Dollar_000",	"CoupleFam_EI",	"CoupleFam_EI_Dollar_000",	"CoupleFam_EI_Median",	"CoupleFam_EI_ProvIndex",	"CoupleFam_EI_CanIndex",	"CoupleFam_Wage_Salary_Commission",	"CoupleFam_Wage_Salary_Commission_Dollar_000",	"CoupleFam_Self_EI",	"CoupleFam_Self_EI_Dollar_000",	"CoupleFam_Emp_Insurance",	"CoupleFam_Emp_Insurance_Dollar_000",	"CoupleFam_Emp_Insurance_EDR",	"CoupleFam_Emp_Insurance_ProvIndex", "CoupleFam_Emp_Insurance_CanIndex",	"MalePartner_CoupleFam_Num",	"Husbands_CoupleFam_Total_Income",	"Husbands_CoupleFam_Total_Income_Dollar_000",	"Husbands_CoupleFam_Total_Income_Median",	"Husbands_CoupleFam_Total_Income_ProvIndex",	"Husbands_CoupleFam_Total_Income_CanIndex",	"Husbands_CoupleFam_Labour_Income",	"Husbands_CoupleFam_Labour_Income_Dollar_000",	"Husbands_CoupleFam_EI",	"Husbands_CoupleFam_EI_Dollar_000",	"Husbands_CoupleFam_EI_Median",	"Husbands_CoupleFam_EI_ProvIndex",	"Husbands_CoupleFam_EI_CanIndex",	"Husbands_CoupleFam_Wage_Salary_Commission",	"Husbands_CoupleFam_Wage_Salary_Commission_Dollar_000",	"Husbands_CoupleFam_Self_EI", "Husbands_CoupleFam_Self_EI_Dollar_000",	"Husbands_CoupleFam_Emp_Insurance",	"Husbands_CoupleFam_Emp_Insurance_Dollar_000",	"Husbands_CoupleFam_Emp_Insurance_EDR",	"Husbands_CoupleFam_Emp_Insurance_ProvIndex",	"Husbands_CoupleFam_Emp_Insurance_CanIndex",	"FemalePartners_CoupleFam_Num",	"Wife_CoupleFam_Total_Income",	"Wife_CoupleFam_Total_Income_Dollar_000",	"Wife_CoupleFam_Total_Income_Median",	"Wife_CoupleFam_Total_Income_ProvIndex",	"Wife_CoupleFam_Total_Income_CanIndex",	"Wife_CoupleFam_Labour_Income",	"Wife_CoupleFam_Labour_Income_Dollar_000",	"Wife_CoupleFam_EI",	"Wife_CoupleFam_EI_Median_Dollar_000",	"Wife_CoupleFam_EI_Median",	"Wife_CoupleFam_EI_ProvIndex",	"Wife_CoupleFam_EI_CanIndex",	"Wife_CoupleFam_Wage_Salary_Commission",	"Wife_CoupleFam_Wage_Salary_Commission_Dollar_000",	"Wife_CoupleFam_Self_EI",	"Wife_CoupleFam_Self_EI_Dollar_000",	"Wife_CoupleFam_Emp_Insurance",	"Wife_CoupleFam_Emp_Insurance_Dollar_000",	"Wife_CoupleFam_Emp_Insurance_EDR",	"Wife_CoupleFam_Emp_Insurance_ProvIndex",	"Wife_CoupleFam_Emp_Insurance_CanIndex",	"Children_CFF_Num",	"Children_CFF_Total_Income",	"Children_CFF_Total_Income_Dollar_000",	"Children_CFF_Total_Income_Median",	"Children_CFF_Total_Income_ProvIndex",	"Children_CFF_Total_Income_CanIndex",	"Children_CFF_Labour_Income",	"Children_CFF_Labour_Income_Dollar_000",	"Children_CFF_EI",	"Children_CFF_EI_Dollar_000",	"Children_CFF_EI_Median",	"Children_CFF_EI_ProvIndex",	"Children_CFF_EI_CanIndex",	"Children_CFF_Wage_Salary_Commission",	"Children_CFF_Wage_Salary_Commission_Dollar_000",	"Children_CFF_Self_EI",	"Children_CFF_Self_EI_Dollar_000",	"Children_CFF_Emp_Insurance",	"Children_CFF_Emp_Insurance_Dollar_000",	"Children_CFF_Emp_Insurance_EDR",	"Children_CFF_Emp_Insurance_ProvIndex",	"Children_CFF_Emp_Insurance_CanIndex",	"AllFam_Num",	"AllFam_Total_Income",	"AllFam_Total_Income_Dollar_000",	"AllFam_Total_Income_Median",	"AllFam_Total_Income_ProvIndex",	"AllFam_Total_Income_CanIndex",	"AllFam_Labour_Income",	"AllFam_Labour_Income_Dollar_000",	"AllFam_EI",	"AllFam_EI_Dollar_000",	"AllFam_EI_Median",	"AllFam_EI_ProvIndex",	"AllFam_EI_CanIndex",	"AllFam_Wage_Salary_Commission",	"AllFam_Wage_Salary_Commission_Dollar_000",	"AllFam_Self_EI",	"AllFam_Self_EI_Dollar_000",	"AllFam_Emp_Insurance",	"AllFam_Emp_Insurance_Dollar_000",	"AllFam_Emp_Insurance_EDR",	"AllFam_Emp_Insurance_ProvIndex",	"AllFam_Emp_Insurance_CanIndex")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 14

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


#Output the generated table 14

write.table(df, file ="2015_Family_Table_9_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 15 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 15, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "LoneParent_Num",	"LoneParent_Total_Income",	"LoneParent_Total_Income_Dollar_000",	"LoneParent_Total_Income_Median",	"LoneParent_Total_Income_ProvIndex",	"LoneParent_Total_Income_CanIndex",	"LoneParent_Labour_Income",	"LoneParent_Labour_Income_Dollar_000",	"LoneParent_EI",	"LoneParent_EI_Dollar_000",	"LoneParent_EI_Median",	"LoneParent_EI_ProvIndex",	"LoneParent_EI_CanIndex",	"LoneParent_Wage_Salary_Commission",	"LoneParent_Wage_Salary_Commission_Dollar_000",	"LoneParent_Self_EI",	"LoneParent_Self_EI_Dollar_000",	"LoneParent_Emp_Insurance",	"LoneParent_Emp_Insurance_Dollar_000",	"CoupleFam_Emp_Insurance_EDR",	"CoupleFam_Emp_Insurance_ProvIndex", "CoupleFam_Emp_Insurance_CanIndex",	
                 "Parents_LPF_Num",	"Parents_LPF_Total_Income",	"Parents_LPF_Total_Income_Dollar_000",	"Parents_LPF_Total_Income_Median",	"Parents_LPF_Total_Income_ProvIndex",	"Parents_LPF_Total_Income_CanIndex",	"Parents_LPF_Labour_Income",	"Parents_LPF_Labour_Income_Dollar_000",	"Parents_LPF_EI",	"Parents_LPF_EI_Dollar_000",	"Parents_LPF_EI_Median",	"Parents_LPF_EI_ProvIndex",	"Parents_LPF_EI_CanIndex",	"Parents_LPF_Wage_Salary_Commission",	"Parents_LPF_Wage_Salary_Commission_Dollar_000",	"Parents_LPF_Self_EI", "Parents_LPF_Self_EI_Dollar_000",	"Parents_LPF_Emp_Insurance",	"Parents_LPF_Emp_Insurance_Dollar_000",	"Parents_LPF_Emp_Insurance_EDR",	"Parents_LPF_Emp_Insurance_ProvIndex",	"Parents_LPF_Emp_Insurance_CanIndex",	"Children_LPF_Num",	"Children_LPF_Total_Income",	"Children_LPF_Total_Income_Dollar_000",	"Children_LPF_Total_Income_Median",	"Children_LPF_Total_Income_ProvIndex",	"Children_LPF_Total_Income_CanIndex",	"Children_LPF_Labour_Income",	"Children_LPF_Labour_Income_Dollar_000",	"Children_LPF_EI",	"Children_LPF_Dollar_000",	"Children_LPF_EI_Median",	"Children_LPF_EI_ProvIndex",	"Children_LPF_EI_CanIndex",	"Children_LPF_Wage_Salary_Commission",	"Children_LPF_Wage_Salary_Commission_Dollar_000",	"Children_LPF_Self_EI",	"Children_LPF_Self_EI_Dollar_000",	"Children_LPF_Emp_Insurance",	"Children_LPF_Emp_Insurance_Dollar_000",	"Children_LPF_Emp_Insurance_EDR",	"Children_LPF_Emp_Insurance_ProvIndex",	"Children_LPF_Emp_Insurance_CanIndex",	
                 "NonFam_Num",	"NonFam_Total_Income",	"NonFam_Total_Income_Dollar_000",	"NonFam_Total_Income_Median",	"NonFam_Total_Income_ProvIndex",	"NonFam_Total_Income_CanIndex",	"NonFam_Labour_Income",	"NonFam_Labour_Income_Dollar_000",	"NonFam_EI",	"NonFam_EI_Median_Dollar_000",	"NonFam_EI_Median",	"NonFam_EI_ProvIndex",	"NonFam_EI_CanIndex",	"NonFam_Wage_Salary_Commission",	"NonFam_Wage_Salary_Commission_Dollar_000",	"NonFam_Self_EI",	"NonFam_Self_EI_Dollar_000",	"NonFam_Emp_Insurance",	"NonFam_Emp_Insurance_Dollar_000",	"NonFam_Emp_Insurance_EDR",	"NonFam_Emp_Insurance_ProvIndex",	"NonFam_Emp_Insurance_CanIndex",	"AllPersons_Num",	"AllPersons_Total_Income",	"AllPersons_Total_Income_Dollar_000",	"AllPersons_Total_Income_Median",	"AllPersons_Total_Income_ProvIndex",	"AllPersons_Total_Income_CanIndex",	"AllPersons_Labour_Income",	"AllPersons_Labour_Income_Dollar_000",	"AllPersons_EI",	"AllPersons_EI_Dollar_000",	"AllPersons_EI_Median",	"AllPersons_EI_ProvIndex",	"AllPersons_EI_CanIndex",	"AllPersons_Wage_Salary_Commission",	"AllPersons_Wage_Salary_Commission_Dollar_000",	"AllPersons_Self_EI",	"AllPersons_Self_EI_Dollar_000",	"AllPersons_Emp_Insurance",	"AllPersons_Emp_Insurance_Dollar_000",	"AllPersons_Emp_Insurance_EDR",	"AllPersons_Emp_Insurance_ProvIndex",	"AllPersons_Emp_Insurance_CanIndex")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 15

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


#Output the generated table 15

write.table(df, file ="2015_Family_Table_10_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  
  #read file path for individual income table 16 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 16, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Couple_Fam_0_Child", "Couple_Fam_1_Child", "Couple_Fam_2_Child", "Couple_Fam_3_Child", "Couple_Fam_Total", "Male_SingleEarner_CFF_0_Child", "Male_SingleEarner_CFF_1_Child", "Male_SingleEarner_CFF_2_Child", "Male_SingleEarner_CFF_3_Child", "Male_SingleEarner_CFF_Total", "Husband_EI_0_Child", "Husband_EI_1_Child", "Husband_EI_2_Child", "Husband_EI_3_Child", "Husband_EI_Total", "Husband_Median_EI_0_Child", "Husband_Median_EI_1_Child", "Husband_Median_EI_2_Child", "Husband_Median_EI_3_Child", "Husband_Median_EI_Total", "Female_SingleEarner_CFF_0_Child", "Female_SingleEarner_CFF_1_Child", "Female_SingleEarner_CFF_2_Child", "Female_SingleEarner_CFF_3_Child", "Female_SingleEarner_CFF_Total", "Wife_EI_0_Child", "Wife_EI_1_Child", "Wife_EI_2_Child", "Wife_EI_3_Child", "Wife_EI_EI_Total", "Wife_Median_EI_0_Child", "Wife_Median_EI_1_Child", "Wife_Median_EI_2_Child", "Wife_Median_EI_3_Child", "Wife_Median_EI_Total", "DualEarner_CFF_0_Child", "DualEarner_CFF_1_Child", "DualEarner_CFF_2_Child", "DualEarner_CFF_3_Child", "DualEarner_CFF_Total", 
                 "Spouse_EI_0_Child_Dollar", "Spouse_EI_1_Child_Dollar", "Spouse_EI_2_Child_Dollar", "Spouse_EI_3_Child_Dollar", "Spouse_EI_Total_Dollar",  "Spouse_Median_EI_0_Child", "Spouse_Median_EI_1_Child", "Spouse_Median_EI_2_Child", "Spouse_Median_EI_3_Child", "Spouse_Median_EI_Total", "LPF_1_Child", "LPF_2_Child", "LPF_3_Child", "LPF_Total", "LPF_EI_Dollar_1_Child", "LPF_EI_Dollar_2_Child", "LPF_EI_Dollar_3_Child", "LPF_EI_Dollar_Total", "LPF_Median_EI_1_Child", "LPF_Median_EI_2_Child", "LPF_Median_EI_3_Child", "LPF_Median_EI_Total")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 16
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


#Output the generated table 16

write.table(df, file ="2015_Family_Table_13_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 17 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 17, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Wife_CF_EI_0_Percent_0_Child", "Wife_CF_EI_0_Percent_1_Child", "Wife_CF_EI_0_Percent_2_Child", "Wife_CF_EI_0_Percent_3_Child", "Wife_CF_EI_0_Percent_Total", "Wife_CF_EI_1_25_Percent_0_Child", "Wife_CF_EI_1_25_Percent_1_Child", "Wife_CF_EI_1_25_Percent_2_Child", "Wife_CF_EI_1_25_Percent_3_Child", "Wife_CF_EI_1_25_Percent_Total", "Wife_CF_EI_26_50_Percent_0_Child", "Wife_CF_EI_26_50_Percent_1_Child", "Wife_CF_EI_26_50_Percent_2_Child", "Wife_CF_EI_26_50_Percent_3_Child", "Wife_CF_EI_26_50_Percent_Total", "Wife_CF_EI_51_75_Percent_0_Child", "Wife_CF_EI_51_75_Percent_1_Child", "Wife_CF_EI_51_75_Percent_2_Child", "Wife_CF_EI_51_75_Percent_3_Child", "Wife_CF_EI_51_75_Percent_Total", "Wife_CF_EI_76_99_Percent_0_Child", "Wife_CF_EI_76_99_Percent_1_Child", "Wife_CF_EI_76_99_Percent_2_Child", "Wife_CF_EI_76_99_Percent_3_Child", "Wife_CF_EI_76_99_Percent_Total", "Wife_CF_EI_100_Percent_0_Child", "Wife_CF_EI_100_Percent_1_Child", "Wife_CF_EI_100_Percent_2_Child", "Wife_CF_EI_100_Percent_3_Child", "Wife_CF_EI_100_Percent_Total", "Families_CF_EI_morethan0_0_Child", "Families_CF_EI_morethan0_1_Child", "Families_CF_EI_morethan0_2_Child", "Families_CF_EI_morethan0_3_Child", "Families_CF_EI_morethan0_Total","Wife_CF_Median_EI_Child", "Wife_CF_Median_EI_1_Child", "Wife_CF_Median_EI_2_Child", "Wife_CF_Median_EI_3_Child", "Wife_CF_Median_EI_Total")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 17

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


#Output the generated table 17

write.table(df, file ="2015_Family_Table_14A_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 18 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 18, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Wife_CF_EI_0_Percent_Wife_0_24_years", "Wife_CF_EI_0_Percent_Wife_25_34_years", "Wife_CF_EI_0_Percent_Wife_35_44_years", "Wife_CF_EI_0_Percent_Wife_45_54_years", "Wife_CF_EI_0_Percent_Wife_55_64_years", "Wife_CF_EI_0_Percent_Wife_65P_years", "Wife_CF_EI_0_Percent_Total", 
                 "Wife_CF_EI_1_25_Percent_Wife_0_24_years", "Wife_CF_EI_1_25_Percent_Wife_25_34_years", "Wife_CF_EI_1_25_Percent_Wife_35_44_years", "Wife_CF_EI_1_25_Percent_Wife_45_54_years", "Wife_CF_EI_1_25_Percent_Wife_55_64_years", "Wife_CF_EI_1_25_Percent_Wife_65P_years", "Wife_CF_EI_1_25_Percent_Total", 
                 "Wife_CF_EI_26_50_Percent_Wife_0_24_years", "Wife_CF_EI_26_50_Percent_Wife_25_34_years", "Wife_CF_EI_26_50_Percent_Wife_35_44_years", "Wife_CF_EI_26_50_Percent_Wife_45_54_years", "Wife_CF_EI_26_50_Percent_Wife_55_64_years", "Wife_CF_EI_26_50_Percent_Wife_65P_years", "Wife_CF_EI_26_50_Percent_Total", 
                 "Wife_CF_EI_51_75_Percent_Wife_0_24_years", "Wife_CF_EI_51_75_Percent_Wife_25_34_years", "Wife_CF_EI_51_75_Percent_Wife_35_44_years", "Wife_CF_EI_51_75_Percent_Wife_45_54_years", "Wife_CF_EI_51_75_Percent_Wife_55_64_years", "Wife_CF_EI_51_75_Percent_Wife_65P_years", "Wife_CF_EI_51_75_Percent_Total", 
                 "Wife_CF_EI_76_99_Percent_Wife_0_24_years", "Wife_CF_EI_76_99_Percent_Wife_25_34_years", "Wife_CF_EI_76_99_Percent_Wife_35_44_years", "Wife_CF_EI_76_99_Percent_Wife_45_54_years", "Wife_CF_EI_76_99_Percent_Wife_55_64_years", "Wife_CF_EI_76_99_Percent_Wife_65P_years", "Wife_CF_EI_76_99_Percent_Total", 
                 "Wife_CF_EI_100_Percent_Wife_0_24_years", "Wife_CF_EI_100_Percent_Wife_25_34_years", "Wife_CF_EI_100_Percent_Wife_35_44_years", "Wife_CF_EI_100_Percent_Wife_45_54_years", "Wife_CF_EI_100_Percent_Wife_55_64_years", "Wife_CF_EI_100_Percent_Wife_65P_years", "Wife_CF_EI_100_Percent_Total", 
                 "Wife_CF_EI_morethan0_Wife_0_24_years", "Wife_CF_EI_morethan0_Wife_25_34_years", "Wife_CF_EI_morethan0_Wife_35_44_years", "Wife_CF_EI_morethan0_Wife_45_54_years", "Wife_CF_EI_morethan0_Wife_55_64_years", "Wife_CF_EI_morethan0_Wife_65P_years", "Wife_CF_EI_morethan0_Total")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 18

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


#Output the generated table 18

write.table(df, file ="2015_Family_Table_14B_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 19 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 19, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Wife_CF_EI_0_Percent_Wife_1_19999_Dollars", "Wife_CF_EI_0_Percent_20000_39999_Dollars", "Wife_CF_EI_0_Percent_40000_59999_Dollars", "Wife_CF_EI_0_Percent_60000P_Dollars", "Wife_CF_EI_0_Percent_Total_Dollar", 
                 "Wife_CF_EI_1_25_Percent_19999_Dollars", "Wife_CF_EI_1_25_Percent_20000_39999_Dollars", "Wife_CF_EI_1_25_Percent_40000_59999_Dollars", "Wife_CF_EI_1_25_Percent_60000P_Dollars", "Wife_CF_EI_1_25_Percent_Total_Dollar",
                 "Wife_CF_EI_26_50_Percent_1_19999_Dollars", "Wife_CF_EI_26_50_Percent_20000_39999_Dollars", "Wife_CF_EI_26_50_Percent_40000_59999_Dollars", "Wife_CF_EI_26_50_Percent_60000P_Dollars", "Wife_CF_EI_26_50_Percent_Total_Dollars", 
                 "Wife_CF_EI_51_75_Percent_1_19999_Dollars", "Wife_CF_EI_51_75_Percent_20000_39999_Dollars", "Wife_CF_EI_51_75_Percent_40000_59999_Dollars", "Wife_CF_EI_51_75_Percent_60000P_Dollars", "Wife_CF_EI_51_75_Percent_Total_Dollar", 
                 "Wife_CF_EI_76_99_Percent_1_19999_Dollars", "Wife_CF_EI_76_99_Percent_20000_39999_Dollars", "Wife_CF_EI_76_99_Percent_40000_59999_Dollars", "Wife_CF_EI_76_99_Percent_60000P_Dollars", "Wife_CF_EI_76_99_Percent_Total_Dollar",  
                 "Wife_CF_EI_100_Percent_1_19999_Dollars", "Wife_CF_EI_100_Percent_20000_39999_Dollars", "Wife_CF_EI_100_Percent_40000_59999_Dollars", "Wife_CF_EI_100_Percent_60000P_Dollars", "Wife_CF_EI_100_Percent_Total_Dollar",  
                 "Wife_CF_EI_morethan0_1_19999_Dollars", "Wife_CF_EI_morethan0_20000_39999_Dollars", "Wife_CF_EI_morethan0_40000_59999_Dollars", "Wife_CF_EI_morethan0_60000P_Dollars", "Wife_CF_EI_morethan0_Total_Dollar")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 19

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


#Output the generated table 19

write.table(df, file ="2015_Family_Table_14C_Canada.csv", sep = ",", row.names = FALSE)

---------------------------   
  
  #read file path for individual income table 20 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 20, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Fam_CFF_Children_Under_6", "Fam_LPF_Children_Under_6", "AllFam_Children_Under_6", "Fam_CFF_Children_6_14", "Fam_LPF_Children_6_14", "AllFam_Children_6_14", "Fam_CFF_Children_15_17", "Fam_LPF_Children_15_17", "AllFam_Children_15_17", "Fam_CFF_Children_Some_Under_6_Some_6_14", "Fam_LPF_ChildrenSome_Under_6_Some_6_14", "AllFam_Children_Some_Under_Some_Under_6_Some_6_14", "Fam_CFF_Children_Some_Under_6_Some_15_17", "Fam_LPF_Children_Some_Under_6_Some_15_17", "AllFam_Children_Some_Under_6_Some_15_17", "Fam_CFF_Children_Some_6_14_Some_15_17", "Fam_LPF_Children_Some_6_14_Some_15_17", "AllFam_Children_Some_6_14_Some_15_17", "Fam_CFF_Children_Some_Under_6_Some_6_14_Some_15_17", "Fam_LPF_Children_Some_Under_6_Some_6_14_Some_15_17", "AllFam_Children_Some_Under_6_Some_6_14_Some_15_17", "Fam_CFF_Children_Under_18", "Fam_LPF_Children_Under_18", "AllFam_Children_Under_18", "Fam_CFF_All_Under_18", "Fam_LPF_All_Under_18", "AllFam_All_Under_18",
                 "Fam_CFF_Some_Under_18_Some_18P", "Fam_LPF_Some_Under_18_Some_18P", "AllFam_Some_Under_18_Some_18P", "Fam_CFF_All_18P", "Fam_LPF_All_18P", "AllFam_All_18P", "Fam_CFF_All_Total", "Fam_LPF_All_Total", "AllFam_All_Total",
                 "Children_Fam_CFF_Under_6", "Children_Fam_LPF_Under_6", "Children_AllFam_Under_6", "Children_Fam_CFF_6_14", "Children_Fam_LPF_6_14", "Children_AllFam_6_14", "Children_Fam_CFF_15_17", "Children_Fam_LPF_15_17", "Children_AllFam_15_17", "Children_Fam_CFF_Some_Under_6_Some_6_14", "ChildrenFam_LPF_Some_Under_6_Some_6_14", "ChildrenAllFam_Some_Under_Some_Under_6_Some_6_14", "ChildrenFam_CFF_Some_Under_6_Some_15_17", "ChildrenFam_LPF_Some_Under_6_Some_15_17", "ChildrenAllFam_Some_Under_6_Some_15_17", "ChildrenFam_CFF_Some_6_14_Some_15_17", "ChildrenFam_LPF_Some_6_14_Some_15_17", "ChildrenAllFam_Some_6_14_Some_15_17", "ChildrenFam_CFF_Some_Under_6_Some_6_14_Some_15_17", "ChildrenFam_LPF_Some_Under_6_Some_6_14_Some_15_17", "ChildrenAllFam_Some_Under_6_Some_6_14_Some_15_17", "ChildrenFam_CFF_Under_18", "ChildrenFam_LPF_Under_18", "ChildrenAllFam_Under_18", "AllFam_CFF_Under_18", "AllFam_LPF_Under_18", "AllAllFam_Under_18",
                 "Children_Fam_CFF_Some_Under_18_Some_18P", "Children_Fam_LPF_Some_Under_18_Some_18P", "Children_AllFam_Some_Under_18_Some_18P", "Children_Fam_CFF_All_18P", "Children_Fam_LPF_All_18P", "Children_AllFam_All_18P", "Children_Fam_CFF_All_Total", "Children_Fam_LPF_All_Total", "Children_AllFam_All_Total")

dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 20

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


#Output the generated table 20

write.table(df, file ="2015_Family_Table_15_Canada.csv", sep = ",", row.names = FALSE)

---------------------------   
  
  #read file path for individual income table 21 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 21, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Couple_Fam_0_Child", "Couple_Fam_1_Child", "Couple_Fam_2_Child", "Couple_Fam_3_Child", "Couple_Fam_Total", "Couple_Fam_Median_Income_0_Child", "Couple_Fam_Median_Income_1_Child", "Couple_Fam_Median_Income_2_Child", "Couple_Fam_Median_Income_3_Child", "Couple_Fam_Median_Income_Total", "Persons_With_0_Child", "Persons_With_1_Child", "Persons_With_2_Child", "Persons_With_3_Child", "Persons_With_Total", "Children_0_17_1_Child", "Children_0_17_2_Child", "Children_0_17_3_Child",  "Children_0_17_Total", "Persons_65P_0_Child", "Persons_65P_1_Child", "Persons_65P_2_Child", "Persons_65P_3_Child", "Persons_65P_Total",
                 "LowIncome_Couple_Fam_0_Child", "LowIncome_Couple_Fam_1_Child", "LowIncome_Couple_Fam_2_Child", "LowIncome_Couple_Fam_3_Child", "LowIncome_Couple_Fam_Total", "LowIncome_Couple_Fam_Median_Income_0_Child", "LowIncome_Couple_Fam_Median_Income_1_Child", "LowIncome_Couple_Fam_Median_Income_2_Child", "LowIncome_Couple_Fam_Median_Income_3_Child", "LowIncome_Couple_Fam_Median_Income_Total", "LowIncome_Persons_With_0_Child", "LowIncome_Persons_With_1_Child", "LowIncome_Persons_With_2_Child", "LowIncome_Persons_With_3_Child", "LowIncome_Persons_With_Total", "LowIncome_Children_0_17_1_Child", "LowIncome_Children_0_17_2_Child", "LowIncome_Children_0_17_3_Child",  "LowIncome_Children_0_17_Total", "LowIncome_Persons_65P_0_Child", "LowIncome_Persons_65P_1_Child", "LowIncome_Persons_65P_2_Child", "LowIncome_Persons_65P_3_Child", "LowIncome_Persons_65P_Total",
                 "LPF_1_Child", "LPF_2_Child", "LPF_3_Child", "LPF_Total", "LPF_Median_Income_1_Child", "LPF_Median_Income_2_Child", "LPF_Median_Income_3_Child", "LPF_Median_Income_Total", "LPF_Persons_With_1_Child", "LPF_Persons_With_2_Child", "LPF_Persons_With_3_Child", "LPF_Persons_With_Total", "LPF_Children_0_17_1_Child", "LPF_Children_0_17_2_Child", "LPF_Children_0_17_3_Child",  "LPF_Children_0_17_Total", "LPF_Persons_65P_1_Child", "LPF_Persons_65P_2_Child", "LPF_Persons_65P_3_Child", "LPF_Persons_65P_Total",
                 "Low_Income_LPF_1_Child", "Low_Income_LPF_2_Child", "Low_Income_LPF_3_Child", "Low_Income_LPF_Total", "Low_Income_LPF_Median_Income_1_Child", "Low_Income_LPF_Median_Income_2_Child", "Low_Income_LPF_Median_Income_3_Child", "Low_Income_LPF_Median_Income_Total", "Low_Income_LPF_Persons_With_1_Child", "Low_Income_LPF_Persons_With_2_Child", "Low_Income_LPF_Persons_With_3_Child", "Low_Income_LPF_Persons_With_Total", "Low_Income_LPF_Children_0_17_1_Child", "Low_Income_LPF_Children_0_17_2_Child", "Low_Income_LPF_Children_0_17_3_Child",  "Low_Income_LPF_Children_0_17_Total", "Low_Income_LPF_Persons_65P_1_Child", "Low_Income_LPF_Persons_65P_2_Child", "Low_Income_LPF_Persons_65P_3_Child", "Low_Income_LPF_Persons_65P_Total",
                 "NonFam_0_Child", "NonFam_0_Child_Median_Income", "NonFam_0_Child_Persons", "NonFam_0_Child_65P", "LowIncome_NonFam_0_Child", "LowIncome_NonFam_0_Child_Median_Income", "LowIncome_NonFam_0_Child_Persons", "LowIncome_NonFam_0_Child_65P", 
                 "AllFam_NonFam_0_Child", "AllFam_NonFam_1_Child", "AllFam_NonFam_2_Child", "AllFam_NonFam_3_Child", "AllFam_NonFam_Total", "AllFam_NonFam_Median_Income_0_Child", "AllFam_NonFam_Median_Income_1_Child", "AllFam_NonFam_Median_Income_2_Child", "AllFam_NonFam_Median_Income_3_Child", "AllFam_NonFam_Median_Income_Total", "AllFam_NonFam_Persons_With_0_Child", "AllFam_NonFam_Persons_With_1_Child", "AllFam_NonFam_Persons_With_2_Child", "AllFam_NonFam_Persons_With_3_Child", "AllFam_NonFam_Persons_With_Total", "AllFam_NonFam_Children_0_17_1_Child", "AllFam_NonFam_Children_0_17_2_Child", "AllFam_NonFam_Children_0_17_3_Child",  "AllFam_NonFam_Children_0_17_Total", "AllFam_NonFam_Persons_65P_0_Child", "AllFam_NonFam_Persons_65P_1_Child", "AllFam_NonFam_Persons_65P_2_Child", "AllFam_NonFam_Persons_65P_3_Child", "AllFam_NonFam_Persons_65P_Total",
                 "All_Low_Income_Fam_NonFam_0_Child", "All_Low_Income_Fam_NonFam_1_Child", "All_Low_Income_Fam_NonFam_2_Child", "All_Low_Income_Fam_NonFam_3_Child", "All_Low_Income_Fam_NonFam_Total", "All_Low_Income_Fam_NonFam_Median_Income_0_Child", "All_Low_Income_Fam_NonFam_Median_Income_1_Child", "All_Low_Income_Fam_NonFam_Median_Income_2_Child", "All_Low_Income_Fam_NonFam_Median_Income_3_Child", "All_Low_Income_Fam_NonFam_Median_Income_Total", "All_Low_Income_Fam_NonFam_Persons_With_0_Child", "All_Low_Income_Fam_NonFam_Persons_With_1_Child", "All_Low_Income_Fam_NonFam_Persons_With_2_Child", "All_Low_Income_Fam_NonFam_Persons_With_3_Child", "All_Low_Income_Fam_NonFam_Persons_With_Total", "All_Low_Income_Fam_NonFam_Children_0_17_1_Child", "All_Low_Income_Fam_NonFam_Children_0_17_2_Child", "All_Low_Income_Fam_NonFam_Children_0_17_3_Child",  "All_Low_Income_Fam_NonFam_Children_0_17_Total", "All_Low_Income_Fam_NonFam_Persons_65P_0_Child", "All_Low_Income_Fam_NonFam_Persons_65P_1_Child", "All_Low_Income_Fam_NonFam_Persons_65P_2_Child", "All_Low_Income_Fam_NonFam_Persons_65P_3_Child", "All_Low_Income_Fam_NonFam_Persons_65P_Total")

dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 21

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


#Output the generated table 21

write.table(df, file ="2015_Family_Table_17_Canada.csv", sep = ",", row.names = FALSE)

---------------------------   
  
  #read file path for individual income table 22 to clean-up column names
  
  file.dat <- file.path(dir.wrk, "2015_Family_Tables_1_to_18_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 21, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Couple_Fam_0_Child", "Couple_Fam_1_Child", "Couple_Fam_2_Child", "Couple_Fam_3_Child", "Couple_Fam_Total", "Couple_Fam_Median_Income_0_Child", "Couple_Fam_Median_Income_1_Child", "Couple_Fam_Median_Income_2_Child", "Couple_Fam_Median_Income_3_Child", "Couple_Fam_Median_Income_Total", "Persons_With_0_Child", "Persons_With_1_Child", "Persons_With_2_Child", "Persons_With_3_Child", "Persons_With_Total", "Children_0_17_1_Child", "Children_0_17_2_Child", "Children_0_17_3_Child",  "Children_0_17_Total", "Persons_65P_0_Child", "Persons_65P_1_Child", "Persons_65P_2_Child", "Persons_65P_3_Child", "Persons_65P_Total",
                 "LowIncome_Couple_Fam_0_Child", "LowIncome_Couple_Fam_1_Child", "LowIncome_Couple_Fam_2_Child", "LowIncome_Couple_Fam_3_Child", "LowIncome_Couple_Fam_Total", "LowIncome_Couple_Fam_Median_Income_0_Child", "LowIncome_Couple_Fam_Median_Income_1_Child", "LowIncome_Couple_Fam_Median_Income_2_Child", "LowIncome_Couple_Fam_Median_Income_3_Child", "LowIncome_Couple_Fam_Median_Income_Total", "LowIncome_Persons_With_0_Child", "LowIncome_Persons_With_1_Child", "LowIncome_Persons_With_2_Child", "LowIncome_Persons_With_3_Child", "LowIncome_Persons_With_Total", "LowIncome_Children_0_17_1_Child", "LowIncome_Children_0_17_2_Child", "LowIncome_Children_0_17_3_Child",  "LowIncome_Children_0_17_Total", "LowIncome_Persons_65P_0_Child", "LowIncome_Persons_65P_1_Child", "LowIncome_Persons_65P_2_Child", "LowIncome_Persons_65P_3_Child", "LowIncome_Persons_65P_Total",
                 "LPF_1_Child", "LPF_2_Child", "LPF_3_Child", "LPF_Total", "LPF_Median_Income_1_Child", "LPF_Median_Income_2_Child", "LPF_Median_Income_3_Child", "LPF_Median_Income_Total", "LPF_Persons_With_1_Child", "LPF_Persons_With_2_Child", "LPF_Persons_With_3_Child", "LPF_Persons_With_Total", "LPF_Children_0_17_1_Child", "LPF_Children_0_17_2_Child", "LPF_Children_0_17_3_Child",  "LPF_Children_0_17_Total", "LPF_Persons_65P_1_Child", "LPF_Persons_65P_2_Child", "LPF_Persons_65P_3_Child", "LPF_Persons_65P_Total",
                 "Low_Income_LPF_1_Child", "Low_Income_LPF_2_Child", "Low_Income_LPF_3_Child", "Low_Income_LPF_Total", "Low_Income_LPF_Median_Income_1_Child", "Low_Income_LPF_Median_Income_2_Child", "Low_Income_LPF_Median_Income_3_Child", "Low_Income_LPF_Median_Income_Total", "Low_Income_LPF_Persons_With_1_Child", "Low_Income_LPF_Persons_With_2_Child", "Low_Income_LPF_Persons_With_3_Child", "Low_Income_LPF_Persons_With_Total", "Low_Income_LPF_Children_0_17_1_Child", "Low_Income_LPF_Children_0_17_2_Child", "Low_Income_LPF_Children_0_17_3_Child",  "Low_Income_LPF_Children_0_17_Total", "Low_Income_LPF_Persons_65P_1_Child", "Low_Income_LPF_Persons_65P_2_Child", "Low_Income_LPF_Persons_65P_3_Child", "Low_Income_LPF_Persons_65P_Total",
                 "NonFam_0_Child", "NonFam_0_Child_Median_Income", "NonFam_0_Child_Persons", "NonFam_0_Child_65P", "LowIncome_NonFam_0_Child", "LowIncome_NonFam_0_Child_Median_Income", "LowIncome_NonFam_0_Child_Persons", "LowIncome_NonFam_0_Child_65P", 
                 "AllFam_NonFam_0_Child", "AllFam_NonFam_1_Child", "AllFam_NonFam_2_Child", "AllFam_NonFam_3_Child", "AllFam_NonFam_Total", "AllFam_NonFam_Median_Income_0_Child", "AllFam_NonFam_Median_Income_1_Child", "AllFam_NonFam_Median_Income_2_Child", "AllFam_NonFam_Median_Income_3_Child", "AllFam_NonFam_Median_Income_Total", "AllFam_NonFam_Persons_With_0_Child", "AllFam_NonFam_Persons_With_1_Child", "AllFam_NonFam_Persons_With_2_Child", "AllFam_NonFam_Persons_With_3_Child", "AllFam_NonFam_Persons_With_Total", "AllFam_NonFam_Children_0_17_1_Child", "AllFam_NonFam_Children_0_17_2_Child", "AllFam_NonFam_Children_0_17_3_Child",  "AllFam_NonFam_Children_0_17_Total", "AllFam_NonFam_Persons_65P_0_Child", "AllFam_NonFam_Persons_65P_1_Child", "AllFam_NonFam_Persons_65P_2_Child", "AllFam_NonFam_Persons_65P_3_Child", "AllFam_NonFam_Persons_65P_Total",
                 "All_Low_Income_Fam_NonFam_0_Child", "All_Low_Income_Fam_NonFam_1_Child", "All_Low_Income_Fam_NonFam_2_Child", "All_Low_Income_Fam_NonFam_3_Child", "All_Low_Income_Fam_NonFam_Total", "All_Low_Income_Fam_NonFam_Median_Income_0_Child", "All_Low_Income_Fam_NonFam_Median_Income_1_Child", "All_Low_Income_Fam_NonFam_Median_Income_2_Child", "All_Low_Income_Fam_NonFam_Median_Income_3_Child", "All_Low_Income_Fam_NonFam_Median_Income_Total", "All_Low_Income_Fam_NonFam_Persons_With_0_Child", "All_Low_Income_Fam_NonFam_Persons_With_1_Child", "All_Low_Income_Fam_NonFam_Persons_With_2_Child", "All_Low_Income_Fam_NonFam_Persons_With_3_Child", "All_Low_Income_Fam_NonFam_Persons_With_Total", "All_Low_Income_Fam_NonFam_Children_0_17_1_Child", "All_Low_Income_Fam_NonFam_Children_0_17_2_Child", "All_Low_Income_Fam_NonFam_Children_0_17_3_Child",  "All_Low_Income_Fam_NonFam_Children_0_17_Total", "All_Low_Income_Fam_NonFam_Persons_65P_0_Child", "All_Low_Income_Fam_NonFam_Persons_65P_1_Child", "All_Low_Income_Fam_NonFam_Persons_65P_2_Child", "All_Low_Income_Fam_NonFam_Persons_65P_3_Child", "All_Low_Income_Fam_NonFam_Persons_65P_Total")
dat1 <- na.omit(dat1)


#Extract the BC subset of the data in table 22

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


#Output the generated table 22

write.table(df, file ="2015_Family_Table_18_Canada.csv", sep = ",", row.names = FALSE)

---------------------------   
  
  
  
  #combine/merge all subsheets into one table
  
df1 <-  read.table(file ="2015_Family_Table_1_Canada.csv", sep = ",")
df2 <-  read.table(file ="2015_Family_Table_2_Canada.csv", sep = ",")
df3 <-  read.table(file ="2015_Family_Table_3A_Canada.csv", sep = ",")
df4 <-  read.table(file ="2015_Family_Table_3B_Canada.csv", sep = ",")
df5 <-  read.table(file ="2015_Family_Table_3C_Canada.csv", sep = ",")
df6 <-  read.table(file ="2015_Family_Table_4A_Canada.csv", sep = ",")
df7 <-  read.table(file ="2015_Family_Table_4B_Canada.csv", sep = ",")
df8 <-  read.table(file ="2015_Family_Table_4C_Canada.csv", sep = ",")
df9 <-  read.table(file ="2015_Family_Table_5A_Canada.csv", sep = ",")
df10 <-  read.table(file ="2015_Family_Table_5B_Canada.csv", sep = ",")
df11 <-  read.table(file ="2015_Family_Table_6_Canada.csv", sep = ",")
df12 <-  read.table(file ="2015_Family_Table_7_Canada.csv", sep = ",")
df13 <-  read.table(file ="2015_Family_Table_8_Canada.csv", sep = ",")
df14 <-  read.table(file ="2015_Family_Table_9_Canada.csv", sep = ",")
df15 <-  read.table(file ="2015_Family_Table_10_Canada.csv", sep = ",")
df16 <-  read.table(file ="2015_Family_Table_14A_Canada.csv", sep = ",")
df17 <-  read.table(file ="2015_Family_Table_14B_Canada.csv", sep = ",")
df18 <-  read.table(file ="2015_Family_Table_14C_Canada.csv", sep = ",")
df19 <-  read.table(file ="2015_Family_Table_15_Canada.csv", sep = ",")
df20 <-  read.table(file ="2015_Family_Table_17_Canada.csv", sep = ",")
df21 <-  read.table(file ="2015_Family_Table_18_Canada.csv", sep = ",")



DFs <- data.frame(cbind(df1, df2[,6:ncol(df2)], df3[,6:ncol(df3)], df4[,6:ncol(df4)], df5[,6:ncol(df5)], df6[,6:ncol(df6)], df7[,6:ncol(df7)], df8[,6:ncol(df8)], df9[,6:ncol(df9)], df10[,6:ncol(df10)], df11[,6:ncol(df11)], df12[,6:ncol(df12)], 
                        df13[,6:ncol(df13)], df14[,6:ncol(df14)], df15[,6:ncol(df15)], df16[,6:ncol(df16)], df17[,6:ncol(df17)], df18[,6:ncol(df18)], df19[,6:ncol(df19)], df20[,6:ncol(df20)], df21[,6:ncol(df21)]), col.names = T)

DFs <- na.omit(DFs)

write.table(DFs, file ="2015_Family_Table.csv", sep = ",", row.names = FALSE, col.names = TRUE)



