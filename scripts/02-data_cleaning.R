#### Preamble ####
# Purpose: This code performs data cleaning and aggregation tasks, identifies and summarizes the top 5 causes of death in Alberta for 2019, and saves the processed datasets for further analysis or reporting.
# Author: Ziheng Zhong
# Date: 10 March 2024
# Contact: ziheng.zhong@mail.utoronto.ca
# License: MIT
# Pre-requisites: none



#### Workspace setup ####
# setup all libraries
library(readr)
library(knitr)
library(janitor)
library(tidyverse)



#### load data ####
raw_data <- read_csv("inputs/data/raw_data.csv")



#### data cleaning ####
cleaned_data <- raw_data %>%  # Assigns the result of the following operations to `cleaned_data`
  clean_names() %>%  # Converts column names of `raw_data` to a consistent, clean format
  add_count(cause) %>%  # Adds a new column that counts the number of occurrences for each `cause`
  mutate(cause = str_trunc(cause, 30))  # Truncates the `cause` column strings to 30 characters, for beter readability



#### check top 8 major causes in 2019 ####
cleaned_data |>  # Starts with the `cleaned_data` dataset
  filter(
    calendar_year == 2019,  # Keeps only the rows where `calendar_year` is 2019
    ranking <= 8  # Keeps only the rows where `ranking` is 8 or less
  ) |> 
  mutate(total_deaths = format(total_deaths, big.mark = ",")) |>  # Formats `total_deaths` column, adding commas as thousands separators
  kable(
    col.names = c("Year", "Cause", "Ranking", "Deaths", "Years"),  # Specifies column names for the table
    align = c("l", "r", "r", "r", "r"),  # Sets alignment for each column: left for the first and right for the others
    digits = 0,  # Specifies that numbers should be displayed with no decimal places
    booktabs = TRUE,  # Uses booktabs style for the table, providing a more professional look
    linesep = ""  # Specifies that there should be no additional line separators between rows
  )



#### top 5 data ####
top_five <-  # Assigns the result of the following operations to `top_five`
  cleaned_data |>  # Starts with the `cleaned_data` dataset
  filter(
    calendar_year == 2019,  # Keeps only the rows where `calendar_year` is 2019
  ) |> 
  slice_max(order_by = desc(ranking), n = 5) |>  # Selects the top 5 rows based on the `ranking` column, in descending order
  pull(cause)  # Extracts the `cause` column values from the filtered dataset, resulting in a vector of top 5 causes

top_5_cause_data <-  # Assigns the result of the following operations to `top_5_cause_data`
  cleaned_data |>  # Starts with the `cleaned_data` dataset
  filter(cause %in% top_five)  # Keeps only the rows where the `cause` is one of the top 5 causes determined above



#### summarize top 5 data ####
summarized_top_5_cause_data <- top_5_cause_data %>%  # Assigns the result of the following operations to `summarized_top_5_cause_data`
  group_by(calendar_year) %>%  # Groups the data by `calendar_year` to perform operations within each year
  summarize(sum_deaths = sum(total_deaths, na.rm = TRUE)) %>%  # Creates a new column `sum_deaths` that contains the sum of `total_deaths` for each group, ignoring NA values
  ungroup()  # Removes the grouping structure, returning the data to a standard tibble format



#### save data ####
write_csv(
  x = cleaned_data,
  file = "outputs/data/cleaned_data.csv"
)

write_csv(
  x = top_5_cause_data,
  file = "outputs/data/top_5_cause_data.csv"
)

write_csv(
  x = summarized_top_5_cause_data,
  file = "outputs/data/summarized_top_5_cause_data.csv"
)
