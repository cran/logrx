test_that("axecute will run a file and create the necessary log", {
  options("log.rx" = NULL)
  scriptPath <- tempfile()
  logDir <- tempdir()
  writeLines("print('hello logrx')", con = scriptPath)

  # check no log is currently written out
  expect_warning(expect_error(file(file.path(logDir, "log_out"), "r"), "cannot open the connection"))

  axecute(scriptPath, log_name = "log_out", log_path = logDir)
  con <- file(file.path(logDir, "log_out"), "r")
  flines <- readLines(con)
  close(con)

  # check that the output file is populated
  expect_gt(length(flines), 1)
  # check all the elements are there
  expect_true(grepl(
    paste(write_log_header("logrx Metadata"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("User and File Information"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Session Information"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Masked Functions"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Program Run Time Information"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Errors and Warnings"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Messages, Output, and Result"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Log Output File"), collapse = ","),
    paste(flines, collapse = ",")
  ))

  # remove all the stuff we added
  rm(flines, con, scriptPath, logDir)
  log_remove()
})

test_that("to_report works to control log output elements", {
  options("log.rx" = NULL)
  scriptPath <- tempfile()
  logDir <- tempdir()
  writeLines(
    c(
      "message('hello logrx')",
      "cat('this is output')",
      "data.frame(c(8, 6, 7, 5, 3, 0, 9))"
    ),
    con = scriptPath
  )

  # check no log is currently written out
  expect_warning(expect_error(file(file.path(logDir, "log_out_report"), "r"), "cannot open the connection"))

  axecute(scriptPath,
    log_name = "log_out_report",
    log_path = logDir,
    to_report = c("messages", "result")
  )
  con <- file(file.path(logDir, "log_out_report"), "r")
  flines <- readLines(con)
  close(con)

  expect_true(any(grepl("^Messages:", flines) == TRUE))
  expect_true(all(grepl("^Output:", flines) != TRUE))
  expect_true(any(grepl("^Result:", flines) == TRUE))

  rm(flines, con, scriptPath, logDir)
  log_remove()
})

test_that("show_repo_url works to show repo url elements", {
  options("log.rx" = NULL)
  scriptPath <- tempfile()
  logDir <- tempdir()
  writeLines(
    c(
      "message('hello logrx')",
      "cat('this is output')",
      "data.frame(c(8, 6, 7, 5, 3, 0, 9))"
    ),
    con = scriptPath
  )

  # check no log is currently written out
  expect_warning(expect_error(file(file.path(logDir, "log_out_repo_url"), "r"), "cannot open the connection"))

  axecute(scriptPath,
    log_name = "log_out_repo_url",
    log_path = logDir,
    show_repo_url = TRUE
  )
  con <- file(file.path(logDir, "log_out_repo_url"), "r")
  flines <- readLines(con)
  close(con)

  expect_true(grepl(
    paste(write_log_header("Repo URLs"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  rm(flines, con)
  log_remove()

  axecute(scriptPath,
    log_name = "log_out_repo_url2",
    log_path = logDir,
    show_repo_url = FALSE
  )
  con <- file(file.path(logDir, "log_out_repo_url2"), "r")
  flines <- readLines(con)
  close(con)

  expect_false(grepl(
    paste(write_log_header("Repo URLs"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  rm(flines, con, scriptPath, logDir)
})

test_that("include_rds works to output log as rds", {
  options("log.rx" = NULL)
  scriptPath <- tempfile()
  logDir <- tempdir()
  writeLines(
    c(
      "message('hello logrx')",
      "cat('this is output')",
      "data.frame(c(8, 6, 7, 5, 3, 0, 9))"
    ),
    con = scriptPath
  )

  # check no log is currently written out
  expect_warning(expect_error(file(file.path(logDir, "log_out_nested"), "r"), "cannot open the connection"))

  axecute(scriptPath,
    log_name = "log_out_nested",
    log_path = logDir,
    include_rds = TRUE,
    to_report = c("messages", "result")
  )
  con <- file(file.path(logDir, "log_out_nested.Rds"), "r")
  logRDS <- readRDS(file.path(logDir, "log_out_nested.Rds"))

  expect_type(logRDS, "list")
  expect_true("messages" %in% names(logRDS))
  expect_true(all(is.na(logRDS$output)))
  expect_true("result" %in% names(logRDS))
  expect_true("start_time" %in% names(logRDS))

  rm(con, scriptPath, logDir, logRDS)
  log_remove()
})

test_that("extra_info works to output extra info list", {
  scriptPath <- tempfile()
  logDir <- tempdir()
  writeLines(
    c(
      "message('hello logrx')",
      "cat('this is output')",
      "data.frame(c(8, 6, 7, 5, 3, 0, 9))"
    ),
    con = scriptPath
  )

  axecute(scriptPath,
    log_name = "log_out_extra_info1",
    log_path = logDir,
    extra_info = list("orange", paste0("green eggs and ham"))
  )
  con <- file(file.path(logDir, "log_out_extra_info1"), "r")
  flines <- readLines(con)
  close(con)

  expect_true(grepl(
    paste(write_log_header("Extra info"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    "orange",
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    "green eggs and ham",
    paste(flines, collapse = ",")
  ))
  rm(flines, con)
  log_remove()

  axecute(scriptPath,
    log_name = "log_out_extra_info2",
    log_path = logDir,
    extra_info = list(a = 1, b = list(c = 2, d = list(3, 4)))
  )
  con <- file(file.path(logDir, "log_out_extra_info2"), "r")
  flines <- readLines(con)
  close(con)

  expect_true(grepl("a: 1", paste(flines, collapse = ",")))
  expect_true(grepl("b:", paste(flines, collapse = ",")))
  expect_true(grepl("c: 2", paste(flines, collapse = ",")))
  expect_true(grepl("- 3", paste(flines, collapse = ",")))
  rm(flines, con)

  axecute(scriptPath,
    log_name = "log_out_extra_info3",
    log_path = logDir,
    extra_info = NA
  )
  con <- file(file.path(logDir, "log_out_extra_info3"), "r")
  flines <- readLines(con)
  close(con)

  expect_false(grepl(
    paste(write_log_header("Extra info"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  rm(flines, con, scriptPath, logDir)
})

test_that("axecute will run a markdown file and create the necessary log", {
  options("log.rx" = NULL)

  scriptPath <- test_path("ref", "ex1.Rmd")
  logDir <- tempdir()

  # check no log is currently written out
  expect_warning(expect_error(file(file.path(logDir, "rmd_log_out"), "r"), "cannot open the connection"))

  axecute(scriptPath, log_name = "rmd_log_out", log_path = logDir)
  con <- file(file.path(logDir, "rmd_log_out"), "r")
  flines <- readLines(con)
  close(con)

  # check that the output file is populated
  expect_gt(length(flines), 1)
  # check all the elements are there
  expect_true(grepl(
    paste(write_log_header("logrx Metadata"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("User and File Information"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Session Information"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Masked Functions"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Program Run Time Information"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Errors and Warnings"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Messages, Output, and Result"), collapse = ","),
    paste(flines, collapse = ",")
  ))
  expect_true(grepl(
    paste(write_log_header("Log Output File"), collapse = ","),
    paste(flines, collapse = ",")
  ))

  # remove all the stuff we added
  rm(flines, con, scriptPath, logDir)
  log_remove()
})
