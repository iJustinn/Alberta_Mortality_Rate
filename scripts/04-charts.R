#### Preamble ####
# Purpose: 
# Author: Ziheng Zhong
# Date: 10 March 2024
# Contact: ziheng.zhong@mail.utoronto.ca
# License: MIT
# Pre-requisites: none



#### Workspace setup ####
# setup all libraries
library(knitr)
library(janitor)
library(ggplot2)
library(tidyverse)



#### load data ####
filtered_data <- read_csv("outputs/data/raw_data.csv")



#### generate charts ####
filtered_data |>
  ggplot(aes(x = calendar_year, y = total_deaths, color = cause)) +
  geom_line() +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  labs(x = "Year", y = "Annual number of deaths in Alberta") +
  facet_wrap(vars(cause), dir = "v", ncol = 1) +
  theme(legend.position = "none")

pp_check(cause_of_death_alberta_poisson) +
  theme(legend.position = "bottom")

pp_check(cause_of_death_alberta_neg_binomial) +
  theme(legend.position = "bottom")

