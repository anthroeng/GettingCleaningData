The run_analysis.R sript performs the required analysis for the Getting and Cleaning Data Course Project

Download the dataset
Dataset downloaded and extracted under the folder called Data

Each dataset was assigned to a variable
features <- features.txt
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt List of activities performed when the corresponding measurements were taken and its codes (labels)
subject_test <- test/subject_test.txt contains test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt contains recorded features test data
y_test <- test/y_test.txt contains test data of activities'code labels
subject_train <- test/subject_train.txt contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt contains recorded features train data
y_train <- test/y_train.txt contains train data of activities'code labels

*Step 1*
Merges the training and the test sets to create one data set, using the rbind() function
"x_data" is created by merging x_train and x_test
y_data is created by merging y_train and y_test
subject_data is created by merging subject_train and subject_test
merged_data is created by merging subject_data, y_data and x_data

*Step 2*
Extracts only the measurements on the mean and standard deviation for each measurement
all_data is created by subsetting merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

*Step 3*
Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the all_data replaced with corresponding activity taken from second column of the activities variable

*Step 4*
Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All Acc in column's name replaced by Accelerometer
All Gyro in column's name replaced by Gyroscope
All BodyBody in column's name replaced by Body
All Mag in column's name replaced by Magnitude
All start with character f in column's name replaced by Frequency
All start with character t in column's name replaced by Time

*Step 5*
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data is created by summarizing all_data taking the means of each variable for each activity and each subject, after grouped by subject and activity.
Finnaly export the data to a .txt file named "tidy_data"