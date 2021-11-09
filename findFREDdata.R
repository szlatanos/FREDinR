#Set up ----
# Load necessary libraries
library("tidyverse")
library("fredr")

# Set up API key
fredr_set_key("APIkey")

# Find series of interest ----
series_gr <- fredr_series_search_text(
  search_text = "greece",
  order_by = "popularity",
  sort_order = "desc")

series_gr <- series_gr %>%
  filter(frequency_short %in% c("M", "Q")) %>% # select only M and Q frequencies
  filter(seasonal_adjustment_short %in% c("SA")) %>% # select only SA series
  filter(str_detect(title, "Greece")) %>% # filter out non-Greece series
  filter(str_detect(observation_end, "2021")) # filter out discontinued series

# Save series keys ----
series <- series_gr
save(series, file = "FREDseries.RData")