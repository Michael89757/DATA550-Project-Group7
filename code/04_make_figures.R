here::i_am(
  "code/04_make_figures.R"
)

df <- readRDS(
  file = here::here("data/covid_data_cleaned.rds")
)

# Coder 3 TO DO Here
library(ggplot2)
library(dplyr)
library(tidyr)

### Comorbidities With the Highest Correlations to Death 
Comorbidities_High_Correlations <- c("PNEUMONIA", "DIABETES", "HIPERTENSION", "RENAL_CHRONIC", "COPD")

df[Comorbidities_High_Correlations] <- lapply(df[Comorbidities_High_Correlations], function(x) {
  if (is.factor(x) | is.character(x)) {
    as.numeric(x == "Yes")
  } else {
    as.numeric(x)
  }
})
#remove rows with missing values
boxplot_data <- df |>
  select(all_of(Comorbidities_High_Correlations), DEATH) |>
  na.omit()
#reshaping data to long format
boxplot_data_long <- boxplot_data %>%
  pivot_longer(cols = all_of(Comorbidities_High_Correlations), 
               names_to = "Comorbidity", 
               values_to = "Comorbidity_Status")

#creating a boxplot for each comorbidity
high_cor_plot <- ggplot(boxplot_data_long, aes(x = Comorbidity_Status, y = DEATH, fill = Comorbidity_Status)) +
  geom_boxplot() +
  facet_wrap(~ Comorbidity, scales = "free_x") + 
  labs(
    title = "Comorbidities with the Strongest Positive Correlation to Death",
    x = "Comorbidity Status",
    y = "Death"
  ) +
  theme_minimal()
  
# save the figures
  ggsave(
    filename = here::here("figure", "Comorbidities with the Strongest Positive Correlation to Death.rds"),
    plot =  high_cor_plot,
    width = 8,        
    height = 8,
    device = "png"
  )


