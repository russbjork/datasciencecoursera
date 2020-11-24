pollutantmean <- function(directory = 'specdata', pollutant = 'sulfate', id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating the location of
    ## the CSV files.
  
    ## 'pollutant' is a character vector of length 1 indicating the name of the
    ## pollutant for which we will calculate the mean; either "sulfate" or 
    ## "nitrate".
  
    ## 'id' is an integer vector indicating the monitor ID numbers to be used.
  
    ## Returns the mean of the pollutant across all monitors list in the 'id' 
    ## vector (ignoring NA values).
    ## NOTE:  Do not round the results!
    #rawd <- read.csv(file = 'specdata/001.csv')

    file_list <- list.files(directory, full.names=T)
    data <- data.frame()
    for (i in id) {
      data <- rbind(data, read.csv(file_list[i]))
    }
    mean(data[, pollutant], na.rm = TRUE)
    
}