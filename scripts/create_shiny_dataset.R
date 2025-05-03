# scripts/create_shiny_dataset.R

library(tidyverse)
library(here)
library(fs)

# 1) Read the full *traffic-stop* cleaned data
full <- read_rds(here("dataset","cleaned_dataset.rds"))

# 2) Drop any impossible or missing ages
full <- full %>%
  filter(!is.na(SubjectAge), SubjectAge >= 0, SubjectAge <= 100)

# 3) Subset only the columns our app needs
shiny_data <- full %>%
  select(
    SubjectRaceCode,
    SubjectSexCode,
    SubjectAge,
    InterventionReasonCode,
    `Department Name`,
    InterventionDateTime,
    CustodialArrestIndicator,
    TowedIndicator,
    VehicleSearchedIndicator
  )

# 4) Write out the small RDS
fs::dir_create(here("dataset_for_shiny"))
write_rds(shiny_data, here("dataset_for_shiny","shiny_stops.rds"))
