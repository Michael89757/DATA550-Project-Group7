here::i_am(
  "code/01_data_processing.R"
)

absolute_path_to_data <- here::here("data", "covid_sub.csv")
df <- read.csv(absolute_path_to_data, header = TRUE)

# Coder 1 TO DO Here


# save cleaned data in `data/` folder
saveRDS(
  df, 
  file = here::here("data/covid_data_cleaned.rds")
)

