#For Table 1 in individual income data
#load income data into R
setwd("~/Desktop/Income/IND tables 2000 to 2015")
getwd()
dir.wrk <- "~/Desktop/Income/IND tables 2000 to 2015"
dir.wrk <- getwd()

#load libraries
library(data.table)
library(openxlsx)
library(dplyr)
library(here)
library(stringr)

---------------------------
  
#read file path for individual income table 1 to clean-up column names

file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 1, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "No_Taxfilers",  "Taxfilers_0_24_Percent",  "Taxfilers_25_44_Percent", "Taxfilers_45_64_Percent", "Taxfilers_65Plus_Percent", "Taxfilers_Average_Age",	"Taxfilers_Female_Percent", "Taxfilers_Married_Percent", "Taxfilers_Appt_Percent",	"No_All_Persons",  "Persons_0_24_Percent",	"Persons_25_44_Percent", "Persons_45_64_Percent", "Persons_56Plus_Percent",	"Persons_Average_Age", "Persons_Female_Percent", "Persons_Married_Percent", "Persons_Appt_Percent",	"No_Total_Income", "Percent_Total_Income_15K", "Percent_Total_Income_25K", "Percent_Total_Income_35K", "Percent_Total_Income_50K", "Percent_Total_Income_75K", "Percent_Total_Income_100K",	"Total_Income_Median_Males", "Total_Income_Median_Females", "Total_Income_Median",	"Total_Income_Median_Cdn_Index",	"Total_Income_Median_Prov_Index",	"Employment_Income",	"EI_Female_Percent",	"EI_Percent",	"Median_EI_Males", "Median_EI_Females", "Total_Median_EI",	"No_CCTB", 	"CCTB_Dollars_000")
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

