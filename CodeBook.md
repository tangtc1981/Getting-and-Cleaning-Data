# CodeBook


## Sources

Data Set Description:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## The data

features_info.txt: 
Shows information about the variables used on the feature vector.

features.txt: 
List of all feature names.

activity_labels.txt: 
Links the activity class labels with their activity name.

train/X_train.txt: 
Training set of all the 561 features. Features are normalized and bounded within [-1,1].

train/y_train.txt: 
Training labels of activities. Range is from 1 to 6.

test/X_test.txt: 
Test set of all the 561 features. Features are normalized and bounded within [-1,1].

test/y_test.txt: 
Test labels of activities. Range is from 1 to 6.

train/subject_train.txt: 
Each row identifies the subject who performed the activity for each window sample. Range is from 1 to 30.

test/subject_test.txt: 
Each row identifies the subject who performed the activity for each window sample. Range is from 1 to 30.


## Transformation details

Do combined the files X_train.txt and X_test.txt into the featureData data frame using the rbind command. This data frame has 10299 rows, where each row represents a case corresponding to a particular subject and 561 columns corresponding to the 561 features, where each is a particular measure.

Then combined the files y_train.txt and y_test.txt into the activityLabels data frame using the rbind command. This data frame has 10299 rows and 1 column, where each row represents an activity done by a particular subject.

Next, combined the files subject_train.txt and subject_test.txt into the subjectLabels data frame using the rbind command. This data frame has 10299 rows and 1 column, where each row represents a particular person i.e., subject identifier.

Then, we read in the feature names from the files features.txt and stores it in the featureNames vector with dimensions of 561 x 2. Where each row represents a particular feature consisting of a feature identifier and its corresponding feature name. We transform this into a 561 x 1 vector containing the feature names only and store it back into the featureNames vector.

From the featureNames vector, we get the required feature indices using the grep command for features having both mean and std and store the indices in the reqdfeatureIndices vector of size 66 x 1 representing a total of 66 features. We use the gsub command to remove the () symbols from the variable names and also converted them to lower case following the conventions for variable names.

Then, we read the different activity names corresponding to the activity identifiers from the activity_labels.txt file and transform the activity ids in the activityLabels data frame to form a new data frame activityData of size 10299 x 1 containing all the activity names. We also follow necessary naming conventions by removing underscores and transforming the names to lower case.

Finally we combine the three dataframes, subjectLabels, activityData and featureData to form the data frame cleanData with dimensions 10299 x 68. This is the first required tidy data set and we write it to the files clean_data.csv and clean_data.txt both having the same content. The rows represent a particular case of a perticular subject.

Next, we load the reshape2 package which will be required for creating the next tidy data set.

Next, we set our identifier and measure variables as idVars and measureVars respectively and then we convert our cleanData data frame into a molten data frame meltData with dimensions of 679734 x 4 using the melt function. The idVars contain subjectid and activityname because we will be using them as identifier variables while computing average of the remaining feature variables which are the measure variables here.

Now, we decast our molten data frame into the required aggregated data frame where each feature is averaged per person ( subjectid ) per activity ( activityname ) using the dcast function, and we get our second required tidy data set tidyData which is a data frame having dimensions 180 x 68

Finally write this tidy data set to the files tidy_data.txt
