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