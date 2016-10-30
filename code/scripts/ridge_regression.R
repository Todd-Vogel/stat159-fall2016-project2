require("glmnet")
library("glmnet")

training_data <- read.csv(file = "../data/")

response <- training_data$Balance
response <- as.matrix(response)
predictors <- training_data[,-12]
predictors <- as.matrix(predictors)