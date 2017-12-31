
## Purpose of CodeBook.md
This repo analyzes data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip according to the directions in the course project for the Getting and Cleaning Data course in Coursera's Data Science Specialization.  See README.md in this repo for project directions.  This codebook explains how the data and variable names were selected and adjusted, describes the meaning of the variables, and explains the results in DataAverages.txt, the output file created by the R script run_analysis.R.

## Documentation from Original Data Source
*Copied from the zip folder referenced above.
Describes original data, not results of R script.*

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## License from Original Data Source
*Copied from the zip folder referenced above.*

License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
## Data Selection
The original data has 561 variables.  This project selected 79 of them – all the variables that represent a mean or a standard deviation (containing "mean" or "std" in the variable name).  Variables with "meanFreq" in their names represent weighted averages, so these were retained.  However, variables with both "mean" and "angle" in their names represent an angle between two vectors.  The variables are not means themselves and were removed.  

Each set of measurements comes from measuring one of thirty participants (also called subjects) engaged in one of six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying).  

The R script run_analysis.R creates a tidy data set in a data frame called finalData, which shows the activity and participant ID for each selected set of measurements.  The variable names were changed to make them easier to understand.

The R script also creates a second, independent tidy data set in a data frame called DataAverages.  This data frame is exported to a file DataAverages.txt in the user's working directory.  DataAverages shows the average for each measured variable in finalData for each of the six activities and each of the thirty participants.

## Feature Selection
** Edited information from zip folder referenced above.**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals sing another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm.

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency domain signals.

## Variables in finalData data frame
There are 81 columns in finalData -- one to identify the participant, one to identify the activity, and 79 for measured data variables.

*ParticipantID*: Integer from 1 to 30 (thirty participants, also called subjects)
*ActivityName*: From WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

The names of measurement data variables are constructed from the parts below.  See Feature Selection above for more detail.

ALL MEASUREMENTS ARE NORMALIZED AND BOUNDED WITHIN [-1, 1].

*LinearAcceleration*: Measured using accelerometer, originally measured in standard gravity units "g"
*AngularVelocity*: Measured using gyroscope, originally measured in radians per second
*Jerk*: Calculated from the derivative of LinearAcceleration or Angular Velocity with respect to time

*TimeDomain*: Based on the original measurements
*FrequencyDomain*: Based on the Fast Fourier Transform of original measurements

*Body*: Based on the motion of the participant
*Gravity*: Based on the effect of gravity

*Magnitude*: Magnitude of three dimensional signal
*.X or .Y or .Z*: Identifies axis of measurement (one-dimensional)

*.Mean*: Mean measurement for that trial
*.StdDev*: Standard deviation of the measurements for that trial
*.WeightedMeanFrequency*: Weighted average of frequency components

## Information in DataAverages data frame

DataAverages is a tidy data set meeting the requirements of part 5 of the project directions.

The columns of DataAverages are the same as the columns of finalData.  There are 36 rows -- one for each activity followed by one for each participant.  Each row shows the averages of each measured variable from finalData for each activity and for each participant.  The DataAverages data frame is exported via write.table as DataAverages.txt in the user's working directory.  The variable names are the same as in finalData.
