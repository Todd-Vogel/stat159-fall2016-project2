#Phony targets
.PHONY: all
.PHONY: tests
.PHONY: eda
.PHONY: ols
.PHONY: ridge
.PHONY: lasso
.PHONY: pcr
.PHONY: plsr
.PHONY: regressions
.PHONY: report
.PHONY: slides
.PHONY: session
.PHONY: clean


#make a data phony
all:
	make eda
	make regressions
	make tests
	make reports
	make slides
	make session

regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

#runnings the scripts
ols:
	cd code/scripts && Rscript ordinary_least_squares.R
ridge:
	cd code/scripts && R CMD BATCH ridge_regression.R
lasso:
	cd code/scripts && R CMD BATCH lasso_regression.R
pcr:
	cd code/scripts && Rscript partial_least_squares_regression.R
plsr:
	cd code/scripts && Rscript principal_components_regression.R
eda:
	cd code/scripts && Rscript eda_script.R


#creating the report
report: report/report.pdf
report.Rmd:
	cd report/sections && pandoc -f markdown -t markdown -o ../report.Rmd *.Rmd
report.html: report/report.Rmd
	cd report/sections && pandoc -f markdown -t html -o ../paper.html *.Rmd
report.pdf:
	cd report; R -e "rmarkdown::render('report.Rmd')" #need to make sure the output for the RMD is set as PDF

#creating the slides
slides: report/presentation.html
report/presentation.html:
	cd report && R -e "rmarkdown::render('presentation.Rmd')"

#cleaning the reports
clean:
	rm report/paper.html report/report.Rmd report/report.html report/presentation.html

#testing
test:
	cd code/tests; Rscript -e 'library(testthat); test_file("all_tests.R")'

#session info
session: session-info.txt
session-info.txt:
	cd code/scripts; Rscript session_info_script.R


#data: #use variables here to call everthing
#bellow this should chance, we need to run it like I did above!

data/full_coefficients_plsr.RData: code/scripts/partial_least_squares_regression.R data/scaled_credit.csv
	cd code/scripts; Rscript lasso_regression.R

data/mse_plsr.txt: code/scripts/partial_least_squares_regression.R data/test_data.csv code/functions/mse_function.R
	cd code/scripts; Rscript partial_least_squares_regression.R

data/testing_plsr: code/scripts/partial_least_squares_regression.R data/test_data.csv
	cd code/scripts; Rscript partial_least_squares_regression.R

data/plsr_model.txt: code/scripts/partial_least_squares_regression.R data/training_data.csv
	cd code/scripts; Rscript partial_least_squares_regression.R

data/full_coefficients_lasso.RData: code/scripts/lasso_regression.R data/scaled_credit.csv
	cd code/scripts; Rscript lasso_regression.R

data/mse_lasso.txt: code/scripts/lasso_regression.R data/test_data.csv code/functions/mse_function.R
	cd code/scripts; Rscript lasso_regression.R

data/lasso_model.RData: code/scripts/lasso_regression.R data/training_data.csv
	cd code/scripts; Rscript lasso_regression.R

data/ANOVA_output.txt: code/scripts/eda_script.R data/Credit.csv
	cd code/scripts; Rscript eda_script.R

data/eda_qualitative_output.txt: code/scripts/eda_script.R data/Credit.csv
	cd code/scripts; Rscript eda_script.R

data/eda_quantitative_output.txt: code/scripts/eda_script.R data/Credit.csv
	cd code/scripts; Rscript eda_script.R

data/correlation_matrix.RData: code/scripts/eda_script.R data/Credit.csv
	cd code/scripts; Rscript eda_script.R

data/training_data.csv: code/data_separation.R data/scaled_credit.csv
	cd code; Rscript data_separation.R

data/test_data.csv: code/data_separation.R data/scaled_credit.csv
	cd code; Rscript data_separation.R

data/scaled_credit.csv: code/Data_Cleaning.R data/Credit.csv
	cd code; Rscript Data-Cleaning.R

data/Credit.csv:
	curl -o data/Credit.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"



	# 	Your Makefile should include:
	# – declaration of variables
	# – use of Make automatic variables
	# – comments for rules, targets or dependencies that need further description – all required phony targets
