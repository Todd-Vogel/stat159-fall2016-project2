#Getting the Training Data
training_data <- read.csv("../../data/training_data.csv")
training_data <- training_data[,-1]

ols <- lm(Balance ~ Income + Limit + Rating + Cards + Age + Education + GenderFemale + StudentYes + MarriedYes + EthnicityAsian + EthnicityCaucasian, training_data)

summary(ols)

ols_coef <- coef(ols)

test_set <- read.csv(file = "../../data/test_data.csv")
response = test_set$Balance
test_set <- test_set[,-1]
test_set <- test_set[,-12]
test_predictors = as.data.frame(test_set)

test_ols <- predict(ols, newdata = test_predictors, type ="response")


source("../functions/mse_function.R")
MSE_ols <- MSE(test_ols, response)

save(ols_coef, file = "../../data/ols_model.RData")
save(MSE_ols, file = "../../data/MSE_ols.RData")



#saving  the important stuff
sink(file = "../../data/ols_model.txt")
print("The OLS model")
summary(ols)
print("The OLS MSE")
MSE_ols
sink()