credit <- read.csv('../../data/Credit.csv')

Balance <- credit$Balance
Income <- credit$Income
Limit <- credit$Limit
Rating <- credit$Rating
Cards <- credit$Cards
Age <- credit$Age
Education <- credit$Education

bal_summary <- summary(Balance)
inc_summary <- summary(Income)
limit_summary <- summary(Limit)
rate_summary <- summary(Rating)
card_summary <- summary(Cards)
age_summary <- summary(Age)
edu_summary <- summary(Education)
quantitative_summary <- rbind(bal_summary, inc_summary, limit_summary, rate_summary, card_summary, age_summary, edu_summary)
quantitative_summary <- as.data.frame(quantitative_summary)

bal_IQR <- IQR(Balance)
inc_IQR <- IQR(Income)
limit_IQR <- IQR(Limit)
rate_IQR <- IQR(Rating)
card_IQR <- IQR(Cards)
age_IQR <- IQR(Age)
edu_IQR <- IQR(Education)
variable_IQR <- rbind(bal_IQR, inc_IQR, rate_IQR, card_IQR, age_IQR, edu_IQR)
variable_IQR <- as.data.frame(variable_IQR)
colnames(variable_IQR) <- "IQR"

bal_sd <- sd(Balance)
inc_sd <- sd(Income)
limit_sd <- sd(Limit)
rate_sd <- sd(Rating)
card_sd <- sd(Cards)
age_sd <- sd(Age)
edu_sd <- sd(Education)
variable_sd <- rbind(bal_sd, inc_sd, rate_sd, card_sd, age_sd, edu_sd)
variable_sd <- as.data.frame(variable_sd)
colnames(variable_sd) <- "SD"

dependent.matrix <- credit[,c(2,3,4,5,6,7)]
cor_matrix <- as.matrix(cor(dependent.matrix))

sink("../../data/eda-output.txt")
quantitative_summary
variable_IQR
variable_sd
cor_matrix
sink()

save(cor_matrix, file = "../../data/correlation-matrix.RData")

png('../../images/scatterplot-matrix.png')
pairs(dependent.matrix)
dev.off()


png('../../images/histogram-income.png')
hist(Income)
dev.off()

png('../../images/histogram-limit.png')
hist(Limit)
dev.off()

png('../../images/histogram-rating.png')
hist(Rating)
dev.off()

png('../../images/histogram-cards.png')
hist(Cards)
dev.off()

png('../../images/histogram-age.png')
hist(Age)
dev.off()

png('../../images/histogram-education.png')
hist(Education)
dev.off()

png('../../images/histogram-balance.png')
hist(Balance)
dev.off()


png('../../images/boxplot-income')
boxplot(Income)
dev.off()

png('../../images/boxplot-limit')
boxplot(Limit)
dev.off()

png('../../images/boxplot-rating')
boxplot(Rating)
dev.off()

png('../../images/boxplot-cards')
boxplot(Cards)
dev.off()

png('../../images/boxplot-age')
boxplot(Age)
dev.off()

png('../../images/boxplot-education')
boxplot(Education)
dev.off()

png('../../images/boxplot-Balance')
boxplot(Balance)
dev.off()



