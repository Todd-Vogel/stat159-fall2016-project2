scaled_credit <- read.csv("../../data/scaled_credit.csv")

set.seed(1)
training_data <- scaled_credit[sample(nrow(scaled_credit), 300),]
sort(training_data$X)
training_data <- training_data[,-1]

write.csv(training_data, file = "../../data/training_data.csv")

set.seed(1)
test_data <- scaled_credit[-sample(nrow(scaled_credit), 300),]
test_data <- test_data[,-1]

write.csv(test_data, file = "../../data/test_data.csv")