Journal Article Sampling Methodology
================

Creating a sample of articles
-----------------------------

The top 20 journals in the discipline of plant pathology were selected according to Google Scholar's ranking by h-index, (<https://scholar.google.com.au/citations?view_op=top_venues&hl=en&vq=bio_plantpathology>).

100 articles are chosen at random with the assumption that journals publish an average 10 articles per issue, and using a confidence level of 95% and confidence interval of 10% we only need 88 samples, so to round it up and make it even, we'll select 100 articles over the last five years from a population that should be ~1000.

R setup
-------

Set up the R environment

``` r
library(dplyr)

set.seed(27)
```

Import data
-----------

The list of the top 20 plant pathology journals was retrieved from Google Scholar on December 5, 2016 and saved as a CSV file for reproducibility.

``` r
journal_list <- read.csv("../data/Google Scholar Top 20 Plant Pathology Journals 05-12-2016.csv")

journal_list[1:20, -4] # drop h-index median value
```

    ##    Rank                                           Publication h5.index
    ## 1     1                  Molecular Plant-Microbe Interactions       47
    ## 2     2                             Molecular Plant Pathology       43
    ## 3     3                       Annual Review of Phytopathology       42
    ## 4     4                                         Plant Disease       35
    ## 5     5                                        Phytopathology       34
    ## 6     6                                       Plant Pathology       34
    ## 7     7                                       Crop Protection       32
    ## 8     8                   European Journal of Plant Pathology       29
    ## 9     9                                      Forest Pathology       20
    ## 10   10                          Phytopathologia Mediterranea       19
    ## 11   11                             Journal of Phytopathology       17
    ## 12   12           Physiological and Molecular Plant Pathology       17
    ## 13   13                          Australasian Plant Pathology       16
    ## 14   14 International Phytoplasmologist Working Group Meeting       15
    ## 15   15                   Canadian Journal of Plant Pathology       15
    ## 16   16                                         EPPO Bulletin       15
    ## 17   17                    Journal of General Plant Pathology       15
    ## 18   18                                            Nematology       15
    ## 19   19                            Journal of Plant Pathology       14
    ## 20   20                                       Phytoparasitica       14

Create random lists
-------------------

Create a randomised list of the journals

``` r
journals <- as.data.frame(sample(1:20, 100, replace = TRUE))
names(journals) <- "Rank"
# reorder joural list
journals <- left_join(journals, journal_list, "Rank")[, -c(3:4)]
```

Randomly select articles
------------------------

Generate a random list of years between 2012 and 2016 and a random list of start pages between 1 and 150 since some journals start numbering at 1 with every issue. Then bind the columns of the randomised list of journals with the randomised years and page start numbers. This then assumes that there is no temporal effect, i.e., the time of year an article is published does not affect whether or not it is reproducible.

*How to handle reviews or letters?*

