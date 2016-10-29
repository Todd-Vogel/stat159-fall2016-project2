credit <- read.csv("../../data/Credit.csv")

temp_credit <- model.matrix(Balance ~ ., data = credit)
new_credit <- cbind(temp_credit[ ,c(-1, -2)], Balance = credit$Balance)

scaled_credit <- scale(new_credit, center = TRUE, scale = TRUE)

write.csv(scaled_credit, file = "../../data/scaled-credit.csv")

