#### Preamble ####
# Purpose: 
# Author: Ziheng Zhong
# Date: 10 March 2024
# Contact: ziheng.zhong@mail.utoronto.ca
# License: MIT
# Pre-requisites: none



#### Workspace setup ####
# setup all libraries
library(tibble)
library(ggplot2)
library(tidyverse)



#### simulation ####
simulation_data <-
  tibble(
    cause = rep(x = c("Heart", "Stroke", "Diabetes"), each = 6, times = 3), # Repeats each cause for every year, 3 times
    year = rep(x = 2015:2020, each = 1, times = 9), # Each year repeated for each cause, matching the total repetitions
    deaths = rnbinom(n = 54, size = 20, prob = 0.1) # Matching the total number of rows
  )



#### chart ####
ggplot(simulation_data, aes(x = year, y = deaths, color = cause)) +
  geom_point() + # Add points
  geom_smooth(method = "lm", se = FALSE) + # Add linear model trendline
  theme_minimal() +
  labs(title = "Trend of Deaths by Cause",
       x = "Year",
       y = "Number of Deaths") +
  scale_x_continuous(breaks = unique(simulation_data$year))


