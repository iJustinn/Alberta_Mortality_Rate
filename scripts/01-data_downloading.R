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
library(tidyverse)



#### download data ####
raw_data <-
  read_csv(
    "https://open.alberta.ca/dataset/03339dc5-fb51-4552-97c7-853688fc428d/resource/3e241965-fee3-400e-9652-07cfbf0c0bda/download/deaths-leading-causes.csv",
    skip = 2,
    col_types = cols(
      `Calendar Year` = col_integer(),
      Cause = col_character(),
      Ranking = col_integer(),
      `Total Deaths` = col_integer()
    )
  )



#### save data ####
write_csv(
  x = raw_data,
  file = "inputs/data/raw_data.csv"
)


