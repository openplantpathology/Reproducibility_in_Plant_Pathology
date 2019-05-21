context("doi2bib")

test_that("doi2bib fetches a bib object", {
  expect_equal(doi2bib("10.4454/jpp.fa.2012.002"),
              " @article{F. Suárez-Estrella_M.A. Bustamante_R. Moral_M.C. Vargas-García_M.J. López_J. Moreno_2012, title={IN VITRO CONTROL OF FUSARIUM WILT USING AGROINDUSTRIAL SUBPRODUCT-BASED COMPOSTS}, volume={94}, ISSN={1125-4653}, url={http://doi.org/10.4454/jpp.fa.2012.002}, DOI={10.4454/jpp.fa.2012.002}, number={1}, journal={Journal of Plant Pathology}, author={F. Suárez-Estrella and M.A. Bustamante and R. Moral and M.C. Vargas-García and M.J. López and J. Moreno}, year={2012} }\n")
})
