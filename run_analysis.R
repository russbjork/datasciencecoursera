##
## Load any required library files
## 
library(dplyr)
##
## Load data frames from the source data files
##
features <- read.table("Data/ucidataset/features.txt", col.names = c("n","functions"))
activities <- read.table("Data/ucidataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("Data/ucidataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("Data/ucidataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("Data/ucidataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("Data/ucidataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("Data/ucidataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("Data/ucidataset/train/y_train.txt", col.names = "code")
##
## Merge the X and Y data
##
XMerged <- rbind(x_train, x_test)
YMerged <- rbind(y_train, y_test)
SubjectMerged <- rbind(subject_train, subject_test)
MergedData <- cbind(SubjectMerged, YMerged, XMerged)
##
## Filter data for columns with mean and standard deviation
##
FilteredData<-MergedData %>% select(subject, code, contains("mean"), contains("std"))
##
## Load descriptive activity names from activities data frame
##
FilteredData$code <- activities[FilteredData$code, 2]
##
## Label the data set with descriptive variable names
##
names(FilteredData)[1] = "Subject"
names(FilteredData)[2] = "Activity"
names(FilteredData)<-gsub("Acc", "Accelerometer", names(FilteredData))
names(FilteredData)<-gsub("Gyro", "Gyroscope", names(FilteredData))
names(FilteredData)<-gsub("BodyBody", "Body", names(FilteredData))
names(FilteredData)<-gsub("Mag", "Magnitude", names(FilteredData))
names(FilteredData)<-gsub("^t", "Time", names(FilteredData))
names(FilteredData)<-gsub("^f", "Frequency", names(FilteredData))
names(FilteredData)<-gsub("tBody", "TimeBody", names(FilteredData))
names(FilteredData)<-gsub("-mean()", "Mean", names(FilteredData), ignore.case = TRUE)
names(FilteredData)<-gsub("-std()", "STD", names(FilteredData), ignore.case = TRUE)
names(FilteredData)<-gsub("-freq()", "Frequency", names(FilteredData), ignore.case = TRUE)
names(FilteredData)<-gsub("angle", "Angle", names(FilteredData))
names(FilteredData)<-gsub("gravity", "Gravity", names(FilteredData))