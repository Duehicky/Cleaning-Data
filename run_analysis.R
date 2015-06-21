##set up directories 
directory <- getwd()
TrainData <- paste(directory,"/TrainData", sep ="")
trainDirectory <-paste(TrainData,"/train", sep ="")
testDirectory <-paste(TrainData,"/test", sep ="")

## get train data
setwd(file.path(trainDirectory))
subTrain <- read.table("subject_train.txt", colClasses = "numeric")
xTrain <- read.table("X_train.txt")
yTrain <- read.table("y_train.txt")

## get test data
setwd(file.path(testDirectory))
subTest <- read.table("subject_test.txt", colClasses = "numeric")
xTest <- read.table("X_test.txt")
yTest <- read.table("y_test.txt")

## get labels and features
setwd(file.path(TrainData))
activityLabels <- read.table("activity_labels.txt", col.names=c("activityId","activityLabel"))
featuresLabels <- read.table("features.txt", col.names=c("featuresId","featureLabel"))

## merge full data
subjectData <- rbind(subTrain, subTest)
names(subjectData) <- "subjectId"
featuresData <- rbind(xTrain, xTest)
activitiesData <- rbind(yTrain, yTest)
names(activitiesData) <- "activityId"
activitiesData <-merge(activitiesData,activityLabels)
names(featuresData) <- featuresLabels$featureLabel

## obtain and combine mean and standard deviation data
meanData <- featuresData[grep("mean", names(featuresData))]
stdData <- featuresData[grep("std", names(featuresData))]
tidyData <- cbind(subjectData,activitiesData, meanData,stdData)

# create a data set with the mean of each column in tidy day by subject and activity
library(data.table)
tidyDataDT <- data.table(tidyData)
write.table(tidyDataDT, "tidyData.txt", row.name=FALSE)

## .SD gets all the columns
meanTidyData<- tidyDataDT[, lapply(.SD, mean), by=c("subjectId", "activityLabel")]
write.table(meanTidyData, "meanTidyData.txt", row.name=FALSE)