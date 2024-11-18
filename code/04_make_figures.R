here::i_am(
  "code/04_make_figures.R"
)

df <- readRDS(
  file = here::here("data/covid_data_cleaned.rds")
)

# Coder 3 TO DO Here
library(ggplot2)
library(dplyr)

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

#creating a boxplot for each comorbidity
for (high_comorbidity in Comorbidities_High_Correlations) {
  high_cor_plot <- ggplot(boxplot_data, aes(x = .data[[high_comorbidity]], y = .data[["DEATH"]])) +
    geom_boxplot(fill = "lightblue", color = "darkblue") +
    labs(
      title = paste("Boxplot of", high_comorbidity, "vs Death"),
      x = high_comorbidity,
      y = "Death"
    ) +
    theme_minimal()
  
# save the figures
  ggsave(
    filename = here::here("figure", paste0(high_comorbidity, "_vs_Death.png")),
    plot =  high_cor_plot,
    width = 8,        
    height = 8,
    device = "png"
  )
}

