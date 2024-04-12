## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(logrx)

## ----axecute, eval = FALSE----------------------------------------------------
#  axecute("my_script.R")

## ----log_*, eval = FALSE------------------------------------------------------
#  log_config("my_script.R")
#  run_safely_loudly("my_script.R")
#  log_write()
#  log_remove()

## ----scripting, eval = FALSE--------------------------------------------------
#  lapply(c("file.R", "otherfile.R"), axecute)

## ----scripting-dir, eval = FALSE----------------------------------------------
#  r_script_list <- list.files(path = ".", pattern = "\\.R$")
#  lapply(r_script_list, axecute)

