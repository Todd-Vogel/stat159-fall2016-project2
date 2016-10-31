library("pls")

training_data <- read.csv("../../data/training_data.csv")
training_data <- training_data[,-1]

response <- training_data$Balance
response <- as.matrix(response)
predictors <- training_data[,-12]
predictors <- as.matrix(predictors)

set.seed(1)
plsr_obj <- plsr(response ~ predictors, validation = "CV")

plsr_model <- plsr_obj$validation$PRESS

sink("../../plsr_model.txt")
plsr_model
sink()

png("../../images/CV_Errors_plsr.png")
validationplot(plsr_obj, val.type = "MSEP")
dev.off()