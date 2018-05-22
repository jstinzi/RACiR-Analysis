# RACiR-Analysis
Coding for correcting rapid A/Ci response (RACiR) data using R.

# Terms

A: net CO2 assimilation

Ci: intercellular CO2 concentration

CO2_r: reference CO2 concentration

CO2_s: sample CO2 concentration

RACiR: rapid A/Ci response


# ASSUMPTIONS

The user has read and understands Stinziano et al. (2017)

The user has a basic understanding of R

All RACiR diagnostics are completed (i.e. instrument settings were properly set for the species, conditions, and experiment)

RACiR calibration curves are available for each environmental condition (e.g. leaf temperature)

Each RACiR is in a separate file


# Overview

When done properly, RACiR facilitates rapid and robust estimates of Vcmax and Jmax compared to the standard 'steady-state' A/Ci response (Stinziano et al., 2017). This allows for a high frequency measurement regime and time-savings during the experiment. A side effect is that time typically invested in performing the A/Ci measurements via the standard approach is pushed instead to the data analysis portion. Thus time is not necessarily 'saved' but rather shunted from the data collection to the data analysis phase of an experiment. The code in this respository is intended to reduce time during data analysis, resulting in 'real' time savings.

# Tips

It is easier to work with the code in RStudio using RMarkdown.


# References

Stinziano JR, Morgan PB, Lynch DJ, Saathoff AJ, McDermitt DK, Hanson DT. 2017. The rapid A-Ci response: photosynthesis in the phenomic era. Plant, Cell & Environment 40:1256-1262
