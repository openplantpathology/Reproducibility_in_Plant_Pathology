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
    "Virology Journal (Plant Viruses Section)",
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
    ## 68                    Molecular Plant Pathology 2012        108     Zach
    ## 69                    Molecular Plant Pathology 2012        142      Nik
    ## 70                    Molecular Plant Pathology 2013         18     Zach
    ## 71                    Molecular Plant Pathology 2013         57     Adam
    ## 72                    Molecular Plant Pathology 2013         72      Nik
    ## 73                    Molecular Plant Pathology 2013        107  Emerson
    ## 74                    Molecular Plant Pathology 2013        141     Zach
    ## 75                    Molecular Plant Pathology 2014         53     Zach
    ## 76                    Molecular Plant Pathology 2014        149  Emerson
    ## 77                    Molecular Plant Pathology 2015        145     Zach
    ## 78                    Molecular Plant Pathology 2016          6      Nik
    ## 79                    Molecular Plant Pathology 2016         94      Nik
    ## 80                    Molecular Plant Pathology 2016        116     Zach
    ## 81                    Molecular Plant Pathology 2016        121     Zach
    ## 82                    Molecular Plant Pathology 2016        128      Nik
    ## 83         Molecular Plant-Microbe Interactions 2012         66     Adam
    ## 84         Molecular Plant-Microbe Interactions 2012        115     Adam
    ## 85         Molecular Plant-Microbe Interactions 2013          1     Zach
    ## 86         Molecular Plant-Microbe Interactions 2013         18  Emerson
    ## 87         Molecular Plant-Microbe Interactions 2014         56     Adam
    ## 88         Molecular Plant-Microbe Interactions 2014        136  Emerson
    ## 89         Molecular Plant-Microbe Interactions 2015        110  Emerson
    ## 90         Molecular Plant-Microbe Interactions 2016         51     Zach
    ## 91         Molecular Plant-Microbe Interactions 2016         52     Zach
    ## 92         Molecular Plant-Microbe Interactions 2016        140  Emerson
    ## 93                                   Nematology 2012         51  Emerson
    ## 94                                   Nematology 2012         86      Nik
    ## 95                                   Nematology 2012         92      Nik
    ## 96                                   Nematology 2014         40     Adam
    ## 97                                   Nematology 2014         56     Adam
    ## 98                                   Nematology 2016         15     Adam
    ## 99                                   Nematology 2016        107  Emerson
    ## 100 Physiological and Molecular Plant Pathology 2012         11      Nik
    ## 101 Physiological and Molecular Plant Pathology 2012        127     Zach
    ## 102 Physiological and Molecular Plant Pathology 2012        144  Emerson
    ## 103 Physiological and Molecular Plant Pathology 2013          7      Nik
    ## 104 Physiological and Molecular Plant Pathology 2013         98      Nik
    ## 105 Physiological and Molecular Plant Pathology 2014         80  Emerson
    ## 106 Physiological and Molecular Plant Pathology 2014        131     Zach
    ## 107 Physiological and Molecular Plant Pathology 2014        144     Zach
    ## 108 Physiological and Molecular Plant Pathology 2015        150  Emerson
    ## 109 Physiological and Molecular Plant Pathology 2016          9      Nik
    ## 110 Physiological and Molecular Plant Pathology 2016         91     Zach
    ## 111                             Phytoparasitica 2012        118      Nik
    ## 112                             Phytoparasitica 2013          2     Adam
    ## 113                             Phytoparasitica 2013         71     Adam
    ## 114                             Phytoparasitica 2013         91     Zach
    ## 115                             Phytoparasitica 2013        100     Zach
    ## 116                             Phytoparasitica 2013        101     Adam
    ## 117                             Phytoparasitica 2014         24     Zach
    ## 118                             Phytoparasitica 2014         45  Emerson
    ## 119                             Phytoparasitica 2015         40     Adam
    ## 120                             Phytoparasitica 2015         84     Adam
    ## 121                             Phytoparasitica 2015         96      Nik
    ## 122                             Phytoparasitica 2016         42  Emerson
    ## 123                             Phytoparasitica 2016         44     Adam
    ## 124                Phytopathologia Mediterranea 2012         84     Zach
    ## 125                Phytopathologia Mediterranea 2013         29     Zach
    ## 126                Phytopathologia Mediterranea 2014         24  Emerson
    ## 127                Phytopathologia Mediterranea 2015        113     Adam
    ## 128                Phytopathologia Mediterranea 2015        121      Nik
    ## 129                Phytopathologia Mediterranea 2016         11  Emerson
    ## 130                Phytopathologia Mediterranea 2016         60     Adam
    ## 131                              Phytopathology 2012         57      Nik
    ## 132                              Phytopathology 2012         71      Nik
    ## 133                              Phytopathology 2012         89     Adam
    ## 134                              Phytopathology 2012         97     Adam
    ## 135                              Phytopathology 2014         19     Adam
    ## 136                              Phytopathology 2014         73     Zach
    ## 137                              Phytopathology 2015         12     Zach
    ## 138                              Phytopathology 2015         30     Adam
    ## 139                              Phytopathology 2015         43     Adam
    ## 140                              Phytopathology 2015         75     Adam
    ## 141                              Phytopathology 2016         59     Adam
    ## 142                              Phytopathology 2016         62  Emerson
    ## 143                              Phytopathology 2016         80      Nik
    ## 144                               Plant Disease 2012         68      Nik
    ## 145                               Plant Disease 2013         64  Emerson
    ## 146                               Plant Disease 2013        110      Nik
    ## 147                               Plant Disease 2013        124      Nik
    ## 148                               Plant Disease 2014         60     Zach
    ## 149                               Plant Disease 2014         75     Zach
    ## 150                               Plant Disease 2015         25      Nik
    ## 151                               Plant Disease 2015         69      Nik
    ## 152                               Plant Disease 2015        111     Adam
    ## 153                               Plant Disease 2016         76     Zach
    ## 154                               Plant Disease 2016        106     Zach
    ## 155                       Plant Health Progress 2012        127     Zach
    ## 156                       Plant Health Progress 2012        144      Nik
    ## 157                       Plant Health Progress 2013          7     Adam
    ## 158                       Plant Health Progress 2013         16     Zach
    ## 159                       Plant Health Progress 2013         75  Emerson
    ## 160                       Plant Health Progress 2014         63      Nik
    ## 161                       Plant Health Progress 2016         38     Adam
    ## 162                             Plant Pathology 2012         37      Nik
    ## 163                             Plant Pathology 2012        104  Emerson
    ## 164                             Plant Pathology 2013         20  Emerson
    ## 165                             Plant Pathology 2013         25  Emerson
    ## 166                             Plant Pathology 2013         90     Adam
    ## 167                             Plant Pathology 2013        130     Adam
    ## 168                             Plant Pathology 2014         79      Nik
    ## 169                             Plant Pathology 2014        109  Emerson
    ## 170                             Plant Pathology 2014        111      Nik
    ## 171                             Plant Pathology 2014        126     Adam
    ## 172                             Plant Pathology 2014        137     Adam
    ## 173                             Plant Pathology 2015         98     Zach
    ## 174                             Plant Pathology 2015        110  Emerson
    ## 175                             Plant Pathology 2016         67      Nik
    ## 176           Revista Mexicana de Fitopatología 2012         18     Zach
    ## 177           Revista Mexicana de Fitopatología 2012        114     Adam
    ## 178           Revista Mexicana de Fitopatología 2012        145     Adam
    ## 179           Revista Mexicana de Fitopatología 2013         66     Adam
    ## 180           Revista Mexicana de Fitopatología 2013        135      Nik
    ## 181           Revista Mexicana de Fitopatología 2014         25     Adam
    ## 182           Revista Mexicana de Fitopatología 2014         56     Zach
    ## 183           Revista Mexicana de Fitopatología 2014         98  Emerson
    ## 184                    Tropical Plant Pathology 2012        132     Zach
    ## 185                    Tropical Plant Pathology 2014         27     Zach
    ## 186                    Tropical Plant Pathology 2014        100      Nik
    ## 187                    Tropical Plant Pathology 2015        104      Nik
    ## 188                    Tropical Plant Pathology 2015        125     Adam
    ## 189                    Tropical Plant Pathology 2016         47  Emerson
    ## 190    Virology Journal (Plant Viruses Section) 2012         37      Nik
    ## 191    Virology Journal (Plant Viruses Section) 2012         66  Emerson
    ## 192    Virology Journal (Plant Viruses Section) 2012         78  Emerson
    ## 193    Virology Journal (Plant Viruses Section) 2012        140      Nik
    ## 194    Virology Journal (Plant Viruses Section) 2013         15  Emerson
    ## 195    Virology Journal (Plant Viruses Section) 2014         61  Emerson
    ## 196    Virology Journal (Plant Viruses Section) 2014        139      Nik
    ## 197    Virology Journal (Plant Viruses Section) 2016         10      Nik
    ## 198    Virology Journal (Plant Viruses Section) 2016        105  Emerson
    ## 199    Virology Journal (Plant Viruses Section) 2016        119  Emerson
    ## 200    Virology Journal (Plant Viruses Section) 2016        128     Zach

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
    ## 7  Physiological and Molecular Plant Pathology    11
    ## 8                                Plant Disease    11
    ## 9     Virology Journal (Plant Viruses Section)    11
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
