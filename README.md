Getting-and-Cleaning-Data README
====================================
Assignment submission includes:

README.md - explains how run_analysis.R works and basic overview of the data

CodeBook.md - proivdes details about the data set

run_analysis.R - code to run

tidyData.txt - original tidy data set with only mean and standard deviation columns (parts 1-4 of the assignment)

meanTidyData.txt - required data (part 5 of the assignment)

Data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  has been download and saved in a folder called UCI HAR dataset.

UCI HAR dataset contains two folders one called test with test data and a second with training data called train. The main UCI HAR dataset folder also includes text files features.txt and activity.txt

R script called run_analysis.R that does the following:

1. Set up a list of directories
2. Change working directory to train folder
3. All train data is read into using the read.table command
4. Change working directory to test folder
5. All test data is read into R using the read.table command 
6. Change working directory to the TrainData folder
7. Activities and features data are read into R using the read.table command
8. Test and train data are combined for subjects, activities and features. Column names are adjusted to be more readable in this step
9. Two new data frames are created with only the feature columns with mean or std in their name
10. The mean and standard deviation data frames are combined with subject id and activity names and labels
11. Convert created data frame to a data table and create a file with the data named tidyData
12. Remove character column and convert tidyData to a data table
13. Creates a second, independent tidy data set with the average of all columns in tidyData by subject and activity
14. Formatting of meanTidyData
