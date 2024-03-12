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
library(rstanarm)
library(modelsummary)


#### load data ####
filtered_data <- read_csv("outputs/data/filtered_data.csv.csv")



#### poisson model ####
cause_of_death_alberta_poisson <-
  stan_glm(
    total_deaths ~ cause,
    data = filtered_data,
    family = poisson(link = "log"),
    seed = 123
  )



#### negative binomial model ####
cause_of_death_alberta_neg_binomial <-
  stan_glm(
    total_deaths ~ cause,
    data = filtered_data,
    family = neg_binomial_2(link = "log"),
    seed = 123
  )



#### modeling results ####
name_mapping <- 
  c("causeAll other forms of chronic ..."
    = "other chronic",
    "causeMalignant neoplasms of trac..."
    = "neoplasms",
    "causeOrganic dementia"
    = "dementia",
    "causeOther chronic obstructive p..."
    = "obstructive pulmonary"
  )

modelsummary(
  list(
    "Poisson" = cause_of_death_alberta_poisson,
    "Negative binomial" = cause_of_death_alberta_neg_binomial
  ),
  coef_map = name_mapping
)


