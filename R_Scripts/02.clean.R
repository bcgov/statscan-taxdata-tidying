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

# Since the data is at federal Canada level, we need to extract BC Geographies out
# extract the BC geographical concepts in data tables

dat1.new <- subset(dat1[dat1$Geo_Level == "11" | dat1$Geo_Level == "12",])
dat2.new <- subset(dat1[dat1$Place_Name == "ABBOTSFORD - MISSION" | dat1$Place_Name == "CHILLIWACK" | dat1$Place_Name == "KAMLOOPS" | dat1$Place_Name == "KELOWNA" | dat1$Place_Name == "PRINCE GEORGE" | dat1$Place_Name == "VANCOUVER" | dat1$Place_Name == "VICTORIA" | dat1$Place_Name ==  "VANCOUVER ISLAND AND COAST" | dat1$Place_Name =="VANCOUVER CENTRE" | dat1$Place_Name == "VANCOUVER EAST" | dat1$Place_Name == "VANCOUVER GRANVILLE" | dat1$Place_Name == "VANCOUVER KINGSWAY" | dat1$Place_Name ==  "VANCOUVER QUADRA" | dat1$Place_Name == "VANCOUVER SOUTH", ])
dat3.new <-subset(dat1, grepl("^V", Postal_Area))
dat4.new <-subset(dat1, grepl("^9", Postal_Area))

df <- rbind(dat1.new, dat2.new, dat3.new, dat4.new)


# Output the sub-sheets generated into a .csv format file 
write.table(df, file ="2015_Individuals_Table_1_BC.csv", sep = ",", row.names = FALSE)
