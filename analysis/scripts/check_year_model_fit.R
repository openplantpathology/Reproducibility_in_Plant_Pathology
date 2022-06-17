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

m_g1_logit <-
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

m_g2_logit <-
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

m_g1_probit <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    iter = 20000,
    control = list(adapt_delta = 0.99),
    save_pars = save_pars(all = TRUE)
  )

m_g2_probit <-
  brm(
    formula = data_avail ~ year +
      (1 | assignee),
    data = rrpp,
    seed = 27,
    prior = priors,
    family = cumulative(link = "probit"),
    iter = 20000,
    control = list(adapt_delta = 0.99),
    save_pars = save_pars(all = TRUE)
  )

m_g1_comparison <- bayesfactor_models(m_g1_logit, m_g1_probit)
m_g2_comparison <- bayesfactor_models(m_g2_logit, m_g2_probit)


# compare with waic
waic(m_g1_logit,
     m_g1_probit)
waic(m_g2_logit,
     m_g2_probit)

# compare with LOO
loo_compare(loo_f1_logit,
            loo_f1_probit)
loo_compare(loo_f2_logit,
            loo_f2_probit)

