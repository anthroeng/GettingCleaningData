# Peer-graded Assignment: Getting and Cleaning Data Course Project
# Data was downloaded and extracted to the Data folder in the working directory

#Libraries
library(dplyr)

# 1 - Merges the training and the test sets to create one data set.

# Getting all dataframes

# Features
features <- read.table("./Data/features.txt", col.names = c("n","functions"))
# Activity names
activities <- read.table("./Data/activity_labels.txt", col.names = c("code", "activity"))
# Test datasets
subject_test <- read.table("./Data/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./Data/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./Data/test/y_test.txt", col.names = "code")
# Train datasets
subject_train <- read.table("./Data/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./Data/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./Data/train/y_train.txt", col.names = "code")

# Merging data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
merged_data <- cbind(subject_data, y_data, x_data)

# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
all_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

# 3 - Uses descriptive activity names to name the activities in the data set.
all_data$code <- activities[all_data$code, 2]

# 4 - Appropriately labels the data set with descriptive variable names.
names(all_data)[2] = "activity"
names(all_data)<-gsub("Acc", "Accelerometer", names(all_data))
names(all_data)<-gsub("Gyro", "Gyroscope", names(all_data))
names(all_data)<-gsub("BodyBody", "Body", names(all_data))
names(all_data)<-gsub("Mag", "Magnitude", names(all_data))
names(all_data)<-gsub("^t", "Time", names(all_data))
names(all_data)<-gsub("^f", "Frequency", names(all_data))
names(all_data)<-gsub("tBody", "TimeBody", names(all_data))
names(all_data)<-gsub("-mean()", "Mean", names(all_data), ignore.case = TRUE)
names(all_data)<-gsub("-std()", "STD", names(all_data), ignore.case = TRUE)
names(all_data)<-gsub("-freq()", "Frequency", names(all_data), ignore.case = TRUE)
names(all_data)<-gsub("angle", "Angle", names(all_data))
names(all_data)<-gsub("gravity", "Gravity", names(all_data))

# 5 - From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.   
tidy_data <- all_data %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)