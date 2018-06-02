library(tidyverse)
library(rvest)

#####################################################
# Codebook for Personal NCVS Dataset
#####################################################
ncvs_personal_fields <- read_xml("https://api.bjs.ojp.gov/bjs/ncvs/v2/personal/fields")

ncvs_p_id <- ncvs_personal_fields %>%
  xml_nodes("id") %>%
  xml_text()

ncvs_p_desc <- ncvs_personal_fields %>%
  xml_nodes(xpath = "fields/description") %>%
  xml_text() %>%
  str_remove("<p>")

ncvs_p_name <- ncvs_personal_fields %>%
  xml_nodes(xpath = "fields/name") %>%
  xml_text()

ncvs_p_values <- ncvs_personal_fields %>%
  xml_nodes(xpath = "fields/values/description") %>%
  xml_text()

ncvs_p_factor_values <- ncvs_personal_fields %>%
  xml_nodes(xpath = "fields/values/name") %>%
  xml_text()

var_p_table <- tibble(ncvs_p_id, ncvs_p_name, ncvs_p_desc)

values_p_table <- tibble(ncvs_p_values, ncvs_p_factor_values)

nested_p_vals <- values_p_table %>%
  group_by(group = cumsum(c(FALSE, diff(as.numeric(ncvs_p_factor_values)) <= 0))) %>%
  ungroup() %>%
  mutate(group = replace(group, group %in% NA, c(21,21,22))) %>%
  group_by(group) %>%
  nest(ncvs_p_values:ncvs_p_factor_values)

ncvs_personal_codebook <- bind_cols(var_p_table, nested_p_vals) %>%
  unnest() %>%
  select(-group)

#####################################################
# Codebook for Household NCVS Dataset
#####################################################
ncvs_household_fields <- read_xml("https://api.bjs.ojp.gov/bjs/ncvs/v2/household/fields")

ncvs_h_id <- ncvs_household_fields %>%
  xml_nodes("id") %>%
  xml_text()

ncvs_h_desc <- ncvs_household_fields %>%
  xml_nodes(xpath = "fields/description") %>%
  xml_text() %>%
  str_remove("<p>")

ncvs_h_name <- ncvs_household_fields %>%
  xml_nodes(xpath = "fields/name") %>%
  xml_text()

ncvs_h_values <- ncvs_household_fields %>%
  xml_nodes(xpath = "fields/values/description") %>%
  xml_text()

ncvs_h_factor_values <- ncvs_household_fields %>%
  xml_nodes(xpath = "fields/values/name") %>%
  xml_text()

var_h_table <- tibble(ncvs_h_id, ncvs_h_name, ncvs_h_desc)

values_h_table <- tibble(ncvs_h_values, ncvs_h_factor_values)

nested_h_vals <- values_h_table %>%
  group_by(group = cumsum(c(FALSE, diff(as.numeric(ncvs_h_factor_values)) < 0 ))) %>%
  ungroup() %>%
  mutate(group = replace(group, group %in% 12:13, c(12,12,13,13,13,14,14)),
         group = replace(group, group %in% NA, c(15,15,16))) %>%
  group_by(group) %>%
  nest(ncvs_h_values:ncvs_h_factor_values)

ncvs_household_codebook <- bind_cols(var_h_table, nested_h_vals) %>%
  unnest() %>%
  select(-group)

devtools::use_data(ncvs_personal_codebook,
                   ncvs_household_codebook,
                   overwrite = TRUE)
