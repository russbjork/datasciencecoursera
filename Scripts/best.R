best <- function(state,outcome){
## The function best() takes TWO (2) arguments: (a) the TWO(2)-character 
## abbreviated name of a state; and (b) an outcome name. The function reads the 
## outcome-of-care-measures.csv file and returns a character vector with the 
## name of the hospital that has the best (i.e. LOWEST) 30-day mortality for the 
## specified outcome in that state. The hospital name is the name provided in 
## the Hospital.Name variable. The outcomes can be one of “heart attack”, 
## “heart failure”, or “pneumonia”.     
##
## Test output from this function
## best("SC", "heart attack") 
## [1] "MUSC MEDICAL CENTER"
  
    ## Read in the outcome data
    data <- read.csv(file='Data/outcome-of-care-measures.csv', colClasses = 'character')
  
    ## Check state and outcome for validity
    if(!any(state == data$State)){
      stop("invalid state")}
    else if((outcome %in% c("heart attack", "heart failure",
                            "pneumonia")) == FALSE) {
      stop(print("invalid outcome"))
    }
    outsub <- subset(data, State == state)
    if (outcome == "heart attack") {
      colindx <- 11
    }
    else if (outcome == "heart failure") {
      colindx <- 17
    }
    else {
      colindx <- 23
    }      
    outsub[,colindx] <- as.numeric(as.character(outsub[,colindx]))

    ## Return hospital name in the state with lowest 30-day death rate
    min_row <- which(outsub[,colindx] == min(outsub[,colindx], na.rm = TRUE))
    hospitals <- outsub[min_row,2]
    hospitals <- sort(hospitals)
    return(hospitals[1])
    
}