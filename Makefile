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
.PHONY: data

#make a data phony
all:
	make data
	make eda
	make regressions
	make tests
	make slides
	make report
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


#creating the report - depends on running the regression
report: report.pdf
report.pdf: report.Rmd report.html
	cd report; R -e "rmarkdown::render('report.Rmd')" #need to make sure the output for the RMD is set as PDF
report.Rmd:
	cd report/sections && pandoc -f markdown -t markdown -o ../report.Rmd *.Rmd
report.html: report/report.Rmd
	cd report/sections && pandoc -f markdown -t html -o ../paper.html *.Rmd

#creating the slides
slides: slides/presentation.html
slides/presentation.html:
	cd slides && R -e "rmarkdown::render('presentation.Rmd')"

#cleaning the report
clean:
	rm report/paper.html report/report.Rmd report/report.html report/presentation.html
	rm session-info.txt

#testing
test:
	cd code/tests; Rscript -e 'library(testthat); test_file("all_tests.R")'

#session info
session:
	bash session.sh
	cd code/scripts; Rscript session-info.R

#getting all data files
data:
	curl -o data/Credit.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"
	cd code/scripts; Rscript eda_script.R
	cd code/scripts; Rscript Data_Cleaning.R
	cd code/scripts; Rscript data_separation.R



	# 	Your Makefile should include:
	# – declaration of variables
	# – use of Make automatic variables
