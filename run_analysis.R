
#  Load required packages
library(dplyr)


#  Download required data files

if(!file.exists("./data")){
  dir.create("./data")
  }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## if folder exists, extract the zip file
if (!file.exists("UCI HAR Dataset")) { 
  unzip("./data/Dataset.zip") 
}

# Reading data and assigning to data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_tests <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_values <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_training <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
training_values <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
training_activities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



# Step 1.  Merges the training and the test sets to create one data set.

combinedHumanActivityData <- rbind(
  cbind(subject_training, training_values, training_activities),
  cbind(subject_tests, test_values, test_activities)
)

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
requiredData <- combinedHumanActivityData %>% select(subject, code, contains("mean"), contains("std"))

# Step 3. Uses descriptive activity names to name the activities in the data set.

requiredData$code <- activities[requiredData$code, 2]

# Step 4. Appropriately labels the data set with descriptive variable names.
names(requiredData)[2] = "activity"
names(requiredData)<-gsub("Acc", "Accelerometer", names(requiredData))
names(requiredData)<-gsub("Gyro", "Gyroscope", names(requiredData))
names(requiredData)<-gsub("BodyBody", "Body", names(requiredData))
names(requiredData)<-gsub("Mag", "Magnitude", names(requiredData))
names(requiredData)<-gsub("^t", "Time", names(requiredData))
names(requiredData)<-gsub("^f", "Frequency", names(requiredData))
names(requiredData)<-gsub("tBody", "TimeBody", names(requiredData))
names(requiredData)<-gsub("-mean()", "Mean", names(requiredData), ignore.case = TRUE)
names(requiredData)<-gsub("-std()", "STD", names(requiredData), ignore.case = TRUE)
names(requiredData)<-gsub("-freq()", "Frequency", names(requiredData), ignore.case = TRUE)
names(requiredData)<-gsub("angle", "Angle", names(requiredData))
names(requiredData)<-gsub("gravity", "Gravity", names(requiredData))


# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

finalTidySet <- aggregate(. ~subject + activity, requiredData, mean)
finalTidySet <- finalTidySet[order(finalTidySet$subject, finalTidySet$activity),]

## Write final tidy data to text file
write.table(finalTidySet, "TidyDataSet.txt", row.name=FALSE)
