print("this is a sample print function line.")
print("just another test of the print function")
x <- 4L
class(x)
x <- c(4, TRUE)
class(x)
x <- c(1,3,5); y <- c(3,2,10)
rbind(x, y)
x <- list(2, "a", "b", TRUE)
x[[1]]
x <- 1:4; y <- 2:3
x + y
class(x + y)
x <- c(3, 5, 1, 10, 12, 6)
x[x<=5]<-0
x[x<6]<-0
x[x %in% 1:5]<-0
x <- read.csv("hw1_data.csv")
mean(x$Ozone, na.rm = TRUE)
y <- x[which(x$Ozone > 31 & x$Temp > 90),]
mean(y$Solar.R)
z <- x[which(x$Month==6),]
mean(z$Temp)
max(z$Ozone,na.rm=TRUE)
