README
================

Creating a sample of articles
-----------------------------

Twenty one journals in the discipline of plant pathology were selected by the four authors as being the primary choice for most plant pathologists when publishing manuscripts.

Using the assumption that journals publish an average 10 articles per issue, for a population of ~1000 articles, using a confidence level of 95% and confidence interval of 10% we need 88 samples. In [Issue \#3](https://github.com/adamhsparks/Reproducible-Research-in-Plant-Pathology/issues/3), we decided to select 200 articles to have a large sample of the population.

R setup
-------

Set up the R environment

``` r
library(dplyr)

set.seed(1)

# For printing tibble in total
options(tibble.print_max = 21, tibble.print_min = 21)
```

Create list of journals
-----------------------

``` r
journal_list <- tibble(
  seq(1:21),
  c("Australasian Plant Pathology",
    "Canadian Journal of Plant Pathology",
    "Crop Protection",
    "European Journal of Plant Pathology",
    "Forest Pathology",
    "Journal of General Plant Pathology",
    "Journal of Phytopathology",
    "Journal of Plant Pathology",
    "Journal of Plant Virology",
    "Molecular Plant-Microbe Interactions",
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
journals <- tibble(sample(1:21, 200, replace = TRUE))
names(journals) <- "number"
journals <- left_join(journals, journal_list, "number")
```

### Randomly select articles

Generate a random list of years between 2012 and 2016 and a random list of start pages between 1 and 150 since some journals start numbering at 1 with every issue. Then bind the columns of the randomised list of journals with the randomised years and page start numbers. This then assumes that there is no temporal effect, *i.e.*, the time of year an article is published does not affect whether or not it is reproducible.

``` r
year <- sample(2012:2016, 200, replace = TRUE)

start_page <- sample.int(150, 200, replace = TRUE)

journals <- cbind(journals[, -1], year, start_page, assignee)

arrange(journals, publication, year, start_page)
```

    ##                                     publication year start_page assignee
    ## 1                  Australasian Plant Pathology 2013         13     Zach
    ## 2                  Australasian Plant Pathology 2013         51     Adam
    ## 3                  Australasian Plant Pathology 2014         29      Nik
    ## 4                  Australasian Plant Pathology 2014         55     Zach
    ## 5           Canadian Journal of Plant Pathology 2012          8  Emerson
    ## 6           Canadian Journal of Plant Pathology 2012         37     Zach
    ## 7           Canadian Journal of Plant Pathology 2012        141      Nik
    ## 8           Canadian Journal of Plant Pathology 2013          5      Nik
    ## 9           Canadian Journal of Plant Pathology 2014          9     Zach
    ## 10          Canadian Journal of Plant Pathology 2015         72     Adam
    ## 11          Canadian Journal of Plant Pathology 2015        142  Emerson
    ## 12                              Crop Protection 2012          1      Nik
    ## 13                              Crop Protection 2012         61     Zach
    ## 14                              Crop Protection 2012         99      Nik
    ## 15                              Crop Protection 2013         82  Emerson
    ## 16                              Crop Protection 2013         85     Adam
    ## 17                              Crop Protection 2014          8  Emerson
    ## 18                              Crop Protection 2014         22      Nik
    ## 19                              Crop Protection 2015         72     Adam
    ## 20                              Crop Protection 2016        117     Adam
    ## 21          European Journal of Plant Pathology 2012         54      Nik
    ## 22          European Journal of Plant Pathology 2013         21  Emerson
    ## 23          European Journal of Plant Pathology 2013         58      Nik
    ## 24          European Journal of Plant Pathology 2013         63  Emerson
    ## 25          European Journal of Plant Pathology 2013        108     Zach
    ## 26          European Journal of Plant Pathology 2014        150     Zach
    ## 27          European Journal of Plant Pathology 2015         81  Emerson
    ## 28          European Journal of Plant Pathology 2016         20      Nik
    ## 29                             Forest Pathology 2012         76  Emerson
    ## 30                             Forest Pathology 2012         78  Emerson
    ## 31                             Forest Pathology 2012        142     Adam
    ## 32                             Forest Pathology 2013        144     Adam
    ## 33                             Forest Pathology 2014        125      Nik
    ## 34                             Forest Pathology 2014        143  Emerson
    ## 35                             Forest Pathology 2015        114      Nik
    ## 36                             Forest Pathology 2016        146  Emerson
    ## 37                             Forest Pathology 2016        150     Zach
    ## 38           Journal of General Plant Pathology 2012         99     Adam
    ## 39           Journal of General Plant Pathology 2012        125     Zach
    ## 40           Journal of General Plant Pathology 2012        132     Adam
    ## 41           Journal of General Plant Pathology 2012        141  Emerson
    ## 42           Journal of General Plant Pathology 2013          4     Zach
    ## 43           Journal of General Plant Pathology 2013         50      Nik
    ## 44           Journal of General Plant Pathology 2013         99     Adam
    ## 45           Journal of General Plant Pathology 2014         99     Zach
    ## 46           Journal of General Plant Pathology 2014         99     Zach
    ## 47           Journal of General Plant Pathology 2015         26  Emerson
    ## 48           Journal of General Plant Pathology 2016         52     Adam
    ## 49           Journal of General Plant Pathology 2016        124     Zach
    ## 50                    Journal of Phytopathology 2013         57     Zach
    ## 51                    Journal of Phytopathology 2013         72  Emerson
    ## 52                    Journal of Phytopathology 2013         87     Adam
    ## 53                    Journal of Phytopathology 2013        143      Nik
    ## 54                    Journal of Phytopathology 2014         53     Adam
    ## 55                    Journal of Phytopathology 2015          2     Adam
    ## 56                    Journal of Phytopathology 2015         67      Nik
    ## 57                   Journal of Plant Pathology 2012         60  Emerson
    ## 58                   Journal of Plant Pathology 2012         70     Zach
    ## 59                   Journal of Plant Pathology 2012        104  Emerson
    ## 60                   Journal of Plant Pathology 2013         28  Emerson
    ## 61                   Journal of Plant Pathology 2013        107     Adam
    ## 62                   Journal of Plant Pathology 2013        125     Zach
    ## 63                   Journal of Plant Pathology 2014        144  Emerson
    ## 64                   Journal of Plant Pathology 2015         97      Nik
    ## 65                   Journal of Plant Pathology 2016          2     Adam
    ## 66                   Journal of Plant Pathology 2016        105     Zach
    ## 67                   Journal of Plant Pathology 2016        132  Emerson
    ## 68                    Journal of Plant Virology 2012         37      Nik
    ## 69                    Journal of Plant Virology 2012         66  Emerson
    ## 70                    Journal of Plant Virology 2012         78  Emerson
    ## 71                    Journal of Plant Virology 2012        140      Nik
    ## 72                    Journal of Plant Virology 2013         15  Emerson
    ## 73                    Journal of Plant Virology 2014         61  Emerson
    ## 74                    Journal of Plant Virology 2014        139      Nik
    ## 75                    Journal of Plant Virology 2016         10      Nik
    ## 76                    Journal of Plant Virology 2016        105  Emerson
    ## 77                    Journal of Plant Virology 2016        119  Emerson
    ## 78                    Journal of Plant Virology 2016        128     Zach
    ## 79                    Molecular Plant Pathology 2012        108     Zach
    ## 80                    Molecular Plant Pathology 2012        142      Nik
    ## 81                    Molecular Plant Pathology 2013         18     Zach
    ## 82                    Molecular Plant Pathology 2013         57     Adam
    ## 83                    Molecular Plant Pathology 2013         72      Nik
    ## 84                    Molecular Plant Pathology 2013        107  Emerson
    ## 85                    Molecular Plant Pathology 2013        141     Zach
    ## 86                    Molecular Plant Pathology 2014         53     Zach
    ## 87                    Molecular Plant Pathology 2014        149  Emerson
    ## 88                    Molecular Plant Pathology 2015        145     Zach
    ## 89                    Molecular Plant Pathology 2016          6      Nik
    ## 90                    Molecular Plant Pathology 2016         94      Nik
    ## 91                    Molecular Plant Pathology 2016        116     Zach
    ## 92                    Molecular Plant Pathology 2016        121     Zach
    ## 93                    Molecular Plant Pathology 2016        128      Nik
    ## 94         Molecular Plant-Microbe Interactions 2012         66     Adam
    ## 95         Molecular Plant-Microbe Interactions 2012        115     Adam
    ## 96         Molecular Plant-Microbe Interactions 2013          1     Zach
    ## 97         Molecular Plant-Microbe Interactions 2013         18  Emerson
    ## 98         Molecular Plant-Microbe Interactions 2014         56     Adam
    ## 99         Molecular Plant-Microbe Interactions 2014        136  Emerson
    ## 100        Molecular Plant-Microbe Interactions 2015        110  Emerson
    ## 101        Molecular Plant-Microbe Interactions 2016         51     Zach
    ## 102        Molecular Plant-Microbe Interactions 2016         52     Zach
    ## 103        Molecular Plant-Microbe Interactions 2016        140  Emerson
    ## 104                                  Nematology 2012         51  Emerson
    ## 105                                  Nematology 2012         86      Nik
    ## 106                                  Nematology 2012         92      Nik
    ## 107                                  Nematology 2014         40     Adam
    ## 108                                  Nematology 2014         56     Adam
    ## 109                                  Nematology 2016         15     Adam
    ## 110                                  Nematology 2016        107  Emerson
    ## 111 Physiological and Molecular Plant Pathology 2012         11      Nik
    ## 112 Physiological and Molecular Plant Pathology 2012        127     Zach
    ## 113 Physiological and Molecular Plant Pathology 2012        144  Emerson
    ## 114 Physiological and Molecular Plant Pathology 2013          7      Nik
    ## 115 Physiological and Molecular Plant Pathology 2013         98      Nik
    ## 116 Physiological and Molecular Plant Pathology 2014         80  Emerson
    ## 117 Physiological and Molecular Plant Pathology 2014        131     Zach
    ## 118 Physiological and Molecular Plant Pathology 2014        144     Zach
    ## 119 Physiological and Molecular Plant Pathology 2015        150  Emerson
    ## 120 Physiological and Molecular Plant Pathology 2016          9      Nik
    ## 121 Physiological and Molecular Plant Pathology 2016         91     Zach
    ## 122                             Phytoparasitica 2012        118      Nik
    ## 123                             Phytoparasitica 2013          2     Adam
    ## 124                             Phytoparasitica 2013         71     Adam
    ## 125                             Phytoparasitica 2013         91     Zach
    ## 126                             Phytoparasitica 2013        100     Zach
    ## 127                             Phytoparasitica 2013        101     Adam
    ## 128                             Phytoparasitica 2014         24     Zach
    ## 129                             Phytoparasitica 2014         45  Emerson
    ## 130                             Phytoparasitica 2015         40     Adam
    ## 131                             Phytoparasitica 2015         84     Adam
    ## 132                             Phytoparasitica 2015         96      Nik
    ## 133                             Phytoparasitica 2016         42  Emerson
    ## 134                             Phytoparasitica 2016         44     Adam
    ## 135                Phytopathologia Mediterranea 2012         84     Zach
    ## 136                Phytopathologia Mediterranea 2013         29     Zach
    ## 137                Phytopathologia Mediterranea 2014         24  Emerson
    ## 138                Phytopathologia Mediterranea 2015        113     Adam
    ## 139                Phytopathologia Mediterranea 2015        121      Nik
    ## 140                Phytopathologia Mediterranea 2016         11  Emerson
    ## 141                Phytopathologia Mediterranea 2016         60     Adam
    ## 142                              Phytopathology 2012         57      Nik
    ## 143                              Phytopathology 2012         71      Nik
    ## 144                              Phytopathology 2012         89     Adam
    ## 145                              Phytopathology 2012         97     Adam
    ## 146                              Phytopathology 2014         19     Adam
    ## 147                              Phytopathology 2014         73     Zach
    ## 148                              Phytopathology 2015         12     Zach
    ## 149                              Phytopathology 2015         30     Adam
    ## 150                              Phytopathology 2015         43     Adam
    ## 151                              Phytopathology 2015         75     Adam
    ## 152                              Phytopathology 2016         59     Adam
    ## 153                              Phytopathology 2016         62  Emerson
    ## 154                              Phytopathology 2016         80      Nik
    ## 155                               Plant Disease 2012         68      Nik
    ## 156                               Plant Disease 2013         64  Emerson
    ## 157                               Plant Disease 2013        110      Nik
    ## 158                               Plant Disease 2013        124      Nik
    ## 159                               Plant Disease 2014         60     Zach
    ## 160                               Plant Disease 2014         75     Zach
    ## 161                               Plant Disease 2015         25      Nik
    ## 162                               Plant Disease 2015         69      Nik
    ## 163                               Plant Disease 2015        111     Adam
    ## 164                               Plant Disease 2016         76     Zach
    ## 165                               Plant Disease 2016        106     Zach
    ## 166                       Plant Health Progress 2012        127     Zach
    ## 167                       Plant Health Progress 2012        144      Nik
    ## 168                       Plant Health Progress 2013          7     Adam
    ## 169                       Plant Health Progress 2013         16     Zach
    ## 170                       Plant Health Progress 2013         75  Emerson
    ## 171                       Plant Health Progress 2014         63      Nik
    ## 172                       Plant Health Progress 2016         38     Adam
    ## 173                             Plant Pathology 2012         37      Nik
    ## 174                             Plant Pathology 2012        104  Emerson
    ## 175                             Plant Pathology 2013         20  Emerson
    ## 176                             Plant Pathology 2013         25  Emerson
    ## 177                             Plant Pathology 2013         90     Adam
    ## 178                             Plant Pathology 2013        130     Adam
    ## 179                             Plant Pathology 2014         79      Nik
    ## 180                             Plant Pathology 2014        109  Emerson
    ## 181                             Plant Pathology 2014        111      Nik
    ## 182                             Plant Pathology 2014        126     Adam
    ## 183                             Plant Pathology 2014        137     Adam
    ## 184                             Plant Pathology 2015         98     Zach
    ## 185                             Plant Pathology 2015        110  Emerson
    ## 186                             Plant Pathology 2016         67      Nik
    ## 187           Revista Mexicana de Fitopatología 2012         18     Zach
    ## 188           Revista Mexicana de Fitopatología 2012        114     Adam
    ## 189           Revista Mexicana de Fitopatología 2012        145     Adam
    ## 190           Revista Mexicana de Fitopatología 2013         66     Adam
    ## 191           Revista Mexicana de Fitopatología 2013        135      Nik
    ## 192           Revista Mexicana de Fitopatología 2014         25     Adam
    ## 193           Revista Mexicana de Fitopatología 2014         56     Zach
    ## 194           Revista Mexicana de Fitopatología 2014         98  Emerson
    ## 195                    Tropical Plant Pathology 2012        132     Zach
    ## 196                    Tropical Plant Pathology 2014         27     Zach
    ## 197                    Tropical Plant Pathology 2014        100      Nik
    ## 198                    Tropical Plant Pathology 2015        104      Nik
    ## 199                    Tropical Plant Pathology 2015        125     Adam
    ## 200                    Tropical Plant Pathology 2016         47  Emerson

Check the number of articles per journal
----------------------------------------

``` r
journals %>%  
  group_by(publication) %>% 
  tally(sort = TRUE) 
```

    ## # A tibble: 21 × 2
    ##                                    publication     n
    ##                                          <chr> <int>
    ## 1                    Molecular Plant Pathology    15
    ## 2                              Plant Pathology    14
    ## 3                              Phytoparasitica    13
    ## 4                               Phytopathology    13
    ## 5           Journal of General Plant Pathology    12
    ## 6                   Journal of Plant Pathology    11
    ## 7                    Journal of Plant Virology    11
    ## 8  Physiological and Molecular Plant Pathology    11
    ## 9                                Plant Disease    11
    ## 10        Molecular Plant-Microbe Interactions    10
    ## 11                             Crop Protection     9
    ## 12                            Forest Pathology     9
    ## 13         European Journal of Plant Pathology     8
    ## 14           Revista Mexicana de Fitopatología     8
    ## 15         Canadian Journal of Plant Pathology     7
    ## 16                   Journal of Phytopathology     7
    ## 17                                  Nematology     7
    ## 18                Phytopathologia Mediterranea     7
    ## 19                       Plant Health Progress     7
    ## 20                    Tropical Plant Pathology     6
    ## 21                Australasian Plant Pathology     4

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
