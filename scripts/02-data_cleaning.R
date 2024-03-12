#### Preamble ####
# Purpose: 
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
cleaned_data <- raw_data %>%
  clean_names() %>%
  add_count(cause) %>%
  mutate(cause = str_trunc(cause, 30))



#### check top 8 major causes in 2019 ####
cleaned_data |>
  filter(
    calendar_year == 2019,
    ranking <= 8
  ) |>
  mutate(total_deaths = format(total_deaths, big.mark = ",")) |>
  kable(
    col.names = c("Year", "Cause", "Ranking", "Deaths", "Years"),
    align = c("l", "r", "r", "r", "r"),
    digits = 0, booktabs = TRUE, linesep = ""
  )



#### filtering needed data ####
top_five <-
  cleaned_data |>
  filter(
    calendar_year == 2019,
  ) |>
  slice_max(order_by = desc(ranking), n = 5) |>
  pull(cause)

filtered_data <-
  cleaned_data |>
  filter(cause %in% top_five)



#### save data ####
write_csv(
  x = cleaned_data,
  file = "outputs/data/cleaned_data.csv"
)

write_csv(
  x = filtered_data,
  file = "outputs/data/filtered_data.csv"
)


