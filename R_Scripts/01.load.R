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

# set and locate the working directory in which the data files are stored
setwd(".") #"." is the file path to the data folder containing xlsx
getwd()
dir.wrk <- "."
dir.wrk <- getwd()

# load library dependencies
library(data.table)
library(openxlsx)
library(dplyr)
library(stringr)


# load tax data from individuals or families xlsx tables into R
file.dat <- file.path(dir.wrk, "2015_Individuals_Canada.xlsx") #this is just an example file name
dat1 <- read.xlsx(file.dat, sheet = 1, startRow = 3) # note: the first 2 rows have many empty cells and field names are specific in each sheet
names(dat1) <- c("City_ID", "Postal_Area", "Postal_Walk", "Geo_Level", "Place_Name", "Census_Fam_0_Child",	"Census_Fam_1_Child",	"Census_Fam_2_Child",	"Census_Fam_3_Child",	"Census_Fam_Total",	"Census_Fam_Persons_0_Child",	"Census_Fam_Persons_1_Child",	"Census_Fam_Persons_2_Child",	"Census_Fam_Persons_3_Child",	"Census_Fam_Persons_Total",	"Census_Fam_0_17_Persons_0_Child",	"Census_Fam_0_17_Persons_1_Child",	"Census_Fam_0_17_Persons_2_Child",	"Census_Fam_0_17_Persons_3_Child",	"Census_Fam_0_17_Persons_Total",	"Census_Fam_18_64_Persons_0_Child",	"Census_Fam_18_64_Persons_1_Child", "Census_Fam_18_64_Persons_2_Child",	"Census_Fam_18_64_Persons_3_Child",	"Census_Fam_18_64_Persons_Total",	"Census_Fam_65P_Persons_0_Child",	"Census_Fam_65P_Persons_1_Child",	"Census_Fam_65P_Persons_2_Child",	"Census_Fam_65P_Persons_3_Child",	"Census_Fam_65P_Persons_Total",	"Couple_Fam_0_Child",	"Couple_Fam_1_Child",	"Couple_Fam_2_Child",	"Couple_Fam_3_Child",	"Couple_Fam_Total",	"Couple_Fam_Persons_0_Child",	"Couple_Fam_Persons_1_Child",	"Couple_Fam_Persons_2_Child",	"Couple_Fam_Persons_3_Child",	"Couple_Fam_Persons_Total",	"Couple_Fam_0_17_Persons_0_Child",	"Couple_Fam_0_17_Persons_1_Child",	"Couple_Fam_0_17_Persons_2_Child",	"Couple_Fam_0_17_Persons_3_Child",	"Couple_Fam_0_17_Persons_Total",	"Couple_Fam_18_64_Persons_0_Child",	"Couple_Fam_18_64_Persons_1_Child",	"Couple_Fam_18_64_Persons_2_Child",	"Couple_Fam_18_64_Persons_3_Child",	"Couple_Fam_18_64_Persons_Total",	"Couple_Fam_65P_Persons_0_Child",	"Couple_Fam_65P_Persons_1_Child",	"Couple_Fam_65P_Persons_2_Child",	"Couple_Fam_65P_Persons_3_Child",	"Couple_Fam_65P_Persons_Total",	"LoneParent_Fam_1_Child",	"LoneParent_Fam_2_Child",	"LoneParent_Fam_3_Child", "LoneParent_Fam_Total",	"LoneParent_Fam_Persons_1_Child", "LoneParent_Fam_Persons_2_Child",	"LoneParent_Fam_Persons_3_Child",	"LoneParent_Fam_Persons_Total",	"LoneParent_Fam_Persons_0_17_1_Child",	"LoneParent_Fam_Persons_0_17_2_Child",	"LoneParent_Fam_Persons_0_17_3_Child",	"LoneParent_Fam_Persons_0_17_Total",	"LoneParent_Fam_Persons_18_64_1_Child",	"LoneParent_Fam_Persons_18_64_2_Child",	"LoneParent_Fam_Persons_18_64_3_Child",	"LoneParent_Fam_Persons_18_64_Total",	"LoneParent_Fam_Persons_65P_1_Child",	"LoneParent_Fam_Persons_65P_2_Child",	"LoneParent_Fam_Persons_65P_3_Child",	"LoneParent_Fam_Persons_65P_Total",	"Non_Fam_0_Child",	"Non_Fam_Total", "Non_Fam_Persons_0_Child",	"Non_Fam_Persons_Total",	"Non_Fam_Persons_0_17_0_Child",	"Non_Fam_Persons_0_17_Total",	"Non_Fam_Persons_18_64_0_Child",	"Non_Fam_Persons_18_64_Total",	"Non_Fam_Persons_65P_0_Child",	"Non_Fam_Persons_65P_Total",	"AllFam_0_Child",	"AllFam_1_Child",	"AllFam_2_Child",	"AllFam_3_Child", "AllFam_Total",	"AllFam_Persons_0_Child",	"AllFam_Persons_1_Child",	"AllFam_Persons_2_Child",	"AllFam_Persons_3_Child", 	"AllFam_Persons_Total",	"AllFam_0_17_Persons_0_Child",	"AllFam_0_17_Persons_1_Child",	"AllFam_0_17_Persons_2_Child",	"AllFam_0_17_Persons_3_Child",	"AllFam_0_17_Persons_Total",	"AllFam_18_64_Persons_0_Child",	"AllFam_18_64_Persons_1_Child",	"AllFam_18_64_Persons_2_Child",	"AllFam_18_64_Persons_3_Child",	"AllFam_18_64_Persons_Total",	"AllFam_65P_Persons_0_Child",	"AllFam_65P_Persons_1_Child",	"AllFam_65P_Persons_2_Child",	"AllFam_65P_Persons_3_Child",	"AllFam_65P_Persons_Total")
dat1 <- na.omit(dat1)
