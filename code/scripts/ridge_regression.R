library("glmnet")
library("lars")
library("MASS")

training_data <- read.csv(file = "data/training_data.csv")
training_data <- training_data[,-1]

response <- training_data$Balance #Balance
response <- as.matrix(response)
predictors <- training_data[,-12]  #everythning but Balance
predictors <- as.matrix(predictors)



grid <- 10^seq(10, -2, length = 100)

set.seed(100)
cross_v <- cv.glmnet(x = predictors, y = response, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)



best_model_ridge <- coef(cross_v, cross_v$lambda.min)[which(coef(cross_v, s = "lambda.min") != 0)]


plot(cross_v, xvar='lambda')

save(best_model_ridge, file = "data/ridge_model.RData")



#Adding Histograms to Images
png('images/CV_Errors_Ridge.png')
plot(cross_v, main = "CV Errors Ridge")
dev.off()


test_set <- read.csv(file = "data/test_data.csv")
response = test_set$Balance
test_set <- test_set[,-1]
test_set <- test_set[,-12]
test_predictors = as.matrix(test_set)

test_ridge <- predict(cross_v, newx = test_predictors, s = "lambda.min", type="response")


source("code/functions/mse_function.R")
#use todds method as a test for MSE
mse(test_ridge, response)
