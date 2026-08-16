install.packages("scales")
library(scales)
glimpse(freight_business)

summary(freight_business)

sum(freight_business$tons_2022)

sum(freight_business$value_2022)

# Top 15 origin state
top_origin <- freight_business %>%
  group_by(state_name) %>%
  summarise(
    total_tons = sum(tons_2022),
    total_value = sum(value_2022)
  ) %>%
  arrange(desc(total_tons)) %>%
  slice(1:15)

top_origin

# State origin chart
ggplot(top_origin,
       aes(reorder(state_name,total_tons),
           total_tons))+
  
  geom_col()+
  
  coord_flip()+
  
  labs(
    title="Top 15 Origin States by Freight Volume",
    x="Origin State",
    y="Total Tons"
  )

# Top destination state
top_destination <- freight_business %>%
  group_by(destination_state) %>%
  summarise(
    total_tons=sum(tons_2022)
  ) %>%
  arrange(desc(total_tons)) %>%
  slice(1:15)

top_destination

# State destination chart
ggplot(top_destination,
       aes(reorder(destination_state,total_tons),
           total_tons))+
  
  geom_col()+
  
  coord_flip()+
  
  labs(
    title="Top Destination States by Freight Volume",
    x="Destination State",
    y="Total Tons"
  )
# Transportation Mode
mode_summary <-
  freight_business %>%
  group_by(transport_mode) %>%
  summarise(
    Total_Tons = sum(tons_2022),
    Total_Value = sum(value_2022)
  ) %>%
  arrange(desc(Total_Tons))

mode_summary

 # Transport mode chart
ggplot(
  mode_summary,
  aes(reorder(transport_mode, Total_Tons), Total_Tons)
) +
  geom_col(fill = "#0072B2") +
  coord_flip() +
  labs(
    title="Freight by Transportation Mode",
    x="Mode",
    y="Total Tons"
  ) +
  theme_minimal()

# Top 10 Commodities
commodity_summary <-
  freight_business %>%
  group_by(commodity_name) %>%
  summarise(
    Total_Tons = sum(tons_2022),
    Total_Value = sum(value_2022)
  ) %>%
  arrange(desc(Total_Value))

top10 <- commodity_summary |>
  slice_max(Total_Value, n=10)

# Commodity Chart
ggplot(
  top10,
  aes(reorder(commodity_name, Total_Value), Total_Value)
) +
  geom_col(fill="#009E73") +
  coord_flip() +
  theme_minimal() +
  labs(
    title="Top 10 Commodities by Value",
    x="Commodity",
    y="Million Dollars"
  )

# Average shipment value
freight_business <-
  
  freight_business %>%
  
  mutate(
    
    value_per_ton=
      
      value_2022/
      
      tons_2022
    
  )
summary(freight_business$value_per_ton)

# High value commodities
freight_business %>%
  
  group_by(commodity_name)%>%

  summarise(
    
    Average_Value_Per_Ton=
      
      mean(value_per_ton)
    
  )%>%

  arrange(desc(Average_Value_Per_Ton))

cor(
  
  freight_business$tons_2022,
  
  freight_business$value_2022
  
)

# Distribution (value_2022)
ggplot(
  freight_business,
  aes(value_2022)
) +
  geom_histogram(
    bins=60,
    fill="#D55E00"
  ) +
  scale_x_log10()

# Distribution(ton_2022)
ggplot(
  freight,
  aes(tons_2022)
) +
  geom_histogram(
    bins=60,
    fill="#0072B2"
  ) +
  scale_x_log10()

# Relationship between value and weight
set.seed(123)

sample_data <-
  freight_business %>%
  sample_n(10000)
ggplot(
  sample_data,
  aes(tons_2022,value_2022)
)+
  geom_point(alpha=.25)+
  scale_x_log10()+
  scale_y_log10()+
  theme_minimal()

# Executive KPI
executive_kpis <- tibble(
  Metric = c(
    "Total Freight (Tons)",
    "Total Freight Value",
    "Number of Shipments",
    "Number of Origin States",
    "Number of Destination States",
    "Number of Transportation Modes",
    "Number of Commodity Groups"
  ),
  Value = c(
    sum(freight_business$tons_2022),
    sum(freight_business$value_2022),
    nrow(freight_business),
    n_distinct(freight_business$state_name),
    n_distinct(freight_business$destination_state),
    n_distinct(freight_business$transport_mode),
    n_distinct(freight_business$commodity_name)
  )
)

executive_kpis

write.csv(
  executive_kpis,
  "reports/executive_kpis.csv",
  row.names = FALSE
)

# Overall Metrics
total_tons <- sum(freight_business$tons_2022, na.rm = TRUE)
total_value <- sum(freight_business$value_2022, na.rm = TRUE)
total_states <- n_distinct(freight_business$state_name)
total_commodities <- n_distinct(freight_business$commodity_name)

total_tons
total_value
total_states
total_commodities

#Transport Modes
mode_summary <- freight_business %>%
  group_by(transport_mode) %>%
  summarise(
    freight_tons = sum(tons_2022, na.rm = TRUE),
    freight_value = sum(value_2022, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    volume_share = freight_tons / sum(freight_tons) * 100,
    value_share = freight_value / sum(freight_value) * 100
  ) %>%
  arrange(desc(freight_tons))

mode_summary

#States
state_summary <- freight_business %>%
  group_by(state_name) %>%
  summarise(
    freight_tons = sum(tons_2022, na.rm = TRUE),
    freight_value = sum(value_2022, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(freight_tons))

head(state_summary, 10)

#Commodities Summary
commodity_summary <- freight_business %>%
  group_by(commodity_name) %>%
  summarise(
    freight_tons = sum(tons_2022, na.rm = TRUE),
    freight_value = sum(value_2022, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    value_per_ton = freight_value / freight_tons
  )

commodity_summary %>%
  arrange(desc(freight_value)) %>%
  head(10)

commodity_summary %>%
  arrange(desc(freight_tons)) %>%
  head(10)

commodity_summary %>%
  filter(freight_tons > quantile(freight_tons, 0.25, na.rm = TRUE)) %>%
  arrange(desc(value_per_ton)) %>%
  head(10)

state_summary %>%
  arrange(desc(freight_value)) %>%
  head(10)

state_value_density <- state_summary %>%
  mutate(
    value_per_ton = freight_value / freight_tons
  ) %>%
  arrange(desc(value_per_ton))

head(state_value_density, 10)

commodity_summary <- commodity_summary %>%
  mutate(
    value_per_short_ton = (freight_value / freight_tons) * 1000
  )
commodity_summary %>%
  arrange(desc(value_per_short_ton)) %>%
  head(10)
state_value_density <- state_summary %>%
  mutate(
    value_per_short_ton = (freight_value / freight_tons) * 1000
  ) %>%
  arrange(desc(value_per_short_ton))

head(state_value_density, 10)