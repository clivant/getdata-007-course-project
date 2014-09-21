# Define the column ids and names that we want to extract

desiredFeatureColumnIds <- c(1, 2, 3, 4, 5, 6, 
                             41, 42, 43, 44, 45, 46, 
                             81, 82, 83, 84, 85, 86, 
                             121, 122, 123, 124, 125, 
                             126, 161, 162, 163, 164, 
                             165, 166, 201, 202, 214, 
                             215, 227, 228, 240, 241, 
                             253, 254, 266, 267, 268, 
                             269, 270, 271, 294, 295, 
                             296, 345, 346, 347, 348, 
                             349, 350, 373, 374, 375, 
                             424, 425, 426, 427, 428, 
                             429, 452, 453, 454, 503, 
                             504, 513, 516, 517, 526, 
                             529, 530, 539, 542, 543, 
                             552, 555, 556, 557, 558, 
                             559, 560, 561)

desiredFeaturesColumnNames <- c('tBodyAcc-mean()-X', 'tBodyAcc-mean()-Y', 'tBodyAcc-mean()-Z', 
                                'tBodyAcc-std()-X', 'tBodyAcc-std()-Y', 'tBodyAcc-std()-Z', 
                                'tGravityAcc-mean()-X', 'tGravityAcc-mean()-Y', 'tGravityAcc-mean()-Z', 
                                'tGravityAcc-std()-X', 'tGravityAcc-std()-Y', 'tGravityAcc-std()-Z', 
                                'tBodyAccJerk-mean()-X', 'tBodyAccJerk-mean()-Y', 'tBodyAccJerk-mean()-Z', 
                                'tBodyAccJerk-std()-X', 'tBodyAccJerk-std()-Y', 'tBodyAccJerk-std()-Z', 
                                'tBodyGyro-mean()-X', 'tBodyGyro-mean()-Y', 'tBodyGyro-mean()-Z', 
                                'tBodyGyro-std()-X', 'tBodyGyro-std()-Y', 'tBodyGyro-std()-Z', 
                                'tBodyGyroJerk-mean()-X', 'tBodyGyroJerk-mean()-Y', 'tBodyGyroJerk-mean()-Z', 
                                'tBodyGyroJerk-std()-X', 'tBodyGyroJerk-std()-Y', 'tBodyGyroJerk-std()-Z', 
                                'tBodyAccMag-mean()', 'tBodyAccMag-std()', 'tGravityAccMag-mean()', 
                                'tGravityAccMag-std()', 'tBodyAccJerkMag-mean()', 'tBodyAccJerkMag-std()', 
                                'tBodyGyroMag-mean()', 'tBodyGyroMag-std()', 'tBodyGyroJerkMag-mean()', 
                                'tBodyGyroJerkMag-std()', 'fBodyAcc-mean()-X', 'fBodyAcc-mean()-Y', 
                                'fBodyAcc-mean()-Z', 'fBodyAcc-std()-X', 'fBodyAcc-std()-Y', 'fBodyAcc-std()-Z', 
                                'fBodyAcc-meanFreq()-X', 'fBodyAcc-meanFreq()-Y', 'fBodyAcc-meanFreq()-Z', 
                                'fBodyAccJerk-mean()-X', 'fBodyAccJerk-mean()-Y', 'fBodyAccJerk-mean()-Z', 
                                'fBodyAccJerk-std()-X', 'fBodyAccJerk-std()-Y', 'fBodyAccJerk-std()-Z', 
                                'fBodyAccJerk-meanFreq()-X', 'fBodyAccJerk-meanFreq()-Y', 'fBodyAccJerk-meanFreq()-Z', 
                                'fBodyGyro-mean()-X', 'fBodyGyro-mean()-Y', 'fBodyGyro-mean()-Z', 'fBodyGyro-std()-X', 
                                'fBodyGyro-std()-Y', 'fBodyGyro-std()-Z', 'fBodyGyro-meanFreq()-X', 
                                'fBodyGyro-meanFreq()-Y', 'fBodyGyro-meanFreq()-Z', 'fBodyAccMag-mean()', 
                                'fBodyAccMag-std()', 'fBodyAccMag-meanFreq()', 'fBodyBodyAccJerkMag-mean()', 
                                'fBodyBodyAccJerkMag-std()', 'fBodyBodyAccJerkMag-meanFreq()', 
                                'fBodyBodyGyroMag-mean()', 'fBodyBodyGyroMag-std()', 'fBodyBodyGyroMag-meanFreq()', 
                                'fBodyBodyGyroJerkMag-mean()', 'fBodyBodyGyroJerkMag-std()', 
                                'fBodyBodyGyroJerkMag-meanFreq()', 'angle(tBodyAccMean,gravity)', 
                                'angle(tBodyAccJerkMean),gravityMean)', 'angle(tBodyGyroMean,gravityMean)', 
                                'angle(tBodyGyroJerkMean,gravityMean)', 'angle(X,gravityMean)', 
                                'angle(Y,gravityMean)', 'angle(Z,gravityMean)', 'activity', 'subject')

