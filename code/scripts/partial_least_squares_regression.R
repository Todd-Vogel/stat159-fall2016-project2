library("pls")

training_data <- read.csv("../../data/training_data.csv")
training_data <- training_data[,-1]

response <- training_data$Balance
response <- as.matrix(response)
predictors <- training_data[,-12]
predictors <- as.matrix(predictors)

set.seed(1)
plsr_obj <- plsr(response ~ predictors, validation = "CV")

ncomp_plsr <- which(plsr_obj$validation$PRESS == min(plsr_obj$validation$PRESS)) #selects comp with best model

plsr_coef <- coef(plsr_obj)
save(plsr_coef, file = "../../data/plsr_model.RData")

png("../../images/CV_Errors_plsr.png")
validationplot(plsr_obj, val.type = "MSEP")
dev.off()

test_data <- read.csv("../../data/test_data.csv")
test_response <- test_data$Balance
test_data <- test_data[, -1]
test_predictors <- test_data[,-12]
test_predictors <- as.matrix(test_predictors)

test_plsr <- predict(plsr_obj, ncomp = ncomp_plsr,  newdata =test_predictors, s = "validation$PRESS", type = "response")

save(test_plsr, file = "../../data/testing_plsr.RData")

source("../functions/mse_function.R")
plsr_mse <- MSE(test_plsr, test_response)

save(plsr_mse, file = "../../data/MSE_plsr.RData")

full_data <- read.csv("../../data/scaled_credit.csv")
full_data <- full_data[,-1]

full_response <- full_data$Balance
full_response <- as.matrix(full_response)
full_predictors <- full_data[,-12]
full_predictors <- as.matrix(full_predictors)

full_plsr <- plsr(full_response ~ full_predictors, validation = "CV")

plsr_full_coef <- coef(full_plsr)
save(plsr_coef, file = "../../data/full_coefficients_plsr.RData")


sink("../../data/plsr_model.txt")
print("model coefficients")
plsr_coef
print("applied predictors")
test_plsr
print("mse of prediction")
plsr_mse
print("full model coefficients")
plsr_full_coef
sink()
