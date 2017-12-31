## Repo Purpose

This repo contains my work for the course project for the Getting and Cleaning Data course in Coursera's Data Science Specialization.  This repo contains three files:
* README.md (this file)
* run_analysis.R (implements directions in project)
* CodeBook.md (provides background on data, describes implementation of project directions, describes output of run_analysis.R)  
* DataAverages.txt (output of run_analysis.R with result of project direction 5)

## Project Directions (copied from Coursera):
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Explanation of run_analysis.R
The R script run_analysis implements directions for the course project for the Getting and Cleaning Data course in Coursera's Data Science Specialization.  
The data set created in parts 1-4 of the project is called finalData.  
The data set created in part 5 is called DataAverages.  
The script writes DataAverages to a table DataAverages.txt in the working directory.

## Explanation of CodeBook.md
CodeBook.md contains the codebook that explains which data were selected from the original data set, how the variable names were adjusted for clarity, and what the variables represent.  The codebook also contains information about the data from the original documentation that came with the data.
