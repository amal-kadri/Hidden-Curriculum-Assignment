library(tidyverse)
library(ggplot2)
library(knitr)
library(stargazer)
library(magrittr)
library(here)
library(kableExtra)

#Set your working directory here by pasting where you have located the repository over the file path below
path <- file.path("/Users/amalkadri/Documents/Causal Inference/Hidden-Curriculum-Assignment/")
path_data <- file.path(path, "data")
path_code <- file.path(path, "code")
path_figures <- file.path(path, "figures")

NLSYTable = as.data.frame(read_csv(file.path(path_data, "NLSY97_Incarceration_clean.csv")) %>%
                            mutate(incarcerationStatus = ifelse(total_arrests > 0 , 1, 0)) %>%
                            group_by(race, gender) %>%
                            summarize(propArrested = mean(incarcerationStatus)*100)) %>%
  
  #kable(NLSYTable)
  
  # pivot the values from race into columns
  pivot_wider(names_from = race, values_from = propArrested) %>%
  
  # rename columns using snakecase
  rename_with(to_title_case) %>%
  
  # create the kable object. Requires booktabs and float LaTeX packages
  kbl(
    caption = "Percentage Incarcerated in 2002 by Race and Gender",
    booktabs = TRUE,
    format = "latex",
    label = "tab:summarystats"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>%
  
  write_lines(file.path(path_figures, "incarceration_by_racegender.tex"))
