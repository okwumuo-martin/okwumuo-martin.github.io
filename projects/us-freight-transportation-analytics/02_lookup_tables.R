install.packages("dplyr")
library(dplyr)
states <- read_excel("C:/Users/hp/Desktop/portfolio/Logistics dashboard/dashboard/us-freight/us-freight-transportation-analytics/data/FAF6.0_State/Metadata/FAF6_Metadata.xlsx", sheet = "State")
states <- clean_names(states)
head(states)
mode <- read_excel("C:/Users/hp/Desktop/portfolio/Logistics dashboard/dashboard/us-freight/us-freight-transportation-analytics/data/FAF6.0_State/Metadata/FAF6_Metadata.xlsx", sheet = "Mode")
mode <- clean_names(mode)
head(mode)
commodity <- read_excel("C:/Users/hp/Desktop/portfolio/Logistics dashboard/dashboard/us-freight/us-freight-transportation-analytics/data/FAF6.0_State/Metadata/FAF6_Metadata.xlsx", sheet = "Commodity (SCTG2)")
commodity <- clean_names(commodity)
head(commodity)
trade <- read_excel("C:/Users/hp/Desktop/portfolio/Logistics dashboard/dashboard/us-freight/us-freight-transportation-analytics/data/FAF6.0_State/Metadata/FAF6_Metadata.xlsx", sheet = "Trade Type")
trade <- clean_names(trade)
head(trade)
domestic_zone <- read_excel("C:/Users/hp/Desktop/portfolio/Logistics dashboard/dashboard/us-freight/us-freight-transportation-analytics/data/FAF6.0_State/Metadata/FAF6_Metadata.xlsx", sheet = "FAF Zone (Domestic)")
domestic_zone <- clean_names(domestic_zone)
head(domestic_zone)
foreign_zone <- read_excel("C:/Users/hp/Desktop/portfolio/Logistics dashboard/dashboard/us-freight/us-freight-transportation-analytics/data/FAF6.0_State/Metadata/FAF6_Metadata.xlsx", sheet = "FAF Zone (Foreign)")
head(foreign_zone)

states <- states %>%
  mutate(numeric_label = as.integer(numeric_label))

mode <- mode %>%
  mutate(numeric_label = as.integer(numeric_label))

commodity <- commodity %>%
  mutate(numeric_label = as.integer(numeric_label))

trade <- trade %>%
  mutate(numeric_label = as.integer(numeric_label))

str(states)
str(mode)
str(commodity)
str(trade)

# Renaming the columns

states <- states %>%
  rename(
    state_code = numeric_label,
    state_name = description
  )

mode <- mode %>%
  rename(
    mode_code = numeric_label,
    transport_mode = description
  )

commodity <- commodity %>%
  rename(
    commodity_code = numeric_label,
    commodity_name = description
  )

trade <- trade %>%
  rename(
    trade_code = numeric_label,
    trade_mode = description
  )

# Joining the table

freight_business <- freight %>%
  left_join(
    states,
    by = c("dms_origst" = "state_code")
  )

states_destination <- states %>%
  rename(destination_state = state_name)

freight_business <- freight_business %>%
  left_join(
    states_destination,
    by = c("dms_destst" = "state_code")
  )

freight_business <- freight_business %>%
  left_join(
    mode,
    by = c("dms_mode" = "mode_code")
  )

freight_business <- freight_business %>%
  left_join(
    commodity,
    by = c("sctg2" = "commodity_code")
  )

freight_business <- freight_business %>%
  left_join(
    trade,
    by = c("trade_type" = "trade_code")
  )

glimpse(freight_business)

sum(is.na(freight_business$state_name))

sum(is.na(freight_business$destination_state))

sum(is.na(freight_business$transport_mode))

sum(is.na(freight_business$commodity_name))

sum(is.na(freight_business$trade_mode))

freight_business %>%
  select(
    state_name,
    destination_state,
    commodity_name,
    transport_mode,
    trade_mode,
    tons_2022,
    value_2022
  ) %>%
  tail(20)
