# Samsung-Data
Getting and cleaning data


The r script run_analysis.R is written with the intent of getting, cleaning and modifying the "UCI HAR Dataset" so as to obtain tidy data from it.

The output of this dataset is a tidy dataset called "my_data" and a result data set with the required computations made of finding the averages of all variables in the tidy dataset of all subjects and all activities. This is stored in the dataframe "result_data" and is written onto the result_data.txt file


The script:
1. Merges the training and the test sets to create one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

