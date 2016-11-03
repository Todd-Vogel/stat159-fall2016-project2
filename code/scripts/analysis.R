library(reshape2)
library(ggplot2)
library(xtable)
library(Matrix)


load('../../data/MSE_ols.RData')
load('../../data/MSE_ridge.RData')
load('../../data/MSE_pcr.RData')
load('../../data/mse_lasso.RData')
load('../../data/mse_plsr.RData')
load('../../data/ols_model.RData')
load('../../data/ridge_model.RData')
load('../../data/lasso_model.RData')
load('../../data/pcr_model.RData')
load('../../data/plsr_model.RData')


options(xtable.caption.placement = 'top', xtable.comment = FALSE)

# Getting coeffecient table
Variables <- c("Intercept", "Income","Limit", "Rating", "Cards", "Age", "Education", "GenderFemale", "StudentYes", "MarriedYes", "EthnicityAsian", "EthnicityCaucasian")
OLS <- as.vector(ols_coef)
Ridge <- as.vector(best_model_ridge)
Lasso <- as.vector(bestmodel_lasso)
PCR <- as.vector(pcr_coef)
PCR <- append(PCR, 0, 0)
PLSR <- as.vector(plsr_coef)
PLSR <- append(PLSR, 0, 0)

Coef.frame <- data.frame(Variables, OLS, Ridge, Lasso, PCR, PLSR)

Coef_table <- xtable(Coef.frame, caption="Information about Model Coefficients", digits = 3)



##Getting Table of MSE
MSE <- c(MSE_ols, MSE_ridge, lasso_mse, MSE_pcr, plsr_mse)
Model <- c('OLS', 'Ridge', 'Lasso', 'PCR', 'PLSR')
mse.frame <- data.frame(Model, MSE)

MSE_table <- xtable(mse.frame, caption="Information about Mean Squared Errors", digits = 3)


## Graph Comparing all Coeffecients
coef_data <- data.frame(OLS, Ridge, Lasso, PCR, PLSR)
colnames(coef_data) <- c("OLS", "Ridge", "Lasso", "PCR", "PLSR")
row.names(coef_data) <- Variables
coef_data <- coef_data[-1,]

coef_data["Coeffecient"] <- rownames(coef_data)

df.coef <- melt(coef_data, id.vars = "Coeffecient", value.name = "Coef", variable.name = "Models")

df.coef$Coef = round(df.coef$Coef, digits = 3)


compare_coefficients <- ggplot(df.coef, aes( x = Coeffecient, y = Coef) ) +
                        geom_bar( position = "identity", stat = "identity", alpha = .3, width = .3 ) +
                        facet_grid(Models ~.) +
                        theme(panel.margin = unit(0, "lines")) + 
                        geom_text(aes(label=Coef), position=position_dodge(width=0.9), vjust=0) + 
                        scale_fill_brewer(palette="Blues") + 
                        labs(title = "Comparing all Coeffecients for all the Models") + 
                        theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))


#Adding Histograms to Images
png('../../images/compare_coef.png')
compare_coefficients
dev.off()





#Stuff to save
sink(file = "../../data/MSE_Coeff_Table")
Coef.frame
mse.frame
sink()
