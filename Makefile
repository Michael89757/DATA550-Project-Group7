report_group7.html: final_report.Rmd covid_data_cleaned.rds code/06_render_final_report.R table1.rds .png
	Rscript code/04_render_final_report.R

# creates cleaned data
covid_data_cleaned.rds: code/01_data_processing.R
	Rscript code/01_data_processing.R

# creates table 1
table1.rds: code/02_make_table.R covid_data_cleaned.rds
	Rscript code/02_make_table.R

# creates figures
.png: code/02_make_heatmap.R code/03_make_figures.R covid_data_cleaned.rds
	Rscript code/02_make_heatmap.R code/03_make_figures.R
	
# creates survival analysis results
##### Lead TO DO

.PHONY: clean
clean:
	rm -f output/ && rm -f report_group7.html && rm -f table/ && rm -f data/data_cleaned.rds && rm -f figure/
	