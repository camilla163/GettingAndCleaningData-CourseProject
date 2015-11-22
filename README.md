# GettingAndCleaningData-CourseProject
Assignment for Coursera: Getting and Cleaning Data
### Load and Read Data

* Loads training and test data files by name
  * Note that file names are hard-coded
* Reads the files using read.table
* Uses cbind() to merge subject and activity labels with samsung variable data
* Uses rbind() to merge training data to test data, named all.data

### Label Variable Names to Merged Dataset

* Uses the "features.txt" to label the samsung variable data with names()
* Added ActivityCode and SubjectLabel prior to var.names so that columns would line up properly

### Convert Coded Activity Labels to Readable Activity Names

* Use list indexing to make activity.label match up to the new column ActivityLabel

### Extract mean and stdev for each measurement

* Uses grep() and colnames() to find variable names with 'mean' and 'std' in column name
* Assign subsetted data to subset.cols and make new dataframe called all.summary.data
* all.summary.data forms the basis for creating the tidy.data dataset

### Create a Second Tidy Dataset of the average of each variable for each subject and each activity

* Initialize tidy.data so can add means of variable in all.summary.data
* There are 3 loops to make the tidy dataset
* Loop i runs through all the subjects 1-30
* Loop j runs through all the activities (1-6, WALKING, STANDING etc.)
* Within the j loop temp.df is made to initiate subject and activity label columns 
* Loop k runs through all the variable means and stdevs from all.summary.data: takes average based on i and j 
* Within the k loop all the averages of the variables are bound to one data set called temp.df
* temp.df is added to tidy.data where the column names are re-purposed from all.summary.data



