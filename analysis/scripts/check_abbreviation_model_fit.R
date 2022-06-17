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

rrpp <- drop_na(rrpp, comp_mthds_avail)

priors <- c(prior(normal(0, 1), class = "b"),
            prior(normal(0, 1), class = "Intercept"))

prior_i_only <- c(prior(normal(0, 1), class = "Intercept"))

m_f1_logit_intercept <-
  brm(
    formula = data_avail ~ 1 +
      (1 | assignee) +
      (1 | year),
    data = rrpp,
    seed = 27,
    prior = prior_i_only,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.999,
                   max_treedepth = 15),
    save_pars = save_pars(all = TRUE)
  )
loo_f1_logit_intercept <-
  loo(m_f1_logit_intercept, save_psis = TRUE)

m_f1_logit <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee) +
      (1 | year),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.999),
    save_pars = save_pars(all = TRUE)
  )
loo_f1_logit <- loo(m_f1_logit, save_psis = TRUE)

m_f1_logit_no_year <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.999),
    save_pars = save_pars(all = TRUE)
  )
loo_f1_logit_no_year <- loo(m_f1_logit_no_year, save_psis = TRUE)


m_f2_logit <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee) +
      (1 | year),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.999),
    save_pars = save_pars(all = TRUE)
  )
loo_f2_logit <- loo(m_f2_logit, save_psis = TRUE)

m_f2_logit_no_year <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    iter = 20000,
    control = list(adapt_delta = 0.999),
    save_pars = save_pars(all = TRUE)
  )
loo_f2_logit_no_year <- loo(m_f2_logit_no_year, save_psis = TRUE)

m_f1_probit <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee) +
      (1 | year),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    iter = 20000,
    control = list(adapt_delta = 0.99),
    save_pars = save_pars(all = TRUE)
  )
loo_f1_probit <- loo(m_f1_probit, save_psis = TRUE)

m_f2_probit <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee) +
      (1 | year),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    iter = 20000,
    control = list(adapt_delta = 0.99),
    save_pars = save_pars(all = TRUE)
  )
loo_f2_probit <- loo(m_f2_probit, save_psis = TRUE)

# compare with waic
waic(m_f1_logit_intercept,
     m_f1_logit,
     m_f1_probit,
     m_f1_logit_no_year)
waic(m_f2_logit,
     m_f2_probit,
     m_f2_logit_no_year)

# compare with LOO
loo_compare(loo_f1_logit_intercept,
            loo_f1_logit,
            loo_f1_probit,
            loo_f1_logit_no_year)
loo_compare(loo_f2_logit,
            loo_f2_probit,
            loo_f2_logit_no_year)
