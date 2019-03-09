# jupyter
install.packages(c('IRkernel'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')
#IRkernel::installspec()

# dataio
install.packages(c('RMySQL', 'RSQLite', 'XLConnect', 'xlsx', 'foreign'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# data manipulation
install.packages(c('dplyr', 'tidyr', 'stringr', 'lubridate'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# data visualization
install.packages(c('txtplot', 'ggplot2', 'ggvis', 'rgl', 'htmlwidgets', 'googleVis'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# data modelling
install.packages(c('car', 'mgcv', 'nlme', 'lme4', 'randomForest', 'multcomp', 'vcd', 'glmnet', 'survival', 'caret'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# report results
install.packages(c('shiny', 'markdown', 'xtable'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# Spatial data
install.packages(c('sp', 'maptools', 'maps', 'ggmap'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# Time Series and Financial data
install.packages(c('quantmod', 'xts', 'zoo'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# high performance R code
install.packages(c('data.table', 'Rcpp'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# work with the web
install.packages(c('httr', 'jsonlite', 'XML'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')

# write your own R packages
install.packages(c('devtools', 'testthat', 'roxygen2'),
		 repos='https://cloud.r-project.org',
		 lib='/opt/R/Rpackages/')
