## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(logrx)

## -----------------------------------------------------------------------------
approved_pkgs <- list(base = "mean",
                      dplyr = "All")
approved_pkgs

## -----------------------------------------------------------------------------
build_approved(approved_pkgs)

## -----------------------------------------------------------------------------
dir <- tempdir()

build_approved(approved_pkgs, file = file.path(dir, "approved.rds"))

## -----------------------------------------------------------------------------
options(log.rx.approved = file.path(dir, "approved.rds"))

## -----------------------------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)

results <- mtcars %>%
   group_by(cyl) %>%
   summarize(mean = mean(mpg)) %>%
   mutate(label = "Mean MPG")

results %>%
   tidyr::pivot_wider(names_from = cyl, values_from = mean, id_cols = label)

## ----echo = FALSE-------------------------------------------------------------
# write this to the temp directory so we have a script to axecute

text <- 'library(dplyr)

results <- mtcars %>%
   group_by(cyl) %>%
   summarize(mean = mean(mpg)) %>%
   mutate(label = "Mean MPG")

results %>%
   tidyr::pivot_wider(names_from = cyl, values_from = mean, id_cols = label)'
   
fileConn <- file(file.path(dir,"mpg.R"))
writeLines(text, fileConn)
close(fileConn)

## ----results='hide'-----------------------------------------------------------
axecute(file.path(dir,"mpg.R"), remove_log_object = FALSE)

## ----echo=FALSE---------------------------------------------------------------
cleaned_log_vec <- c()

cleaned_log_vec <- c(cleaned_log_vec,
                           write_log_header("Used Package and Functions"),
                           write_used_functions())

cleaned_log_vec <- c(cleaned_log_vec,
                           write_log_header("Unapproved Package and Functions"),
                           write_unapproved_functions())
cat(cleaned_log_vec, sep = "\n")

## ----cleanup, echo = FALSE----------------------------------------------------
logrx::log_remove()

unlink(dir, recursive = TRUE)

