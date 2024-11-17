here::i_am(
  "code/02_make_table1.R"
)

df <- readRDS(
  file = here::here("data/covid_data_cleaned.rds")
)

# Coder 1 TO DO Here
library(gtsummary)

table_one <- df |>
  select("SEX", "AGE", "COVID19_CARRIER_STATUS", "PATIENT_TYPE", "PNEUMONIA", "PREGNANT", "DIABETES", 
         "COPD", "ASTHMA", "INMSUPR", "HIPERTENSION", "CARDIOVASCULAR", "RENAL_CHRONIC", "OTHER_DISEASE",
         "OBESITY", "TOBACCO", "USMER", "MEDICAL_UNIT", "INTUBED", "ICU", "DEATH") |>
  tbl_summary(by = DEATH, missing = "no") |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**DEATH**") |>
  add_overall() |>
  add_p()

saveRDS(
  table_one,
  file = here::here("table/table1.rds")
)



