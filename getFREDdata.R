#Set up ----
# load necessary libraries
library("tidyverse")
library("fredr")

# set up API key
# for more info visit: https://fred.stlouisfed.org/docs/api/api_key.html
fredr_set_key("APIKey")

# Load series to retrieve
load("FREDseries.RData")

serieskeys <- series$id

# Retrieve data ----
df <- list()
for (i in 1:NROW(serieskeys)){
  d <- fredr(
    series_id = serieskeys[i],
    observation_start = as.Date("1990-01-01"),
    observation_end = as.Date(today()))
  
  df[[i]] <- d
  names(df)[i] <- serieskeys[i]
  
  # Loop tracker
  cat("Now retrieving ", i, " of ", NROW(serieskeys), "series", "\n")
}

# Merge data with metadata df
df <- bind_rows(df, .id = "series_id") %>%
  rename(id = series_id) %>% 
  merge(., series, .id = "id")
  
# Save data as data file
save(df, file = "FREDdata.RData")



  
