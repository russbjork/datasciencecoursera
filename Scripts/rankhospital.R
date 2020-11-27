rankhospital <- function(state, outcome, num = "best") {                            
## The function rankhospital() takes THREE (3) arguments: (a) the TWO(2)-character
## abbreviated name of a state (state); (b) an outcome (outcome); and © the 
## ranking of a hospital in that state for that outcome (num). The function reads 
## the outcome-of-care-measures.csv file and returns a character vector with the 
## name of the hospital that has the ranking specified by the num argument. F    
##
## Test output from this function
## rankhospital("NC", "heart attack", "worst") 
## [1] "WAYNE MEMORIAL HOSPITAL"
## rankhospital("WA", "heart attack", 7)
## [1] "YAKIMA VALLEY MEMORIAL HOSPITAL"
  
    ## Read outcome data                                                
    data <- read.csv("Data/outcome-of-care-measures.csv",colClasses = "character")
    
    ## Check that state and outcome are valid                           
    if(!any(state == data$State)){
      stop("invalid state")}
    else if((outcome %in% c("heart attack", "heart failure",
                            "pneumonia")) == FALSE) {
      stop(print("invalid outcome"))
    }
    
    ## Return hospital name in that state with the given rank           
    ## THIRTY(30)-day death rate 
    subdata <- subset(data, State == state)
    if (outcome == "heart attack") {
      colnum <- 11
    }
    else if (outcome == "heart failure") {
      colnum <- 17
    }
    else {
      colnum <- 23
    }
    subdata[ ,colnum] <- as.numeric(subdata[ ,colnum])
    subdata2 <- subdata[order(subdata[ ,colnum],subdata[,2]), ]
    subdata2 <- subdata2[(!is.na(subdata2[ ,colnum])),]
    if(num == "best"){
      num <- 1
    }            
    else if (num == "worst"){
      num <- nrow(subdata2)
    }      
    return(subdata2[num,2])
} 