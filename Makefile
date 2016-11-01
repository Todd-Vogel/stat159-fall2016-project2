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



regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

ols:

ridge:

lasso:

pcr:

plsr:



# 	Your Makefile should include:
# – declaration of variables
# – use of Make automatic variables
# – comments for rules, targets or dependencies that need further description – all required phony targets

#creating the paper
paper: paper.html

paper.md:
	cd paper/sections && pandoc -f markdown -t markdown -o ../paper.md *.md

paper.html: paper.md
	cd paper/sections && pandoc -f markdown -t html -o ../paper.html *.md

#cleaning the reports
clean:
	rm paper/paper.html paper/paper.md

test:
	cd code/tests; Rscript -e 'library(testthat); test_file("all_tests.R")'




session-info.txt:
	cd code/scripts; Rscript session-info-script.R


#data: #use variables here to call everthing


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
