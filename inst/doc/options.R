## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = FALSE
)

## ----setup--------------------------------------------------------------------
library(knitr)
library(logrx)
library(tibble)

## ----options_table------------------------------------------------------------
table_ops <- tribble(
   ~option, ~value, ~description,
   "log.rx", "An empty R environment", "Used to store log elements during program exection",
   "log.rx.exec.env", "NULL", "The environment in which the program code is executed",
   "[log.rx.lint]", "FALSE", "A `lintr` object for use in lint checking",
   "[log.rx.approved]", "./approved.rds", "Location of an approved functions file"
)

kable(table_ops)

