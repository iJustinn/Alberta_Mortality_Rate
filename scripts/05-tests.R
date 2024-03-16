#### Preamble ####
# Purpose: The code defines a test suite for validating data integrity, including checks for positive calendar years, four-digit year format, non-empty cause entries, and non-negative death counts across multiple datasets within a research project.
# Author: Ziheng Zhong
# Date: 10 March 2024
# Contact: ziheng.zhong@mail.utoronto.ca
# License: MIT
# Pre-requisites: none



#### Workspace setup ####
# setup all libraries
library(readr)
library(testthat)
library(tidyverse)



#### load data ####
setwd("/Users/ijustin/Library/CloudStorage/Dropbox/Code/STA302/Research_Papers/Mortality_Rate_in_Alberta")
raw_data <- readr::read_csv("inputs/data/raw_data.csv")
top_5_cause_data <- read_csv("outputs/data/top_5_cause_data.csv")
summarized_top_5_cause_data <- read_csv("outputs/data/summarized_top_5_cause_data.csv")



#### raw_data testing ####
test_that("Calendar Year values are positive", {
  # Checks that all values in the `Calendar Year` column are non-negative, excluding NA values
  expect_true(all(raw_data$`Calendar Year` >= 0, na.rm = TRUE))
})

test_that("Calendar Year values have four digits", {
  # Checks that all values in the `Calendar Year` column have four digits, excluding NA values
  expect_true(all(nchar(as.character(raw_data$`Calendar Year`)) == 4, na.rm = TRUE))
})

test_that("Cause column contains no empty values", {
  # Checks that the `Cause` column contains no NA or empty strings
  expect_true(all(!is.na(raw_data$Cause) & raw_data$Cause != ""))
})

test_that("Deaths column contains no negative values", {
  # Checks that all values in the `Total Deaths` column are non-negative, excluding NA values
  expect_true(all(raw_data$`Total Deaths` >= 0, na.rm = TRUE))
})

test_that("Ranking values are positive", {
  # Checks that all values in the `Ranking` column are positive integers, excluding NA values
  expect_true(all(raw_data$`Ranking` > 0, na.rm = TRUE))
})



#### top_5_cause_data testing ####
test_that("Calendar Year values are positive", {
  # Verifies that all `calendar_year` entries in `top_5_cause_data` are non-negative, ignoring NA values.
  expect_true(all(top_5_cause_data$`calendar_year` >= 0, na.rm = TRUE))
})

test_that("Calendar Year values have four digits", {
  # Ensures each `calendar_year` entry in `top_5_cause_data` consists of exactly four digits, ignoring NA values.
  expect_true(all(nchar(as.character(top_5_cause_data$`calendar_year`)) == 4, na.rm = TRUE))
})

test_that("Cause column contains no empty values", {
  # Confirms there are no NA or empty strings in the `cause` column of `top_5_cause_data`.
  expect_true(all(!is.na(top_5_cause_data$cause) & top_5_cause_data$cause != ""))
})

test_that("Deaths column contains no negative values", {
  # Asserts all entries in `total_deaths` of `top_5_cause_data` are non-negative, excluding NAs.
  expect_true(all(top_5_cause_data$`total_deaths` >= 0, na.rm = TRUE))
})

test_that("Ranking values are positive", {
  # Checks that all `ranking` entries in `top_5_cause_data` are positive numbers, ignoring NAs.
  expect_true(all(top_5_cause_data$`ranking` > 0, na.rm = TRUE))
})



#### summarized_top_5_cause_data testing ####

test_that("Calendar Year values are positive", {
  # Confirms that all entries in the `calendar_year` column are non-negative, excluding NA values.
  expect_true(all(summarized_top_5_cause_data$`calendar_year` >= 0, na.rm = TRUE))
})

test_that("Calendar Year values have four digits", {
  # Checks that each entry in the `calendar_year` column consists of exactly four digits, removing NA values from consideration.
  expect_true(all(nchar(as.character(summarized_top_5_cause_data$`calendar_year`)) == 4, na.rm = TRUE))
})

test_that("Deaths column contains no negative values", {
  # Verifies that all values in the `sum_deaths` column are non-negative, again excluding any NA values.
  expect_true(all(summarized_top_5_cause_data$`sum_deaths` >= 0, na.rm = TRUE))
})
