#working.dir<-"/Users/chall/Coursera/GettingAndCleaningData/Week3/UCI HAR Dataset/"
#/Users/chall/Coursera/GettingAndCleaningData/Week3/UCI HAR Dataset
run_analysis<-function(working.dir){
## 1. Merge training data with test data ##
    setwd(working.dir)
    getwd()
    # Load in and Read Data
    file1 <- "train/y_train.txt" #training data activity labels
    file2 <- "train/X_train.txt" #training data
    file3 <- "test/y_test.txt" #test data activity labels
    file4 <- "test/X_test.txt" #test data
    file5 <- "features.txt" #variable names
    file6 <- "activity_labels.txt" #readable activity labels
    file7 <- "train/subject_train.txt" # subject codes training data
    file8 <- "test/subject_test.txt" #subject codes test data
    data1 <- read.table(file1)
    data2 <- read.table(file2)
    data3 <- read.table(file3)
    data4 <- read.table(file4)
    train.subject <-read.table(file7)
    test.subject <-read.table(file8)
    #Merge activity labels with training data
    train.data <- cbind(data1,train.subject,data2)
    #Merge activity labels with test data
    test.data <- cbind(data3,test.subject,data4)
    #Merge training data with test data
    all.data <- rbind(train.data,test.data)
    #str(all.data)
    
    ## 4. Appropriately labels the data set with descriptive variable names.##
    #Add variable names to merged dataset
    var.names <- read.table(file5) # read in features.txt
    var.names <- readLines(file5) #must read in as a list so can append to data.frame as column names
    #class(var.names), read in as data.frame
    
    ## rename columns from features.txt##
    names(all.data)<-c("ActivityCode","SubjectLabel", var.names)
    #str(all.data)
    
    ## 3. Uses descriptive activity names to name the activities in the data set ##
    
    #Convert coded activity labels to readable activity labels using list indexing
    activity.names <- read.table(file6)
    activity.label <- c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                       "SITTING", "STANDING","LAYING")
    all.data$ActivityLabel <- activity.label[all.data$ActivityCode]
    #data.sum<-all.data[,c(1,564)] check to see if activity labels match
    
    
    ## 2. Extract only the mean and standard deviation for each measurement. ##
    
    mean.data.cols <- grep('mean', colnames(all.data)) # columns with mean
    std.data.cols <- grep('std',colnames(all.data)) # columns with stdev
    activity<-grep('ActivityLabel',colnames(all.data))
    subject<-grep('Subject',colnames(all.data))
    
    #subsets volunteer subject label, activity label and data for means and stdevs
    subset.cols <- c(subject,activity,mean.data.cols,std.data.cols)
    #subset.data.cols <-order(as.numeric(c(mean.data.cols,std.data.cols)))
    ##Trying to order stdevs next to the means not reading as 3 digit integers, need to fix as.numeric or something...
    all.summary.data<-all.data[,c(subset.cols)]
    #str(all.summary.data)
    colnames(all.summary.data)
    # 5. From the data set in step 4, creates a second, independent tidy data set with 
    #    the average of each variable for each activity and each subject.
    tidy.data<-data.frame() #initialize dataframe
    for(i in 1:30){ #loop over one subject at a time
      for(j in 1:length(activity.label)){ #loop over one activity at a time
        temp.df<-cbind(i,activity.label[j])
        #i<-1 
        #j<-1    
        new.data<-subset(all.summary.data, SubjectLabel ==i & ActivityLabel==activity.label[j])
        
        for(k in 3:ncol(new.data)){ #loop over mean of each variable column for each subject and activity
            #k<-3
            temp.df<-cbind(temp.df,mean(new.data[,k])) #combine mean of variables
            }
        tidy.data<-rbind(tidy.data,temp.df) #combine subject, activity name and variable means
      }
    }
    names(tidy.data)<-c(colnames(all.summary.data)) #take column names from mean and std subset and use with tidy dataset
    tidy.data
    
    }
    
