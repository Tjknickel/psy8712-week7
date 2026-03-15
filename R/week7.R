# Script Settings and Resources 
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning 
week7_tbl <- read.csv("../data/week3.csv", header = TRUE) %>%
  mutate(across(c(timeStart, timeEnd), as.POSIXct)) %>%
  pivot_longer(condition:gender, names_to = "Variable", values_to = "Level") %>%
  mutate(Variable = str_replace_all(Variable, c("condition" = "Condition", "gender" = "Gender"))) %>%
  mutate(Label = Level) %>%
  mutate(Label = str_replace_all(Label, c("^A$" = "Block A", "^B$" = "Block B", "C" = "Control", "M" = "Male", "F" = "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units = "mins"))



# Visualization 
week7_tbl %>%
  ggpairs(columns = grep("^q", names(week7_tbl)))

(week7_tbl %>%
  ggplot(aes(timeStart, q1)) +
  geom_point() +
  labs(x = "Date of Experiment", y = "Q1 Score") 
  ) %>%
  ggsave("../figs/fig1.png",., height = 5, width = 8, units = "in", dpi = 600)




  