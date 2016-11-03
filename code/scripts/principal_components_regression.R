require("pls")

training_data <- read.csv(file = "../../data/training_data.csv")
training_data <- training_data[,-1]

#formatting response and predictors 
response <- training_data$Balance #Balance
response <- as.matrix(response)
predictors <- training_data[,-12]  #everythning but Balance
predictors <- as.matrix(predictors)


set.seed(100)
pcr_obj <- pcr(response ~ predictors, validation = "CV")

pcr_model <- pcr_obj$validation$PRESS
pcr_coef <- coef(pcr_obj)
save(pcr_model, pcr_coef, file = "../../data/pcr_model.RData")

#Adding Histograms to Images
png('../../images/CV_Errors_pcr.png')
validationplot(pcr_obj, val.type = "MSEP")
dev.off()


test_set <- read.csv(file = "../../data/test_data.csv")
response = test_set$Balance
test_set <- test_set[,-1]
test_set <- test_set[,-12]
test_predictors = as.matrix(test_set)

test_pcr <- predict(pcr_obj, ncomp = 1, newdata = test_predictors, s = "validation$PRESS", type="response")
save(test_pcr,file =  "../../data/testing_pcr.RData")


source("../functions/mse_function.R")
MSE_pcr = MSE(test_pcr, response)
save(MSE_pcr, file = "../../data/MSE_pcr.RData")

full_data <- read.csv(file = "../../data/scaled_credit.csv")
full_data <- full_data[,-1]

response <- full_data$Balance #Balance
response <- as.matrix(response)
predictors <- full_data[,-12]  #everythning but Balance
predictors <- as.matrix(predictors)

#rerunning model on the full data set
full_pcr = pcr(response ~ predictors, validation = "CV")

#getting coefficients and saving
pcr_full_coef <- coef(full_pcr)
save(pcr_coef, file = "../../data/full_coeffecients_pcr.RData")

#saving  the important stuff
sink(file = "../../data/pcr_model.txt")
print("The PCR model")
pcr_coef
print("applied predictors")
test_pcr
print("The PCR MSE")
MSE_pcr
print("The coefficients on the full dataset")
pcr_full_coef
sink()


