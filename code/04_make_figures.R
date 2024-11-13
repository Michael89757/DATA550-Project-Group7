here::i_am(
  "code/04_make_figures.R"
)

df <- readRDS(
  file = here::here("data/covid_data_cleaned.rds")
)

# Coder 3 TO DO Here


# save the figures
ggsave(
  here::here("figure/plot_name.png"),
  plot = plot_name,
  device = "png"
)



