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
library(ggplot2)
library(tidyverse)
library(tidybayes)



#### load data ####
top_5_cause_data <- read_csv("outputs/data/top_5_cause_data.csv")
summarized_top_5_cause_data <- read_csv("outputs/data/summarized_top_5_cause_data.csv")


#### top 5 causes ####
top_5_cause_data |>
  ggplot(aes(x = calendar_year, y = total_deaths, color = cause)) +
  geom_line() +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  labs(x = "Year", y = "Annual number of deaths in Alberta") +
  facet_wrap(vars(cause), dir = "v", ncol = 1) +
  theme(legend.position = "none")



#### summarized top 5 causes ####
summarized_top_5_cause_data |>
  ggplot(aes(x = calendar_year, y = sum_deaths)) +
  geom_line() +
  theme_minimal() +
  scale_x_continuous(breaks = unique(summarized_top_5_cause_data$calendar_year)) +
  labs(x = "Year", y = "Sum of Deaths") +
  theme(legend.position = "none")



#### poisson result ####
pp_check(cause_of_death_alberta_poisson) +
  theme(legend.position = "bottom")



#### negative binomial result ####
pp_check(cause_of_death_alberta_neg_binomial) +
  theme(legend.position = "bottom")


