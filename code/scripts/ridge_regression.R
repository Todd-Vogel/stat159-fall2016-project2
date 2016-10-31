library("glmnet")
library("lars")
library("MASS")

training_data <- read.csv(file = "../../data/training_data.csv")
training_data <- training_data[,-1]

#formatting response and predictors 
response <- training_data$Balance #Balance
response <- as.matrix(response)
predictors <- training_data[,-12]  #everythning but Balance
predictors <- as.matrix(predictors)



grid <- 10^seq(10, -2, length = 100)
set.seed(100)
cross_v <- cv.glmnet(x = predictors, y = response, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)

sink(file = "../../data/ridge_model.txt")
best_model_ridge <- coef(cross_v, cross_v$lambda.min)[which(coef(cross_v, s = "lambda.min") != 0)]
sink()

#Adding Histograms to Images
png('../../images/CV_Errors_Ridge.png')
plot(cross_v, main = "CV Errors Ridge")
dev.off()


test_set <- read.csv(file = "../../data/test_data.csv")
response = test_set$Balance
test_set <- test_set[,-1]
test_set <- test_set[,-12]
test_predictors = as.matrix(test_set)

test_ridge <- predict(cross_v, newx = test_predictors, s = "lambda.min", type="response")
save(test_ridge,file =  "../../data/testing_ridge.RData")

source("../functions/mse_function.R")
MSE(test_ridge, response)

full_data <- read.csv(file = "../../data/scaled_credit.csv")
full_data <- full_data[,-1]

response <- full_data$Balance #Balance
response <- as.matrix(response)
predictors <- full_data[,-12]  #everythning but Balance
predictors <- as.matrix(predictors)

#rerunning model on the full data set
full_ridge = glmnet(x = predictors, y = response, intercept = FALSE, standardize = FALSE, lambda = cross_v$lambda.min, alpha = 0)

#getting coefficients and saving
ridge_coef <- coef(full_ridge)
save(ridge_coef, file = "../../data/full_coeffecients_ridge.RData")
