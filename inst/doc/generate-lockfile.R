## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----setup, message = FALSE---------------------------------------------------
# library(logrx)
# library(stringr)
# library(dplyr)
# library(tidyr)
# library(renv)

## ----run_axecute, echo = TRUE-------------------------------------------------
# scriptPath <- tempfile()
# 
# logDir <- tempdir()
# writeLines(
#   c(
#     "print('hello logrx')",
#     "library(dplyr)",
#     "count(iris, Species)"
#   ),
#   con = scriptPath
# )
# 
# filePath <- file.path(logDir, "log_out_parse")
# 
# axecute(scriptPath, log_name = "log_out_parse", log_path = logDir, show_repo_url = TRUE)

## ----read_logfile, warning = FALSE, error = TRUE------------------------------
try({
# parsedFile <- read_log_file(filePath)
})

## ----gen_lockfile, error = TRUE-----------------------------------------------
try({
# pkgs <- parsedFile$`Used Package and Functions` %>%
#   transmute(package_name = str_extract(library, "(?<=package\\:).+"))
# 
# used_pkgs <- parsedFile$`Session Information`$Packages %>%
#   filter(package %in% pkgs$package_name)
# 
# repo_urls <- parsedFile$`Repo URLs`
# 
# temp_lockfile <- tempfile(fileext = ".lockfile")
# 
# # Create lockfile based on used packages
# x <- renv::lockfile_create(
#   packages = c(
#     Package = used_pkgs$package
#   )
# )
# 
# # Update repo URL for lockfile
# lockfile_repos <- repo_urls$Name
# names(lockfile_repos) <- repo_urls$URL
# x <- renv::lockfile_modify(
#   lockfile = x,
#   repos = lockfile_repos
# )
# 
# # Write lockfile
# renv::lockfile_write(
#   lockfile = x,
#   file = temp_lockfile,
#   type = "custom",
# )
# 
# # Update package versions based on session info
# renv::record(
#   records = list(
#     digest = list(
#       Package = used_pkgs$package,
#       Version = used_pkgs$version,
#       Source = "Repository",
#       Repository = used_pkgs$source
#     )
#   ),
#   lockfile = temp_lockfile
# )
# 
# # Open the lockfile you just created to confirm it looks as expected
# # uncomment the lines below to open the lockfile in RStudio
# # if (require("rstudioapi") && rstudioapi::isAvailable()) {
# #   rstudioapi::documentOpen(temp_lockfile)
# # }
})

