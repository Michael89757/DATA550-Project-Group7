here::i_am(
  "code/03_make_heatmap.R"
)

data <- read.csv(
  file = here::here("data/covid_sub.csv")
)

data$COVID19_CARRIER_STATUS <- ifelse(data$CLASIFFICATION_FINAL >= 1 & data$CLASIFFICATION_FINAL <= 3, 
                                      "Confirmed", "Unconfirmed")
data$DEATH <- ifelse(is.na(data$DATE_DIED), "No", "Yes")

# Coder 2 TO DO Here
library(ggcorrplot)
library(dplyr)
library(corrplot)

#### Correlation between Comorbidities and Outcome(overall)

Comorbidities <- data |>
  select(, c("PNEUMONIA", "PREGNANT", "DIABETES", "COPD", "ASTHMA", 
             "INMSUPR", "HIPERTENSION", "CARDIOVASCULAR", "RENAL_CHRONIC", 
             "OTHER_DISEASE", "OBESITY", "TOBACCO", "DEATH"))

Comorbidities[] <- lapply(Comorbidities, function(x) {      #Convert to 1/0
  if(is.factor(x) | is.character(x)) {
    as.numeric(x == "Yes")  
  } else {
  }
})

Comorbidities[] <- lapply(Comorbidities, as.numeric)
Comorbidities <- na.omit(Comorbidities)                #Remove missing values

#correlation matrix
cor_matrix <- cor(Comorbidities, use = "complete.obs")
# Plot the correlation matrix
cor_plot <- ggcorrplot(cor_matrix, 
           method = "circle", 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           show.diag = TRUE,
           title = "Overall Comorbidities & Death")



# save it in `figure/` folder

ggsave(
  filename = here::here("figure", "Overall Comorbidities & Death.rds"),
  plot = cor_plot,
  width = 8,        
  height = 8,
  device = "png"
)
