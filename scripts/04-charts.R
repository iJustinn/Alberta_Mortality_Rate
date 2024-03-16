#### Preamble ####
# Purpose: This code analyzes and visualizes Alberta's top 5 causes of mortality, assesses model fits for Poisson and Negative Binomial distributions, and sets up the workspace with essential libraries and data.
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
top_5_cause_data |>  # Uses the `top_5_cause_data` dataset
  ggplot(aes(x = calendar_year, y = total_deaths, color = cause)) +  # Initializes a ggplot with `calendar_year` on the x-axis, `total_deaths` on the y-axis, and colors lines by `cause`
  geom_line() +  # Adds line geometries to plot the trends of deaths over years for each cause
  theme_minimal() +  # Applies a minimal theme to the plot for a clean and modern appearance
  scale_color_brewer(palette = "Set1") +  # Uses a color palette from Color Brewer for the line colors, enhancing visual distinction
  labs(x = "Year", y = "Annual number of deaths in Alberta") +  # Labels the x-axis as "Year" and the y-axis as "Annual number of deaths in Alberta"
  facet_wrap(vars(cause), dir = "v", ncol = 1) +  # Creates separate plots (facets) for each cause, arranged vertically with one column
  theme(legend.position = "none")  # Hides the legend since the facet titles already indicate the cause



#### summarized top 5 causes ####
summarized_top_5_cause_data |>  # Uses the `summarized_top_5_cause_data` dataset
  ggplot(aes(x = calendar_year, y = sum_deaths)) +  # Initializes a ggplot with `calendar_year` on the x-axis and the summed `sum_deaths` on the y-axis
  geom_line() +  # Adds line geometries to plot the total deaths over years
  theme_minimal() +  # Applies a minimal theme to the plot for a clean and modern appearance
  scale_x_continuous(breaks = unique(summarized_top_5_cause_data$calendar_year)) +  # Sets the x-axis breaks to be the unique years in the dataset, ensuring all years are displayed
  labs(x = "Year", y = "Sum of Deaths") +  # Labels the x-axis as "Year" and the y-axis as "Sum of Deaths"
  theme(legend.position = "none")  # Hides the legend, as it's unnecessary for a single series plot



#### poisson result ####
pp_check(cause_of_death_alberta_poisson) +  # Calls the `pp_check` function on the Poisson model object to generate posterior predictive checks, which graphically compare observed data to data simulated from the model
  theme(legend.position = "bottom")  # Adjusts the plot theme to move the legend to the bottom of the plot, enhancing readability and presentation



#### negative binomial result ####
pp_check(cause_of_death_alberta_neg_binomial) +  # Generates posterior predictive checks for the Negative Binomial model to visually assess model fit by comparing observed data against simulated data from the model
  theme(legend.position = "bottom")  # Modifies the plot theme to position the legend at the bottom, improving plot clarity and aesthetics
