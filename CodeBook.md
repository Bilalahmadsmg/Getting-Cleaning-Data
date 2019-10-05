---
title: "CodeBook"
author: "Bilal"
date: "05/10/2019"
output: html_document
---


# CodeBook

The run_analysis.R script performs the data preparation and then followed by the following steps below

### Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

### Assign each data to data frames
features stores the data of features.txt.

activities contains activity_labels.txt data.List of activities performed when the corresponding measurements were taken and its codes (labels)

subject_tests stores test/subject_test.txt data. It comprises of test data of 9/30 volunteer test subjects being observed.

test_values contains test/X_test.txt data i.e. recorded features test data.

test_activities consists of test/y_test.txt i.e.test data of activities’code labels.

subject_training contains test/subject_train.txt i.e training data of 21/30 volunteer subjects being observed.

training_values records test/X_train.txt i.e. recorded features train data.

training_activities contains test/y_train.txt data i.e. training data of activities’code labels

### Step 1. Merges training + test sets to create one data set

*combinedHumanActivityData* is created by merging test and training data using cbind() function

### Step 2. Extracts only the measurements on the mean and standard deviation for each measurement
*requiredData* is obtained by subsetting combinedHumanActivityData, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement.

### Step 3. Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the requiredData replaced with corresponding activity taken from second column of the activities variable.

### Step 4. Appropriately labels the data set with descriptive variable names
code column in requiredData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All variables starting with character f in column’s name replaced by Frequency
All variables starting with character t in column’s name replaced by Time

### Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
*finalTidySet* is created by sumarizing requiredData taking the means of each variable for each activity and each subject, after groupping by subject and activity.
Export finalTidySet into TidyDataSet.txt file.

Thank you. 