``` r
year <- sample(2012:2016, 100, replace = TRUE)

start_page <- sample.int(150, 100)

journals <- cbind(journals, year, start_page)

journals[1:100, -1]
```

    ##                                               Publication year start_page
    ## 1                                         Phytoparasitica 2013        101
    ## 2                               Molecular Plant Pathology 2014         95
    ## 3                                              Nematology 2014        141
    ## 4                                         Crop Protection 2012         96
    ## 5                                          Phytopathology 2015         66
    ## 6                                        Forest Pathology 2012         72
    ## 7                               Molecular Plant Pathology 2012         82
    ## 8                    Molecular Plant-Microbe Interactions 2014         63
    ## 9                         Annual Review of Phytopathology 2016        121
    ## 10                                          Plant Disease 2016        111
    ## 11                           Australasian Plant Pathology 2016         77
    ## 12                     Journal of General Plant Pathology 2016          5
    ## 13                              Journal of Phytopathology 2015         73
    ## 14                    Canadian Journal of Plant Pathology 2015          8
    ## 15                                             Nematology 2016         83
    ## 16                                          EPPO Bulletin 2016        108
    ## 17                                        Phytoparasitica 2015         94
    ## 18                              Molecular Plant Pathology 2012        136
    ## 19            Physiological and Molecular Plant Pathology 2016         52
    ## 20                   Molecular Plant-Microbe Interactions 2016        126
    ## 21                              Molecular Plant Pathology 2012         58
    ## 22                                        Phytoparasitica 2015         45
    ## 23                              Journal of Phytopathology 2015        117
    ## 24                                       Forest Pathology 2015         31
    ## 25                             Journal of Plant Pathology 2013         54
    ## 26                        Annual Review of Phytopathology 2016         98
    ## 27            Physiological and Molecular Plant Pathology 2016         30
    ## 28                        Annual Review of Phytopathology 2015         16
    ## 29                                         Phytopathology 2013        119
    ## 30                                       Forest Pathology 2016         20
    ## 31                        Annual Review of Phytopathology 2012        135
    ## 32                           Phytopathologia Mediterranea 2012        105
    ## 33                              Molecular Plant Pathology 2015         88
    ## 34                                        Plant Pathology 2015         24
    ## 35                        Annual Review of Phytopathology 2014        134
    ## 36                           Phytopathologia Mediterranea 2015         14
    ## 37                           Phytopathologia Mediterranea 2013         44
    ## 38                           Australasian Plant Pathology 2012         79
    ## 39                           Australasian Plant Pathology 2015         38
    ## 40                    European Journal of Plant Pathology 2016        143
    ## 41                                        Plant Pathology 2013         61
    ## 42                              Molecular Plant Pathology 2012         25
    ## 43                        Annual Review of Phytopathology 2015        137
    ## 44                     Journal of General Plant Pathology 2016        131
    ## 45                              Journal of Phytopathology 2012        115
    ## 46                                             Nematology 2016          4
    ## 47                           Phytopathologia Mediterranea 2015        145
    ## 48                                          Plant Disease 2012         67
    ## 49                   Molecular Plant-Microbe Interactions 2015         80
    ## 50                           Australasian Plant Pathology 2014        120
    ## 51                        Annual Review of Phytopathology 2014         39
    ## 52                     Journal of General Plant Pathology 2016         11
    ## 53                                          Plant Disease 2013         50
    ## 54            Physiological and Molecular Plant Pathology 2014        148
    ## 55                           Australasian Plant Pathology 2013         97
    ## 56                                             Nematology 2012        130
    ## 57                             Journal of Plant Pathology 2015         74
    ## 58                                        Plant Pathology 2016        102
    ## 59                           Australasian Plant Pathology 2016         62
    ## 60                        Annual Review of Phytopathology 2013        114
    ## 61                                       Forest Pathology 2016         75
    ## 62                           Phytopathologia Mediterranea 2013         89
    ## 63                                          Plant Disease 2015        140
    ## 64            Physiological and Molecular Plant Pathology 2016        138
    ## 65                                        Phytoparasitica 2013         41
    ## 66                     Journal of General Plant Pathology 2015         26
    ## 67                              Molecular Plant Pathology 2015        127
    ## 68            Physiological and Molecular Plant Pathology 2016        118
    ## 69                                        Crop Protection 2013         93
    ## 70                           Australasian Plant Pathology 2013         92
    ## 71                     Journal of General Plant Pathology 2016         47
    ## 72                                          Plant Disease 2015        125
    ## 73                    Canadian Journal of Plant Pathology 2014        123
    ## 74                           Phytopathologia Mediterranea 2013         57
    ## 75                                          EPPO Bulletin 2016        124
    ## 76                    European Journal of Plant Pathology 2013         12
    ## 77                                       Forest Pathology 2012        113
    ## 78                                        Plant Pathology 2012        110
    ## 79                                          EPPO Bulletin 2012         42
    ## 80                                        Phytoparasitica 2012         17
    ## 81                   Molecular Plant-Microbe Interactions 2013        128
    ## 82  International Phytoplasmologist Working Group Meeting 2014         59
    ## 83                    European Journal of Plant Pathology 2013          2
    ## 84  International Phytoplasmologist Working Group Meeting 2016         28
    ## 85                             Journal of Plant Pathology 2016          1
    ## 86                           Phytopathologia Mediterranea 2015        132
    ## 87                                        Phytoparasitica 2014         37
    ## 88                                       Forest Pathology 2014         35
    ## 89                              Molecular Plant Pathology 2013        106
    ## 90                           Phytopathologia Mediterranea 2012         70
    ## 91                        Annual Review of Phytopathology 2015        122
    ## 92                     Journal of General Plant Pathology 2013         32
    ## 93                   Molecular Plant-Microbe Interactions 2013         18
    ## 94                                        Phytoparasitica 2014         22
    ## 95  International Phytoplasmologist Working Group Meeting 2016         81
    ## 96                                        Crop Protection 2014         46
    ## 97                           Australasian Plant Pathology 2015         21
    ## 98                                        Phytoparasitica 2013         53
    ## 99                                        Crop Protection 2013         51
    ## 100                          Phytopathologia Mediterranea 2016         36
