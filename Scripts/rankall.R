rankall <-  function(outcome, num = "best") {                                       
## The function rankall() takes TWO (2) arguments: (a) an outcome name 
## (outcome); and (b) a hospital ranking (num). The function reads the 
## outcome-of-care-measures.csv file and returns a TWO(2)-column data frame 
## containing the hospital in EACH state that has the ranking specified in num.    
##
## Test output from this function
## r <- rankall("heart attack", 4)
## as.character(subset(r, state == "HI")$hospital) 
## [1] "CASTLE MEDICAL CENTER"
## head(rankall("heart attack", "worst"))
## head(rankall("heart attack", "best"))

      ## Read outcome data                                                    
    library(dplyr)
    library(magrittr)
    data <- read.csv("Data/outcome-of-care-measures.csv",colClasses = "character")
    
    ## For each state, find the hospital of the given rank                  
    if((outcome %in% c("heart attack", "heart failure",
                       "pneumonia")) == FALSE) {
      stop(print("invalid outcome"))
    }
    if (outcome == "heart attack") {
      colnum <- 11
    }
    else if (outcome == "heart failure") {
      colnum <- 17
    }
    else {
      colnum <- 23
    }
    
    ## Return a data frame with the hospital names and the (abbreviated)    
    ## state name
    data[ ,colnum] <- as.numeric(data[ ,colnum])
    
    data = data[!is.na(data[,colnum]),]
    
    splited = split(data, data$State)
    ans = lapply(splited, function(x, num) {
      x = x[order(x[,colnum], x$Hospital.Name),]
      
      if(class(num) == "character") {
        if(num == "best") {
          return (x$Hospital.Name[1])
        }
        else if(num == "worst") {
          return (x$Hospital.Name[nrow(x)])
        }
      }
      else {
        return (x$Hospital.Name[num])
      }
    }, num)
    
    #Return data.frame with format
    return ( data.frame(hospital=unlist(ans), state=names(ans)) )

} 