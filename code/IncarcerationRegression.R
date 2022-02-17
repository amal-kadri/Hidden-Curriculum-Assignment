#Creates the Logit regression for the NLSY97 Incarceration Analysis and saves it to a
#LaTeX file in the "figures" folder using stargazer package
library(tidyverse)
library(ggplot2)
library(knitr)
library(stargazer)
library(magrittr)
library(here)

#######################################################################################################
#if you have not run the "AKinclude.R" file, uncomment the path variable below, otherwise if you have set your path previously,
#the code should function
#######################################################################################################
#Set your working directory here by pasting where you have located the repository over the file path below
#path <- file.path("/Users/amalkadri/Documents/Causal Inference/Hidden-Curriculum-Assignment/")
path_data <- file.path(path, "data")
path_code <- file.path(path, "code")
path_figures <- file.path(path, "figures")

# Builds a LaTeX table of regression output using the stargazer package.

model <- 
  read_csv(file.path(path_data, "NLSY97_Incarceration_clean.csv")) %>%
  mutate(incarcerationStatus = ifelse(total_arrests > 0 , 1, 0)) %>%
  glm(incarcerationStatus ~ race + gender, data = ., family = "binomial")

# Here we supply our own standard errors b/c we want to 
# use heteroskedasticity-robust errors.
se <- model %>% vcovHC %>% diag %>% sqrt

# this is unnecessary, but tidies the coefficient names,
# so that you have "Male" instead of "genderMale" in the table.
# Note that stargazer treats the intercept differently so we drop it (the [-1] part)
covariate.labels <- names(coef(model))[-1] %>% str_replace("(^race)|(^gender)", "")

stargazer(
  model,
  se = list(se),
  covariate.labels = covariate.labels,
  dep.var.labels = "Likelihood of Being Incarcerated in 2002",
  out = file.path(path_figures, "regress_incarceration_by_racegender.tex"),
  title = "Regression Output. Omitted category is Black Females.",
  label = "tab:regression"
)
