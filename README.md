[![img](https://img.shields.io/badge/Lifecycle-Retired-d45500)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# statscan-taxdata-tidying
 
A set of R scripts to read, tidy, merge & write aggregated annual Statistics Canada income tax data for British Columbia. 

The scripts in this repository tidy aggregated annual Statistics Canada data similar to ['Tax filers and dependants with income by source of income' Table: 11-10-0007-01](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1110000701). The aggregated annual data are provided as sheets in .xls format under the [Statistics Canada Open Licence](https://www.statcan.gc.ca/eng/reference/licence), one .xls file per year for aggregated individual tables and aggregated family tables. The Technical Reference Guide for the Annual Income Estimates for Census Families, Individuals and Seniors is available on the Statistics Canada website:
[T1 Family File, Final Estimates, 2016](
https://www150.statcan.gc.ca/n1/pub/72-212-x/72-212-x2018001-eng.htm).


## Usage

#### Raw Data

The source .xls files per year (or per table in the case of Individual Table 13) must be manually placed in the appropriate subfolders: `/data-raw/fam`, `/data-raw/ind`, and `/data-raw/ind13`. Table 13 is being handled individually to accomodate a diversity of data structures. 

#### Code

There are three core scripts, one for each table type (Individuals, Families and Individual Table 13):

- `fam-clean.R`
- `ind-clean.R`
- `ind-clean-13.R`

The `run-all.R` script should be `source`ed to run the scripts all at once. The `setup.R` and `functions.R` scripts in the `/R` folder are sourced programatically.

All packages used in the analysis can be installed from CRAN using `install.packages()`.  

#### Tidy Data Outputs

Tidied .CSV equivalent files for each Table&mdash;individuals and families&mdash;are written to the `/data-output` folder.  

#### Testing

The `test` scripts in the `/test` subfolder can be used to test the integrity of the data after tidying. These scripts contain code that compares the tidied outputs for individuals and families with the raw data, ensuring data cleanup does not the change original files.  

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

This repository is maintained by [Data Science Partnerships Team (OCIO) ](https://github.com/orgs/bcgov/teams/dsp).

---
*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.* 
