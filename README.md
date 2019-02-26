---
output:
  md_document:
    variant: markdown_github
---



<a id="devex-badge" rel="Exploration" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="Being designed and built, but in the lab. May change, disappear, or be buggy." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/exploration.svg" title="Being designed and built, but in the lab. May change, disappear, or be buggy." /></a>[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# statscan-taxdata-tidying
 
A set of R scripts to load, clean, and merge StatsCan income tax data files for British Columbia. These codes wrangle a purchased export of StatsCan data on this [page](https://www.canada.ca/en/revenue-agency/programs/about-canada-revenue-agency-cra/income-statistics-gst-hst-statistics/t1-final-statistics/final-statistics-2017-edition-2015-tax-year.html)


### structure


This project relates to income tax data released to BC Stats by Statistics Canada. The original data came in xlsx sheets (CD-ROM from BC Stats). Contents include: one xlsx file for each year for individuals and families.

The Individuals_Data folder contains one csv file per year for individuals income tax from 2000 until 2015, and families income tax from 2004 until 2016 are in Families_Data folder not released in this REPO. 


The RCodes_Individuals and RCodes_Families folder contains the R-codes used to read, clean, merge, and wrangle the data into csv. Specifically, the empty cells were removed in all sheets, merged, and the BC geographies was extracted.


The metadata provided by Statistics Canada is in Documentation folder. 

### Usage

There are four scripts that are required for the analysis (housed in R_Scripts folder), they need to be run in order:

- 01_load.R
- 02_clean.R
- 03_merge.R
- 04_encrypt.R


#### Example

This is a basic example which shows you how to solve a common problem:

```{r example}

```

### Project Status

In progress.

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/StatCan_IncomeTax_Tidying/issues/).

### How to Contribute

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

---
*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.* 
