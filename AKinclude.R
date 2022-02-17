# installs the librarian package if you don't have it
if (!("librarian" %in% rownames(utils::installed.packages()))) {
  utils::install.packages("librarian")
}

# put all of the packages that you import here
librarian::shelf( 
  cran_repo = "https://cran.microsoft.com/", # Dallas, TX
  ask = FALSE,
  stats, # https://stackoverflow.com/questions/26935095/r-dplyr-filter-not-masking-base-filter#answer-26935536
  here,
  kableExtra,
  rlang,
  ggthemes,
  tidyverse,
  janitor,
  magrittr,
  glue,
  lubridate,
  haven,
  snakecase,
  sandwich,
  lmtest,
  gganimate,
  gapminder,
  stargazer,
  snakecase
)
#######################################################################33
#Set Path for project by pasting working directory here
path <- file.path("/Users/amalkadri/Documents/Causal Inference/Hidden-Curriculum-Assignment/")

#Nathan Hattersly Legacy code using the "here() function"
# tell here where we are so we can use it elsewhere
#setwd("/Users/amalkadri/Documents/Causal Inference/hidden-curriculum/")
#here::i_am("AKinclude.R")
