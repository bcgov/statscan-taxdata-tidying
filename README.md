

<a id="devex-badge" rel="Exploration" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="Being designed and built, but in the lab. May change, disappear, or be buggy." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/exploration.svg" title="Being designed and built, but in the lab. May change, disappear, or be buggy." /></a>[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# statscan-taxdata-tidying
 
A set of R scripts to load, clean, and merge annual Statistics Canada income tax data files for British Columbia. These codes wrangle a purchased export of Statistics Canada data on this [page](https://www.canada.ca/en/revenue-agency/programs/about-canada-revenue-agency-cra/income-statistics-gst-hst-statistics/t1-final-statistics/final-statistics-2017-edition-2015-tax-year.html)


## structure


This REPO is for tidying annual income tax data released to BC Stats by Statistics Canada. The original data comes in xlsx sheets (CD-ROM to BC Stats). Contents include: one xlsx file for each year for individuals and families.

The Data folder will contain one untidy xlsx and one cleaned csv file per year for individual income tax data and families once the scripts are successfully run (files are not released in this REPO). 


The R_Scripts folder contains the R-codes used to read, clean, merge, and wrangle the data into csv. 
The codes help remove the empty cells in all sheets,extract the BC geographies, and merge all sheets into one csv.


The metadata provided by Statistics Canada is in Documentation folder. 

## usage

There are four scripts that are required for the analysis (housed in R_Scripts folder), they need to be run in order:

- 01_load.R
- 02_clean.R
- 03_merge.R
- 04_encrypt.R


### example

This is a basic example which shows you how to solve a common problem:

```{r example}
coming...
```

## project status

This project is set up to share code, get feedback, and to be used again for future data that get purchased by BC Stats.

## getting help or reporting an issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/StatCan_IncomeTax_Tidying/issues/).

## how to contribute

If you would like to contribute, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### license

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

---
*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.* 
