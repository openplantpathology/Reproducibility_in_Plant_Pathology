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

cat("m_h1_logit model ")
m_h1_logit <-
  brm(
    formula = data_avail ~ IF_5year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    control = list(adapt_delta = 0.99),
    iter = 20000,
    save_pars = save_pars(all = TRUE)
  )

cat("m_h2_logit model ")
m_h2_logit <-
  brm(
    formula = data_avail ~ IF_5year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "logit"),
    control = list(adapt_delta = 0.9),
    iter = 20000,
    save_pars = save_pars(all = TRUE)
  )

cat("m_h1_probit model ")
m_h1_probit <-
  brm(
    formula = data_avail ~ IF_5year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    control = list(adapt_delta = 0.99),
    iter = 25000,
    save_pars = save_pars(all = TRUE)
  )

cat("m_h2_probit model ")
m_h2_probit <-
  brm(
    formula = data_avail ~ IF_5year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    control = list(adapt_delta = 0.99),
    iter = 25000,
    save_pars = save_pars(all = TRUE)
  )

# compare with waic
waic(m_h1_logit,
     m_h1_probit)
waic(m_h2_logit,
     m_h2_probit)
