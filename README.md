<a id="devex-badge" rel="Exploration" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="Being designed and built, but in the lab. May change, disappear, or be buggy." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/exploration.svg" title="Being designed and built, but in the lab. May change, disappear, or be buggy." /></a>[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# statscan-taxdata-tidying
 
A set of R scripts to load, clean, and merge anonymized annual Statistics Canada income tax data for British Columbia. 


## Structure

This repo contains the following contents:
- Documents in `/Documentation/` folder
- Data in `/Data/` folder and `/Data/IND` or `/Data/FAM` subfolders
- R scripts in `/R`folder
- Exercise folder in `/Scratch`

The scripts in this repository wrangle and tidy purchased anonymized annual Statistics Canada data similar to ['Tax filers and dependants with income by source of income' Table: 11-10-0007-01](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1110000701). The annual data are provided as sheets in .xls format under the [Statistics Canada Open Licence](https://www.statcan.gc.ca/eng/reference/licence), one .xls file for each year for anonymized individuals and anonymized families. Metadata provided by Statistics Canada is in `/Documentation` folder. 


## Usage

Untidy .xls files per year for anonymized individual and family income tax data must be placed in the `/Data/` folder either as `/Data/IND` or `/Data/FAM` sub-folders to house the individual or family files respectively.

The .xls files were converted to .xlsx and their empty spaces in the names were removed for more convenient data wrangling. This can also be done with readxl and tidyxl package in RStudio.

Tidied .csv equivalent files are written to a `/Tmp` folder. The `/R` folder contains all the R scripts used to read xlsx, clean, merge, and output the merged csv files.



## Scratch folder 

There are six scripts located in the `/Scratch` folder that are not required for the analysis, and are written after the R scripts were generated and before functions were discovered. The aim is to generate a reproducible workflow for file load, clean, merge, and output in one go.  

- 01_load.R # only an example to load files for one year and the sample column names 
- 02_clean.R # how to extract BC geographies 
- 03_merge.R # merging all sub-sheets into one 
- 04_output.R # write out the merged csv's
- 05_encrypt.R # how to encrypt files for security (was not used, also note warning and latest version when using)
- 06_scratch.R # functions to use for efficiency (i.e. use to load, clean, merge, and output in one go)


## Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/StatCan_IncomeTax_Tidying/issues/).

## How to Contribute

If you would like to contribute, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### License

```
Copyright 2019 Province of British Columbia

Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
```

This repository is maintained by [Integrated Data Division (OCIO)](https://github.com/orgs/bcgov/teams/idd).

---
*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.* 