write.table(df, file ="2015_Individuals_Table_1_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
#read file path for individual income table 2
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 2, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Single_Males",	"Single_Females",	"Single_Total",	"Married_Males",	"Married_Females",	"Married_Total",	"Common_Law_Males",	"Common_Law_Females", "Common_Law_Total",	"Separated_Divorced_Males",	"Separated_Divorced_Females",	"Separated_Divorced_Total",	"Widower_Males"	,"Widow_Females",	"Widow_Total"	,"Total_Males"	,"Total_Females"	,"Total",	"Males_Age_0_14",	"Males_Percent_0_14",	"Females_Age_0_14",	"Females_Percent_0_14",	"Total_Age_0_14"	,"Total_Percent_0_14",	"Males_Age_15_19",	"Males_Percent_15_19",	"Females_Age_15_19",	"Females_Percent_15_19",	"Total_Age_15_19",	"Total_Percent_15_19",	"Males_Age_20_24"	,"Males_Percent_20_24"	,"Females_Age_20_24",	"Females_Percent_20_24",	"Total_Age_20_24", "Total_Percent_20_24",	"Males_Age_25_29",	"Males_Percent_25_29",	"Females_Age_25_29",	"Females_Percent_25_29",	"Total_Age_25_29",	"Total_Percent_25_29",	"Males_Age_30_34",	"Males_Percent_30_34",	"Females_Age_30_34",	"Females_Percent_30_34",	"Total_Age_30_34",	"Total_Percent_30_34",	"Males_Age_35_39",	"Males_Percent_35_39",	"Females_Age_35_39",	"Females_Percent_35_39",	"Total_Age_35_39",	"Total_Percent_35_39",	"Males_Age_40_44",	"Males_Percent_40_44",	"Females_Age_40_44",	"Females_Percent_40_44",	"Total_Age_40_44",	"Total_Percent_40_44",	"Males_Age_45_49",	"Males_Percent_45_49",	"Females_Age_45_49", "Females_Percent_45_49",	"Total_Age_45_49",	"Total_Percent_45_49",	"Males_Age_50_54",	"Males_Percent_50_54",	"Females_Age_50_54",	"Females_Percent_50_54",	"Total_Age_50_54",	"Total_Percent_50_54",	"Males_Age_55_59",	"Males_Percent_55_59",	"Females_Age_55_59",	"Females_Percent_55_59",	"Total_Age_55_59",	"Total_Percent_55_59",	"Males_Age_60_64",	"Males_Percent_60_64",	"Females_Age_60_64",	"Females_Percent_60_64",	"Total_Age_60_64",	"Total_Percent_60_64",	"Males_Age_65_74",	"Males_Percent_65_74",	"Females_Age_65_74",	"Females_Percent_65_74",	"Total_Age_65_74",	"Total_Percent_65_74",	"Males_Age_75P",	"Males_Percent_75P",	"Females_Age_75P",	"Females_Percent_75P",	"Total_Age_75P",	"Total_Percent_75P",	"Total_Males",	"Total_Percent_Males", "Total_Females", "Total_Percent_Females",	"Total",	"Percent_Total",	"Average_Age")
dat1 <- na.omit(dat1)


#Extract a subset of the data in table 2

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

#write out table 2

write.table(df, file ="2015_Individuals_Table_2_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
#read file path for individual income table 3
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 3, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"M_0_years",	"M_1_year",	"M_2_years",	"M_3_years",	"M_4_years",	"M_5_years",	"M_6_years",	"M_7_years",	"M_8_years",	"M_9_years",	"M_10_years",	"M_11_years",	"M_12_years",	"M_13_years",	"M_14_years",	"M_15_years",	"M_16_years",	"M_17_years",	"M_18_years",	"M_19_years",	"M_20_years",	"M_21_years",	"M_22_years",	"M_23_years",	"M_24_years",	"M_25_years",	"M_26_years",	"M_27_years",	"M_28_years",	"M_29_years",	"M_30_years",	"M_31_years",	"M_32_years",	"M_33_years",	"M_34_years",	"M_35_years",	"M_36_years",	"M_37_years",	"M_38_years",	"M_39_years",	"M_40_years",	"M_41_years",	"M_42_years",	"M_43_years",	"M_44_years",	"M_45_years",	"M_46_years",	"M_47_years",	"M_48_years",	"M_49_years",	"M_50_years",	"M_51_years",	"M_52_years",	"M_53_years",	"M_54_years",	"M_55_years",	"M_56_years",	"M_57_years",	"M_58_years",	"M_59_years",	"M_60_years",	"M_61_years",	"M_62_years",	"M_63_years",	"M_64_years",	"M_65_years",	"M_66_years",	"M_67_years",	"M_68_years",	"M_69_years",	"M_70_years",	"M_71_years",	"M_72_years",	"M_73_years",	"M_74_years",	"M_75_years",	"M_76_years",	"M_77_years",	"M_78_years",	"M_79_years",	"M_80_years",	"M_81_years",	"M_82_years",	"M_83_years",	"M_84_years",	"M_85_years",	"M_86_years",	"M_87_years",	"M_88_years",	"M_89_years",	"M_90_years",	"M_91_years",	"M_92_years",	"M_93_years",	"M_94_years",	"M_95_years",	"M_96_years",	"M_97_years",	"M_98_years",	"M_99_years",	"M_100P_years",	"M_Total")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 3

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

#write out table 3

write.table(df, file ="2015_Individuals_Table_3A_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
#read file path for individual income table 4
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 4, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"M_0_years",	"M_1_year",	"M_2_years",	"M_3_years",	"M_4_years",	"M_5_years",	"M_6_years",	"M_7_years",	"M_8_years",	"M_9_years",	"M_10_years",	"M_11_years",	"M_12_years",	"M_13_years",	"M_14_years",	"M_15_years",	"M_16_years",	"M_17_years",	"M_18_years",	"M_19_years",	"M_20_years",	"M_21_years",	"M_22_years",	"M_23_years",	"M_24_years",	"M_25_years",	"M_26_years",	"M_27_years",	"M_28_years",	"M_29_years",	"M_30_years",	"M_31_years",	"M_32_years",	"M_33_years",	"M_34_years",	"M_35_years",	"M_36_years",	"M_37_years",	"M_38_years",	"M_39_years",	"M_40_years",	"M_41_years",	"M_42_years",	"M_43_years",	"M_44_years",	"M_45_years",	"M_46_years",	"M_47_years",	"M_48_years",	"M_49_years",	"M_50_years",	"M_51_years",	"M_52_years",	"M_53_years",	"M_54_years",	"M_55_years",	"M_56_years",	"M_57_years",	"M_58_years",	"M_59_years",	"M_60_years",	"M_61_years",	"M_62_years",	"M_63_years",	"M_64_years",	"M_65_years",	"M_66_years",	"M_67_years",	"M_68_years",	"M_69_years",	"M_70_years",	"M_71_years",	"M_72_years",	"M_73_years",	"M_74_years",	"M_75_years",	"M_76_years",	"M_77_years",	"M_78_years",	"M_79_years",	"M_80_years",	"M_81_years",	"M_82_years",	"M_83_years",	"M_84_years",	"M_85_years",	"M_86_years",	"M_87_years",	"M_88_years",	"M_89_years",	"M_90_years",	"M_91_years",	"M_92_years",	"M_93_years",	"M_94_years",	"M_95_years",	"M_96_years",	"M_97_years",	"M_98_years",	"M_99_years",	"M_100P_years",	"M_Total")
names(dat1) <- str_replace_all(colnames(dat1), "^M", "F")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 4
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

#write out table 4

write.table(df, file ="2015_Individuals_Table_3B_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 5
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 5, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"M_0_years",	"M_1_year",	"M_2_years",	"M_3_years",	"M_4_years",	"M_5_years",	"M_6_years",	"M_7_years",	"M_8_years",	"M_9_years",	"M_10_years",	"M_11_years",	"M_12_years",	"M_13_years",	"M_14_years",	"M_15_years",	"M_16_years",	"M_17_years",	"M_18_years",	"M_19_years",	"M_20_years",	"M_21_years",	"M_22_years",	"M_23_years",	"M_24_years",	"M_25_years",	"M_26_years",	"M_27_years",	"M_28_years",	"M_29_years",	"M_30_years",	"M_31_years",	"M_32_years",	"M_33_years",	"M_34_years",	"M_35_years",	"M_36_years",	"M_37_years",	"M_38_years",	"M_39_years",	"M_40_years",	"M_41_years",	"M_42_years",	"M_43_years",	"M_44_years",	"M_45_years",	"M_46_years",	"M_47_years",	"M_48_years",	"M_49_years",	"M_50_years",	"M_51_years",	"M_52_years",	"M_53_years",	"M_54_years",	"M_55_years",	"M_56_years",	"M_57_years",	"M_58_years",	"M_59_years",	"M_60_years",	"M_61_years",	"M_62_years",	"M_63_years",	"M_64_years",	"M_65_years",	"M_66_years",	"M_67_years",	"M_68_years",	"M_69_years",	"M_70_years",	"M_71_years",	"M_72_years",	"M_73_years",	"M_74_years",	"M_75_years",	"M_76_years",	"M_77_years",	"M_78_years",	"M_79_years",	"M_80_years",	"M_81_years",	"M_82_years",	"M_83_years",	"M_84_years",	"M_85_years",	"M_86_years",	"M_87_years",	"M_88_years",	"M_89_years",	"M_90_years",	"M_91_years",	"M_92_years",	"M_93_years",	"M_94_years",	"M_95_years",	"M_96_years",	"M_97_years",	"M_98_years",	"M_99_years",	"M_100P_years",	"M_Total")
names(dat1) <- str_replace_all(colnames(dat1), "^M", "All")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 5

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

#write out table 5

write.table(df, file ="2015_Individuals_Table_3C_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
#read file path for individual income table 6
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 6, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"EI_Males",	"EI_Females",	"EI_Total",	"EI_Males_Dollars_000",	"EI_Females_Dollars_000",	"EI_Total_Dollars_000",	"Total_Wages_Salaries_Commissions_Males",	"Total_Wages_Salaries_Commissions_Females",	"Total_Wages_Salaries_Commissions",	"Total_Wages_Salaries_Commissions_Males_Dollar_000",	"Total_Wages_Salaries_Commissions_Females_Dollar_000",	"Total_Wages_Salaries_Commissions_Total_Dollar_000",	"Self_Employment_Males",	"Self_Employment_Females",	"Self_Employment_Total",	"Self_Employment_Males_Dollars_000",	"Self_Employment_Females_Dollars_000",	"Self_Employment_Total_Dollars_000",	"Investments_Males",	"Investments_Females",	"Investments_Total",	"Investments_Males_Dollars_000",	"Investments_Females_Dollars_000",	"Investments_Total_Dollars_000",	"Government_Transfers_Males",	"Government_Transfers_Females",	"Government_Transfers_Total",	"Government_Transfers_Males_Dollar_000",	"Government_Transfers_Females_Dollar_000",	"Government_Transfers_Total_Dollar_000",	"EI_Males_No",	"EI_Females_No",	"EI_Total_No",	"EI_Males_Dollar_000",	"EI_Females_Dollar_000",	"EI_Total_Dollar_000",	"OAS_Net_Federal_Supp_Males",	"OAS_Net_Federal_Supp_Females",	"OAS_Net_Federal_Supp_Total",	"OAS_Net_Federal_Supp_Males_Dollar_000",	"OAS_Net_Federal_Supp_Females_Dollar_000",	"OAS_Net_Federal_Supp_Total_Dollar_000",	"CPP_QPP_Males", "CPP_QPP_Females",	"CPP_QPP_Total",	"Total_Males_Dollar_000",	"Total_Females_Dollar_000",	"Total_Total_Dollar_000",	"CCTB_Males",	"CCTB_Females",	"CCTB_Total",	"CCTB_Males_Dollar_000",	"CCTB_Females_Dollar_000",	"CCTB_Total_Dollar_000",	"GST_HST_Credit_Males",	"GST_HST_Credit_Females",	"GST_HST_Credit_Total",	"GST_HST_Credit_Males_Dollar_000",	"GST_HST_Credit_Females_Dollar_000",	"GST_HST_Credit_Total_Dollar_000",	"Workers_Compensation_Males",	"Workers_Compensation_Females",	"Workers_Compensation_Total",	"Workers_Compensation_Males_Dollar_000",	"Workers_Compensation_Females_Dollar_000",	"Workers_Compensation_Total_Dollar_000",	"Social_Assistance_Males",	"Social_Assistance_Females",	"Social_Assistance_Total",	"Social_Assistance_Males_Dollar_000",	"Social_Assistance_Females_Dollar_000",	"Social_Assistance_Total_Dollar_000",	"Provincial_Tax_Credits_Family_Benefits_Males",	"Provincial_Tax_Credits_Family_Benefits_Females",	"Provincial_Tax_Credits_Family_Benefits_Total",	"Provincial_Tax_Credits_Family_Benefits_Males_Dollar_000",	"Provincial_Tax_Credits_Family_Benefits_Females_Dollar_000",	"Provincial_Tax_Credits_Family_Benefits_Total_Dollar_000",	"Other_Government_Transfers_Males",	"Other_Government_Transfers_Females",	"Other_Government_Transfers_Total",	"Other_Government_Transfers_Males",	"Other_Government_Transfers_Females",	"Other_Government_Transfers_Total",	"Private_Pensions_Males",	"Private_Pensions_Females",	"Private_Pensions_Total",	"Private_Pensions_Males_Dollar_000",	"Private_Pensions_Females_Dollar_000",	"Private_Pensions_Total_Dollar_000",	"RRSP_Males",	"RRSP_Females",	"RRSP_Total",	"RRSP_Males_Dollar_000",	"RRSP_Females_Dollar_000",	"RRSP_Total_Dollar_000",	"Other_Income_Males",	"Other_Income_Females",	"Other_Income_Total",	"Other_Income_Males_Dollar_000",	"Other_Income_Females_Dollar_000",	"Other_Income_Total_Dollar_000",	"Total_Income_Males",	"Total_Income_Females",	"Total_Income_Total",	"Total_Income_Males_Dollar_000",	"Total_Income_Females_Dollar_000",	"Total_Income_Total_Dollar_000")

dat1 <- na.omit(dat1)

#Extract a subset of the data in table 6

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

#write out table 6

write.table(df, file ="2015_Individuals_Table_4_Canada.csv", sep = ",", row.names = FALSE)


---------------------------
  
  #read file path for individual income table 7
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 7, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Male_Income_Age_0_24_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total",	"Male_Income_Age_25_34_Less5K",	"Male_Income_Age_25_34_5K",	"Male_Income_Age_25_34_10K",	"Male_Income_Age_25_34_15K",	"Male_Income_Age_25_34_20K",	"Male_Income_Age_25_34_25K",	"Male_Income_Age_25_34_35K",	"Male_Income_Age_25_34_50K",	"Male_Income_Age_25_34_75K",	"Male_Income_Age_25_34_100K",	"Male_Income_Age_25_34_150K",	"Male_Income_Age_25_34_200K",	"Male_Income_Age_25_34_250K",	"Male_Income_Age_25_34_Total",	"Male_Income_Age_35_44_Less5K",	"Male_Income_Age_35_44_5K",	"Male_Income_Age_35_44_10K",	"Male_Income_Age_35_44_15K",	"Male_Income_Age_35_44_20K",	"Male_Income_Age_35_44_25K",	"Male_Income_Age_35_44_35K",	"Male_Income_Age_35_44_50K",	"Male_Income_Age_35_44_75K",	"Male_Income_Age_35_44_100K",	"Male_Income_Age_35_44_150K",	"Male_Income_Age_35_44_200K",	"Male_Income_Age_35_44_250K",	"Male_Income_Age_35_44_Total",	"Male_Income_Age_45_54_Less5K",	"Male_Income_Age_45_54_5K",	"Male_Income_Age_45_54_10K",	"Male_Income_Age_45_54_15K",	"Male_Income_Age_45_54_20K",	"Male_Income_Age_45_54_25K",	"Male_Income_Age_45_54_35K",	"Male_Income_Age_45_54_50K",	"Male_Income_Age_45_54_75K",	"Male_Income_Age_45_54_100K",	"Male_Income_Age_45_54_150K",	"Male_Income_Age_45_54_200K",	"Male_Income_Age_45_54_250K",	"Male_Income_Age_45_54_Total",	"Male_Income_Age_55_64_Less5K",	"Male_Income_Age_55_64_5K",	"Male_Income_Age_55_64_10K",	"Male_Income_Age_55_64_15K",	"Male_Income_Age_55_64_20K",	"Male_Income_Age_55_64_25K",	"Male_Income_Age_55_64_35K",	"Male_Income_Age_55_64_50K",	"Male_Income_Age_55_64_75K",	"Male_Income_Age_55_64_100K",	"Male_Income_Age_55_64_150K",	"Male_Income_Age_55_64_200K",	"Male_Income_Age_55_64_250K",	"Male_Income_Age_55_64_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_65P_5K",	"Male_Income_Age_65P_10K",	"Male_Income_Age_65P_15K",	"Male_Income_Age_65P_20K",	"Male_Income_Age_65P_25K",	"Male_Income_Age_65P_35K",	"Male_Income_Age_65P_50K",	"Male_Income_Age_65P_75K",	"Male_Income_Age_65P_100K",	"Male_Income_Age_65P_150K",	"Male_Income_Age_65P_200K",	"Male_Income_Age_65P_250K",	"Male_Income_Age_65P_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total", "Male_2015_Median")	
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 7

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

#write out table 7

write.table(df, file ="2015_Individuals_Table_5A_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 8
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 8, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Male_Income_Age_0_24_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total",	"Male_Income_Age_25_34_Less5K",	"Male_Income_Age_25_34_5K",	"Male_Income_Age_25_34_10K",	"Male_Income_Age_25_34_15K",	"Male_Income_Age_25_34_20K",	"Male_Income_Age_25_34_25K",	"Male_Income_Age_25_34_35K",	"Male_Income_Age_25_34_50K",	"Male_Income_Age_25_34_75K",	"Male_Income_Age_25_34_100K",	"Male_Income_Age_25_34_150K",	"Male_Income_Age_25_34_200K",	"Male_Income_Age_25_34_250K",	"Male_Income_Age_25_34_Total",	"Male_Income_Age_35_44_Less5K",	"Male_Income_Age_35_44_5K",	"Male_Income_Age_35_44_10K",	"Male_Income_Age_35_44_15K",	"Male_Income_Age_35_44_20K",	"Male_Income_Age_35_44_25K",	"Male_Income_Age_35_44_35K",	"Male_Income_Age_35_44_50K",	"Male_Income_Age_35_44_75K",	"Male_Income_Age_35_44_100K",	"Male_Income_Age_35_44_150K",	"Male_Income_Age_35_44_200K",	"Male_Income_Age_35_44_250K",	"Male_Income_Age_35_44_Total",	"Male_Income_Age_45_54_Less5K",	"Male_Income_Age_45_54_5K",	"Male_Income_Age_45_54_10K",	"Male_Income_Age_45_54_15K",	"Male_Income_Age_45_54_20K",	"Male_Income_Age_45_54_25K",	"Male_Income_Age_45_54_35K",	"Male_Income_Age_45_54_50K",	"Male_Income_Age_45_54_75K",	"Male_Income_Age_45_54_100K",	"Male_Income_Age_45_54_150K",	"Male_Income_Age_45_54_200K",	"Male_Income_Age_45_54_250K",	"Male_Income_Age_45_54_Total",	"Male_Income_Age_55_64_Less5K",	"Male_Income_Age_55_64_5K",	"Male_Income_Age_55_64_10K",	"Male_Income_Age_55_64_15K",	"Male_Income_Age_55_64_20K",	"Male_Income_Age_55_64_25K",	"Male_Income_Age_55_64_35K",	"Male_Income_Age_55_64_50K",	"Male_Income_Age_55_64_75K",	"Male_Income_Age_55_64_100K",	"Male_Income_Age_55_64_150K",	"Male_Income_Age_55_64_200K",	"Male_Income_Age_55_64_250K",	"Male_Income_Age_55_64_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_65P_5K",	"Male_Income_Age_65P_10K",	"Male_Income_Age_65P_15K",	"Male_Income_Age_65P_20K",	"Male_Income_Age_65P_25K",	"Male_Income_Age_65P_35K",	"Male_Income_Age_65P_50K",	"Male_Income_Age_65P_75K",	"Male_Income_Age_65P_100K",	"Male_Income_Age_65P_150K",	"Male_Income_Age_65P_200K",	"Male_Income_Age_65P_250K",	"Male_Income_Age_65P_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total", "Male_2015_Median")	
names(dat1) <- str_replace_all(colnames(dat1), "^Male", "Female")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 8

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

#write out table 8

write.table(df, file ="2015_Individuals_Table_5B_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 9
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 9, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Male_Income_Age_0_24_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total",	"Male_Income_Age_25_34_Less5K",	"Male_Income_Age_25_34_5K",	"Male_Income_Age_25_34_10K",	"Male_Income_Age_25_34_15K",	"Male_Income_Age_25_34_20K",	"Male_Income_Age_25_34_25K",	"Male_Income_Age_25_34_35K",	"Male_Income_Age_25_34_50K",	"Male_Income_Age_25_34_75K",	"Male_Income_Age_25_34_100K",	"Male_Income_Age_25_34_150K",	"Male_Income_Age_25_34_200K",	"Male_Income_Age_25_34_250K",	"Male_Income_Age_25_34_Total",	"Male_Income_Age_35_44_Less5K",	"Male_Income_Age_35_44_5K",	"Male_Income_Age_35_44_10K",	"Male_Income_Age_35_44_15K",	"Male_Income_Age_35_44_20K",	"Male_Income_Age_35_44_25K",	"Male_Income_Age_35_44_35K",	"Male_Income_Age_35_44_50K",	"Male_Income_Age_35_44_75K",	"Male_Income_Age_35_44_100K",	"Male_Income_Age_35_44_150K",	"Male_Income_Age_35_44_200K",	"Male_Income_Age_35_44_250K",	"Male_Income_Age_35_44_Total",	"Male_Income_Age_45_54_Less5K",	"Male_Income_Age_45_54_5K",	"Male_Income_Age_45_54_10K",	"Male_Income_Age_45_54_15K",	"Male_Income_Age_45_54_20K",	"Male_Income_Age_45_54_25K",	"Male_Income_Age_45_54_35K",	"Male_Income_Age_45_54_50K",	"Male_Income_Age_45_54_75K",	"Male_Income_Age_45_54_100K",	"Male_Income_Age_45_54_150K",	"Male_Income_Age_45_54_200K",	"Male_Income_Age_45_54_250K",	"Male_Income_Age_45_54_Total",	"Male_Income_Age_55_64_Less5K",	"Male_Income_Age_55_64_5K",	"Male_Income_Age_55_64_10K",	"Male_Income_Age_55_64_15K",	"Male_Income_Age_55_64_20K",	"Male_Income_Age_55_64_25K",	"Male_Income_Age_55_64_35K",	"Male_Income_Age_55_64_50K",	"Male_Income_Age_55_64_75K",	"Male_Income_Age_55_64_100K",	"Male_Income_Age_55_64_150K",	"Male_Income_Age_55_64_200K",	"Male_Income_Age_55_64_250K",	"Male_Income_Age_55_64_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_65P_5K",	"Male_Income_Age_65P_10K",	"Male_Income_Age_65P_15K",	"Male_Income_Age_65P_20K",	"Male_Income_Age_65P_25K",	"Male_Income_Age_65P_35K",	"Male_Income_Age_65P_50K",	"Male_Income_Age_65P_75K",	"Male_Income_Age_65P_100K",	"Male_Income_Age_65P_150K",	"Male_Income_Age_65P_200K",	"Male_Income_Age_65P_250K",	"Male_Income_Age_65P_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total", "Male_2015_Median")	
names(dat1) <- str_replace_all(colnames(dat1), "^Male", "All")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 9

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

#write out table 9

write.table(df, file ="2015_Individuals_Table_5C_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
#read file path for individual income table 10
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 10, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Total_Income_Males",	"Total_Income_Females",	"Total_Income",	"Total_Income_Males_Dollar_000",	"Total_Income_Females_Dollar_000",	"Total_Income_Dollar_000",	"IncomeTax_Males",	"IncomeTax_Femles",	"IncomeTax_Total",	"IncomeTax_Males_Dollar_000",	"IncomeTax_Females_Dollar_000",	"IncomeTax_Dollar_000",	"FederalTax_Males",	"FederalTax_Females",	"FederalTax_Total",	"FederalTax_Males_Dollar_000",	"FederalTax_Females_Dollar_000",	"FederalTax_Total_Dollar_000",	"ProvincialTax_Males",	"ProvincialTax_Females",	"ProvincialTax_Total",	"ProvincialTax_Males_Dollar_000",	"ProvincialTax_Females_Dollar_000",	"ProvincialTax_Total_Dollar_000",	"Qbc_Abatement_Males",	"Qbc_Abatement_Females",	"Qbc_Abatement_Total",	"Qbc_Abatement_Males_Dollar_000",	"Qbc_Abatement_Females_Dollar_000",	"Qbc_Abatement_Total_Dollar_000",	"CapitalGains_Males",	"CapitalGains_Females",	"CapitalGains_Total",	"CapitalGains_Males_Dollar_000",	"CapitalGains_Females_Dollar_000",	"CapitalGains_Total_Dollar_000",	"EI_Premium_Total",	"EI_Premium_Females",	"EI_Premium_Total",	"EI_Premium_Males_Dollar_000",	"EI_Premium_Females_Dollar_000",	"EI_Premium_Total_Dollar_000",	"CPP_QPP_Premium_Total",	"CPP_QPP_Premium_Females",	"CPP_QPP_Premium_Total",	"CPP_QPP_Premium_Males_Dollar_000",	"CPP_QPP_Premium_Females_Dollar_000",	"CPP_QPP_Premium_Total_Dollar_000",	"RPP_Deduction_Total",	"RPP_Deduction_Females",	"RPP_Deduction_Total",	"RPP_Deduction_Males_Dollar_000",	"RPP_Deduction_Females_Dollar_000",	"RPP_Deduction_Total_Dollar_000",	"Union_Professional_Dues_Total",	"Union_Professional_Dues_Females",	"Union_Professional_Dues_Total",	"Union_Professional_Dues_Males_Dollar_000",	"Union_Professional_Dues_Females_Dollar_000",	"Union_Professional_Dues_Total_Dollar_000",	"Emp_Insurance_Benefits_Total",	"Emp_Insurance_Benefits_Females",	"Emp_Insurance_Benefits_Total",	"Emp_Insurance_Benefits_Males_Dollar_000",	"Emp_Insurance_Benefits_Females_Dollar_000",	"Emp_Insurance_Benefits_Total_Dollar_000",	"CPP_QPP_Benefits_Total",	"CPP_QPP_Benefits_Females",	"CPP_QPP_Benefits_Total",	"CPP_QPP_Benefits_Males_Dollar_000",	"CPP_QPP_Benefits_Females_Dollar_000",	"CPP_QPP_Benefits_Total_Dollar_000")
dat1 <- na.omit(dat1)


#Extract a subset of the data in table 10

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

#write out table 10

write.table(df, file ="2015_Individuals_Table_6_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
#read file path for individual income table 11
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 11, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Male_Income_Age_0_24_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total",	"Male_Income_Age_25_34_Less5K",	"Male_Income_Age_25_34_5K",	"Male_Income_Age_25_34_10K",	"Male_Income_Age_25_34_15K",	"Male_Income_Age_25_34_20K",	"Male_Income_Age_25_34_25K",	"Male_Income_Age_25_34_35K",	"Male_Income_Age_25_34_50K",	"Male_Income_Age_25_34_75K",	"Male_Income_Age_25_34_100K",	"Male_Income_Age_25_34_150K",	"Male_Income_Age_25_34_200K",	"Male_Income_Age_25_34_250K",	"Male_Income_Age_25_34_Total",	"Male_Income_Age_35_44_Less5K",	"Male_Income_Age_35_44_5K",	"Male_Income_Age_35_44_10K",	"Male_Income_Age_35_44_15K",	"Male_Income_Age_35_44_20K",	"Male_Income_Age_35_44_25K",	"Male_Income_Age_35_44_35K",	"Male_Income_Age_35_44_50K",	"Male_Income_Age_35_44_75K",	"Male_Income_Age_35_44_100K",	"Male_Income_Age_35_44_150K",	"Male_Income_Age_35_44_200K",	"Male_Income_Age_35_44_250K",	"Male_Income_Age_35_44_Total",	"Male_Income_Age_45_54_Less5K",	"Male_Income_Age_45_54_5K",	"Male_Income_Age_45_54_10K",	"Male_Income_Age_45_54_15K",	"Male_Income_Age_45_54_20K",	"Male_Income_Age_45_54_25K",	"Male_Income_Age_45_54_35K",	"Male_Income_Age_45_54_50K",	"Male_Income_Age_45_54_75K",	"Male_Income_Age_45_54_100K",	"Male_Income_Age_45_54_150K",	"Male_Income_Age_45_54_200K",	"Male_Income_Age_45_54_250K",	"Male_Income_Age_45_54_Total",	"Male_Income_Age_55_64_Less5K",	"Male_Income_Age_55_64_5K",	"Male_Income_Age_55_64_10K",	"Male_Income_Age_55_64_15K",	"Male_Income_Age_55_64_20K",	"Male_Income_Age_55_64_25K",	"Male_Income_Age_55_64_35K",	"Male_Income_Age_55_64_50K",	"Male_Income_Age_55_64_75K",	"Male_Income_Age_55_64_100K",	"Male_Income_Age_55_64_150K",	"Male_Income_Age_55_64_200K",	"Male_Income_Age_55_64_250K",	"Male_Income_Age_55_64_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_65P_5K",	"Male_Income_Age_65P_10K",	"Male_Income_Age_65P_15K",	"Male_Income_Age_65P_20K",	"Male_Income_Age_65P_25K",	"Male_Income_Age_65P_35K",	"Male_Income_Age_65P_50K",	"Male_Income_Age_65P_75K",	"Male_Income_Age_65P_100K",	"Male_Income_Age_65P_150K",	"Male_Income_Age_65P_200K",	"Male_Income_Age_65P_250K",	"Male_Income_Age_65P_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total", "Male_2015_Median")	
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 11

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

#write out table 11

write.table(df, file ="2015_Individuals_Table_7A_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 12
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 12, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Male_Income_Age_0_24_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total",	"Male_Income_Age_25_34_Less5K",	"Male_Income_Age_25_34_5K",	"Male_Income_Age_25_34_10K",	"Male_Income_Age_25_34_15K",	"Male_Income_Age_25_34_20K",	"Male_Income_Age_25_34_25K",	"Male_Income_Age_25_34_35K",	"Male_Income_Age_25_34_50K",	"Male_Income_Age_25_34_75K",	"Male_Income_Age_25_34_100K",	"Male_Income_Age_25_34_150K",	"Male_Income_Age_25_34_200K",	"Male_Income_Age_25_34_250K",	"Male_Income_Age_25_34_Total",	"Male_Income_Age_35_44_Less5K",	"Male_Income_Age_35_44_5K",	"Male_Income_Age_35_44_10K",	"Male_Income_Age_35_44_15K",	"Male_Income_Age_35_44_20K",	"Male_Income_Age_35_44_25K",	"Male_Income_Age_35_44_35K",	"Male_Income_Age_35_44_50K",	"Male_Income_Age_35_44_75K",	"Male_Income_Age_35_44_100K",	"Male_Income_Age_35_44_150K",	"Male_Income_Age_35_44_200K",	"Male_Income_Age_35_44_250K",	"Male_Income_Age_35_44_Total",	"Male_Income_Age_45_54_Less5K",	"Male_Income_Age_45_54_5K",	"Male_Income_Age_45_54_10K",	"Male_Income_Age_45_54_15K",	"Male_Income_Age_45_54_20K",	"Male_Income_Age_45_54_25K",	"Male_Income_Age_45_54_35K",	"Male_Income_Age_45_54_50K",	"Male_Income_Age_45_54_75K",	"Male_Income_Age_45_54_100K",	"Male_Income_Age_45_54_150K",	"Male_Income_Age_45_54_200K",	"Male_Income_Age_45_54_250K",	"Male_Income_Age_45_54_Total",	"Male_Income_Age_55_64_Less5K",	"Male_Income_Age_55_64_5K",	"Male_Income_Age_55_64_10K",	"Male_Income_Age_55_64_15K",	"Male_Income_Age_55_64_20K",	"Male_Income_Age_55_64_25K",	"Male_Income_Age_55_64_35K",	"Male_Income_Age_55_64_50K",	"Male_Income_Age_55_64_75K",	"Male_Income_Age_55_64_100K",	"Male_Income_Age_55_64_150K",	"Male_Income_Age_55_64_200K",	"Male_Income_Age_55_64_250K",	"Male_Income_Age_55_64_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_65P_5K",	"Male_Income_Age_65P_10K",	"Male_Income_Age_65P_15K",	"Male_Income_Age_65P_20K",	"Male_Income_Age_65P_25K",	"Male_Income_Age_65P_35K",	"Male_Income_Age_65P_50K",	"Male_Income_Age_65P_75K",	"Male_Income_Age_65P_100K",	"Male_Income_Age_65P_150K",	"Male_Income_Age_65P_200K",	"Male_Income_Age_65P_250K",	"Male_Income_Age_65P_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total", "Male_2015_Median")	
names(dat1) <- str_replace_all(colnames(dat1), "^Male", "Female")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 12

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

#write out table 12

write.table(df, file ="2015_Individuals_Table_7B_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 13
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 13, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Male_Income_Age_0_24_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total",	"Male_Income_Age_25_34_Less5K",	"Male_Income_Age_25_34_5K",	"Male_Income_Age_25_34_10K",	"Male_Income_Age_25_34_15K",	"Male_Income_Age_25_34_20K",	"Male_Income_Age_25_34_25K",	"Male_Income_Age_25_34_35K",	"Male_Income_Age_25_34_50K",	"Male_Income_Age_25_34_75K",	"Male_Income_Age_25_34_100K",	"Male_Income_Age_25_34_150K",	"Male_Income_Age_25_34_200K",	"Male_Income_Age_25_34_250K",	"Male_Income_Age_25_34_Total",	"Male_Income_Age_35_44_Less5K",	"Male_Income_Age_35_44_5K",	"Male_Income_Age_35_44_10K",	"Male_Income_Age_35_44_15K",	"Male_Income_Age_35_44_20K",	"Male_Income_Age_35_44_25K",	"Male_Income_Age_35_44_35K",	"Male_Income_Age_35_44_50K",	"Male_Income_Age_35_44_75K",	"Male_Income_Age_35_44_100K",	"Male_Income_Age_35_44_150K",	"Male_Income_Age_35_44_200K",	"Male_Income_Age_35_44_250K",	"Male_Income_Age_35_44_Total",	"Male_Income_Age_45_54_Less5K",	"Male_Income_Age_45_54_5K",	"Male_Income_Age_45_54_10K",	"Male_Income_Age_45_54_15K",	"Male_Income_Age_45_54_20K",	"Male_Income_Age_45_54_25K",	"Male_Income_Age_45_54_35K",	"Male_Income_Age_45_54_50K",	"Male_Income_Age_45_54_75K",	"Male_Income_Age_45_54_100K",	"Male_Income_Age_45_54_150K",	"Male_Income_Age_45_54_200K",	"Male_Income_Age_45_54_250K",	"Male_Income_Age_45_54_Total",	"Male_Income_Age_55_64_Less5K",	"Male_Income_Age_55_64_5K",	"Male_Income_Age_55_64_10K",	"Male_Income_Age_55_64_15K",	"Male_Income_Age_55_64_20K",	"Male_Income_Age_55_64_25K",	"Male_Income_Age_55_64_35K",	"Male_Income_Age_55_64_50K",	"Male_Income_Age_55_64_75K",	"Male_Income_Age_55_64_100K",	"Male_Income_Age_55_64_150K",	"Male_Income_Age_55_64_200K",	"Male_Income_Age_55_64_250K",	"Male_Income_Age_55_64_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_65P_5K",	"Male_Income_Age_65P_10K",	"Male_Income_Age_65P_15K",	"Male_Income_Age_65P_20K",	"Male_Income_Age_65P_25K",	"Male_Income_Age_65P_35K",	"Male_Income_Age_65P_50K",	"Male_Income_Age_65P_75K",	"Male_Income_Age_65P_100K",	"Male_Income_Age_65P_150K",	"Male_Income_Age_65P_200K",	"Male_Income_Age_65P_250K",	"Male_Income_Age_65P_Total",	"Male_Income_Age_65P_Less5K",	"Male_Income_Age_0_24_5K",	"Male_Income_Age_0_24_10K",	"Male_Income_Age_0_24_15K",	"Male_Income_Age_0_24_20K",	"Male_Income_Age_0_24_25K",	"Male_Income_Age_0_24_35K",	"Male_Income_Age_0_24_50K",	"Male_Income_Age_0_24_75K",	"Male_Income_Age_0_24_100K",	"Male_Income_Age_0_24_150K",	"Male_Income_Age_0_24_200K",	"Male_Income_Age_0_24_250K",	"Male_Income_Age_0_24_Total", "Male_2015_Median")	
names(dat1) <- str_replace_all(colnames(dat1), "^Male", "All")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 13

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

#write out table 13

write.table(df, file ="2015_Individuals_Table_7C_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 14
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 14, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "M_0_24_Income",	"M_0_24_Income_Dollar",	"M_0_24_IncomeTax",	"M_0_24_IncomeTax_Dollar",	"M_0_24_AfterTax_Income",	"M_0_24_AfterTax_Income_Dollar",	"M_25_34_Income",	"M_25_34_Income_Dollar",	"M_25_34_IncomeTax",	"M_25_34_IncomeTax_Dollar",	"M_25_34_AfterTax_Income",	"M_25_34_AfterTax_Income_Dollar",	"M_35_44_Income",	"M_35_44_Income_Dollar",	"M_35_44_IncomeTax",	"M_35_44_IncomeTax_Dollar",	"M_35_44_AfterTax_Income",	"M_35_44_AfterTax_Income_Dollar",	"M_45_54_Income",	"M_45_54_Income_Dollar",	"M_45_54_IncomeTax",	"M_45_54_IncomeTax_Dollar",	"M_45_54_AfterTax_Income",	"M_45_54_AfterTax_Income_Dollar",	"M_55_64_Income",	"M_55_64_Income_Dollar",	"M_55_64_IncomeTax",	"M_55_64_IncomeTax_Dollar",	"M_55_64_AfterTax_Income",	"M_55_64_AfterTax_Income_Dollar",	"M_65P_Income",	"M_65P_Income_Dollar",	"M_65P_IncomeTax",	"M_65P_IncomeTax_Dollar",	"M_65P_AfterTax_Income",	"M_65P_AfterTax_Income_Dollar",	"M_All_Income",	"M_All_Income_Dollar",	"M_All_IncomeTax",	"M_All_IncomeTax_Dollar",	"M_All_AfterTax_Income",	"M_All_AfterTax_Income_Dollar",	"F_0_24_Income",	"F_0_24_Income_Dollar",	"F_0_24_IncomeTax",	"F_0_24_IncomeTax_Dollar",	"F_0_24_AfterTax_Income",	"F_0_24_AfterTax_Income_Dollar",	"F_25_34_Income",	"F_25_34_Income_Dollar",	"F_25_34_IncomeTax",	"F_25_34_IncomeTax_Dollar",	"F_25_34_AfterTax_Income",	"F_25_34_AfterTax_Income_Dollar",	"F_35_44_Income",	"F_35_44_Income_Dollar",	"F_35_44_IncomeTax",	"F_35_44_IncomeTax_Dollar",	"F_35_44_AfterTax_Income",	"F_35_44_AfterTax_Income_Dollar",	"F_45_54_Income",	"F_45_54_Income_Dollar",	"F_45_54_IncomeTax",	"F_45_54_IncomeTax_Dollar",	"F_45_54_AfterTax_Income",	"F_45_54_AfterTax_Income_Dollar",	"F_55_64_Income",	"F_55_64_Income_Dollar",	"F_55_64_IncomeTax", "F_55_64_IncomeTax_Dollar",	"F_55_64_AfterTax_Income",	"F_55_64_AfterTax_Income_Dollar",	"F_65P_Income",	"F_65P_Income_Dollar",	"F_65P_IncomeTax",	"F_65P_IncomeTax_Dollar",	"F_65P_AfterTax_Income",	"F_65P_AfterTax_Income_Dollar",	"F_All_Income",	"F_All_Income_Dollar",	"F_All_IncomeTax",	"F_All_IncomeTax_Dollar",	"F_All_AfterTax_Income",	"M_All_AfterTax_Income_Dollar",	"All_0_24_Income",	"All_0_24_Income_Dollar",	"All_0_24_IncomeTax",	"All_0_24_IncomeTax_Dollar",	"All_0_24_AfterTax_Income",	"All_0_24_AfterTax_Income_Dollar",	"All_25_34_Income",	"All_25_34_Income_Dollar",	"All_25_34_IncomeTax",	"All_25_34_IncomeTax_Dollar",	"All_25_34_AfterTax_Income",	"All_25_34_AfterTax_Income_Dollar",	"All_35_44_Income",	"All_35_44_Income_Dollar",	"All_35_44_IncomeTax",	"All_35_44_IncomeTax_Dollar",	"All_35_44_AfterTax_Income",	"All_35_44_AfterTax_Income_Dollar",	"All_45_54_Income",	"All_45_54_Income_Dollar",	"All_45_54_IncomeTax",	"All_45_54_IncomeTax_Dollar",	"All_45_54_AfterTax_Income",	"All_45_54_AfterTax_Income_Dollar",	"All_55_64_Income",	"All_55_64_Income_Dollar",	"All_55_64_IncomeTax",	"All_55_64_IncomeTax_Dollar",	"All_55_64_AfterTax_Income",	"All_55_64_AfterTax_Income_Dollar",	"All_65P_Income",	"All_65P_Income_Dollar",	"All_65P_IncomeTax",	"All_65P_IncomeTax_Dollar",	"All_65P_AfterTax_Income",	"All_65P_AfterTax_Income_Dollar",	"All_Income",	"All_Income_Dollar",	"All_IncomeTax",	"All_IncomeTax_Dollar",	"All_AfterTax_Income",	"All_AfterTax_Income_Dollar")
dat1 <- na.omit(dat1)


#Extract a subset of the data in table 14

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

#write out table 14

write.table(df, file ="2015_Individuals_Table_8_Canada.csv", sep = ",", row.names = FALSE)

---------------------------  
  
  #read file path for individual income table 15
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 15, startRow = 3)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name",	"Govt_Transfer_Males",	"Govt_Transfer_Females",	"Govt_Transfer",	"Govt_Transfer_Males_Dollar_000",	"Govt_Transfer_Females_Dollar_000",	"Govt_Transfer_Dollar_000",	"Govt_TransferEDR_Males",	"Govt_TransferEDR_Females",	"Govt_TransferEDR",	"EDR_Prov_Index_Males",	"EDR_Prov_Index_Females",	"EDR_Prov_Index",	"EDR_Canada_Index_Males",	"EDR_Canada_Index_Females",	"EDR_Canada_Index",	"EmpI_In_Males",	"EmpI_In_Females",	"EmpI_In",	"EmpI_In_Males_Dollar_000",	"EmpI_In_Females_Dollar_000",	"EmpI_In_Dollar_000",	"EI_Males",	"EI_Females",	"EI",	"EI_Males_Dollar_000",	"EI_Females_Dollar_000",	"EI_Dollar_000",	"EI_EDR_Males",	"EI_EDR_Females",	"EI_EDR",	"GST_HST_Males",	"GST_HST_Females",	"GST_HST",	"GST_HST_Males_Dollar_000",	"GST_HST_Females_Dollar_000",	"GST_HST_Dollar_000",	"GST_HST_EDR_Males_Dollar_000",	"GST_HST_EDR_Females_Dollar_000",	"GST_HST_EDR_Dollar_000",	"CCTB_Males",	"CCTB_Females",	"CCTB",	"CCTB_Males_Dollar_000",	"CCTB_Females_Dollar_000",	"CCTB_Dollar_000",	"CCTB_EDR_Males",	"CCTB_EDR_Females",	"CCTB_EDR",	"OAS_NFS_Males",	"OAS_NFS_Females",	"OAS_NFS",	"OAS_NFS_Males_Dollar_000",	"OAS_NFS_Females_Dollar_000",	"OAS_NFS_Dollar_000",	"OAS_NFS_EDR_Males",	"OAS_NFS_EDR_Females",	"OAS_NFS_EDR",	"CPP_QPP_Males",	"CPP_QPP_Females",	"CPP_QPP",	"CPP_QPP_Males_Dollar_000",	"CPP_QPP_Females_Dollar_000",	"CPP_QPP_Dollar_000",	"CPP_QPP_EDR_Males",	"CPP_QPP_EDR_Females",	"CPP_QPP_EDR",	"Work_Comp_Males",	"Work_Comp_Females",	"Work_Comp",	"Work_Comp_Males_Dollar_000",	"Work_Comp_Females_Dollar_000",	"Work_Comp_Dollar_000",	"Work_CompEDR_Males",	"Work_CompEDR_Females",	"WorkEDR_Comp",	"SA_Males",	"SA_Females",	"SA",	"SA_Males_Dollar_000",	"SA_Females_Dollar_000",	"SA_Dollar_000",	"SA_EDR_Males",	"SA_EDR_Females",	"SA_EDR",	"PRTC_FB_Males",	"PRTC_FB_Males",	"PRTC_FB",	"PRTC_FB_Males_Dollar_000",	"PRTC_FB_Males_Dollar_000",	"PRTC_FB_Dollar_000",	"PRTC_FB_EDR_Males",	"PRTC_FB_EDR_Males",	"PRTC_EDR_FB",	"Oth_Govt_Transfer_Males",	"Oth_Govt_Transfer_Females",	"Oth_Govt_Transfer",	"OGT_Males_Dollar_000",	"OGT_Females_Dollar_000",	"OGT_Dollar_000",	"OGT_EDR_Males",	"OGT_EDR_Females",	"OGT_EDR")
dat1 <- na.omit(dat1)


#Extract a subset of the data in table 15

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

#write out table 15

write.table(df, file ="2015_Individuals_Table_9_Canada.csv", sep = ",", row.names = FALSE)

--------------------------- 
  
  #read file path for individual income table 16
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 16, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Total_Males",	"Total_Females",	"Total_All",	"Taxfilers_Males",	"Taxfilers_Females",	"Taxfilers_All",	"Income_Males",	"Income_Femles",	"Income_Total",	"Income_Males_Dollar_000",	"Income_Females_Dollar_000",	"Income_Dollar_000",	"Median_Inc_Males",	"Median_Inc_Females",	"Median_Inc_Total",	"Prov_Index_Males",	"Prov_Index_Females",	"Prov_Index",	"Can_Index_Males",	"Can_Index_Females",	"Can_Index",	"Lab_Inc_Males",	"Lab_Inc_Females",	"Lab_Inc",	"Lab_Inc_Males_Dollar_000",	"Lab_Inc_Females_Dollar_000",	"Lab_Inc_Dollar_000",	"EI_Males",	"EI_Females",	"EI",	"EI_Males_Dollar_000",	"EI_Females_Dollar_000",	"EI_Dollar_000",	"EI_Median_Males",	"EI_Median_Females",	"EI_Median",	"EI_Prov_Index_Males",	"EI_Prov_Index_Females",	"EI_Prov_Index",	"EI_Can_Index_Males",	"EI_Can_Index_Females",	"EI_Can_Index",	"Wages_Males",	"Wages_Females",	"Wages_Total",	"Wages_Males_Dollar_000",	"Wages_Females_Dollar_000",	"Wages_Total_Dollar_000",	"Self_Empl_Males",	"Self_Empl_Females",	"Self_Empl",	"Self_Empl_Males_Dollar_000",	"Self_Empl_Females_Dollar_000",	"Self_Empl_Dollar_000",	"Wages_Only_Males",	"Wages_Only_Females",	"Wages_Only_Total",	"Wages_Only_Males_Dollar_000",	"Wages_Only_Females_Dollar_000",	"Wages_Only_Total_Dollar_000",	"Self_Empl_Only_Males",	"Self_Empl_Only_Females",	"Self_Empl_Only",	"Self_Empl_Only_Males_Dollar_000",	"Self_Empl_Only_Females_Dollar_000",	"Self_Empl_Only_Dollar_000",	"Wages_Self_Emp_Males",	"Wages_Self_Emp_Females",	"Wages_Self_Emp_Total",	"Wages_Self_Emp_Males_Dollar_000",	"Wages_Self_Emp_Females_Dollar_000",	"Wages_Self_Emp_Total_Dollar_000",	"E_Ins_Males",	"E_Ins_Females",	"E_Ins",	"E_Ins_Males_Dollar_000",	"E_Ins_Females_Dollar_000",	"E_Ins_Dollar_000",	"E_Ins_EDR_Males",	"E_Ins_EDR_Females",	"E_Ins_EDR",	"E_Ins_Prov_Index_Males",	"E_Ins_Prov_Index_Females",	"E_Ins_Prov_Index",	"E_Ins_Can_Index_Males",	"E_Ins_Can_Index_Females",	"E_Ins_Can_Index")
dat1 <- na.omit(dat1)

#Extract a subset of the data in table 16

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

#write out table 16

write.table(df, file ="2015_Individuals_Table_10_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 17
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 17, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "M_15_19", 	"M_20_24",	"M_25_29",	"M_30_34", 	"M_35_39",	"M_40_44", 	"M_45_49", 	"M_50_54",	"M_55_59",	"M_60_64",	"M_65P",	"M_Total",	"F_15_19", 	"F_20_24",	"F_25_29",	"F_30_34", 	"F_35_39",	"F_40_44", 	"F_45_49", 	"F_50_54",	"F_55_59",	"F_60_64",	"F_65P",	"F_Total",	"All_15_19", 	"All_20_24",	"All_25_29",	"All_30_34", 	"All_35_39",	"All_40_44", 	"All_45_49", 	"All_50_54",	"All_55_59",	"All_60_64",	"All_65P",	"All_Total",	"M_Lab_Inc_15_19", 	"M_Lab_Inc_20_24",	"M_Lab_Inc_25_29",	"M_Lab_Inc_30_34", 	"M_Lab_Inc_35_39",	"M_Lab_Inc_40_44", 	"M_Lab_Inc_45_49", 	"M_Lab_Inc_50_54",	"M_Lab_Inc_55_59",	"M_Lab_Inc_60_64",	"M_Lab_Inc_65P",	"M_Lab_Inc_Total",	"F_Lab_Inc_15_19", 	"F_Lab_Inc_20_24",	"F_Lab_Inc_25_29",	"F_Lab_Inc_30_34", 	"F_Lab_Inc_35_39",	"F_Lab_Inc_40_44", 	"F_Lab_Inc_45_49", 	"F_Lab_Inc_50_54",	"F_Lab_Inc_55_59",	"F_Lab_Inc_60_64",	"F_Lab_Inc_65P",	"F_Lab_Inc_Total",	"All_Lab_Inc_15_19", 	"All_Lab_Inc_20_24",	"All_Lab_Inc_25_29",	"All_Lab_Inc_30_34", 	"All_Lab_Inc_35_39",	"All_Lab_Inc_40_44", 	"All_Lab_Inc_45_49", 	"All_Lab_Inc_50_54",	"All_Lab_Inc_55_59",	"All_Lab_Inc_60_64",	"All_Lab_Inc_65P",	"All_Lab_Inc_Total",	"M_Part_Rate_15_19", 	"M_Part_Rate_20_24",	"M_Part_Rate_25_29",	"M_Part_Rate_30_34", 	"M_Part_Rate_35_39",	"M_Part_Rate_40_44", 	"M_Part_Rate_45_49", 	"M_Part_Rate_50_54",	"M_Part_Rate_55_59",	"M_Part_Rate_60_64",	"M_Part_Rate_65P",	"M_Part_Rate_Total",	"F_Part_Rate_15_19", "F_Part_Rate_20_24",	"F_Part_Rate_25_29",	"F_Part_Rate_30_34", 	"F_Part_Rate_35_39",	"F_Part_Rate_40_44", 	"F_Part_Rate_45_49", 	"F_Part_Rate_50_54",	"F_Part_Rate_55_59",	"F_Part_Rate_60_64",	"F_Part_Rate_65P",	"F_Part_Rate_Total",	"All_Part_Rate_15_19", 	"All_Part_Rate_20_24",	"All_Part_Rate_25_29",	"All_Part_Rate_30_34", 	"All_Part_Rate_35_39",	"All_Part_Rate_40_44", 	"All_Part_Rate_45_49", 	"All_Part_Rate_50_54",	"All_Part_Rate_55_59",	"All_Part_Rate_60_64",	"All_Part_Rate_65P",	"All_Part_Rate_Total")
dat1 <- na.omit(dat1)


#Extract a subset of the data in table 17

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

#write out table 17

write.table(df, file ="2015_Individuals_Table_11_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
  #read file path for individual income table 18
  file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 18, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Inc_Lab_M_15_19", "Inc_Lab_M_20_24",	"Inc_Lab_M_25_29",	"Inc_Lab_M_30_34", 	"Inc_Lab_M_35_39",	"Inc_Lab_M_40_44", 	"Inc_Lab_M_45_49", "Inc_Lab_M_50_54",	"Inc_Lab_M_55_59",	"Inc_Lab_M_60_64",	"Inc_Lab_M_65P",	"Inc_Lab_M_Total",	"Inc_Lab_F_15_19", 	"Inc_Lab_F_20_24",	"Inc_Lab_F_25_29", "Inc_Lab_F_30_34", 	"Inc_Lab_F_35_39",	"Inc_Lab_F_40_44", 	"Inc_Lab_F_45_49", 	"Inc_Lab_F_50_54",	"Inc_Lab_F_55_59",	"Inc_Lab_F_60_64",	"Inc_Lab_F_65P",	"Inc_Lab_F_Total",	"Inc_Lab_All_15_19", 	"Inc_Lab_All_20_24",	"Inc_Lab_All_25_29",	"Inc_Lab_All_30_34",	"Inc_Lab_All_35_39",	"Inc_Lab_All_40_44", 	"Inc_Lab_All_45_49", 	"Inc_Lab_All_50_54",	"Inc_Lab_All_55_59",	"Inc_Lab_All_60_64",	"Inc_Lab_All_65P",	"Inc_Lab_All_Total",	"EI_M_5_19", 	"EI_M_20_24", "EI_M_25_29",	"EI_M_30_34", 	"EI_M_35_39",	"EI_M_40_44", 	"EI_M_45_49", 	"EI_M_50_54",	"EI_M_55_59",	"EI_M_60_64",	"EI_M_65P",	"EI_M_Total",	"EI_F_15_19", 	"EI_F_20_24",	"EI_F_25_29",	"EI_F_30_34", 	"EI_F_35_39",	"EI_F_40_44", 	"EI_F_45_49", 	"EI_F_50_54",	"EI_F_55_59",	"EI_F_60_64",	"EI_F_65P",	"EI_F_Total",	"All_EI_15_19", 	"All_EI_20_24",	"All_EI_25_29",	"All_EI_30_34", 	"All_EI_35_39",	"All_EI_40_44", 	"All_EI_45_49", 	"All_EI_50_54",	"All_EI_55_59",	"All_EI_60_64",	"All_EI_65P",	"All_EI_Total")
dat1 <- na.omit(dat1)


#Extract a subset of the data in table 18

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

#write out table 18

write.table(df, file ="2015_Individuals_Table_12_Canada.csv", sep = ",", row.names = FALSE)

---------------------------
  
#read file path for individual income table 19
file.dat <- file.path(dir.wrk, "2015_IND_Tables_1_to_13_Canada.xlsx")
dat1 <- read.xlsx(file.dat, sheet = 19, startRow = 4)
names(dat1) <- c("City_ID", "Postal_Area", "Geo_Level", "Place_Name","CoupleFamily_LowIncome_0_Child",
                 "CoupleFamily_LowIncome_1_Child","CoupleFamily_LowIncome_2_Child","CoupleFamily_LowIncome_3P_Child",
                 "CoupleFamily_LowIncome_Total","Percent_LowIncome_0_Child","Percent_LowIncome_1_Child","Percent_LowIncome_2_Child",
                 "Percent_LowIncome_3P_Child","Percent_LowIncome_Total","Avg_LowIncome_Ratio_0_Child","Avg_LowIncome_Ratio_1_Child",
                 "Avg_LowIncome_Ratio_2_Child","Avg_LowIncome_Ratio_3P_Child","Avg_LowIncome_Total","No_0_17_LowIncome_0_Child",
                 "No_0_17_LowIncome_1_Child","No_0_17_LowIncome_2_Child","No_0_17_LowIncome_3P_Child","No_0_17_LowIncome_Total",
                 "Percent_0_17_LowIncome_0_Child","Percent_0_17_LowIncome_1_Child","Percent_0_17_LowIncome_2_Child","Percent_0_17_LowIncome_3P_Child",
                 "Percent_0_17_LowIncome_Total","Avg_0_17_LowIncome_Ratio_0_Child","Avg_0_17_LowIncome_Ratio_1_Child","Avg_0_17_LowIncome_Ratio_2_Child",
                 "Avg_0_17_LowIncome_Ratio_3P_Child","Avg_0_17_LowIncome_Ratio_Total","Age_18_64_LowIncome_0_Child","Age_18_64_LowIncome_1_Child",
                 "Age_18_64_LowIncome_2_Child","Age_18_64_LowIncome_3P_Child","Age_18_64_LowIncome_Total","Percent_18_64_LowIncome_0_Child",
                 "Percent_18_64_LowIncome_1_Child","Percent_18_64_LowIncome_2_Child","Percent_18_64_LowIncome_3P_Child","Percent_18_64_LowIncome_Total",
                 "Avg_18_64_LowIncome_Ratio_0_Child","Avg_18_64_LowIncome_Ratio_1_Child","Avg_18_64_LowIncome_Ratio_2_Child","Avg_18_64_LowIncome_Ratio_3P_Child",
                 "Avg_18_64_LowIncome_Ratio_total","Age_65P_LowIncome_0_Child","Age_65P_LowIncome_1_Child","Age_65P_LowIncome_2_Child","Age_65P_LowIncome_3P_Child",
                 "Age_65P_LowIncome_Total","Percent_65P_LowIncome_0_Child","Percent_65P_LowIncome_1_Child","Percent_65P_LowIncome_2_Child","Percent_65P_LowIncome_3P_Child",
                 "Percent_65P_LowIncome_Total","Avg_65P_LowIncome_Ratio_0_Child","Avg_65P_LowIncome_Ratio_1_Child","Avg_65P_LowIncome_Ratio_2_Child",
                 "Avg_65P_LowIncome_Ratio_3P_Child","Avg_65P_LowIncome_Ratio_total","LoneParent_LowIncome_1_Child","LoneParent_LowIncome_2_Child","LoneParent_LowIncome_3P_Child",
                 "LoneParent_LowIncome_total","LoneParent_Percent_LowIncome_1_Child","LoneParent_Percent_LowIncome_2_Child","LoneParent_Percent_LowIncome_3P_Child","LoneParent_Percent_LowIncome_total",
                 "LoneParent_Avg_LowIncome_1_Child","LoneParent_Avg_LowIncome_Ratio_2_Child","LoneParent_Avg_LowIncome_Ratio_3P_Child","LoneParent_Avg_LowIncome_Ratio_total","LoneParent_Age_0_17_LowIncome_1_Child",
                 "LoneParent_Age_0_17_LowIncome_2_Child","LoneParent_Age_0_17_LowIncome_3P_Child","LoneParent_Age_0_17_LowIncome_total","Percent_LoneParent_Age_0_17_LowIncome_1_Child",
                 "Percent_LoneParent_Age_0_17_LowIncome_2_Child","Percent_LoneParent_Age_0_17_LowIncome_3P_Child","Percent_LoneParent_Age_0_17_LowIncome_total","Avg_LoneParent_Age_0_17_LowIncome_1_Child",
                 "Avg_LoneParent_Age_0_17_LowIncome_2_Child","Avg_LoneParent_Age_0_17_LowIncome_3P_Child","Avg_LoneParent_Age_0_17_LowIncome_total","Age_18_64_LowIncome_1_Child","Age_18_64_LowIncome_2_Child",
                 "Age_18_64_LowIncome_3P_Child","Age_18_64_LowIncome_total","Percent_18_64_LowIncome_1_Child","Percent_18_64_LowIncome_2_Child","Percent_18_64_LowIncome_3P_Child","Percent_18_64_LowIncome_total",
                 "Avg_18_64_LowIncome_1_Child","Avg_18_64_LowIncome_2_Child","Avg_18_64_LowIncome_3P_Child","Avg_18_64_LowIncome_total","Age_65P_LowIncome_1_Child","Age_65P_LowIncome_2_Child","Age_65P_LowIncome_3P_Child",
                 "Age_65P_LowIncome_total","Percent_65P_LowIncome_1_Child","Percent_65P_LowIncome_2_Child","Percent_65P_LowIncome_3P_Child","Percent_65P_LowIncome_total","Avg_65P_LowIncome_1_Child","Avg_65P_LowIncome_2_Child",
                 "Avg_65P_LowIncome_3P_Child","Avg_65P_LowIncome_total","Families_LowIncome_0_Child","Families_LowIncome_1_Child","Families_LowIncome_2_Child","Families_LowIncome_3P_Child","Families_LowIncome_total",
                 "Percent_Families_LowIncome_0_Child","Percent_Families_LowIncome_1_Child","Percent_Families_LowIncome_2_Child","Percent_Families_LowIncome_3P_Child","Percent_Families_LowIncome_total","Avg_Families_LowIncome_0_Child",
                 "Avg_Families_LowIncome_1_Child","Avg_Families_LowIncome_2_Child","Avg_Families_LowIncome_3P_Child","Avg_Families_LowIncome_total","Families_0_17_LowIncome_0_Child","Families_0_17_LowIncome_1_Child",
                 "Families_0_17_LowIncome_2_Child","Families_0_17_LowIncome_3P_Child","Families_0_17_LowIncome_total","Percent_Families_0_17_LowIncome_0_Child","Percent_Families_0_17_LowIncome_1_Child",
                 "Percent_Families_0_17_LowIncome_2_Child","Percent_Families_0_17_LowIncome_3P_Child","Percent_Families_0_17_LowIncome_total","Avg_Families_0_17_LowIncome_0_Child","Avg_Families_0_17_LowIncome_1_Child",
                 "Avg_Families_0_17_LowIncome_2_Child","Avg_Families_0_17_LowIncome_3P_Child","Avg_Families_0_17_LowIncome_total","Age_Families_18_64_LowIncome_0_Child","Age_Families_18_64_LowIncome_1_Child",
                 "Age_Families_18_64_LowIncome_2_Child","Avg_Families_18_64_LowIncome_3P_Child","Age_Families_18_64_LowIncome_total","Percent_Families_18_64_LowIncome_0_Child","Percent_Families_18_64_LowIncome_1_Child",
                 "Percent_Families_18_64_LowIncome_2_Child","Percent_Families_18_64_LowIncome_3P_Child","Percent_Families_18_64_LowIncome_total","Avg_Families_LowIncome_0_Child","Avg_Families_LowIncome_1_Child",
                 "Avg_Families_LowIncome_2_Child","Avg_Families_LowIncome_3P_Child","Avg_Families_LowIncome_total","Age_65P_Families_LowIncome_0_Child","Age_65P_Families_LowIncome_1_Child","Age_65P_Families_LowIncome_2_Child",
                 "Age_65P_Families_LowIncome_3P_Child","Age_65P_Families_LowIncome_total","Percent_Families_LowIncome_0_Child","Percent_Families_LowIncome_1_Child","Percent_Families_LowIncome_2_Child","Percent_Families_LowIncome_3P_Child",
                 "Percent_Families_LowIncome_total","Avg_Families_LowIncome_0_Child","Avg_Families_LowIncome_1_Child","Avg_Families_LowIncome_2_Child","Avg_Families_LowIncome_3P_Child","Avg_Families_LowIncome_total","NonFamily_LowIncome_0_Child",
                 "NonFamily_LowIncome_total","Percent_NonFamily_LowIncome_0_Child","Percent_NonFamily_LowIncome_0_Child_total","Avg_NonFamily_LowIncome_0_Child","Avg_NonFamily_0_ChildLowIncome","Non_Family_Age_0_17_LowIncome_0_Child",
                 "Non_Family_Age_0_17_0_child_LowIncome","Percent_Age_0_17_Non_Family_LowIncome_0_Child","Percent_Age_0_17_Non_Family_0_Child_LowIncome_total","Avg_Age_0_17_Non_Family_LowIncome_0_Child",
                 "Avg_Age_0_17_Non_Family_0_Child_LowIncome_total","Age_18_64_Non_Family_LowIncome_0_Child","Age_18_64_Non_Family_LowIncome_0_Child_total","Percent_18_64_Non_Family_LowIncome_0_Child",
                 "Percent_18_64_Non_Family_LowIncome_0_Child_total","Avg_18_64_Non_Family_LowIncome_0_Child","Avg_18_64_Non_Family_LowIncome_0_Child_total","Age_65P_Non_Family_LowIncome_0_Child",
                 "Age_65P_Non_Family_LowIncome_0_Child_total","Percent_65P_Non_Family_LowIncome_0_Child","Percent_65P_Non_Family_LowIncome_0_Child_total","Avg_65P_Non_Family_LowIncome_0_Child","Avg_65P_Non_Family_LowIncome_0_Child_total",
                 "AllFamilies_LowIncome_0_Child","AllFamilies_LowIncome_1_Child","AllFamilies_LowIncome_2_Child","AllFamilies_LowIncome_3P_Child","AllFamilies_LowIncome_total","Percent_AllFamilies_LowIncome_0_Child","Percent_AllFamilies_LowIncome_1_Child",
                 "Percent_AllFamilies_LowIncome_2_Child","Percent_AllFamilies_LowIncome_3P_Child","Percent_AllFamilies_LowIncome_total","Avg_AllFamilies_LowIncome_0_Child","Avg_AllFamilies_LowIncome_1_Child","Avg_AllFamilies_LowIncome_2_Child",
                 "Avg_AllFamilies_LowIncome_3P_Child","Avg_AllFamilies_LowIncome_total","AllFamilies_0_17_LowIncome_0_Child","AllFamilies_0_17_LowIncome_1_Child","AllFamilies_0_17_LowIncome_2_Child","AllFamilies_0_17_LowIncome_3P_Child",
                 "AllFamilies_0_17_LowIncome_total","Percent_AllFamilies_0_17_LowIncome_0_Child","Percent_AllFamilies_0_17_LowIncome_1_Child","Percent_AllFamilies_0_17_LowIncome_2_Child","Percent_AllFamilies_0_17_LowIncome_3P_Child",
                 "Percent_AllFamilies_0_17_LowIncome_total","Avg_AllFamilies_0_17_LowIncome_0_Child","Avg_AllFamilies_0_17_LowIncome_1_Child","Avg_AllFamilies_0_17_LowIncome_2_Child","Avg_AllFamilies_0_17_LowIncome_3P_Child",
                 "Avg_AllFamilies_0_17_LowIncome_total","Age_AllFamilies_18_64_LowIncome_0_Child","Age_AllFamilies_18_64_LowIncome_1_Child","Age_AllFamilies_18_64_LowIncome_2_Child","Avg_AllFamilies_18_64_LowIncome_3P_Child",
                 "Age_AllFamilies_18_64_LowIncome_total","Percent_AllFamilies_18_64_LowIncome_0_Child","Percent_AllFamilies_18_64_LowIncome_1_Child","Percent_AllFamilies_18_64_LowIncome_2_Child","Percent_AllFamilies_18_64_LowIncome_3P_Child",
                 "Percent_AllFamilies_18_64_LowIncome_total","Avg_AllFamilies_LowIncome_0_Child","Avg_AllFamilies_LowIncome_1_Child","Avg_AllFamilies_LowIncome_2_Child","Avg_AllFamilies_LowIncome_3P_Child","Avg_AllFamilies_LowIncome_total",
                 "Age_65P_AllFamilies_LowIncome_0_Child","Age_65P_AllFamilies_LowIncome_1_Child","Age_65P_AllFamilies_LowIncome_2_Child","Age_65P_AllFamilies_LowIncome_3P_Child","Age_65P_AllFamilies_LowIncome_total",
                 "Percent_AllFamilies_LowIncome_0_Child","Percent_Families_LowIncome_1_Child","Percent_AllFamilies_LowIncome_2_Child","Percent_AllFamilies_LowIncome_3P_Child","Percent_AllFamilies_LowIncome_total","Avg_AllFamilies_LowIncome_0_Child",
                 "Avg_AllFamilies_LowIncome_1_Child","Avg_AllFamilies_LowIncome_2_Child","Avg_AllFamilies_LowIncome_3P_Child","Avg_AllFamilies_LowIncome_total")
dat1 <- na.omit(dat1)


#Extract a subset of the data in table 19

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

#write out table 19

write.table(df, file ="2015_Individuals_Table_13_Canada.csv", sep = ",", row.names = FALSE)  
  
---------------------------
#combine/merge all subsheets into one table

  x <- c(1,2,'3A','3B', '3C')
for (val in x) {
  filename <- paste("cars",val,".csv", sep="")
  print(filename)
  dataframe_name <- paste("df",val,sep="")
  assign(dataframe_name, as.data.table(fread(filename)))
}
  
  
  
  
df1 <- read.table(file ="2015_Individuals_Table_1_Canada.csv", sep = ",")
df2 <- read.table(file ="2015_Individuals_Table_2_Canada.csv", sep = ",")
df3 <- read.table(file ="2015_Individuals_Table_3A_Canada.csv", sep = ",")
df4 <- read.table(file ="2015_Individuals_Table_3B_Canada.csv", sep = ",")
df5 <- read.table(file ="2015_Individuals_Table_3C_Canada.csv", sep = ",")
df6 <- read.table(file ="2015_Individuals_Table_4_Canada.csv", sep = ",")
df7 <- read.table(file ="2015_Individuals_Table_5A_Canada.csv", sep = ",")
df8 <- read.table(file ="2015_Individuals_Table_5B_Canada.csv", sep = ",")
df9 <- read.table(file ="2015_Individuals_Table_5C_Canada.csv", sep = ",")
df10 <- read.table(file ="2015_Individuals_Table_6_Canada.csv", sep = ",")
df11 <- read.table(file ="2015_Individuals_Table_7A_Canada.csv", sep = ",")
df12 <- read.table(file ="2015_Individuals_Table_7B_Canada.csv", sep = ",")
df13 <- read.table(file ="2015_Individuals_Table_7C_Canada.csv", sep = ",")
df14 <- read.table(file ="2015_Individuals_Table_8_Canada.csv", sep = ",")
df15 <- read.table(file ="2015_Individuals_Table_9_Canada.csv", sep = ",")
df16 <- read.table(file ="2015_Individuals_Table_10_Canada.csv", sep = ",")
df17 <- read.table(file ="2015_Individuals_Table_11_Canada.csv", sep = ",")
df18 <- read.table(file ="2015_Individuals_Table_12_Canada.csv", sep = ",")
df19 <- read.table(file ="2015_Individuals_Table_13_Canada.csv", sep = ",")


nrow(df1)
nrow(df2)
nrow(df3)
nrow(df4)
nrow(df5)
nrow(df6)
nrow(df7)
nrow(df8)
nrow(df9)
nrow(df10)
nrow(df11)
nrow(df12)
nrow(df13)
nrow(df14)
nrow(df15)
nrow(df16)
nrow(df17)
nrow(df18)
nrow(df19)


DFs <- data.frame(cbind(df1, df2[,6:ncol(df2)],df3[,6:ncol(df3)], df4[,6:ncol(df4)], df5[,6:ncol(df5)], df6[,6:ncol(df6)], df7[,6:ncol(df7)], df8[,6:ncol(df8)], df9[,6:ncol(df9)], df10[,6:ncol(df10)], df11[,6:ncol(df11)], df12[,6:ncol(df12)], df13[,6:ncol(df13)], df14[,6:ncol(df14)], df15[,6:ncol(df15)], df16[,6:ncol(df16)],  df17[,6:ncol(df17)],  df18[,6:ncol(df18)], df19[,5:ncol(df19)]), col.names = T)
DFs <- na.omit(DFs)

colnames(DFs) <- c(paste0("V", 1:ncol(DFs)))

write.table(DFs, file ="2015_Individuals_Canada.csv", sep = ",", row.names = FALSE, col.names = TRUE)









