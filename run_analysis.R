setwd("~/Documents/DataScienceSpecialization/Getting and Cleaning Data/UCI HAR Dataset")

##Reading tables
x_train <- read.table(file = "train/X_train.txt", header = FALSE)
y_train <- read.table(file = "train/y_train.txt", header = FALSE)
subject_train <- read.table(file = "train/subject_train.txt", header = FALSE)
body_acc_x_train <- read.table(file = "train/Inertial Signals/body_acc_x_train.txt", header = TRUE)
body_acc_y_train <- read.table(file = "train/Inertial Signals/body_acc_y_train.txt", header = TRUE)
body_acc_z_train <- read.table(file = "train/Inertial Signals/body_acc_z_train.txt", header = TRUE)
body_gyro_x_train <- read.table(file = "train/Inertial Signals/body_gyro_x_train.txt", header = TRUE)
body_gyro_y_train <- read.table(file = "train/Inertial Signals/body_gyro_y_train.txt", header = TRUE)
body_gyro_z_train <- read.table(file = "train/Inertial Signals/body_gyro_z_train.txt", header = TRUE)
total_acc_x_train <- read.table(file = "train/Inertial Signals/total_acc_x_train.txt", header = TRUE)
total_acc_y_train <- read.table(file = "train/Inertial Signals/total_acc_y_train.txt", header = TRUE)
total_acc_z_train <- read.table(file = "train/Inertial Signals/total_acc_z_train.txt", header = TRUE)
features <- read.table(file = "features.txt", header = TRUE)
activity_labels <- read.table(file = "activity_labels.txt", header = TRUE)
x_test <- read.table(file = "test/X_test.txt", header = FALSE)
y_test <- read.table(file = "test/y_test.txt", header = TRUE)
subject_test <- read.table(file = "test/subject_test.txt", header = TRUE)
body_acc_x_test <- read.table(file = "test/Inertial Signals/body_acc_x_test.txt", header = TRUE)
body_acc_y_test <- read.table(file = "test/Inertial Signals/body_acc_y_test.txt", header = TRUE)
body_acc_z_test <- read.table(file = "test/Inertial Signals/body_acc_z_test.txt", header = TRUE)
body_gyro_x_test <- read.table(file = "test/Inertial Signals/body_gyro_x_test.txt", header = TRUE)
body_gyro_y_test <- read.table(file = "test/Inertial Signals/body_gyro_y_test.txt", header = TRUE)
body_gyro_z_test <- read.table(file = "test/Inertial Signals/body_gyro_z_test.txt", header = TRUE)
total_acc_x_test <- read.table(file = "test/Inertial Signals/total_acc_x_test.txt", header = TRUE)
total_acc_y_test <- read.table(file = "test/Inertial Signals/total_acc_y_test.txt", header = TRUE)
total_acc_z_test <- read.table(file = "test/Inertial Signals/total_acc_z_test.txt", header = TRUE)

#Subjects
##changing colnames, mergind and ordering
colnames(subject_test) <- c("subject_id")
colnames(subject_train) <- c("subject_id")

#Features
##merging x_test, x_train and featureslabels
features <- as.vector(features[ ,2])
sets <- rbind(x_test, x_train)
remove(x_test, x_train)
drop <- c("V560")
sets <- sets[ , !(names(sets) %in% drop)]
colnames(sets) <- features

#Activity
##merging y_test and y_train
library(dplyr)
colnames(y_test) <- c("Activity")
colnames(y_train) <- c("Activity")
Activity <- rbind(y_test, y_train)
Activity <- arrange(Activity)
 
##Merging activity, features and sets
remove(a)
Activity <- as.data.frame(Activity[1:10298,])
sets <- as.data.frame(sets[1:10298,])


run_analysis <- cbind(Activity, sets)


##Extracting only mean and std for each measurement
mean_and_std <- grep("-(mean|std)\\(\\)", Features[,2])
sets <- sets[,mean_and_std]
names(sets) <- Features[mean_and_std, 2]

##Naming activities
#See activity part

##Average per subject
average <- colMeans(run_analysis)
save(run_analysis, file = "dataset.Rdata")
