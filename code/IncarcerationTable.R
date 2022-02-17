library(tidyverse)
library(ggplot2)
library(knitr)
library(stargazer)
library(magrittr)
library(here)
file.path("/Users/amalkadri/Documents/Causal Inference/hidden-curriculum")

NLSYTable = as.data.frame(read_csv(here("data/NLSY97_Incarceration_clean.csv")) %>%
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
    caption = "Mean arrests in 2002 by Race and Gender",
    booktabs = TRUE,
    format = "latex",
    label = "tab:summarystats"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>%
  
  write_lines(here("tables/arrests_by_racegender.tex"))