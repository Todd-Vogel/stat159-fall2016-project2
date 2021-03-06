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

sink("../../data/eda_quantitative_output.txt")
quantitative_summary
variable_IQR
variable_sd
cor_matrix
sink()

save(cor_matrix, file = "../../data/correlation_matrix.RData")

png('../../images/scatterplot_matrix.png')
pairs(dependent.matrix)
dev.off()


png('../../images/histogram_income.png')
hist(Income)
dev.off()

png('../../images/histogram_limit.png')
hist(Limit)
dev.off()

png('../../images/histogram_rating.png')
hist(Rating)
dev.off()

png('../../images/histogram_cards.png')
hist(Cards)
dev.off()

png('../../images/histogram_age.png')
hist(Age)
dev.off()

png('../../images/histogram_education.png')
hist(Education)
dev.off()

png('../../images/histogram_balance.png')
hist(Balance)
dev.off()


png('../../images/boxplot_income.png')
boxplot(Income)
dev.off()

png('../../images/boxplot_limit.png')
boxplot(Limit)
dev.off()

png('../../images/boxplot_rating.png')
boxplot(Rating)
dev.off()

png('../../images/boxplot_cards.png')
boxplot(Cards)
dev.off()

png('../../images/boxplot_age.png')
boxplot(Age)
dev.off()

png('../../images/boxplot_education.png')
boxplot(Education)
dev.off()

png('../../images/boxplot_Balance.png')
boxplot(Balance)
dev.off()

library('plyr')

colnames(credit)
qual_variables <- credit[,c(8,9,10,11)]
gender_freq <- count(qual_variables$Gender)
gender_freq$'relative frequency' <- round(gender_freq$freq/sum(gender_freq$freq), 2)
colnames(gender_freq)[1] <- "Gender"

student_freq <- count(qual_variables$Student)
student_freq$'relative frequency' <- round(student_freq$freq/sum(student_freq$freq), 2)
colnames(student_freq)[1] <- "Student"

married_freq <- count(qual_variables$Married)
married_freq$'relative frequency' <- round(married_freq$freq/sum(married_freq$freq), 2)
colnames(married_freq)[1] <- "Married"

ethnicity_freq <- count(qual_variables$Ethnicity)
ethnicity_freq$'relative frequency' <- round(ethnicity_freq$freq/sum(ethnicity_freq$freq), 3)
colnames(ethnicity_freq)[1] <- "Ethnicity"

sink("../../data/eda_qualitative_output.txt")
gender_freq
student_freq
married_freq
ethnicity_freq
sink()


png('../../images/barplot_gender.png')
barplot(gender_freq$freq, main = "Gender Frequencies", names.arg = c("Male", "Female"))
dev.off()

png('../../images/barplot_student.png')
barplot(student_freq$freq, main = "Student Frequencies", names.arg = c("No", "Yes"))
dev.off()

png('../../images/barplot_married.png')
barplot(married_freq$freq, main = "Married Frequencies", names.arg = c("No", "Yes"))
dev.off()

png('../../images/barplot_ethnicity.png')
barplot(ethnicity_freq$freq, main = "Ethnicity Frequencies", names.arg = c("African American", "Asian", "Caucasian"))
dev.off()

qual_credit <- credit[, c(8,9,10,11,12)]
anova_analysis <- aov(Balance ~ Gender + Student + Married + Ethnicity, data = qual_credit)

sink("../../data/ANOVA_output.txt")
anova_analysis
sink()

library('ggplot2')
gender_conditional_plot <- ggplot(credit, aes(x = Gender, y = Balance, fill = Gender)) + geom_boxplot()

png('../../images/gender_conditional_plot.png')
gender_conditional_plot
dev.off()


ethnicity_conditional_plot <- ggplot(credit, aes(x = Ethnicity, y = Balance, fill = Ethnicity)) + geom_boxplot()

png('../../images/ethnicity_conditional_plot.png')
ethnicity_conditional_plot
dev.off()


student_conditional_plot <- ggplot(credit, aes(x = Student, y = Balance, fill = Student)) + geom_boxplot()

png('../../images/student_conditional_plot.png')
student_conditional_plot
dev.off()


married_conditional_plot <- ggplot(credit, aes(x = Married, y = Balance, fill = Married)) + geom_boxplot()

png('../../images/married_conditional_plot.png')
married_conditional_plot
dev.off()

