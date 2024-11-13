here::i_am(
  "code/02_make_table1.R"
)

df <- readRDS(
  file = here::here("data/covid_data_cleaned.rds")
)

# Coder 1 TO DO Here


saveRDS(
  table1,
  file = here::here("table/table1.rds")
)



