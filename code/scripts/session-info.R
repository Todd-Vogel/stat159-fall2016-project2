#Includes calls to ALL the packages that you use for your project, as well as output of the function sessionInfo()

# include all R packages in your project
library(devtools)
library(knitr)
library(rmarkdown)
library(xtable)
library(ggplot2)
sink("../../session-info.txt", append = TRUE)
cat("Session Information\n\n")
print(sessionInfo())
devtools::session_info()
sink()
