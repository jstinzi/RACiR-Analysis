# RACiR-Analysis
Coding for correcting rapid A/Ci response (RACiR) data using R.


# Contact Information

Author: Joseph Ronald Stinziano

Email 1: jstinziano@unm.edu

Email 2: josephstinziano@gmail.com

ORCID: 0000-0002-7628-4201


# Terms

A: net CO2 assimilation

Ci: intercellular CO2 concentration

CO2_r: reference CO2 concentration

CO2_s: sample CO2 concentration

H2O_r: reference H2O concentration

RACiR: rapid A/Ci response


# ASSUMPTIONS

The user has read and understands Stinziano et al. (2017)

The user has a basic understanding of R

All RACiR diagnostics are completed (i.e. instrument settings were properly set for the species, conditions, and experiment)

RACiR calibration curves are available for each environmental condition (e.g. leaf temperature)

Each RACiR is in a separate file


# Overview

When done properly, RACiR facilitates rapid and robust estimates of Vcmax and Jmax compared to the standard 'steady-state' A/Ci response (Stinziano et al., 2017). This allows for a high frequency measurement regime and time-savings during the experiment. A side effect is that time typically invested in performing the A/Ci measurements via the standard approach is pushed instead to the data analysis portion. Thus time is not necessarily 'saved' but rather shunted from the data collection to the data analysis phase of an experiment. The code in this respository is intended to reduce time during data analysis, resulting in 'real' time savings.

Included in this repository are two code files and three LI6800 data files. For the coding files, there is one R script and one R Markdown file. These are identical except for the additional notation required in R Markdown.


# Data description

The data files are from RACiR measurements taken using a LI6800 equipped with the fluorometer. RACiRs were run from 300 to 900 umol mol1 CO2 at a rate of 100 umol mol-1 min-1, a temperature of 25 Celsius, flow rate of 600 umol s-1, fan speed of 10,000 rpm, H2O_r controlled to 19.5 mmol mol-1, and irradiance of 1,000 umol m-2 s-1. Files are labelled with the range of CO2 used, the rate, and whether the file is for calibration (empty chamber) or contains data measured from poplar (Populus deltoides).

# Tips

It is easier to work with the code in RStudio using RMarkdown.


# References

Stinziano JR, Morgan PB, Lynch DJ, Saathoff AJ, McDermitt DK, Hanson DT. 2017. The rapid A-Ci response: photosynthesis in the phenomic era. Plant, Cell & Environment 40:1256-1262


# MIT License

Copyright (c) [2018] [Joseph Ronald Stinziano]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