featureWidths <- rep(16, each=561)

numColsToReadEachTime <- 100

# 1. Merges the training and the test sets to create one data set.

# Read test data frame, 100 rows at a time

xTestRecordsReadSoFar <- 0
xTestDfWithDesiredVars <- numeric()
while (xTestRecordsReadSoFar < 2947) {
  
  df <- read.fwf(file = 'test/X_test.txt', skip=xTestRecordsReadSoFar, n=numColsToReadEachTime, widths=featureWidths)
  xTestDfWithDesiredVars <- rbind(xTestDfWithDesiredVars, df[ , desiredFeatureColumnIds])
  xTestRecordsReadSoFar <- xTestRecordsReadSoFar + numColsToReadEachTime

}

# Append column of activity labels to test data
testActivityLabels <- scan('test/y_test.txt')
xTestDfWithDesiredVars <- cbind(xTestDfWithDesiredVars, testActivityLabels)

# Append column of subject to test data
testSubjectLabels <- scan('test//subject_test.txt')
xTestDfWithDesiredVars <- cbind(xTestDfWithDesiredVars, testSubjectLabels)

#Rename columns of test data frame
colnames(xTestDfWithDesiredVars) <- desiredFeaturesColumnNames

# Read train data frame, 100 rows at a time

xTrainRecordsReadSoFar <- 0
xTrainDfWithDesiredVars <-numeric()
while(xTrainRecordsReadSoFar < 7352) {
  
  df <- read.fwf(file = 'train/X_train.txt', skip=xTrainRecordsReadSoFar, n=numColsToReadEachTime, widths=featureWidths)
  xTrainDfWithDesiredVars <-rbind(xTrainDfWithDesiredVars, df[ , desiredFeatureColumnIds]);
  xTrainRecordsReadSoFar <- xTrainRecordsReadSoFar + numColsToReadEachTime
  
}

# Append column of activity to train data
trainActivityLabels = scan('train/y_train.txt')
xTrainDfWithDesiredVars <- cbind(xTrainDfWithDesiredVars, trainActivityLabels)

#Append column of subject to test data
trainSubjectLabels = scan('train/subject_train.txt')
xTrainDfWithDesiredVars <- cbind(xTrainDfWithDesiredVars, trainSubjectLabels)

#Rename columns of train data frame
colnames(xTrainDfWithDesiredVars) <- desiredFeaturesColumnNames

#Merge both datasets
finalDf <- rbind(xTestDfWithDesiredVars, xTrainDfWithDesiredVars)

# Use descriptive activity names to name the activities in the data set
finalDf[finalDf$activity == 1, ]$activity = 'WALKING'
finalDf[finalDf$activity == 2, ]$activity = 'WALKING_UPSTAIRS'
finalDf[finalDf$activity == 3, ]$activity = 'WALKING_DOWNSTAIRS'
finalDf[finalDf$activity == 4, ]$activity = 'SITTING'
finalDf[finalDf$activity == 5, ]$activity = 'STANDING'
finalDf[finalDf$activity == 6, ]$activity = 'LAYING'

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Create a dataframe with placeholder 
tidyDataDf <- data.frame(placeHolderCol <- NA)

# for loop to build average measure per activity
for (finalDfColName in names(finalDf)) {
  
  # Skip the activity and subject columnn
  if (finalDfColName == 'activity' || finalDfColName == 'subject') {
    next
  }
  
  # calculate the average of measure per activity
  avgOfMeasurePerActivity <- tapply(finalDf[[finalDfColName]], finalDf$activity, mean)
  
  for (activityName in names(avgOfMeasurePerActivity)) {
    tidyDataDf[ , paste0('Avg ', finalDfColName, ' for ', activityName)] <- avgOfMeasurePerActivity[[activityName]]
  }
  
    
} # End for loop to build average measure per activity

# for loop to build average measure per subject
for (finalDfColName in names(finalDf)) {
  
  # Skip the activity and subject columnn
  if (finalDfColName == 'activity' || finalDfColName == 'subject') {
    next
  }
  
  # calculate the average of measure per activity
  avgOfMeasurePerSubject <- tapply(finalDf[[finalDfColName]], finalDf$subject, mean)
  
  # Build the columns dynamically to tidy data frame
  for (subject in names(avgOfMeasurePerSubject)) {
    tidyDataDf[ , paste0('Avg ', finalDfColName, ' for subject: ', subject)] <- avgOfMeasurePerSubject[[subject]]
  }
  
  
} # End for loop to build average measure per activity

# Remove the placeholder column
tidyDataDf <- tidyDataDf[ , 2:ncol(tidyDataDf)]
