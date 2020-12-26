# Example: Iris Data
library(ggplot2)
library(AppliedPredictiveModeling)
library(caret)
data(iris)
names(iris)
table(iris$Species)

## Create training and test sets
inTrain <- createDataPartition(y=iris$Species,p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)

## Iris petal widths/sepal width
qplot(Petal.Width,Sepal.Width,colour=Species,data=training)

## Iris petal widths/sepal width
library(caret)
modFit <- train(Species ~ .,method="rpart",data=training)
print(modFit$finalModel)

## Plot tree
plot(modFit$finalModel, uniform=TRUE, main="Classification Tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=.8)

## Prettier plots
library(rattle)
fancyRpartPlot(modFit$finalModel)

## Predicting new values
predict(modFit,newdata=testing)
