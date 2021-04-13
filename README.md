# GettingCleaningData_AssignmentWeek4

This repo was created for the Programming Assignment of the course Getting and Cleaning Data. 

For a further explanation see also the CodeBook.

## Describing the Transformation
The package dplyr was used to transform the data.

The data was created by transforming the data from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
using the test and train data sets
- subject_test.txt, subjext_train.txt: containing the subjects (compare to column
one of our cleaned data set)
- X_test.txt, X_train.txt: containing the features
- y_test.txt, y_train.txt: containing the activties
- activity_labels.txt: includes the encoding of y_test and y_train
- features.txt: including the column names of X_test and X_train

Steps to create the tiny data set
1. Download and unzip the raw data
2. Merge the tiny and the test data for each type (activtiy, feature and subject)
3. Use the column names stored in features.txt
4. Merge the whole data together
5. Select - except for subject and activtiy - only the columns that contain mean
or std
6. Replace the coded activity by its description stored in activtiy_labels.txt 
7. Rename the columns so they can be understood intuitively 
8. Create a tidy data set containing the average of each variable for each 
subject and activtiy and store it
