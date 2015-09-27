---
title: "ReadMe"
author: "Javier Clavijo"
date: "27 de septiembre de 2015"
output: html_document
---

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
* Create names for all columns according to the type of measure, type of processing and measured axis (see *codebook.md* for more details).
* Compute the mean of each column containing measures (columns 3 to 81), grouping then by subject and type of activity.
* Write the resulting data set (180 rows, 81 columns) into a new table called tidy_data.

All these steps produce a tidy data set, accomplishing the next rules:

* Each measured variable is in a separate column.
* Each observation (Activity perform by each subject) is in a different row.
* Every column have a name which is self-describing, but explained anyways in detailed in the Codebook file.
* There is just one table in the file.

The R code is provided below:

```{r}
tidy_set<-function(){
        library(tidyr)
        library(dplyr)
        
        #Read and store all the relevant files for the assignment
        
