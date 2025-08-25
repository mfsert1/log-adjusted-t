# logAdjustedT — The Log-Adjusted t-Statistic

[![R-CMD-check](https://github.com/mfsert1/log-adjusted-t/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mfsert1/log-adjusted-t/actions)

## Overview

In large data sets, classical t-tests often overemphasize statistical significance.  
With hundreds of thousands of observations, even negligible effects can yield extremely low *p*-values, undermining interpretability.  

This package implements the **log-adjusted t-statistic**, a transformation of the classical t-statistic that depends on the degrees of freedom.  
The method preserves classical behavior in small samples but suppresses artificial sensitivity in large samples, avoiding misleading significance.

## Installation

You can install the development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("mfsert1/log-adjusted-t")
library(logAdjustedT)
