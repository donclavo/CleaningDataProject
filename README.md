---
title: "ReadMe"
author: "Javier Clavijo"
date: "27 de septiembre de 2015"
output: html_document
---
# CleaningDataProject
Relevants files for the Cleaning Data assignment of Coursera.

##ReadMe

The script *run_analysis.R*  contains the process taken to transform the raw data of an experiment for wearable devices into a summarized tidy data set. 
The details of the experiment can be found in

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. 

The raw data and explanation of raw variables can be extracted from

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.

The script perform the next task:       

* Read all the relevant tables of the Raw Data folder for train and test.
* Merges the table containing the subject ID, and the Activities ID for the train set and the test set.
* Merges the resulting train and merge set in just one big data set.
* Extracts exclusively the columns with information of the mean and standard deviation (STD) measurements, obtaining a Reduced Dataset. 
* Transform all the activities IDs with their descriptive name.
* Create names for all columns according to the type of measure, type of processing and measured axis (see *CodeBook.md* for more details).
* Compute the mean of each column containing measures (columns 3 to 81), grouping then by subject and type of activity.
* Write the resulting data set (180 rows, 81 columns) into a new table called tidy_data.

All these steps produce a tidy data set, accomplishing the next rules:

* Each measured variable is in a separate column.
* Each observation (Activity perform by each subject) is in a different row.
* Every column have a name which is self-describing, but explained anyways in detailed in the CodeBook file.
* There is just one table in the file.

The R code is provided below:

```{r}
tidy_set<-function(){
        library(tidyr)
        library(dplyr)
        
        #Read and store all the relevant files for the assignment
        
        X_Test<-read.table("X_test.txt",header=FALSE)
        X_Train<-read.table("X_train.txt",header=FALSE)
        Y_Test<-read.table("Y_test.txt",header=FALSE)
        Y_Train<-read.table("Y_train.txt",header=FALSE)
        activity_labels<-read.table("activity_labels.txt",header=FALSE)
        Subject_Test<-read.table("Subject_test.txt",header=FALSE)
        Subject_Train<-read.table("Subject_train.txt",header=FALSE)
        features<-read.table("features.txt",header=FALSE)

        #Modification of some table names to make easier the process of transformation
        names(features)<-c("Number","Measured_Variable")
        names(X_Test)<-features$Measured_Variable
        names(X_Train)<-features$Measured_Variable
        names(Subject_Test)<-"Subject"
        names(Subject_Train)<-"Subject"
        names(Y_Test)<-"Activity_Number"
        names(Y_Train)<-"Activity_Number"

        #Merge the subject, activity and the training/test sets
        
        X_Test_Compl<-cbind(Subject_Test,Y_Test,X_Test)
        X_Train_Compl<-cbind(Subject_Train,Y_Train,X_Train)
        full_set<-rbind(X_Train_Compl,X_Test_Compl)
        
        #Replace the numbers of activities by descriptive names
        full_set$Activity_Number<-activity_labels[,2][full_set$Activity_Number]
        names(full_set)[2]<-"ActivityName"

        #Extraction of the measurements that contains the words mean() or std()
        Reduced_set<-cbind(full_set[,1],full_set[,2],full_set[,grep("mean()|std()",names(full_set))])
        
        #Provide appropiate and valid names for the data
        names(Reduced_set)[1:2]<-c("SubjectID","ActivityName")
        names(Reduced_set)<-make.names(names(Reduced_set),unique=TRUE)
        names(Reduced_set)<-gsub("tBody","TimeBody",names(Reduced_set))
        names(Reduced_set)<-gsub("fBody","FreqBody",names(Reduced_set))
        names(Reduced_set)<-gsub("tGrav","TimeGrav",names(Reduced_set))
        names(Reduced_set)<-gsub("mean","Mean",names(Reduced_set))
        names(Reduced_set)<-gsub("std","Std",names(Reduced_set))
        names(Reduced_set)<-gsub(".","",names(Reduced_set),fixed=TRUE)

        #PRoduce the tidy data set, containing the mean of each duple Subject-Activity
        
        Tidy_Dataset<-group_by(Reduced_set,SubjectID,ActivityName)%>%summarise_each(funs(mean))
        
        #Exports the table to a .txt file
        
        write.table(Tidy_Dataset,"tidy_data.txt",row.names = FALSE)
}
```
