Setup of common variables: desiredFeatureColumnIds and desiredFeaturesColumnNames
==================================================================================

The column ids of the features that contain the word "mean" or "std" is 
being identified and recorded in desiredFeatureColumnIds.

The names of the features that contains the word "mean" or "std" is being
identified and recorded in desiredFeaturesColumnNames, with two other column names "activity" and 
"subject"

Reading the necessary columns from the test data into a data frame
==================================================================

Data from test/X_test.txt is first read, 100 rows at a time with the read.fwf function. While reading,
desiredFeatureColumnIds is used to pick up only the column values that we are interested in, into xTestDfWithDesiredVars.
The activity labels are then read from test/y_test.txt and appended, as a new column, to xTestDfWithDesiredVars.
The subject labels are also read from test/subject_test.txt and appended, as a new column, to xTestDfWithDesiredVars.

The column names are then being renamed to the values contained in desiredFeaturesColumnNames.

Reading the necessary columns from the train data into a data frame
==================================================================

Data from train/X_train.txt is then read, 100 rows at a time with the read.fwf function. While reading, 
desiredFeatureColumnIds is used to pick up only the column values that we are interested in, into xTrainDfWithDesiredVars.
The activity labels are then read from train/y_test.txt and appended, as a new column, to xTrainDfWithDesiredVars.
The subject labels are also read from train/subject_test.txt and appended, as a new column, to xTrainDfWithDesiredVars.

The column names are then being renamed to the values contained in desiredFeaturesColumnNames.

Merging the test and train data into a data frame
==================================================

The xTestDfWithDesiredVars and xTrainDfWithDesiredVars data frames are then being merged to a larger data 
frame and stored in finalDf. The numerics that represents the activities are the renamed to more descriptive
labels.

Creating the tidy data frame
====================================

A variable is created: tidyDataDf, is then created to hold the tidy data.  

The average of each measure is first computed based on the activity type, by looping through the 
columns in finalDf, and using the tapply function with the mean function. The return values from the
tapply function calls is the appended to tidyDataDf.

After computing the average based on activities, the average based on subject is calculated via similar means.
The return values from the tapply function calls are also appended to tidyDataDf.

The column names of tidyDataDf was dynamically generated. 

For the average based on activity type, it follows the following form:
Avg <measure_column_name> for <activity_label>

For the average based on subject, it follows the following form:
Avg <measure_column_name> for subject: <subject_id>

All the values in tidyDataDf is of type double.

Writing tidy data frame
===========================

The resultant tidyDataDf is then written to disk via the write.table function. 