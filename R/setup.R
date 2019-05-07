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

## Install Packages/dependencies

library("plyr")
library("janitor")
library("tibble")
library("stringr")
library("tidyr")
library("here")
library("readr")
library("purrr")
library("readxl")
library("dplyr")


#-------------------------------------------------------------------------------

## Make new directories if they do not exist

if (!exists(here("data-raw"))) dir.create(here("data-raw"), showWarnings = FALSE)
if (!exists(here("data-raw/fam"))) dir.create(here("data-raw/fam"), showWarnings = FALSE)
if (!exists(here("data-raw/ind"))) dir.create(here("data-raw/ind"), showWarnings = FALSE)
if (!exists(here("data-raw/ind13"))) dir.create(here("data-raw/ind13"), showWarnings = FALSE)
if (!exists(here("data-tidy"))) dir.create(here("data-tidy"), showWarnings = FALSE)
if (!exists(here("data-tidy/fam"))) dir.create(here("data-tidy/fam"), showWarnings = FALSE)
if (!exists(here("data-tidy/ind"))) dir.create(here("data-tidy/ind"), showWarnings = FALSE)
if (!exists(here("data-tidy/ind13"))) dir.create(here("data-tidy/ind13"), showWarnings = FALSE)
if (!exists(here("data-output"))) dir.create(here("data-output"), showWarnings = FALSE)


#-------------------------------------------------------------------------------

## Object to source setup script

.setup_sourced <- TRUE



