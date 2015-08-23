#Files for "Getting and cleaning data" course project on coursera

run_analysis.R - R script should be placed in the working directory with Samsung dataset unpacked
(place it inside "UCI HAR Dataset" by default)

It will go by these steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It will return tidy dataset made in step 5, which also will be saved in tidy.txt
