corr <- function(directory = 'specdata', threshold = 0){
    ## 'directory' is a character vector of length 1 indicating the location of
    ## the CSV files.
  
    ## 'threshold' is a character vector of length 1 indicating the number of
    ## completely observed observations (on all variables) required to compute 
    ## the correlation between nitrate and sulfate; the default is 0.
  
    ## Returns a numeric vector of correlations.
    ## NOTE:  Do not round the results!
 
    file_list <- list.files(directory, full.names=T)
    data <- vector(mode = "numeric", length = 0)
  
    for (i in 1:length(file_list)) {
      monitors <- read.csv(file_list[i])
      check <- sum((!is.na(monitors$sulfate)) & (!is.na(monitors$nitrate)))
      if (check > threshold) {
        temp <- monitors[which(!is.na(monitors$sulfate)), ]
        sub_monitor <- temp[which(!is.na(temp$nitrate)), ]
        data <- c(data, cor(sub_monitor$sulfate, sub_monitor$nitrate))
      }
    }
  
    data
}