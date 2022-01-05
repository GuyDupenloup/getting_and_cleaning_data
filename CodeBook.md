# myHAR dataset codebook

This codebook describes the contents of the myHAR dataset and the process that was used to derive it from the HAR dataset.

## HAR dataset

The Human Activity Recognition (HAR) Using Smartphones dataset was created by:

    Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
    Smartlab - Non Linear Complex Systems Laboratory
    DITEN - Universita degli Studi di Genova.
    Via Opera Pia 11A, I-16145, Genoa, Italy.
	
Use this link to access the HAR dataset homepage:\
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The authors of the HAR dataset carried out experiments with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six 
activities (walking, walking_upstairs, walking_downstairs, sitting, standing, laying) wearing a smartphone on the waist. 
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec 
and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz 
cutoff frequency was used.

These signals were used to generate the following signals for each pattern ('XYZ' is used to denote 3-axial signals in the X, Y and Z directions):
   - tBodyAcc-XYZ
   - tGravityAcc-XYZ
   - tBodyAccJerk-XYZ
   - tBodyGyro-XYZ
   - tBodyGyroJerk-XYZ
   - tBodyAccMag
   - tGravityAccMag
   - tBodyAccJerkMag
   - tBodyGyroMag
   - tBodyGyroJerkMag
   - fBodyAcc-XYZ
   - fBodyAccJerk-XYZ
   - fBodyGyro-XYZ
   - fBodyAccMag
   - fBodyAccJerkMag
   - fBodyGyroMag
   - fBodyGyroJerkMag

Then, variables were estimated from these signals to create a feature vector that has 561 variables.

As the HAR dataset is intended to be used to develop and benchmark machine learning algorithms, it was partitioned into a training set and a test set.

For the training set:
   - The values of the feature vector variables for each record are provided in a text file named "X_train.txt" that contains a table of real numbers 
     with 7,352 rows (the number of records) and 561 columns (the number of features). There is no header in this table. The names of the feature vector 
	 variables are provided in a separate text file named "features.txt".
   - The type of activity being performed for each record is provided in a text file named "y_train.txt" containing a column vector with 7,352 rows. 
   Activity values are encoded using integers with values ranging from 1 to 6. The mapping of integer values to activity names is provided in a
   text file named "activity_labels.txt": 1 corresponds to "walking", 2 corresponds to "walking_upstairs", etc.
   - The ID of the subject performing the activity for each record is provided in another text file named "subject_train.txt" containing a column vector 
   with 7,352 rows. Subject IDs are integers with values ranging from 1 to 30.

The test set data is structured in the same way as the training set data. The string "_train" in filenames is replaced by the string "_test". There are
2,947 records in the test set.

Additional text files are provided that contain the values of the phone sensor signals that were captured during activities.  They contain tables of 
real numbers. They were not used to create the myHAR dataset.

## Creation of the myHAR dataset

The myHAR dataset was created as follows:
   1. The HAR training set and test set tables containing the values of the feature vector variables for each record were merged (stacked) 
   to create a single table with 10,299 rows and 561 columns.
   2. The variables of this new table were named using the "features.txt" text file that provides the names of the feature vector variables.
   3. All the variables that are not mean or standard deviation variables were discarded, reducing the number of variables from 561 to 66. 
   The names of the variables were used to identify mean and standard deviation variables. The names of mean variables contain the string "-mean()"
   and the names of standard deviation variables contain the string "-std()".
   4. The records were grouped by activity, then by subject. Then, the average of each variable across records was computed. The resulting data frame 
   has 180 rows and 68 columns (including the activity and subject variables).
   5. The suffix "-avg" was added to the name of each variable to indicate that they are average variables.
   6. The activity vectors of the training set and test set were merged (stacked) to create a single column vector. The integer values that
   encoded the types of activity being performed were replaced with their corresponding names using the "activity labels.txt" mapping file.
   7. The subject ID vectors of the training set and test set were merged (stacked) in a similar way as the activity vectors.
   8. The activity and subject vectors were appended to the left of the table of mean and standard deviation variables. 
   9. The records were grouped by activity, then by subject. Then, the average of each variable across records was computed. The resulting data frame
   has 180 rows and 68 columns.
   10. The dataset was saved to a text file containing a table of real numbers with a header.

The version of the HAR dataset that was used is Version 1.0.

## myHAR dataset variables

The first two variables of the myHAR dataset are:

_activity_\
    - Contains the name of the activity being performed\
    - Values (factors): walking, walking_upstairs, walking_downstairs, sitting, standing, laying

_subject_\
    - Contains the ID of the subject performing the activity\
    - Values (factors): integers ranging from 1 to 30

All the other variables are averages of the mean and standard deviation variables that were extracted from the feature vector variables of the HAR dataset. 
The averages were calculated across records grouped by activity and subject (in this order).

A complete list of the feature vector variables of the HAR dataset is available in the "features.txt" text file. 
You can get the list of all the variables that were selected to create the myHAR dataset as follows:\
    - Look for variables in "features.txt" with names that include the string "-mean()" (mean variables) or "-std()" (standard deviation variables)\
	- The corresponding variables in the myHAR dataset have the same names suffixed with "-avg" to indicate that they are averages.
	
For example, the variable _tBodyAcc-mean()-X_ of the HAR dataset is a mean variable. The corresponding variable in the myHAR dataset is 
named _tBodyAcc-mean()-X-avg_.
