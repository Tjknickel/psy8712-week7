# Script Settings and Resources 
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning 
week7_tbl <- read.csv("../data/week3.csv", header = TRUE) %>%
  mutate(across(c(timeStart, timeEnd), as.POSIXct)) %>%
  rename(Condition = condition, Gender = gender) %>%
  mutate(Condition = str_replace_all(Condition, c("^A$" = "Block A", "^B$" = "Block B", "C" = "Control"))) %>%
  mutate(Gender = str_replace_all(Gender, c("M" = "Male", "F" = "Female"))) %>%
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
(week7_tbl %>%
  ggplot(aes(q1, q2, color = factor(Gender, levels = c("Male", "Female")))) +
  geom_jitter() +
  scale_color_manual(values = c("#F8766D", "#00BFC4"), name = "Participant Gender")) %>%
  ggsave("../figs/fig2.png",., height = 5, width = 8, units = "in", dpi = 600)