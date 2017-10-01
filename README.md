# Getting and Cleaning Data Course Project

### CodeBook.md  
Describes the variables, the data, and transformations  

### TidyDataSet.txt  
Text file that is returned after you run the run_analysis.R  

### run_analysis.R  
The code in run_analysis.R will merge the training and test sets into one data set, then extract only the mean and standard deviation for each measurement. It labels the new data set with descriptive variable names and finally makes a tidy data set with the average of each variable for each activity and each subject.

**   Requires packages dplyr & plyr to be installed**  
**   Requires the Samsung folder (UCI HAR Dataset) to be in your working directory**  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
