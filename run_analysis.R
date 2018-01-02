#Course Project for Getting and Cleaning Data
#Coursera Data Science Specialization

#The project assumes the Samsung data are in the user's working directory.  
#Just in case, check for the folder with the dataset and download it if it isn't found.
if (!file.exists("UCI HAR Dataset")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest="dataset.zip", mode="wb") 
    unzip ("dataset.zip", exdir = getwd())
}

#Read in the test and training data and combine into a single data set.
testData <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/X_test.txt"), header = FALSE)
trainData <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/X_train.txt"), header = FALSE)
fullData <- rbind(testData, trainData)

#Each line of fullData represents measurements of a participant (also called a subject) performing an activity.
#There are six types of activity and thirty participants.
#Read in information about the activity and participant information about each row.
#Activities are coded 1-6.  Read in labels that describe each activity.  Attach descriptions and codes.
testActivities <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/y_test.txt"), header = FALSE)
trainActivities <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/y_train.txt"), header = FALSE)
fullActivities <- rbind(testActivities, trainActivities)

ActivityNames <- read.table(paste0(getwd(),"/UCI HAR Dataset/activity_labels.txt"), header = FALSE)
fullActivities$ActivityName <- factor(fullActivities$V1, labels = ActivityNames$V2) 

testSubjects <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/subject_test.txt"), header = FALSE)
trainSubjects <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/subject_train.txt"), header = FALSE)
fullSubjects <- rbind(testSubjects, trainSubjects)
names(fullSubjects) <- "ParticipantID"

#Read in column headings for data.  These headings describe measurements in each column.
#Transfer column headings to data.
header <- read.table(paste0(getwd(),"/UCI HAR Dataset/features.txt"), header = FALSE)
names(fullData) <- header$V2

#Remove data columns that do not include "mean" or "std" (for standard deviation).  Case insensitive.
mean_sd_logical <- grepl("[Mm][Ee][Aa][Nn]", names(fullData)) | grepl("[Ss][Tt][Dd]", names(fullData))
Data_mean_sd <- fullData[ , mean_sd_logical]

#remove columns about angles of means
Data_mean_sd <- Data_mean_sd[ , !grepl("angle", names(Data_mean_sd))]

#We now have the requested data.  Clean up the column names to make them easier to understand.
tempNames <- names(Data_mean_sd) 
#remove () from every column name
tempNames <- sub("\\(\\)", "", tempNames)
#replace initial t with TimeDomain
tempNames <- sub("^t", "TimeDomain", tempNames)
#replace initial f with FrequencyDomain (for Fast Fourier Transform)
tempNames <- sub("^f", "FrequencyDomain", tempNames)
#replace Acc with LinearAcceleration
tempNames <- sub("Acc", "LinearAcceleration", tempNames)
#replace Gyro with AngularVelocity
tempNames <- sub("Gyro", "AngularVelocity", tempNames)
#replace Mag with Magnitude
tempNames <- sub("Mag", "Magnitude", tempNames)
#replace mean with Mean
tempNames <- sub("mean", "Mean", tempNames)
#replace std with StdDev
tempNames <- sub("std", "StdDev", tempNames)
#replace BodyBody with Body to fix typos
tempNames <- sub("BodyBody", "Body", tempNames)
#replace MeanFreq with WeightedMeanFrequency
tempNames <- sub("MeanFreq", "WeightedMeanFrequency", tempNames)
#assign column names to measurement data
names(Data_mean_sd) <- tempNames

#Combine information about participants and activities with measurement data.
finalData <- data.frame(fullSubjects, fullActivities$ActivityName, Data_mean_sd)
names(finalData)[2] <- "ActivityName"
#Result is finalData -- a tidy data set of selected data from original dataset

#Goal: create "a second, independent tidy data set with the average 
#of each variable for each activity and each subject."
#Initialize the data frame for the new data set, 
#One row for each combination of activity and participants (6 activities times 30 participants = 180 rows). 
#Same number of columns as finalData.
#Make 30 blocks of 6 rows each.
#Each block has all mean measurements in all activities for a particular participant.
#I decided to use same column headings in DataAverages as in finalData, 
#but in DataAverages the data values represent averages.

DataAverages <- data.frame(matrix(nrow = 6*30, ncol = ncol(finalData)))
names(DataAverages) <- names(finalData)

#Label combinations of Participant IDs and Activities
#Make 30 blocks of 6 rows each.
#Each block uses a single participant ID and all 6 activities.
DataAverages$ParticipantID <- rep(1:30, each = 6)
DataAverages$ActivityName <- rep(ActivityNames$V2, times = 30)

#Find means for each variable by combination of participant and activity.
#Measurement variables start in column 3 of finalData.
#First two columns indicate participant ID number and activity name.

for (i in 3:ncol(DataAverages)){
    DataAverages[ , i] <- as.vector(tapply(finalData[ , i], 
                                    list(finalData$ActivityName, finalData$ParticipantID), 
                                    mean))
}

#export DataAverages to txt file in working directory
write.table(DataAverages, "DataAverages.txt", row.names = FALSE)
