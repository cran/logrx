
<!-- README.md is generated from README.Rmd. Please edit that file -->

# logrx <img src="man/figures/logo.png" align="right" alt="" width="120" />

<!-- start badges -->

[![R build
status](https://github.com/pharmaverse/logrx/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pharmaverse/logrx/actions?workflow=R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/logrx)](https://CRAN.R-project.org/package=logrx)
[<img src="https://img.shields.io/badge/License-MIT-blue.svg">](https://github.com/pharmaverse/logrx/blob/master/LICENSE.md)
[![pharmaverse logrx
Badge](http://pharmaverse.org/shields/logrx.svg)](https://pharmaverse.org)
[![Test
Coverage](https://raw.githubusercontent.com/pharmaverse/logrx/refs/heads/badges/test-coverage.svg)](https://github.com/pharmaverse/logrx/actions/workflows/test-coverage.yaml)

<!-- end badges -->

The goal of `{logrx}` is to facilitate logging in a clinical environment
with the goal of making code easily traceable and reproducible.

## Installation

This package is available from CRAN and can be installed by running:

``` r
install.packages("logrx")
```

To get the latest development version use:

``` r
devtools::install_github("pharmaverse/logrx")
```

## What is `{logrx}` ?

Simple! The `{logrx}` package makes a log file for a R script!. Below we
have a short gif of making a log file for a `adsl.R` script using the
Addin which can be found in the [logrxaddin
package](https://github.com/pharmaverse/logrxaddin). More details on the
parts of the log script are found in [Get
Started](https://pharmaverse.github.io/logrx/articles/logrx.html) and we
have several vignettes that show specific use cases for using the
package.

<div class="figure" style="text-align: center">

<img src="https://github.com/pharmaverse/logrxaddin/blob/assets/logrx_gif.gif?raw=true" alt="logrx Addin in Action" width="100%" />
<p class="caption">

logrx Addin in Action
</p>

</div>

## `{logrx}` Mission and Methodology

While many packages to facilitate the logging of code already exist in
the R ecosystem, it is hard to find a solution that works well for
clinical programming applications. Many logging implementations are more
implicit and rely on user input to create the log for the execution of a
script. While this is useful for logging specific events of an
application, in clinical programming a log has a set purpose.

`{logrx}` is built around the concept of creating a log for the
execution of an R script that provides an overview of what happened as
well as the environment that it happened in. We set out to create a
flexible logging utility that could provide the necessary information to
anyone reviewing the code execution so they can recreate the execution
environment and run the code for themselves. While we strive to create a
comprehensive and accurate log, we also want to keep the package light
and unintrusive in a coding environment. `{logrx}` is purpose-built for
the needs of clinical programming to capture necessary elements of the
environment and execution to be able to create a complete view of the
program execution and environment.

## Using logrx

`logrx` can be used in a file or through scripting. More information on
how to use `{logrx}` can be found in [Get
Started](https://pharmaverse.github.io/logrx/articles/logrx.html) and in
our Articles on Execution and Use Cases.
