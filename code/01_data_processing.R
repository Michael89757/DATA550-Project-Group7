here::i_am(
  "code/01_data_processing.R"
)

absolute_path_to_data <- here::here("data", "covid_sub.csv")
df <- read.csv(absolute_path_to_data, header = TRUE)

# Coder 1 TO DO Here
df$COVID19_CARRIER_STATUS <- ifelse(df$CLASIFFICATION_FINAL >= 1 & df$CLASIFFICATION_FINAL <= 3, 
                                      "Confirmed", "Unconfirmed")
df$DEATH <- ifelse(is.na(df$DATE_DIED), "No", "Yes")


# save cleaned data in `data/` folder
saveRDS(
  df, 
  file = here::here("data/covid_data_cleaned.rds")
)

