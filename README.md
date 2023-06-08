# GettingCleaningData
Getting and Cleaning Data Course Assignment


In first place, I set the path of the data folder in R, checking if the data folder exists. Afterwards, I downloaded the file from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip' and saved it as 'descarga.zip' and unzipped it.

I set the width of each column in the text file to 16
and read the text files into dataframes: 
- X files have 16 character width for columns and 561 features
- y files have 1 character width for column and only 1 feature
- I also read the subjects information which has one column and one feature
Later, I combine the three dataframes vertically and  horizontally.


I manage the names of the features reading them from the text file


Later, I select the features of interest and rename column names to the vector of characters


To moodify the name of the activities, I read the names of the activity values and change the values of activity column

Finally, I group the data by subject and activity and average all the variables




The description of the variables used in my code is as follows:

- `url`: The URL of the zip file containing the data.
- `data_folder`: The path of the data folder in R.
- `zip_file`: The path of the zip file.
- `widths`: The width of each column in the text file.
- `df_X_test`: A dataframe containing test set measurements.
- `df_y_test`: A dataframe containing test set activity labels.
- `df_subject_test`: A dataframe containing test set subject IDs.
- `df_X_train`: A dataframe containing training set measurements.
- `df_y_train`: A dataframe containing training set activity labels.
- `df_subject_train`: A dataframe containing training set subject IDs.
- `combined_X_df`: A dataframe containing X values both train and test data.
- `combined_y_df`: A dataframe containing y values both train and test data.
- `combined_subject_df`: A dataframe containing subjects informationboth train and test data.
- `complete_df`: A combination of the three previous dataframes.
- `names`: Names of the features.
- `selected_features`: Names of the features to keep.
- `selected_positions`: Positions of the features to keep.
- `selected_df`: Dataframe from complete_df but only with the features of interest.
- `selected_names`: Names of the features of interest.
- `tidy_names`: Improved names of features.
- `activity_names`: Identification of each activity.
- `df_mean`: Dataframe with the average of each selected feature grouped by activity and subject.
