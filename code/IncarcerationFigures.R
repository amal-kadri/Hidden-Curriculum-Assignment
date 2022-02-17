library(tidyverse)
library(ggplot2)
library(knitr)
library(stargazer)
library(magrittr)
library(here)
#if you have not run the "AKinclude.R" file, uncomment the path variable below, otherwise if you have set your path previously,
#the code should function
#Set your working directory here by pasting where you have located the repository over the file path below
#path <- file.path("/Users/amalkadri/Documents/Causal Inference/Hidden-Curriculum-Assignment/")
path_data <- file.path(path, "data")
path_code <- file.path(path, "code")
path_figures <- file.path(path, "figures")
here()
NLSYFigures = as.data.frame(read_csv(file.path(path_data, "NLSY97_Incarceration_clean.csv")) %>%
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

ggsave(file.path(path_figures, "Incarceration_by_Racegender.png"), width=8, height=4.5)
