training_data <- read.csv("../../data/training_data.csv")
training_data <- training_data[,-1]

library("glmnet")
library("lars")

response <- training_data$Balance
response <- as.matrix(response)
predictors <- training_data[,-12]
predictors <- as.matrix(predictors)

grid <- 10^seq(10, -2, length = 100)

set.seed(1)
lm.lasso <- cv.glmnet(predictors, response, lambda = grid, alpha = 1, intercept = FALSE, standardize = FALSE)
bestmodel_lasso <- coef(lm.lasso, lm.lasso$lambda.min)

save(bestmodel_lasso, file = "../../data/lasso_model.RData")

png("../../images/CV_errors_lasso.png")
plot(lm.lasso, main = "CV Errors Lasso")
dev.off()

test_data <- read.csv("../../data/test_data.csv")
test_data <- test_data[,-1]
test_predictors <- test_data[, -12]
test_predictors <- as.matrix(test_predictors)
test_response <- test_data[,12]

predicted_response <- predict(lm.lasso, newx=test_predictors, s = "lambda.min", type = "response")
predicted_response <- as.vector(predicted_response)

source("../functions/mse_function.R")
lasso_mse <- MSE(predicted_response, test_response)

sink("../../data/mse_lasso.txt")
lasso_mse
sink()

scaled_credit <- read.csv("../../data/scaled_credit.csv")
scaled_credit <- scaled_credit[,-1]
total_response <- scaled_credit$Balance
total_response <- as.matrix(total_response)
total_predictors <- scaled_credit[,-12]
total_predictors <- as.matrix(total_predictors)


full.lasso <- glmnet(total_predictors, total_response, lambda = lm.lasso$lambda.min, alpha = 1, intercept = FALSE, standardize = FALSE)
full_coefficients <- coef(full.lasso)

save(full_coefficients, file = "../../data/full_coefficients_lasso.RData")

