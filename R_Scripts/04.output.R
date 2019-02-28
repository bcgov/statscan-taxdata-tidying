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


# once all annual csv's are generated, merge them all together into one final csv 
# this merge is to meet Popdata BC's standards for data import to Secure Research Environment (SRE) machines

# load package dependencies
library(dplyr)
library(plyr)


# load data files, skip first line, and add tax year  (for family files)

df1 <- read.table(file ="2016_Family_Table.csv", sep = ",", skip = 1)
df1 <- mutate(df1, taxyear = "2016")

df2 <- read.table(file ="2015_Family_Table.csv", sep = ",", skip = 1)
df2 <- mutate(df2, taxyear = "2015")

df3 <- read.table(file ="2014_Family_Table.csv", sep = ",", skip = 1)
df3 <- mutate(df3, taxyear = "2014")

df4 <- read.table(file ="2013_Family_Table.csv", sep = ",", skip = 1)
df4 <- mutate(df4, taxyear = "2013")

df5 <- read.table(file ="2012_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df5 <- mutate(df5, taxyear = "2012")

df6 <- read.table(file ="2012_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df6 <- mutate(df6, taxyear = "2012")

df7 <- read.table(file ="2011_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df7 <- mutate(df7, taxyear = "2011")

df8 <- read.table(file ="2011_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df8 <- mutate(df8, taxyear = "2011")

df9 <- read.table(file ="2010_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df9 <- mutate(df9, taxyear = "2010")

df10 <- read.table(file ="2010_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df10 <- mutate(df10, taxyear = "2010")

df11 <- read.table(file ="2009_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df11 <- mutate(df11, taxyear = "2009")

df12 <- read.table(file ="2009_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df12 <- mutate(df12, taxyear = "2009")

df13 <- read.table(file ="2008_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df13 <- mutate(df13, taxyear = "2008")

df14 <- read.table(file ="2008_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df14 <- mutate(df14, taxyear = "2008")

df15 <- read.table(file ="2007_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df15 <- mutate(df15, taxyear = "2007")

df16 <- read.table(file ="2007_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df16 <- mutate(df16, taxyear = "2007")

df17 <- read.table(file ="2006_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df17 <- mutate(df17, taxyear = "2006")

df18 <- read.table(file ="2006_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df18 <- mutate(df18, taxyear = "2006")

df19 <- read.table(file ="2005_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df19 <- mutate(df19, taxyear = "2005")

df20 <- read.table(file ="2005_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df20 <- mutate(df20, taxyear = "2005")

df21 <- read.table(file ="2004_Family_Table_19_New_LIM.csv", sep = ",", skip = 1)
df21 <- mutate(df21, taxyear = "2004")

df22 <- read.table(file ="2004_Family_Table_20_New_LIM.csv", sep = ",", skip = 1)
df22 <- mutate(df22, taxyear = "2004")

# Bind all tables into one final csv and write out the table
# put data.frames into list (dfs named df1, df2, df3, etc)
mydflist <- mget(ls(pattern="df\\d+"))

# get all variable names
allNms <- unique(unlist(lapply(mydflist, names)))

# put em all together
Final_DF <- do.call(rbind,
                    lapply(mydflist,
                           function(x) data.frame(c(x, sapply(setdiff(allNms, names(x)),
                                                              function(y) NA)))))

# prepare the table for popdata standards (i.e. replace hyphens with pipes)

colnames(Final_DF) <- gsub("_", "|", colnames(Final_DF)) # this is to meet Popdata BC's requirements


# write out the data frame
write.table(Final_DF, file ="Taxdata_2004_2016_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#-------------------------------------------------------------------------------------------------

# load data files, skip first line, and add tax year (for individual files)

df1 <- read.table(file ="2015_Individuals_BC.csv", sep = ",", skip = 1)
df1 <- mutate(df1, taxyear = "2015")

df2 <- read.table(file ="2014_Individuals_BC.csv", sep = ",", skip = 1)
df2 <- mutate(df2, taxyear = "2014")

df3 <- read.table(file ="2013_Individuals_BC.csv", sep = ",", skip = 1)
df3 <- mutate(df3, taxyear = "2013")

df4 <- read.table(file ="2012_Individuals_BC.csv", sep = ",", skip = 1)
df4 <- mutate(df4, taxyear = "2012")

df5 <- read.table(file ="2011_Individuals_BC.csv", sep = ",", skip = 1)
df5 <- mutate(df5, taxyear = "2011")

df6 <- read.table(file ="2010_Individuals_BC.csv", sep = ",", skip = 1)
df6 <- mutate(df6, taxyear = "2010")

df7 <- read.table(file ="2009_Individuals_BC.csv", sep = ",", skip = 1)
df7 <- mutate(df7, taxyear = "2009")

df8 <- read.table(file ="2008_Individuals_BC.csv", sep = ",", skip = 1)
df8 <- mutate(df8, taxyear = "2008")

df9 <- read.table(file ="2007_Individuals_BC.csv", sep = ",", skip = 1)
df9 <- mutate(df9, taxyear = "2007")

df10 <- read.table(file ="2006_Individuals_BC.csv", sep = ",", skip = 1)
df10 <- mutate(df10, taxyear = "2006")

df11 <- read.table(file ="2005_Individuals_BC.csv", sep = ",", skip = 1)
df11 <- mutate(df11, taxyear = "2005")

df12 <- read.table(file ="2004_Individuals_BC.csv", sep = ",", skip = 1)
df12 <- mutate(df12, taxyear = "2004")

df13 <- read.table(file ="2003_Individuals_BC.csv", sep = ",", skip = 1)
df13 <- mutate(df13, taxyear = "2003")

df14 <- read.table(file ="2002_Individuals_BC.csv", sep = ",", skip = 1)
df14 <- mutate(df14, taxyear = "2002")

df15 <- read.table(file ="2001_Individuals_BC.csv", sep = ",", skip = 1)
df15 <- mutate(df15, taxyear = "2001")

df16 <- read.table(file ="2000_Individuals_BC.csv", sep = ",", skip = 1)
df16 <- mutate(df16, taxyear = "2000")

# Bind all tables into one final csv and write out the table
# put data.frames into list (dfs named df1, df2, df3, etc)
mydflist <- mget(ls(pattern="df\\d+"))

# get all variable names
allNms <- unique(unlist(lapply(mydflist, names)))

# put em all together
Final_DF <- do.call(rbind,
                    lapply(mydflist,
                           function(x) data.frame(c(x, sapply(setdiff(allNms, names(x)),
                                                              function(y) NA)))))

# prepare the table for popdata standards (i.e. replace hyphens with pipes)
colnames(Final_DF) <- gsub("_", "|", colnames(Final_DF)) # this is to meet Popdata BC's requirements

# write out the data frame
write.table(Final_DF, file ="Taxdata_2000_2015_Individuals.csv", sep = ",", row.names = FALSE, col.names = TRUE)

