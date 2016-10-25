scaled_credit <- read.csv("../data/scaled-credit.csv")

set.seed(1)
training_data <- scaled_credit[sample(nrow(scaled_credit), 300),]

training_data