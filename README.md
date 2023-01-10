
<!-- README.md is generated from README.Rmd. Please edit that file -->

# apa.cor() - A correlation matrix in R, using APA style

## What it does:

This function is designed to be a fast way of creating a correlation
matrix from a dataframe that includes the needed variables. It also
produces means, standard deviations and NHS significance tests at
various levels, with an export function for the clipboard.

It is also a good tool of creating an S3 object that plugs in well into
the the `papaja: Prepare APA Journal Articles with R Markdown` package,
to produce a correlation table afer the APA manuscript guidelines (6th
Edition).

## Example of recommended Usage

``` r
library(tidyverse)    # load Tidyverse
library(psych)        # load package psych for the `bfi`dataset
library(apa.cor)

bfi %>% 
  select(A1:A5) %>% 
  apa.cor()
```

    ##       M   SD      1     2     3     4
    ## A1 2.41 1.41                         
    ## A2 4.80 1.17 -.34**                  
    ## A3 4.60 1.30 -.27** .49**            
    ## A4 4.70 1.48 -.15** .34** .36**      
    ## A5 4.56 1.26 -.18** .39** .50** .31**

## Supplemental Argument

The function also has an export option `export = TRUE`, that copies the
output into the clipboard, for further manipulation such a simple paste
into Microsoft Word.

## Better usage

Since the function outputs a proper S3 object, it is perfect for
integrating it into the [papaja](https://github.com/crsh/papaja)
package.
