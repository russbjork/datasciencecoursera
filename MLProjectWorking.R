library(ggplot2)
library(AppliedPredictiveModeling)
library(caret)
library(lattice)
library(dplyr)
library(readr)
library(rattle)
library(randomForest)
library(rpart)

## Data loading and exploration:
traindata <- read_csv("Data/pml-training.csv")
head(traindata)
dim(traindata)
names(traindata)
table(traindata$classe)

testdata <- read_csv("Data/pml-testing.csv")
head(testdata)
dim(testdata)

## Data cleansing and tiddying
remove <- which(colSums(is.na(traindata) | traindata=="")>0.9*dim(traindata)[1]) 
traindata <- traindata[,-remove]
traindata <- traindata[,-c(1:7)]
dim(traindata)
str(traindata)

remove <- which(colSums(is.na(testdata) | testdata=="")>0.9*dim(testdata)[1]) 
testdata <- testdata[,-remove]
testdata <- testdata[,-c(1:7)]
dim(testdata)
str(testdata)

## Create training and validation sets
set.seed(12345)
intrain <- createDataPartition(y=traindata$classe, p=0.75, list=FALSE)
training <- traindata[intrain,]
validation <- traindata[-intrain,]
dim(training)
dim(validation)

summary(validation$classe)
summary(training$classe)

  
## Build the different models
### Classification Tree
control <- trainControl(method="cv", number=5)
model1 <- train(classe~., data=training, method="rpart", trControl=control)
print(model1$finalModel)
fancyRpartPlot(model1$finalModel)

### Random Forest
control <- trainControl(method="cv", number=5)
model2 <- train(classe~., data=training, method="rf", trControl=control, verbose=FALSE)
print(model2)
plot(model2, main="Accuracy of Random Forest by Number of Predictors")
plot(model2$finalModel,main="Random Forest Model Error by Number of Trees")

### Gradient Boost
control <- trainControl(method="cv", number=5)
model3 <- train(classe~., data=training, method="gbm", trControl=control, verbose=FALSE)
print(model3)
plot(model3, main="Accuracy of Gradient Boost")

## Predictions from the different models
### Classification Tree
pred1 <- predict(model1, newdata=validation)
confmat1 <- confusionMatrix(as.factor(validation$classe), pred1)
confmat1$table
confmat1$overall[1]

### Random Forest
pred2 <- predict(model2, newdata=validation)
confmat2 <- confusionMatrix(as.factor(validation$classe), pred2)
confmat2$table
confmat2$overall[1]

### Gradient Boost
pred3 <- predict(model3, newdata=validation)
confmat3 <- confusionMatrix(as.factor(validation$classe), pred3)
confmat3$table
confmat3$overall[1]


## Conclusion
predtest <- predict(model2,newdata=testdata)
predtest
critvars <- varImp(model2)
critvars
plot(predtest)