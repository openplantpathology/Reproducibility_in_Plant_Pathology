
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Reproducibility in Plant Pathology

![Publish
Docker](https://github.com/openplantpathology/Reproducibility_in_Plant_Pathology/workflows/Publish%20Docker/badge.svg)
[![DOI](https://zenodo.org/badge/62676177.svg)](https://zenodo.org/badge/latestdoi/62676177)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

This repository contains the data and code for our letter:

> Sparks, A.H., Del Ponte, E.M., Alves, K. S., Foster, Z., Grünwald, N.
> J. (YYYY). *Reproducibility in plant pathology: where do we stand and
> a way forward*. Name of journal/book <https://doi.org/xxx/xxx>

Our pre-print is online here:

> Authors, (YYYY). *Reproducibility in plant pathology: where do we
> stand and a way forward*. Name of journal/book, Accessed 29 Sep 2021.
> Online at <https://doi.org/xxx/xxx>

### How to cite

Please cite this compendium as:

> Sparks, A.H., Del Ponte, E.M., Alves, K. S., Foster, Z., Grünwald, N.
> J. (2021). *Compendium of R code and data for ‘Status and Best
> Practices for Reproducible Research In Plant Pathology’*. Accessed 29
> Sep 2021. Online at <https://doi.org/10.5281/zenodo.1250665>

### How to download or install

#### The R package

This repository is organized as an R package. There are custom R
functions, `table_of_journals()` and `workflow_dia()` that are used in
this repository, along with a bibliography file of the articles that
were examined and the notes that are located in `inst/extdata`
directory. We have used the R package structure to help manage
dependencies, to take advantage of continuous integration for automated
code testing and for file organisation.

You can download the compendium as a zip from from this URL:
<https://github.com/openplantpathology/Reproducibility_in_Plant_Pathology/archive/main.zip>

Or you can install this compendium as an R package,
Reproducibility.in.Plant.Pathology, from GitHub with:

``` r
if (!require("remotes"))
  install.packages("remotes")
remotes::install_github("openplantpathology/Reproducibility_in_Plant_Pathology"
)
```

Once the download is complete, open the
`Reproducibility_in_Plant_Pathology.Rproj` in RStudio to begin working
with the package and compendium files.

#### The Docker Instance

Get the latest instance from Dockerhub, launch it and go to
`localhost:8787` in your browser. Login with `rstudio`, password is
`rstudio`.

``` bash
docker pull adamhsparks/reproducibility_in_plant_pathology
docker run -d -p 8787:8787 adamhsparks/reproducibility_in_plant_pathology
```

#### The Paper

The file structure follows a normal R package with one exception. The
top-level “/analysis” directory contains the directories and files
necessary to re-knit the MS Word document of the paper from an Rmd file,
“/analysis/paper/paper.Rmd”.

A script, `knit_paper.R`, is located in `analysis/paper/knit_paper.R`
that will knit the [Word document](analysis/paper/paper.docx) in a
Docker session.

## Meta

### Licensing

Code: [MIT](http://opensource.org/licenses/MIT) year: 2021, copyright
holder: Adam H. Sparks

Data: [CC-0](http://creativecommons.org/publicdomain/zero/1.0/)
attribution requested in reuse

Adam H. Sparks Senior Research Scientist Farming Systems Innovation
Primary Industries Development Department of Primary Industries and
Regional Development Level 6.35, 1 Nash St., Perth WA 6000

<https://adamhsparks.com/>

### Code of Conduct

Please note that the Reproducibility.in.Plant.Pathology project is
released with a [Contributor Code of
Conduct](https://openplantpathology.github.io/Reproducible.Plant.Pathology/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
