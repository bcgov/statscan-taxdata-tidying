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

# load folder and files
setwd("~/Desktop/StatCan_IncomeTax_Tidying/Family tables 2013 to 2015")
getwd()
dir.wrk <- "~/Desktop/StatCan_IncomeTax_Tidying/Family tables 2013 to 2015"
dir.wrk <- getwd()

# load package dependencies
library(dplyr)
library(plyr)

#------------------------------------------

# load data files, skip first line, and add tax year 

df1 <- read.table(file ="2016_Family_Table.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df1 <- mutate(df1, TAXYEAR = "2016")
df1 <- na.omit(df1)

# add prefix column numbers so we can search through duplicate names
list1 <- colnames(df1)
set_prefix <- paste0("V", 1:ncol(df1), sep = "")
colnames(df1) <- paste0(set_prefix, "_", list1) 

# popdata requirement to convert hyphens to pipes
colnames(df1) <- gsub("_", "|", colnames(df1))

# write out the table 

write.table(df1, file ="Taxdata_2016_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)


#------------------------------------------

df2 <- read.table(file ="2015_Family_Table.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df2 <- mutate(df2, TAXYEAR = "2015")

# add prefix column numbers so we can search through duplicate names
list2 <- colnames(df2)
set_prefix <- paste0("V", 1:ncol(df2), sep = "")
colnames(df2) <- paste0(set_prefix, "_", list2) 

# popdata requirement to convert hyphens to pipes
colnames(df2) <- gsub("_", "|", colnames(df2))

# write out the table 

write.table(df2, file ="Taxdata_2015_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------
df3 <- read.table(file ="2014_Family_Table.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df3 <- mutate(df3, TAXYEAR = "2014")

# add prefix column numbers so we can search through duplicate names
list3 <- colnames(df3)
set_prefix <- paste0("V", 1:ncol(df3), sep = "")
colnames(df3) <- paste0(set_prefix, "_", list3) 

# popdata requirement to convert hyphens to pipes
colnames(df3) <- gsub("_", "|", colnames(df3))

# write out the table 

write.table(df3, file ="Taxdata_2014_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------
df4 <- read.table(file ="2013_Family_Table.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df4 <- mutate(df4, TAXYEAR = "2013")

# add prefix column numbers so we can search through duplicate names
list4 <- colnames(df4)
set_prefix <- paste0("V", 1:ncol(df4), sep = "")
colnames(df4) <- paste0(set_prefix, "_", list4) 

# popdata requirement to convert hyphens to pipes
colnames(df4) <- gsub("_", "|", colnames(df4))

# write out the table 

write.table(df4, file ="Taxdata_2013_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df5 <- read.table(file ="2012_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df5 <- mutate(df5, TAXYEAR = "2012")

# add prefix column numbers so we can search through duplicate names
list5 <- colnames(df5)
set_prefix <- paste0("V", 1:ncol(df5), sep = "")
colnames(df5) <- paste0(set_prefix, "_", list5) 

# popdata requirement to convert hyphens to pipes
colnames(df5) <- gsub("_", "|", colnames(df5))

# write out the table 

write.table(df5, file ="Taxdata_2012_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df6 <- read.table(file ="2011_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df6 <- mutate(df6, TAXYEAR = "2011")

# add prefix column numbers so we can search through duplicate names
list6 <- colnames(df6)
set_prefix <- paste0("V", 1:ncol(df6), sep = "")
colnames(df6) <- paste0(set_prefix, "_", list6) 

# popdata requirement to convert hyphens to pipes
colnames(df6) <- gsub("_", "|", colnames(df6))

# write out the table 

write.table(df6, file ="Taxdata_2011_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df7 <- read.table(file ="2010_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df7 <- mutate(df7, TAXYEAR = "2010")

# add prefix column numbers so we can search through duplicate names
list7 <- colnames(df7)
set_prefix <- paste0("V", 1:ncol(df7), sep = "")
colnames(df7) <- paste0(set_prefix, "_", list7) 

# popdata requirement to convert hyphens to pipes
colnames(df7) <- gsub("_", "|", colnames(df7))

# write out the table 

write.table(df7, file ="Taxdata_2010_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df8 <- read.table(file ="2009_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df8 <- mutate(df8, TAXYEAR = "2009")

# add prefix column numbers so we can search through duplicate names
list8 <- colnames(df8)
set_prefix <- paste0("V", 1:ncol(df8), sep = "")
colnames(df8) <- paste0(set_prefix, "_", list8) 

# popdata requirement to convert hyphens to pipes
colnames(df8) <- gsub("_", "|", colnames(df8))

# write out the table 

write.table(df8, file ="Taxdata_2009_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df9 <- read.table(file ="2008_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df9 <- mutate(df9, TAXYEAR = "2008")

# add prefix column numbers so we can search through duplicate names
list9 <- colnames(df9)
set_prefix <- paste0("V", 1:ncol(df9), sep = "")
colnames(df9) <- paste0(set_prefix, "_", list9) 

# popdata requirement to convert hyphens to pipes
colnames(df9) <- gsub("_", "|", colnames(df9))

# write out the table 

write.table(df9, file ="Taxdata_2008_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df10 <- read.table(file ="2007_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df10 <- mutate(df10, TAXYEAR = "2007")

# add prefix column numbers so we can search through duplicate names
list10 <- colnames(df10)
set_prefix <- paste0("V", 1:ncol(df10), sep = "")
colnames(df10) <- paste0(set_prefix, "_", list10) 

# popdata requirement to convert hyphens to pipes
colnames(df10) <- gsub("_", "|", colnames(df10))

# write out the table 

write.table(df10, file ="Taxdata_2007_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df11 <- read.table(file ="2006_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df11 <- mutate(df11, TAXYEAR = "2006")

# add prefix column numbers so we can search through duplicate names
list11 <- colnames(df11)
set_prefix <- paste0("V", 1:ncol(df11), sep = "")
colnames(df11) <- paste0(set_prefix, "_", list11) 

# popdata requirement to convert hyphens to pipes
colnames(df11) <- gsub("_", "|", colnames(df11))

# write out the table 

write.table(df11, file ="Taxdata_2006_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df12 <- read.table(file ="2005_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df12 <- mutate(df12, TAXYEAR = "2005")

# add prefix column numbers so we can search through duplicate names
list12 <- colnames(df12)
set_prefix <- paste0("V", 1:ncol(df12), sep = "")
colnames(df12) <- paste0(set_prefix, "_", list12) 

# popdata requirement to convert hyphens to pipes
colnames(df12) <- gsub("_", "|", colnames(df12))

# write out the table 

write.table(df12, file ="Taxdata_2005_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------

df13 <- read.table(file ="2004_Family_Table_19_20_LIM.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",", skip = 1)
df13 <- mutate(df13, TAXYEAR = "2004")

# add prefix column numbers so we can search through duplicate names
list13 <- colnames(df13)
set_prefix <- paste0("V", 1:ncol(df13), sep = "")
colnames(df13) <- paste0(set_prefix, "_", list13) 

# popdata requirement to convert hyphens to pipes
colnames(df13) <- gsub("_", "|", colnames(df13))

# write out the table 

write.table(df13, file ="Taxdata_2004_Families.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#------------------------------------------


## Did not use this option because the tables aren't all the same length 
# Bind all tables into one final csv and write out the table
# put data.frames into list (dfs named df1, df2, df3, etc)
#mydflist <- mget(ls(pattern="df\\d+"))

# get all variable names
#allNms <- unique(unlist(lapply(mydflist, names)))

# put em all together
# Final_DF <- do.call(rbind,
#  lapply(mydflist,
#        function(x) data.frame(c(x, sapply(setdiff(allNms, names(x)),
#                                          function(y) NA)))))

# prepare the table for popdata standards (i.e. replace hyphens with pipes)

#colnames(Final_DF) <- gsub("_", "|", colnames(Final_DF))





























