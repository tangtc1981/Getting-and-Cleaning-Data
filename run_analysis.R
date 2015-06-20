## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Load activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Select the measurements on the mean and standard deviation for each measurement.
measures <- grepl("mean|std", features)

# Load and process x_test & y_test data.
testX <- read.table("./UCI HAR Dataset/test/x_test.txt")

testY <- read.table("./UCI HAR Dataset/test/y_test.txt")

testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(testX) = features

# Select the measurements on the mean and standard deviation for each measurement.
testX = testX[,measures]

# Load activity labels
testY[,2] = activityLabels[testY[,1]]

names(testY) = c("Activity_ID", "Activity_Label")

names(testSubject) = "subject"

# Bind data
testData <- cbind(as.data.table(testSubject), testY, testX)

# Load and process x_train & y_train data.
trainX <- read.table("./UCI HAR Dataset/train/x_train.txt")

trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")

trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(trainX) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
trainX = trainX[,measures]

# Load activity data
trainY[,2] = activityLabels[trainY[,1]]

names(trainY) = c("Activity_ID", "Activity_Label")

names(trainSubject) = "subject"

# Bind data
trainData <- cbind(as.data.table(trainSubject), trainY, trainX)

# Merge test and train data
mergeData = rbind(testData, trainData)

labelId   = c("subject", "Activity_ID", "Activity_Label")

labelData = setdiff(colnames(mergeData), labelId)

meltData      = melt(mergeData, id = id_labels, measure.vars = labelData)

# Apply mean function to dataset using dcast function
tidyData   = dcast(meltData, subject + Activity_Label ~ variable, mean)

write.table(tidyData, file = "./tidy_data.txt", row.name = FALSE)
