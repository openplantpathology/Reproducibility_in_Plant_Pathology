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

m_f1_logit_fit <-
  add_criterion(
    m_f1_logit,
    criterion = "loo",
    moment_match = TRUE,
    reloo = TRUE
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
m_f1_logit_no_year_fit <-
  add_criterion(
    m_f1_logit_no_year,
    criterion = "loo",
    moment_match = TRUE,
    reloo = TRUE
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
loo_f2_logit <- loo(m_f2_logit, save_psis = TRUE)

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
loo_f2_logit_no_year <- loo(m_f2_logit_no_year, save_psis = TRUE)

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
loo_f1_probit <- loo(m_f1_probit, save_psis = TRUE)


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
loo_f2_probit <- loo(m_f2_probit, save_psis = TRUE)

# compare with waic
waic(m_f1_logit,
     m_f1_probit,
     m_f1_logit_no_year)
# Output of model 'm_f1_logit':
#
#   Computed from 40000 by 440 log-likelihood matrix
#
# Estimate   SE
# elpd_waic    -33.7 12.3
# p_waic         8.1  3.7
# waic          67.3 24.7
#
# 5 (1.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#
# Output of model 'm_f1_probit':
#
#   Computed from 40000 by 440 log-likelihood matrix
#
# Estimate   SE
# elpd_waic    -33.8 11.9
# p_waic         9.7  4.1
# waic          67.5 23.9
#
# 5 (1.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#
# Output of model 'm_f1_logit_no_year':
#
#   Computed from 40000 by 440 log-likelihood matrix
#
# Estimate   SE
# elpd_waic    -33.3 12.2
# p_waic         5.8  2.8
# waic          66.6 24.4
#
# 5 (1.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#
# Model comparisons:
#   elpd_diff se_diff
# m_f1_logit_no_year  0.0       0.0
# m_f1_logit         -0.4       0.5
# m_f1_probit        -0.5       1.4
# Warning messages:
#   1:
#   5 (1.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.
# 2:
#   5 (1.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.
# 3:
#   5 (1.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.

waic(m_f2_logit,
     m_f2_probit,
     m_f2_logit_no_year)
#
# Output of model 'm_f2_logit':
#
#   Computed from 40000 by 448 log-likelihood matrix
#
# Estimate   SE
# elpd_waic   -299.5 20.5
# p_waic        23.0  1.9
# waic         599.0 40.9
#
# 2 (0.4%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#
# Output of model 'm_f2_probit':
#
#   Computed from 40000 by 448 log-likelihood matrix
#
# Estimate   SE
# elpd_waic   -300.6 20.7
# p_waic        26.1  2.5
# waic         601.2 41.3
#
# 13 (2.9%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#
# Output of model 'm_f2_logit_no_year':
#
#   Computed from 40000 by 448 log-likelihood matrix
#
# Estimate   SE
# elpd_waic   -299.0 20.4
# p_waic        19.2  1.6
# waic         598.1 40.8
#
# 1 (0.2%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#
# Model comparisons:
#   elpd_diff se_diff
# m_f2_logit_no_year  0.0       0.0
# m_f2_logit         -0.5       1.4
# m_f2_probit        -1.5       1.9
# Warning messages:
#   1:
#   2 (0.4%) p_waic estimates greater than 0.4. We recommend trying loo instead.
# 2:
#   13 (2.9%) p_waic estimates greater than 0.4. We recommend trying loo instead.
# 3:
#   1 (0.2%) p_waic estimates greater than 0.4. We recommend trying loo instead.

# compare with LOO
loo_compare(loo_f1_logit_intercept,
            loo_f1_logit,
            loo_f1_probit,
            loo_f1_logit_no_year)
loo_compare(loo_f2_logit,
            loo_f2_probit,
            loo_f2_logit_no_year)
