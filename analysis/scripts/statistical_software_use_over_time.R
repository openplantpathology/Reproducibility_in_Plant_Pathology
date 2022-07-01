
library(Reproducibility.in.Plant.Pathology)
library(tidyverse)

rrpp <- import_notes()

# tally up software used
rrpp_software <-
  rrpp %>%
  transform(software_used = strsplit(software_used, ",")) %>%
  unnest(software_used) %>%
  mutate(software_used = trimws(software_used)) %>%
  mutate(software_used = toupper(software_used))

tab <- table(rrpp_software$software_used)
tab_s <- as.data.frame(sort(tab))
tab_s <-
  tab_s %>%
  arrange(desc(Freq)) %>%
  filter(Freq %in% head(unique(Freq), 10)) %>%
  rename("Software" = "Var1", "Frequency" = "Freq")

tab_t <- tabyl(rrpp_software, software_used, year)

tab_t <- tab_t[tab_t$software_used %in% tab_s$Software , ]

tab_t %>%
  rowwise() %>%
  mutate(sumnumeric = sum(c_across(where(is.numeric)), na.rm = T)) %>%
  arrange(sumnumeric) %>%
  select(-sumnumeric) %>%
  filter(
    software_used == "R" |
      software_used == "SAS" |
      software_used == "GENSTAT" |
      software_used == "SPSS" |
      software_used == "STATISTICA"
  ) %>%
  mutate(software_used = factor(software_used)) %>%
  pivot_longer(!software_used, names_to = "year", values_to = "count") %>%
  ggplot(aes(
    x = year,
    y = count,
    group = software_used,
    colour = software_used
  )) +
  geom_line() +
  geom_point(size = 4, aes(shape = software_used)) +
  scale_color_brewer(type = "qual", palette = "Dark2")
