#Install plyr & dplyr packages if you have not already
#install.packages("plyr")
#install.packages("dplyr")

##The Samsung folder (UCI HAR Dataset) must be in your working directory

library(plyr)
library(dplyr) ### Be sure dplyr is loaded after plyr otherwise Summarize function will not work properly.

setwd("./UCI HAR Dataset")
features <- read.table("features.txt") #Read 'features' file
activity_labels <- read.table("activity_labels.txt") #Read 'activity_labels' file

###Format Training Data
setwd("./train") #Change Directory to 'train' folder

x_train <- read.table("X_train.txt") #Read 'X_train' file
        colnames(x_train) <- features[,2] #Change column names. Refers to 'features' file.
subject_train <- read.table("subject_train.txt") #Read 'subject_train' file
        colnames(subject_train) <- "Subject" #Add heading to Subject column
y_train <- read.table("y_train.txt") #Read 'y_train' file
        y_train2 <- join(y_train, activity_labels, by="V1")[2] ##Converts numbers to labels
        colnames(y_train2) <- "Activity" ###Step 3 (1 of 2) Complete

train_table <- cbind(subject_train, y_train2, x_train) #Combine all TRAIN data into one table

###Format Test Data
setwd("..")
setwd("./test") #Change Directory to 'test' folder

x_test <- read.table("X_test.txt") #Read 'X_test' file
        colnames(x_test) <- features[,2] #Change column headings. Refers to 'features' file.
subject_test <- read.table("subject_test.txt") #Read 'subject_test' file
        colnames(subject_test) <- "Subject" #add heading to Subject column
y_test <- read.table("y_test.txt") #Read 'y_test' file
        y_test2 <- join(y_test, activity_labels, by="V1")[2] #Converts Activity numbers to labels
        colnames(y_test2) <- "Activity"

test_table <- cbind(subject_test, y_test2, x_test) #Combine all TEST data into one table

###Create Full File
full_table <- rbind(train_table,test_table)

###Extract only mean and standard deviation
mean_std <- grep("mean\\(\\)|std\\(\\)", colnames(full_table)) #Stores all columns with the strings "mean()" or "std()"
full_table_MeanStd <- full_table[c(1,2,mean_std)] 

###Clean up the variable names
var_names <- gsub("()","", colnames(full_table_MeanStd), fixed = TRUE) #Remove '()' from all columns
	colnames(full_table_MeanStd) <- var_names
var_names <- gsub("-","_", colnames(full_table_MeanStd), fixed = TRUE) #Replace all '-' with '_' in all columns
	colnames(full_table_MeanStd) <- var_names

###Tidy data set with average of each variable for each Activity and each Subject.
TidyData <- full_table_MeanStd %>%
	group_by(Subject, Activity) %>%
	summarize_all(funs(mean))

###Save text file to working directory
setwd("..")
setwd("..")
write.table(TidyData, "TidyDataSet.txt", row.name=FALSE) #File will be placed in your working directory
