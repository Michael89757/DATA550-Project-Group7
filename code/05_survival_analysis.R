here::i_am("code/05_survival_analysis.R")

library(dplyr)
library(gtsummary)
df <- readRDS(
  file = here::here("data/covid_data_cleaned.rds")
)





df_regression<-df%>%
  select(-X,-DATE_DIED)%>%
  mutate(ICU = case_when(
    ICU == "Yes" ~ "Yes",
    ICU == "No" | is.na(ICU) ~ "No/NA"
  ))%>%
  mutate(PREGNANT = case_when(
    PREGNANT == "Yes" ~ "Yes",
    PREGNANT == "No" | is.na(PREGNANT) ~ "No/NA"
  ))%>%
  mutate(INTUBED  = case_when(
    INTUBED  == "Yes" ~ "Yes",
    INTUBED  == "No" | is.na(INTUBED ) ~ "No/NA"
  ))

df_regression$DEATH <- ifelse(df_regression$DEATH == "Yes", 1, 0)
df_regression <- na.omit(df_regression)


# Coder 4 TO DO Here
# Fit the logistic regression model
full_model <- glm(DEATH ~ factor(USMER) + factor(MEDICAL_UNIT) +
               factor(SEX) + factor(PATIENT_TYPE) + factor(INTUBED) + factor(PNEUMONIA) +
               AGE + factor(PREGNANT) + factor(DIABETES) +  factor(INMSUPR) + factor(HIPERTENSION) +
               factor(OTHER_DISEASE) + factor(CARDIOVASCULAR) + factor(OBESITY) +
               factor(RENAL_CHRONIC) + factor(TOBACCO) + factor(CLASIFFICATION_FINAL) +
               factor(ICU),
             data = df_regression,
             family = "binomial")

# View the summary of the model
summary(full_model)





optimized_model <- glm(DEATH ~ factor(USMER) +
                factor(SEX) + factor(PATIENT_TYPE) + factor(INTUBED) + factor(PNEUMONIA) +
                AGE +  factor(DIABETES)  + factor(INMSUPR) + factor(HIPERTENSION) +
                factor(OTHER_DISEASE) + factor(RENAL_CHRONIC) + factor(TOBACCO) + factor(CLASIFFICATION_FINAL) +
                factor(ICU),
                  data = df_regression,
                  family = "binomial")

# View the summary of the model
summary(optimized_model)

optimized_regression_table<-
  tbl_regression((optimized_model),exponentiate=TRUE)

optimized_regression_table


saveRDS(
  optimized_regression_table,
  file = here::here("output","optimized_model.rds")
)

