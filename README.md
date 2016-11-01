## Statistics 159 Project 2
*Authors: Bryan Alcorn and Todd Vogel*

### File Structure

`stat159-fall2016-project2/`
	`code/`
		`functions/`
		`scripts/`
		`tests/`
	`data/`
	`images/`
	`report/`
		`sections/`
	`slides/`

The main directories are `code/`, `data/`, `images/`, `report/` and `slides/`.  The `code/` directory importantly contains the the eda script as well as the scripts for our 5 regression analyses (ols, ridge, lasso, plsr, and pcr). The `data/` and `images/` directories mostly stores outputs from the scripts, however `data/` also houses the Credit.csv file and the training and tests sets used throughout the project.  The `report/` folder contains the various sections of the project report to be consolidated by the Makefile.


### Make commands

`all`: will be associated to phony targets eda, regressions, and report
`data`: will download the file Credit.csv to the folder data/
`tests`: will run the unit tests of your functions
`eda`: will perform the exploratory data analysis
`ols`: OLS regression
`ridge`: Rdige Regression
`lasso`: Lasso Regression
`pcr`: Principal Components Regression
`plsr`: Partial Least Squares Regression
`regressions`: all five types of regressions
`report`: will generate report.pdf (or report.html)
`slides`: will generate slides.html
`session`: will generate session-info.txt
`clean`: will delete the generated report (pdf and/or html)



### License

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
