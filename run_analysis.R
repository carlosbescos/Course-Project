install.packages("dplyr")
library(dplyr)

install.packages("data.table")
library(data.table)

#STEP 1
#Reading the data
Train <- read.table("./data/train/X_train.txt", stringsAsFactors=FALSE, header = FALSE)
Test <- read.table("./data/test/X_test.txt", stringsAsFactors=FALSE, header = FALSE)
#STEP 4 Appropriately labels the data set with descriptive variable names
colName <- read.table("./data/features.txt", stringsAsFactors=FALSE, header = FALSE)
colName <- select(colName, V2)
#Transpose the matrix to have 561 column names
colNameT <- t(colName)
#Apply the column names
setnames(Train, old=names(Train), new=colNameT)
setnames(Test, old=names(Test), new=colNameT)
#Merge the training and test sets
valTotal <- rbind(Train, Test)

#Load, name and merge the subject data
subjectTrain <- read.table("./data/train/subject_train.txt", stringsAsFactors=FALSE, header = FALSE)
subjectTest <- read.table("./data/test/subject_test.txt", stringsAsFactors=FALSE, header = FALSE)
names(subjectTrain)[1]<-paste("subject")
names(subjectTest)[1]<-paste("subject")
subjectTotal <- rbind(subjectTrain, subjectTest)

#Load, name and merge the activity data
activTrain <- read.table("./data/train/y_train.txt", stringsAsFactors=FALSE, header = FALSE)
activTest <- read.table("./data/test/y_test.txt", stringsAsFactors=FALSE, header = FALSE)
names(activTrain)[1]<-paste("activity")
names(activTest)[1]<-paste("activity")
activTotal <- rbind(activTrain, activTest)

#Merge subject, sets and activities together for training and test data
dataTotal <- cbind(subjectTotal, valTotal, activTotal)

#STEP 2
#Extracts only the measurements on the mean and standard deviation for each measurement
dataStep2a <- dataTotal[grep("mean()",names(dataTotal),fixed = TRUE)]
dataStep2b <- dataTotal[grep("std()",names(dataTotal),fixed = TRUE)]
#Merge subject, sets and activities together for the mean and std
dataStep2 <- cbind(subjectTotal, dataStep2a, dataStep2b, activTotal)

#STEP 3
#Uses descriptive activity names to name the activities in the data set
activTotal[activTotal$activity==1,1] <- "WALKING"
activTotal[activTotal$activity==2,1] <- "WALKING_UPSTAIRS"
activTotal[activTotal$activity==3,1] <- "WALKING_DOWNSTAIRS"
activTotal[activTotal$activity==4,1] <- "SITTING"
activTotal[activTotal$activity==5,1] <- "STANDING"
activTotal[activTotal$activity==6,1] <- "LAYING"

dataStep3 <- cbind(subjectTotal, dataStep2a, dataStep2b, activTotal)

#STEP 5
#Create a tidy data set by grouping by subject and activity with mean for every variable
dataStep5a <- dataStep3 %>% group_by(subject, activity)
dataStep5 <- dataStep5a %>% summarise_each(funs(mean))

#Write to a file in the data folder
write.table(dataStep5, file = "./data/step5result.txt", row.names = FALSE)
