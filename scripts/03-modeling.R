#### Preamble ####
# Purpose: This code fits Poisson and Negative Binomial models to analyze Alberta's mortality rates, and summarizes the modeling results with customized naming for clarity.
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
top_5_cause_data <- read_csv("outputs/data/top_5_cause_data.csv")



#### poisson model ####
cause_of_death_alberta_poisson <-  # Assigns the result of the following model fitting operation to `cause_of_death_alberta_poisson`
  stan_glm(  # Calls the `stan_glm` function to fit a generalized linear model using Stan
    total_deaths ~ cause,  # Defines the model formula: `total_deaths` as the response variable, with `cause` as the predictor
    data = top_5_cause_data,  # Specifies the dataset to use for the model fitting
    family = poisson(link = "log"),  # Sets the model family to Poisson, indicating the response variable is count data, and specifies the link function as logarithmic
    seed = 123  # Sets a seed for random number generation to ensure reproducibility of the model fitting process
  )



#### negative binomial model ####
cause_of_death_alberta_neg_binomial <-  # Assigns the result of the model fitting to `cause_of_death_alberta_neg_binomial`
  stan_glm(  # Calls the `stan_glm` function to fit a generalized linear model using Stan
    total_deaths ~ cause,  # Defines the model formula: `total_deaths` as the response variable, with `cause` as the predictor
    data = top_5_cause_data,  # Specifies the dataset to use for the model fitting
    family = neg_binomial_2(link = "log"),  # Sets the model family to Negative Binomial (version 2), suitable for count data with overdispersion, with a logarithmic link function
    seed = 123  # Sets a seed for random number generation to ensure reproducibility of the model fitting process
  )



#### modeling results ####
name_mapping <- # Assigns a named vector to `name_mapping`, maps the full name for a cause of death to a shortened version
  c("causeAll other forms of chronic ..."
    = "other chronic",
    "causeMalignant neoplasms of trac..."
    = "neoplasms",
    "causeOrganic dementia"
    = "dementia",
    "causeOther chronic obstructive p..."
    = "obstructive pulmonary"
  )

modelsummary(  # Calls the `modelsummary` function to display or return a summary of model(s) statistics
  list(  # Constructs a list of models to summarize
    "Poisson" = cause_of_death_alberta_poisson,  # Includes the Poisson model object under the name "Poisson"
    "Negative binomial" = cause_of_death_alberta_neg_binomial  # Includes the Negative Binomial model object under the name "Negative binomial"
  ),
  coef_map = name_mapping  # Applies the `name_mapping` vector to rename coefficients in the output for clarity
)
