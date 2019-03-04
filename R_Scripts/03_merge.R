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

# # load package dependencies
# library(here)
# 
# # chose the file location
# here("file path to data folder")

# input all sub-tables in a year and check their structure before merging them
# this code is an example for individual csv's

df1 <- read.table(file ="2015_Individuals_Table_1_BC.csv", sep = ",")
df2 <- read.table(file ="2015_Individuals_Table_2_BC.csv", sep = ",")
df3 <- read.table(file ="2015_Individuals_Table_3A_BC.csv", sep = ",")
df4 <- read.table(file ="2015_Individuals_Table_3B_BC.csv", sep = ",")
df5 <- read.table(file ="2015_Individuals_Table_3C_BC.csv", sep = ",")
df6 <- read.table(file ="2015_Individuals_Table_4_BC.csv", sep = ",")
df7 <- read.table(file ="2015_Individuals_Table_5A_BC.csv", sep = ",")
df8 <- read.table(file ="2015_Individuals_Table_5B_BC.csv", sep = ",")
df9 <- read.table(file ="2015_Individuals_Table_5C_BC.csv", sep = ",")
df10 <- read.table(file ="2015_Individuals_Table_6_BC.csv", sep = ",")
df11 <- read.table(file ="2015_Individuals_Table_7A_BC.csv", sep = ",")
df12 <- read.table(file ="2015_Individuals_Table_7B_BC.csv", sep = ",")
df13 <- read.table(file ="2015_Individuals_Table_7C_BC.csv", sep = ",")
df14 <- read.table(file ="2015_Individuals_Table_8_BC.csv", sep = ",")
df15 <- read.table(file ="2015_Individuals_Table_9_BC.csv", sep = ",")
df16 <- read.table(file ="2015_Individuals_Table_10_BC.csv", sep = ",")
df17 <- read.table(file ="2015_Individuals_Table_11_BC.csv", sep = ",")
df18 <- read.table(file ="2015_Individuals_Table_12_BC.csv", sep = ",")
df19 <- read.table(file ="2015_Individuals_Table_13_BC.csv", sep = ",")

# check the number of rows to see if they are all the same length before merging
nrow(df1) # check the number of rows for all dfs


# merge all csv sub-sheets into one large .csv file

DFs <- data.frame(cbind(df1, df2[,6:ncol(df2)],df3[,6:ncol(df3)], df4[,6:ncol(df4)], 
                        df5[,6:ncol(df5)], df6[,6:ncol(df6)], df7[,6:ncol(df7)], df8[,6:ncol(df8)], 
                        df9[,6:ncol(df9)], df10[,6:ncol(df10)], df11[,6:ncol(df11)], df12[,6:ncol(df12)], 
                        df13[,6:ncol(df13)], df14[,6:ncol(df14)], df15[,6:ncol(df15)], df16[,6:ncol(df16)],  
                        df17[,6:ncol(df17)],  df18[,6:ncol(df18), df18[,6:ncol(df18)])), col.names = T)
DFs <- na.omit(DFs)
View(DFs)

# Output all generated merged csv's into one csv per year
write.table(DFs, file ="2015_Individuals_BC.csv", sep = ",", row.names = FALSE, col.names = TRUE)


#-------------------------------------------------------------------------------------------------

# input all sub-tables in a year and check their structure before merging them
# this code is an example for families csv's

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
df18 <-  read.table(file ="2015_Family_Table_14A_Canada.csv", sep = ",")
df19 <-  read.table(file ="2015_Family_Table_14B_Canada.csv", sep = ",")
df20 <-  read.table(file ="2015_Family_Table_14C_Canada.csv", sep = ",")
df21 <-  read.table(file ="2015_Family_Table_15_Canada.csv", sep = ",")
df22 <-  read.table(file ="2015_Family_Table_17_Canada.csv", sep = ",")
df23 <-  read.table(file ="2015_Family_Table_18_Canada.csv", sep = ",")
df24 <- read.table(file ="2015_Family_Table_19_New_LIM.csv", sep = ",")
df25 <- read.table(file ="2015_Family_Table_20_New_LIM.csv", sep = ",")


DFs <- data.frame(cbind(df1, df2[,6:ncol(df2)], df3[,6:ncol(df3)], df4[,6:ncol(df4)], df5[,6:ncol(df5)], df6[,6:ncol(df6)], df7[,6:ncol(df7)], df8[,6:ncol(df8)], df9[,6:ncol(df9)], df10[,6:ncol(df10)], df11[,6:ncol(df11)], df12[,6:ncol(df12)], 
                        df13[,6:ncol(df13)], df14[,6:ncol(df14)], df15[,6:ncol(df15)], df18[,6:ncol(df18)], df19[,6:ncol(df19)], df20[,6:ncol(df20)], df21[,6:ncol(df21)], df22[,6:ncol(df22)], df23[,6:ncol(df23)]), col.names = T)

View(DFs)

write.table(DFs, file ="2015_Family_BC.csv", sep = ",", row.names = FALSE, col.names = TRUE)

