data/eda-output.txt: code/scripts/eda-script.R data/Credit.csv
	cd code/scripts; Rscript eda-script.R

data/correlation-matrix.RData: code/scripts/eda-script.R data/Credit.csv
	cd code/scripts; Rscript eda-script.R

data/training-data.csv: code/data-separation.R data/scaled-credit.csv
	cd code; Rscript data-separation.R

data/test-data.csv: code/data-separation.R data/scaled-credit.csv
	cd code; Rscript data-separation.R

data/scaled-credit.csv: code/Data-Cleaning.R data/Credit.csv
	cd code; Rscript Data-Cleaning.R

data/Credit.csv:
	curl -o data/Credit.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"