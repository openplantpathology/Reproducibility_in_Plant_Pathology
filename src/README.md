README
================

Creating a sample of articles
-----------------------------

Twenty journals in the discipline of plant pathology were selected by the authors as being the primary choice for most plant pathologists when publishing manuscripts.

Using the assumption that journals publish an average 10 articles per issue, for a population of ~1000 articles, using a confidence level of 95% and confidence interval of 10% we need 88 samples. In [Issue \#3](https://github.com/adamhsparks/Reproducible-Research-in-Plant-Pathology/issues/3), we decided to select 200 articles to have a large sample of the population.

R setup
-------

Set up the R environment

``` r
library(dplyr)

set.seed(1)
```

Import data
-----------

The list of the top 20 plant pathology journals was retrieved from Google Scholar on December 5, 2016 and saved as a CSV file for reproducibility.

``` r
journal_list <- tibble(
  seq(1:20),
  c("Australasian Plant Pathology",
    "Canadian Journal of Plant Pathology",
    "Crop Protection",
    "European Journal of Plant Pathology",
    "Forest Pathology",
    "Journal of General Plant Pathology",
    "Journal of Phytopathology",
    "Journal of Plant Pathology",
    "Journal of Plant Virology",
    "Molecular Plant Pathology",
    "Nematology",
    "Physiological and Molecular Plant Pathology",
    "Phytoparasitica",
    "Phytopathologia Mediterranea",
    "Phytopathology",
    "Plant Disease",
    "Plant Health Progress",
    "Plant Pathology",
    "Revista Mexicana de Fitopatología",
    "Tropical Plant Pathology"))

names(journal_list) <- c("number", "publication")
```

Create random lists
-------------------

Create a randomised list of the journals

``` r
journals <- tibble(sample(1:20, 200, replace = TRUE))
names(journals) <- "number"
journals <- left_join(journals, journal_list, "number")
```

Randomly select articles
------------------------

Generate a random list of years between 2012 and 2016 and a random list of start pages between 1 and 150 since some journals start numbering at 1 with every issue. Then bind the columns of the randomised list of journals with the randomised years and page start numbers. This then assumes that there is no temporal effect, i.e., the time of year an article is published does not affect whether or not it is reproducible.

``` r
year <- sample(2012:2016, 200, replace = TRUE)

start_page <- sample.int(150, 200, replace = TRUE)

(journals <- cbind(journals, year, start_page)[, -1])
```

    ##                                     publication year start_page
    ## 1            Journal of General Plant Pathology 2013         99
    ## 2                    Journal of Plant Pathology 2013         28
    ## 3   Physiological and Molecular Plant Pathology 2014        144
    ## 4             Revista Mexicana de Fitopatología 2013        135
    ## 5                              Forest Pathology 2012        142
    ## 6                               Plant Pathology 2014        109
    ## 7             Revista Mexicana de Fitopatología 2014         56
    ## 8                  Phytopathologia Mediterranea 2012        118
    ## 9                               Phytoparasitica 2013          2
    ## 10          Canadian Journal of Plant Pathology 2015        142
    ## 11                             Forest Pathology 2016        150
    ## 12          European Journal of Plant Pathology 2012         54
    ## 13                 Phytopathologia Mediterranea 2015        113
    ## 14                   Journal of Plant Pathology 2016        119
    ## 15                                Plant Disease 2016        106
    ## 16                    Molecular Plant Pathology 2013         72
    ## 17                               Phytopathology 2015         75
    ## 18                     Tropical Plant Pathology 2016         47
    ## 19                   Journal of Plant Pathology 2016        105
    ## 20                                Plant Disease 2013        124
    ## 21            Revista Mexicana de Fitopatología 2013         66
    ## 22                             Forest Pathology 2012         78
    ## 23                 Phytopathologia Mediterranea 2013        100
    ## 24                              Crop Protection 2014         22
    ## 25           Journal of General Plant Pathology 2016         52
    ## 26                   Journal of Plant Pathology 2014         61
    ## 27                 Australasian Plant Pathology 2013         13
    ## 28                   Journal of Plant Pathology 2012        140
    ## 29                              Plant Pathology 2014        126
    ## 30                    Journal of Phytopathology 2016        132
    ## 31                    Molecular Plant Pathology 2013        141
    ## 32  Physiological and Molecular Plant Pathology 2012         11
    ## 33                    Molecular Plant Pathology 2013         57
    ## 34          European Journal of Plant Pathology 2015         81
    ## 35                        Plant Health Progress 2013         16
    ## 36                 Phytopathologia Mediterranea 2015        121
    ## 37                                Plant Disease 2015        111
    ## 38                              Crop Protection 2014          8
    ## 39                               Phytopathology 2014         73
    ## 40                    Journal of Plant Virology 2014        139
    ## 41                        Plant Health Progress 2013          7
    ## 42                              Phytoparasitica 2014         45
    ## 43                                Plant Disease 2016         76
    ## 44  Physiological and Molecular Plant Pathology 2012         92
    ## 45                                   Nematology 2014         40
    ## 46                                Plant Disease 2013         64
    ## 47                 Australasian Plant Pathology 2014         55
    ## 48                    Molecular Plant Pathology 2012        142
    ## 49                               Phytopathology 2014         19
    ## 50                 Phytopathologia Mediterranea 2016         11
    ## 51                    Molecular Plant Pathology 2015        145
    ## 52                              Plant Pathology 2016         67
    ## 53                    Journal of Plant Virology 2014         56
    ## 54                             Forest Pathology 2015         26
    ## 55          Canadian Journal of Plant Pathology 2014          9
    ## 56          Canadian Journal of Plant Pathology 2012         99
    ## 57                    Journal of Phytopathology 2013         87
    ## 58                                   Nematology 2014        149
    ## 59                 Phytopathologia Mediterranea 2013         91
    ## 60                    Journal of Plant Virology 2016         10
    ## 61            Revista Mexicana de Fitopatología 2014         25
    ## 62           Journal of General Plant Pathology 2013         72
    ## 63                    Molecular Plant Pathology 2013          1
    ## 64                    Journal of Phytopathology 2015         67
    ## 65                 Phytopathologia Mediterranea 2015         40
    ## 66           Journal of General Plant Pathology 2012        141
    ## 67                    Molecular Plant Pathology 2012        108
    ## 68                                Plant Disease 2015         25
    ## 69          Canadian Journal of Plant Pathology 2015         72
    ## 70                              Plant Pathology 2012        104
    ## 71                    Journal of Phytopathology 2012         70
    ## 72                        Plant Health Progress 2012        144
    ## 73                    Journal of Phytopathology 2013        107
    ## 74                    Journal of Phytopathology 2012         60
    ## 75                    Molecular Plant Pathology 2013         18
    ## 76                              Plant Pathology 2012         37
    ## 77                              Plant Pathology 2013        130
    ## 78                   Journal of Plant Pathology 2012         66
    ## 79                                Plant Disease 2014         75
    ## 80                     Tropical Plant Pathology 2015        104
    ## 81                    Journal of Plant Virology 2012        115
    ## 82                               Phytopathology 2014         24
    ## 83                   Journal of Plant Pathology 2016        128
    ## 84                    Journal of Phytopathology 2013        143
    ## 85                                Plant Disease 2012         89
    ## 86                             Forest Pathology 2012         76
    ## 87                               Phytopathology 2013         29
    ## 88                              Crop Protection 2012          1
    ## 89                             Forest Pathology 2012        132
    ## 90                              Crop Protection 2013         21
    ## 91                             Forest Pathology 2013          4
    ## 92          Canadian Journal of Plant Pathology 2012        141
    ## 93                              Phytoparasitica 2016         44
    ## 94                              Plant Pathology 2013         25
    ## 95                                Plant Disease 2014         60
    ## 96                                Plant Disease 2015         69
    ## 97                    Molecular Plant Pathology 2012         66
    ## 98                    Journal of Plant Virology 2012         78
    ## 99                        Plant Health Progress 2012        127
    ## 100                             Phytoparasitica 2016          9
    ## 101                Phytopathologia Mediterranea 2015         84
    ## 102                  Journal of Plant Pathology 2012        104
    ## 103          Journal of General Plant Pathology 2014         99
    ## 104                    Tropical Plant Pathology 2014        100
    ## 105                             Phytoparasitica 2013         71
    ## 106                            Forest Pathology 2016        146
    ## 107                             Crop Protection 2012         61
    ## 108                   Molecular Plant Pathology 2016        128
    ## 109           Revista Mexicana de Fitopatología 2012        114
    ## 110 Physiological and Molecular Plant Pathology 2014         80
    ## 111                    Tropical Plant Pathology 2012        132
    ## 112                              Phytopathology 2012         71
    ## 113                  Journal of Plant Pathology 2016          2
    ## 114                   Journal of Plant Virology 2015        110
    ## 115                             Crop Protection 2013        108
    ## 116                Australasian Plant Pathology 2014         29
    ## 117                              Phytopathology 2012         97
    ## 118                             Crop Protection 2013         82
    ## 119                   Journal of Plant Virology 2016         51
    ## 120                             Phytoparasitica 2015         96
    ## 121                    Tropical Plant Pathology 2015        125
    ## 122                   Molecular Plant Pathology 2013        107
    ## 123                   Molecular Plant Pathology 2014         53
    ## 124         European Journal of Plant Pathology 2016         20
    ## 125                               Plant Disease 2016         59
    ## 126                   Molecular Plant Pathology 2016        140
    ## 127                                  Nematology 2016        121
    ## 128                            Forest Pathology 2015        114
    ## 129                            Forest Pathology 2013        144
    ## 130 Physiological and Molecular Plant Pathology 2015        150
    ## 131 Physiological and Molecular Plant Pathology 2016         91
    ## 132         Canadian Journal of Plant Pathology 2013          5
    ## 133                Australasian Plant Pathology 2013         51
    ## 134                             Phytoparasitica 2016         42
    ## 135           Revista Mexicana de Fitopatología 2012         18
    ## 136 Physiological and Molecular Plant Pathology 2013          7
    ## 137 Physiological and Molecular Plant Pathology 2014         56
    ## 138                                  Nematology 2012         51
    ## 139                    Tropical Plant Pathology 2014         27
    ## 140                                  Nematology 2016         94
    ## 141                Phytopathologia Mediterranea 2016         60
    ## 142                             Phytoparasitica 2012        144
    ## 143                            Forest Pathology 2014         99
    ## 144          Journal of General Plant Pathology 2013         50
    ## 145                              Phytopathology 2015         30
    ## 146                   Molecular Plant Pathology 2013         18
    ## 147         European Journal of Plant Pathology 2014        150
    ## 148                              Phytopathology 2012         57
    ## 149                             Crop Protection 2013         85
    ## 150                             Plant Pathology 2015        110
    ## 151                             Phytoparasitica 2014        131
    ## 152 Physiological and Molecular Plant Pathology 2012         86
    ## 153                   Journal of Phytopathology 2015          2
    ## 154                   Molecular Plant Pathology 2014        136
    ## 155                                  Nematology 2016        116
    ## 156         European Journal of Plant Pathology 2013         58
    ## 157                                  Nematology 2016         15
    ## 158         Canadian Journal of Plant Pathology 2012          8
    ## 159          Journal of General Plant Pathology 2016        124
    ## 160                            Forest Pathology 2014        125
    ## 161          Journal of General Plant Pathology 2012         99
    ## 162                             Plant Pathology 2013         20
    ## 163                   Journal of Plant Virology 2016         52
    ## 164                               Plant Disease 2013        110
    ## 165                             Plant Pathology 2014        137
    ## 166                   Journal of Plant Virology 2016        105
    ## 167         Canadian Journal of Plant Pathology 2012         37
    ## 168                   Journal of Phytopathology 2015         97
    ## 169                              Phytopathology 2015         43
    ## 170                   Journal of Phytopathology 2014        144
    ## 171                             Phytoparasitica 2014         24
    ## 172                       Plant Health Progress 2014         63
    ## 173                             Plant Pathology 2016         38
    ## 174                  Journal of Plant Pathology 2013         15
    ## 175                  Journal of Plant Pathology 2013        125
    ## 176                             Plant Pathology 2014         79
    ## 177                             Phytoparasitica 2013        101
    ## 178                              Phytopathology 2016         62
    ## 179                             Phytoparasitica 2012        127
    ## 180           Revista Mexicana de Fitopatología 2014        111
    ## 181          Journal of General Plant Pathology 2014         53
    ## 182         European Journal of Plant Pathology 2014        143
    ## 183                             Plant Pathology 2015         98
    ## 184                                  Nematology 2016          6
    ## 185                             Plant Pathology 2013         90
    ## 186         European Journal of Plant Pathology 2013         63
    ## 187                               Plant Disease 2015         12
    ## 188                              Phytopathology 2016         80
    ## 189           Revista Mexicana de Fitopatología 2012        145
    ## 190                                  Nematology 2016        107
    ## 191                              Phytopathology 2012         84
    ## 192                  Journal of Plant Pathology 2012         37
    ## 193                             Crop Protection 2016        117
    ## 194           Revista Mexicana de Fitopatología 2014         98
    ## 195          Journal of General Plant Pathology 2012        125
    ## 196 Physiological and Molecular Plant Pathology 2013         98
    ## 197                             Crop Protection 2015         72
    ## 198                       Plant Health Progress 2013         75
    ## 199                   Journal of Phytopathology 2013         57
    ## 200                               Plant Disease 2012         68

Check the number of articles per journal
----------------------------------------

``` r
journals %>%  
 group_by(publication) %>% 
    tally(sort = TRUE) 
```

    ## # A tibble: 20 × 2
    ##                                    publication     n
    ##                                          <chr> <int>
    ## 1                    Molecular Plant Pathology    15
    ## 2                                Plant Disease    14
    ## 3                              Plant Pathology    14
    ## 4                               Phytopathology    13
    ## 5                             Forest Pathology    12
    ## 6                   Journal of Plant Pathology    12
    ## 7                              Phytoparasitica    12
    ## 8                    Journal of Phytopathology    11
    ## 9                              Crop Protection    10
    ## 10          Journal of General Plant Pathology    10
    ## 11 Physiological and Molecular Plant Pathology    10
    ## 12                   Journal of Plant Virology     9
    ## 13                                  Nematology     9
    ## 14                Phytopathologia Mediterranea     9
    ## 15           Revista Mexicana de Fitopatología     9
    ## 16         Canadian Journal of Plant Pathology     8
    ## 17         European Journal of Plant Pathology     7
    ## 18                       Plant Health Progress     6
    ## 19                    Tropical Plant Pathology     6
    ## 20                Australasian Plant Pathology     4

R Session Info
--------------

``` r
sessionInfo()
```

    ## R version 3.3.3 (2017-03-06)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: OS X El Capitan 10.11.6
    ## 
    ## locale:
    ## [1] en_AU.UTF-8/en_AU.UTF-8/en_AU.UTF-8/C/en_AU.UTF-8/en_AU.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] dplyr_0.5.0
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.10         digest_0.6.12        rprojroot_1.2       
    ##  [4] assertthat_0.1       R6_2.2.0             DBI_0.6-1           
    ##  [7] backports_1.0.5      magrittr_1.5         evaluate_0.10       
    ## [10] stringi_1.1.5        lazyeval_0.2.0       rmarkdown_1.4.0.9001
    ## [13] tools_3.3.3          stringr_1.2.0        yaml_2.1.14         
    ## [16] htmltools_0.3.5      knitr_1.15.1         tibble_1.3.0
