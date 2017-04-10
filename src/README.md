README
================

Creating a sample of articles
-----------------------------

Twenty journals in the discipline of plant pathology were selected by the assignee as being the primary choice for most plant pathologists when publishing manuscripts.

Using the assumption that journals publish an average 10 articles per issue, for a population of ~1000 articles, using a confidence level of 95% and confidence interval of 10% we need 88 samples. In [Issue \#3](https://github.com/adamhsparks/Reproducible-Research-in-Plant-Pathology/issues/3), we decided to select 200 articles to have a large sample of the population.

R setup
-------

Set up the R environment

``` r
library(dplyr)

set.seed(1)
```

Create list of journals
-----------------------

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

Create list of assignees
------------------------

From the four authors of this paper, create a list for us to use that will randomly assign articles for us to evaluate for this manuscript.

``` r
assignee <- rep(c("Adam", "Emerson", "Zach", "Nik"), 50)
```

Create random lists
-------------------

### Create a randomised list of the journals

``` r
journals <- tibble(sample(1:20, 200, replace = TRUE))
names(journals) <- "number"
journals <- left_join(journals, journal_list, "number")
```

### Randomly select articles

Generate a random list of years between 2012 and 2016 and a random list of start pages between 1 and 150 since some journals start numbering at 1 with every issue. Then bind the columns of the randomised list of journals with the randomised years and page start numbers. This then assumes that there is no temporal effect, *i.e.*, the time of year an article is published does not affect whether or not it is reproducible.

``` r
year <- sample(2012:2016, 200, replace = TRUE)

start_page <- sample.int(150, 200, replace = TRUE)

journals <- cbind(journals[, -1], year, start_page, assignee)

arrange(journals, assignee)
```

    ##                                     publication year start_page assignee
    ## 1            Journal of General Plant Pathology 2013         99     Adam
    ## 2                              Forest Pathology 2012        142     Adam
    ## 3                               Phytoparasitica 2013          2     Adam
    ## 4                  Phytopathologia Mediterranea 2015        113     Adam
    ## 5                                Phytopathology 2015         75     Adam
    ## 6             Revista Mexicana de Fitopatología 2013         66     Adam
    ## 7            Journal of General Plant Pathology 2016         52     Adam
    ## 8                               Plant Pathology 2014        126     Adam
    ## 9                     Molecular Plant Pathology 2013         57     Adam
    ## 10                                Plant Disease 2015        111     Adam
    ## 11                        Plant Health Progress 2013          7     Adam
    ## 12                                   Nematology 2014         40     Adam
    ## 13                               Phytopathology 2014         19     Adam
    ## 14                    Journal of Plant Virology 2014         56     Adam
    ## 15                    Journal of Phytopathology 2013         87     Adam
    ## 16            Revista Mexicana de Fitopatología 2014         25     Adam
    ## 17                 Phytopathologia Mediterranea 2015         40     Adam
    ## 18          Canadian Journal of Plant Pathology 2015         72     Adam
    ## 19                    Journal of Phytopathology 2013        107     Adam
    ## 20                              Plant Pathology 2013        130     Adam
    ## 21                    Journal of Plant Virology 2012        115     Adam
    ## 22                                Plant Disease 2012         89     Adam
    ## 23                             Forest Pathology 2012        132     Adam
    ## 24                              Phytoparasitica 2016         44     Adam
    ## 25                    Molecular Plant Pathology 2012         66     Adam
    ## 26                 Phytopathologia Mediterranea 2015         84     Adam
    ## 27                              Phytoparasitica 2013         71     Adam
    ## 28            Revista Mexicana de Fitopatología 2012        114     Adam
    ## 29                   Journal of Plant Pathology 2016          2     Adam
    ## 30                               Phytopathology 2012         97     Adam
    ## 31                     Tropical Plant Pathology 2015        125     Adam
    ## 32                                Plant Disease 2016         59     Adam
    ## 33                             Forest Pathology 2013        144     Adam
    ## 34                 Australasian Plant Pathology 2013         51     Adam
    ## 35  Physiological and Molecular Plant Pathology 2014         56     Adam
    ## 36                 Phytopathologia Mediterranea 2016         60     Adam
    ## 37                               Phytopathology 2015         30     Adam
    ## 38                              Crop Protection 2013         85     Adam
    ## 39                    Journal of Phytopathology 2015          2     Adam
    ## 40                                   Nematology 2016         15     Adam
    ## 41           Journal of General Plant Pathology 2012         99     Adam
    ## 42                              Plant Pathology 2014        137     Adam
    ## 43                               Phytopathology 2015         43     Adam
    ## 44                              Plant Pathology 2016         38     Adam
    ## 45                              Phytoparasitica 2013        101     Adam
    ## 46           Journal of General Plant Pathology 2014         53     Adam
    ## 47                              Plant Pathology 2013         90     Adam
    ## 48            Revista Mexicana de Fitopatología 2012        145     Adam
    ## 49                              Crop Protection 2016        117     Adam
    ## 50                              Crop Protection 2015         72     Adam
    ## 51                   Journal of Plant Pathology 2013         28  Emerson
    ## 52                              Plant Pathology 2014        109  Emerson
    ## 53          Canadian Journal of Plant Pathology 2015        142  Emerson
    ## 54                   Journal of Plant Pathology 2016        119  Emerson
    ## 55                     Tropical Plant Pathology 2016         47  Emerson
    ## 56                             Forest Pathology 2012         78  Emerson
    ## 57                   Journal of Plant Pathology 2014         61  Emerson
    ## 58                    Journal of Phytopathology 2016        132  Emerson
    ## 59          European Journal of Plant Pathology 2015         81  Emerson
    ## 60                              Crop Protection 2014          8  Emerson
    ## 61                              Phytoparasitica 2014         45  Emerson
    ## 62                                Plant Disease 2013         64  Emerson
    ## 63                 Phytopathologia Mediterranea 2016         11  Emerson
    ## 64                             Forest Pathology 2015         26  Emerson
    ## 65                                   Nematology 2014        149  Emerson
    ## 66           Journal of General Plant Pathology 2013         72  Emerson
    ## 67           Journal of General Plant Pathology 2012        141  Emerson
    ## 68                              Plant Pathology 2012        104  Emerson
    ## 69                    Journal of Phytopathology 2012         60  Emerson
    ## 70                   Journal of Plant Pathology 2012         66  Emerson
    ## 71                               Phytopathology 2014         24  Emerson
    ## 72                             Forest Pathology 2012         76  Emerson
    ## 73                              Crop Protection 2013         21  Emerson
    ## 74                              Plant Pathology 2013         25  Emerson
    ## 75                    Journal of Plant Virology 2012         78  Emerson
    ## 76                   Journal of Plant Pathology 2012        104  Emerson
    ## 77                             Forest Pathology 2016        146  Emerson
    ## 78  Physiological and Molecular Plant Pathology 2014         80  Emerson
    ## 79                    Journal of Plant Virology 2015        110  Emerson
    ## 80                              Crop Protection 2013         82  Emerson
    ## 81                    Molecular Plant Pathology 2013        107  Emerson
    ## 82                    Molecular Plant Pathology 2016        140  Emerson
    ## 83  Physiological and Molecular Plant Pathology 2015        150  Emerson
    ## 84                              Phytoparasitica 2016         42  Emerson
    ## 85                                   Nematology 2012         51  Emerson
    ## 86                              Phytoparasitica 2012        144  Emerson
    ## 87                    Molecular Plant Pathology 2013         18  Emerson
    ## 88                              Plant Pathology 2015        110  Emerson
    ## 89                    Molecular Plant Pathology 2014        136  Emerson
    ## 90          Canadian Journal of Plant Pathology 2012          8  Emerson
    ## 91                              Plant Pathology 2013         20  Emerson
    ## 92                    Journal of Plant Virology 2016        105  Emerson
    ## 93                    Journal of Phytopathology 2014        144  Emerson
    ## 94                   Journal of Plant Pathology 2013         15  Emerson
    ## 95                               Phytopathology 2016         62  Emerson
    ## 96          European Journal of Plant Pathology 2014        143  Emerson
    ## 97          European Journal of Plant Pathology 2013         63  Emerson
    ## 98                                   Nematology 2016        107  Emerson
    ## 99            Revista Mexicana de Fitopatología 2014         98  Emerson
    ## 100                       Plant Health Progress 2013         75  Emerson
    ## 101           Revista Mexicana de Fitopatología 2013        135      Nik
    ## 102                Phytopathologia Mediterranea 2012        118      Nik
    ## 103         European Journal of Plant Pathology 2012         54      Nik
    ## 104                   Molecular Plant Pathology 2013         72      Nik
    ## 105                               Plant Disease 2013        124      Nik
    ## 106                             Crop Protection 2014         22      Nik
    ## 107                  Journal of Plant Pathology 2012        140      Nik
    ## 108 Physiological and Molecular Plant Pathology 2012         11      Nik
    ## 109                Phytopathologia Mediterranea 2015        121      Nik
    ## 110                   Journal of Plant Virology 2014        139      Nik
    ## 111 Physiological and Molecular Plant Pathology 2012         92      Nik
    ## 112                   Molecular Plant Pathology 2012        142      Nik
    ## 113                             Plant Pathology 2016         67      Nik
    ## 114         Canadian Journal of Plant Pathology 2012         99      Nik
    ## 115                   Journal of Plant Virology 2016         10      Nik
    ## 116                   Journal of Phytopathology 2015         67      Nik
    ## 117                               Plant Disease 2015         25      Nik
    ## 118                       Plant Health Progress 2012        144      Nik
    ## 119                             Plant Pathology 2012         37      Nik
    ## 120                    Tropical Plant Pathology 2015        104      Nik
    ## 121                   Journal of Phytopathology 2013        143      Nik
    ## 122                             Crop Protection 2012          1      Nik
    ## 123         Canadian Journal of Plant Pathology 2012        141      Nik
    ## 124                               Plant Disease 2015         69      Nik
    ## 125                             Phytoparasitica 2016          9      Nik
    ## 126                    Tropical Plant Pathology 2014        100      Nik
    ## 127                   Molecular Plant Pathology 2016        128      Nik
    ## 128                              Phytopathology 2012         71      Nik
    ## 129                Australasian Plant Pathology 2014         29      Nik
    ## 130                             Phytoparasitica 2015         96      Nik
    ## 131         European Journal of Plant Pathology 2016         20      Nik
    ## 132                            Forest Pathology 2015        114      Nik
    ## 133         Canadian Journal of Plant Pathology 2013          5      Nik
    ## 134 Physiological and Molecular Plant Pathology 2013          7      Nik
    ## 135                                  Nematology 2016         94      Nik
    ## 136          Journal of General Plant Pathology 2013         50      Nik
    ## 137                              Phytopathology 2012         57      Nik
    ## 138 Physiological and Molecular Plant Pathology 2012         86      Nik
    ## 139         European Journal of Plant Pathology 2013         58      Nik
    ## 140                            Forest Pathology 2014        125      Nik
    ## 141                               Plant Disease 2013        110      Nik
    ## 142                   Journal of Phytopathology 2015         97      Nik
    ## 143                       Plant Health Progress 2014         63      Nik
    ## 144                             Plant Pathology 2014         79      Nik
    ## 145           Revista Mexicana de Fitopatología 2014        111      Nik
    ## 146                                  Nematology 2016          6      Nik
    ## 147                              Phytopathology 2016         80      Nik
    ## 148                  Journal of Plant Pathology 2012         37      Nik
    ## 149 Physiological and Molecular Plant Pathology 2013         98      Nik
    ## 150                               Plant Disease 2012         68      Nik
    ## 151 Physiological and Molecular Plant Pathology 2014        144     Zach
    ## 152           Revista Mexicana de Fitopatología 2014         56     Zach
    ## 153                            Forest Pathology 2016        150     Zach
    ## 154                               Plant Disease 2016        106     Zach
    ## 155                  Journal of Plant Pathology 2016        105     Zach
    ## 156                Phytopathologia Mediterranea 2013        100     Zach
    ## 157                Australasian Plant Pathology 2013         13     Zach
    ## 158                   Molecular Plant Pathology 2013        141     Zach
    ## 159                       Plant Health Progress 2013         16     Zach
    ## 160                              Phytopathology 2014         73     Zach
    ## 161                               Plant Disease 2016         76     Zach
    ## 162                Australasian Plant Pathology 2014         55     Zach
    ## 163                   Molecular Plant Pathology 2015        145     Zach
    ## 164         Canadian Journal of Plant Pathology 2014          9     Zach
    ## 165                Phytopathologia Mediterranea 2013         91     Zach
    ## 166                   Molecular Plant Pathology 2013          1     Zach
    ## 167                   Molecular Plant Pathology 2012        108     Zach
    ## 168                   Journal of Phytopathology 2012         70     Zach
    ## 169                   Molecular Plant Pathology 2013         18     Zach
    ## 170                               Plant Disease 2014         75     Zach
    ## 171                  Journal of Plant Pathology 2016        128     Zach
    ## 172                              Phytopathology 2013         29     Zach
    ## 173                            Forest Pathology 2013          4     Zach
    ## 174                               Plant Disease 2014         60     Zach
    ## 175                       Plant Health Progress 2012        127     Zach
    ## 176          Journal of General Plant Pathology 2014         99     Zach
    ## 177                             Crop Protection 2012         61     Zach
    ## 178                    Tropical Plant Pathology 2012        132     Zach
    ## 179                             Crop Protection 2013        108     Zach
    ## 180                   Journal of Plant Virology 2016         51     Zach
    ## 181                   Molecular Plant Pathology 2014         53     Zach
    ## 182                                  Nematology 2016        121     Zach
    ## 183 Physiological and Molecular Plant Pathology 2016         91     Zach
    ## 184           Revista Mexicana de Fitopatología 2012         18     Zach
    ## 185                    Tropical Plant Pathology 2014         27     Zach
    ## 186                            Forest Pathology 2014         99     Zach
    ## 187         European Journal of Plant Pathology 2014        150     Zach
    ## 188                             Phytoparasitica 2014        131     Zach
    ## 189                                  Nematology 2016        116     Zach
    ## 190          Journal of General Plant Pathology 2016        124     Zach
    ## 191                   Journal of Plant Virology 2016         52     Zach
    ## 192         Canadian Journal of Plant Pathology 2012         37     Zach
    ## 193                             Phytoparasitica 2014         24     Zach
    ## 194                  Journal of Plant Pathology 2013        125     Zach
    ## 195                             Phytoparasitica 2012        127     Zach
    ## 196                             Plant Pathology 2015         98     Zach
    ## 197                               Plant Disease 2015         12     Zach
    ## 198                              Phytopathology 2012         84     Zach
    ## 199          Journal of General Plant Pathology 2012        125     Zach
    ## 200                   Journal of Phytopathology 2013         57     Zach

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
