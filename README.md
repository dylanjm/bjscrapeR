bjscrapeR <img src="man/figures/bjscrapeR_hex.png" align="right" height="150" width="125"/>
===================================================================

[![Build Status](https://travis-ci.com/dylanjm/bjscrapeR.svg?branch=master)](https://travis-ci.com/dylanjm/bjscrapeR)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

Drawing heavy influence from [`library(blscrapeR)`](https://github.com/keberwein/blscrapeR), this library is meant to be a tidy wrapper around the Bureau of Justice Statistics (BJS) API. The idea is to utilize the 'tidyverse' methodology to create an efficient workflow when dealing with crime statistics. 

## Install

Currently, `library(bjscrapeR)` is only available through github

```
devtools::install_github("dylanjm/bjscrapeR")
```

## Basic Usage

As of right now, the package only comes with one function: `ncvs_api()`, which queries information from the __National Crime Victimization Survey (NCVS)__. This data comes in two forms: personal and household crime statistics with years available from 1993-2016.

```
library(bjscrapeR)

crime_dat <- ncvs_api(year = 2012, dataset = "personal")
head(crime_dat, 5)

#> # A tibble: 5 x 23
#>    year weight gender race1R hispanic ethnic1R  ager marital2 hincome popsize region   msa direl notify
#>   <int>  <dbl>  <int>  <int>    <int>    <int> <int>    <int>   <int>   <int>  <int> <int> <int>  <int>
#> 1  2012  1535.      2      2        2        2     6        4       1       0      3     2     3      2
#> 2  2012  2780.      1      2        2        2     5        1       5       5      3     1     4      1
#> 3  2012  3294.      2      1        2        1     4        1       2       1      3     2     4      1
#> 4  2012  3774.      1      1        1        4     2        1       5       1      4     1     4      2
#> 5  2012  3580.      1      1        2        1     7        1       2       1      3     1     4      1
#> # ... with 9 more variables: weapon <int>, weapcat <int>, newcrime <int>, newoff <int>,
#> #   seriousviolent <int>, injury <int>, treatment <int>, vicservices <int>, locationr <int>
```
