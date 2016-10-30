#Getting the Training Data
training_data <- read.csv("./data/training_data.csv")
training_data <- training_data[,-1]

ols <- lm(Balance ~ Income + Limit + Rating + Cards + Age + Education + GenderFemale + StudentYes + MarriedYes + EthnicityAsian + EthnicityCaucasian, training_data)

summary(ols)
