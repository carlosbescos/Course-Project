# Course-Project
Script, readme and codebook file for the 'Course Project' for the Getting and Cleaning Data course

This file describes the process to achieve the final tidy data.

The ‘dplyr’ and ‘data.table’ packages are installed and loaded.

Step 1
The Train and Test data are read using read.table with no header.
Then Step 4 is achieve to be able to join Train and Test data.
The column names are read from the features.txt file as a vector and then transpose to be able to applied by using the ‘setnames()’ command from the data.table package.
Then the Train and Test data with the corresponding column names are join by using the ‘rbind()’ command.

The subject data for Train and Test are loaded and the column name pasted by using the ‘names()’ command.
The Train and Test subject data are join together.

The activity data for Train and Test are loaded and the column name pasted by using the ‘names()’ command.
The Train and Test activity data are join together.

Finally subject, measurements and activity data are merged together by using the ‘cbind()’ command.

The data table in R for step 1 is ‘dataTotal’. 

Step 2
The process to extract the mean and standard deviation data is achieved by two steps based on the data table ‘dataTotal’.
In the first step, the mean value measurements are extracted and in the second step, the standard deviation value measurements are extracted by using the ‘grep()’ command.

Finally the two data frames are merged together with the subject and activity data by using ‘cbind()’ command.

The data table in R for step 2 is ‘dataStep2’. 

Step 3
The descriptive activity names form the final ‘activity_labels.txt’ are assigned to the activity labels in step 3 and the ‘cbind()’ command is used to build the data table.

The data table in R for step 3 is ‘dataStep3’. 

Step 4
The column names are read from the features.txt file as a vector and then transpose to be able to applied by using the ‘setnames()’ command from the data.table package.

Step 5
To create the final tidy data containing the mean measurements values according to subject and activity, the command ‘summarise_each()’ is used but based on a group selection by ‘subject’ and ‘activity’ by using the ‘group_by()’ command.

The data table in R for step 5 is ‘dataStep5’. 

Finally the ‘dataStep5’ data table is written to a file by using the ‘write.table()’ command.
