##libraries used
library(data.table)
library(dplyr)

##set up directories 
directory <- getwd()
TrainData <- paste(directory,"/UCI HAR Dataset", sep ="")
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
activityLabels <- read.table("activity_labels.txt", col.names=c("activityId","activityLabel"), colClasses=c("numeric","character"))
featuresLabels <- read.table("features.txt", col.names=c("featuresId","featureLabel"))

## merge full data
subjectData <- rbind(subTrain, subTest)
names(subjectData) <- "subjectId"
featuresData <- rbind(xTrain, xTest)
activitiesData <- rbind(yTrain, yTest)
names(activitiesData) <- "activityId"
activitiesData <-merge(activitiesData,activityLabels, by.x="activityId", by.y="activityId")
names(featuresData) <- featuresLabels$featureLabel
fullData <- cbind(subjectData,activitiesData, featuresData)

## obtain and combine mean and standard deviation data
meanStdData<- fullData[grep("mean\\(\\)|std\\(\\)", names(fullData))]
tidyData <- cbind(subjectData,activitiesData, meanStdData)
cleanNames <- gsub("\\()","",names(tidyData))
cleanNames <- gsub("\\-","",cleanNames)
names(tidyData) <- cleanNames

## create a data set with the mean of each column in tidy data by subject and activity
tidyDataDT <- data.table(tidyData)
write.table(tidyDataDT, "tidyData.txt", row.name=FALSE)

## reset so there is only numeric values
activitiesData <- rbind(yTrain, yTest)
tidyData <- cbind(subjectData,activitiesData, meanStdData)
cleanNames <- gsub("\\()","",names(tidyData))
cleanNames <- gsub("\\-","",cleanNames)
names(tidyData) <- cleanNames
tidyDataDT <- data.table(tidyData)

## .SD gets all the columns, the rest is formatting
meanTidyData<- tidyDataDT[, lapply(.SD, mean), by=c("subjectId", "V1")]
meanTidyData<-merge(activityLabels,meanTidyData, by.x="activityId", by.y="V1")
meanTidyData <-arrange(meanTidyData, subjectId, activityId)
meanTidyData <-meanTidyData[-1]
meanTidyData <- meanTidyData[,c(2,1,3:68)]
write.table(meanTidyData, "meanTidyData.txt", row.name=FALSE)
