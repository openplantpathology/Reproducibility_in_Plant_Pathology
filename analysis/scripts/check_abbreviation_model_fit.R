library(tidyverse)
library(brms)
library(Reproducibility.in.Plant.Pathology)
library(bayestestR)

options(mc.cores = parallel::detectCores())

rrpp <- import_notes()

rrpp <-
  within(rrpp,
         abbreviation <-
           relevel(abbreviation, ref = "Phytopathology"))

rrpp_code <- drop_na(rrpp, comp_mthds_avail)
rrpp_data <- drop_na(rrpp, data_avail)

priors <- c(prior(normal(0, 1), class = "b"),
            prior(normal(0, 1), class = "Intercept"))

m_f1_logit <-
  brm(
    formula = comp_mthds_avail ~ abbreviation +
      (1 | assignee) +
      (1 | year),
    data = rrpp_code,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.995),
    save_pars = save_pars(all = TRUE)
  )

m_f1_logit_no_year <-
  brm(
    formula = comp_mthds_avail ~ abbreviation +
      (1 | assignee),
    data = rrpp_code,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.99),
    save_pars = save_pars(all = TRUE)
  )

m_f2_logit <-
  brm(
    formula = data_avail ~ abbreviation +
      (1 | assignee) +
      (1 | year),
    data = rrpp_data,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.9),
    save_pars = save_pars(all = TRUE)
  )

m_f2_logit_no_year <-
  brm(
    formula = data_avail ~ abbreviation +
      (1 | assignee),
    data = rrpp_data,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.9),
    save_pars = save_pars(all = TRUE)
  )

m_f1_probit <-
  brm(
    formula = comp_mthds_avail ~ abbreviation +
      (1 | assignee) +
      (1 | year),
    data = rrpp_code,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    iter = 20000,
    control = list(adapt_delta = 0.995),
    save_pars = save_pars(all = TRUE)
  )

m_f2_probit <-
  brm(
    formula = data_avail ~ abbreviation +
      (1 | assignee) +
      (1 | year),
    data = rrpp_data,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    iter = 20000,
    control = list(adapt_delta = 0.99),
    save_pars = save_pars(all = TRUE)
  )

# compare with waic
waic(m_f1_logit,
     m_f1_probit,
     m_f1_logit_no_year)
waic(m_f2_logit,
     m_f2_probit,
     m_f2_logit_no_year)
