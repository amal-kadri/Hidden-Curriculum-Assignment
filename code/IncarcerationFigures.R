library(tidyverse)
library(ggplot2)
library(knitr)
library(stargazer)
library(magrittr)
library(here)

path <- file.path("/Users/amalkadri/Documents/Causal Inference/hidden-curriculum/")
setwd("/Users/amalkadri/Documents/Causal Inference/hidden-curriculum")
getwd()
here()
NLSYFigures = as.data.frame(read_csv(here("data/NLSY97_Incarceration_clean.csv")) %>%
                              mutate(incarcerationStatus = ifelse(total_arrests > 0 , 1, 0)) %>%
                              group_by(race, gender) %>%
                              summarize(propArrested = mean(incarcerationStatus)*100))


ggplot(data = NLSYFigures, aes(race, propArrested, fill = gender)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Race", 
    y = "Percent of Sample Arrested", 
    fill = "Gender",
    title = "Percentage of Individuals Incarcerated in 2002 by Race and Gender") +
  theme_minimal() 

ggsave(here("figures/Incarceration_of_racegender.png"), width=8, height=4.5)
