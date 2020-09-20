library(tidyverse)
library(datasets)

# Exercise 1
iris %>%
  lm(Sepal.Length ~ Sepal.Width, data = .) %>%
  summary() %>%
  pluck('r.squared') %>%
  paste('Sepal.Length on Sepal.Width:', .)

iris %>%
  lm(Sepal.Length ~ Petal.Length, data = .) %>%
  summary() %>%
  pluck('r.squared') %>%
  paste('Sepal.Length on Petal.Length:', .)

iris %>%
  lm(Sepal.Length ~ Petal.Width, data = .) %>%
  summary() %>%
  pluck('r.squared') %>%
  paste('Sepal.Length on Petal.Width:', .)