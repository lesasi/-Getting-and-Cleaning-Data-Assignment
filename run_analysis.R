# dplyr package version 0.8.0.1 
library(dplyr)
# data.table package version 1.12.2
library(data.table)

# functions for getting initial datasets
trimmed_dataset <- function(X_text, Y_text, subject_text){

  # uses fread from 'data.table' package to factilitate much faster input and formatting it as a dataframe
  X = fread(file = X_text, sep = " ", data.table = FALSE)
  Y = fread(file = Y_text, sep = " ", data.table = FALSE)
  subject = read.table(subject_text)
  
  ############################## 
  # Appropriately label the data set with descriptive variable names.
  ############################## 
  
  # getting feature names so we can give accurate names to columns
  feature_names = read.table("UCI HAR Dataset/features.txt", sep = " ")
  feature_names = as.character(feature_names$V2)
  names(X) = feature_names
  names(Y) = c("Activity")
  names(subject) = c("Subject")
  
  
  ############################## 
  # Extract only the measurements on the mean and standard deviation for each measurement.
  ##############################
  
  # extracting all column names related to mean() and std() using grep
  names_std_mean = grep("mean\\(\\)|std\\(\\)", names(X), value = TRUE)
  X_polished = X[, names(X) %in% names_std_mean]
  
  ############################## 
  # Use descriptive activity names to name the activities in the data set
  ##############################
  
  activity_labels = read.table("UCI HAR Dataset/activity_labels.txt")
  # replacing Y labels with the corresponding activity names
  rownames(activity_labels) = activity_labels$V1
  Y = mutate(Y, Activity = activity_labels[Activity, "V2"])
  
  # attaching them together
  polished_dataset = cbind(subject, X_polished, Y)
  return(polished_dataset)
  
}

##############################
# BEGINNING OF MAIN PROGRAM
##############################

# Check if the dataset folder(whose default name is "UCI HAR Dataset") exists in the current directory
if(!file.exists("UCI HAR Dataset")){
  stop("The dataset folder 'UCI HAR Dataset' does not exist. If the dataset folder exists, please 
        rename it to 'UCI HAR Dataset'. If not, either copy the existing dataset into the current 
        folder or run the provided script 'download_dataset.R' to download the dataset.")
}

# destinations to train and test datasets
train_X_text = "UCI HAR Dataset/train/X_train.txt"
train_Y_text = "UCI HAR Dataset/train/y_train.txt"
subject_train_text = "UCI HAR Dataset/train/subject_train.txt"
test_X_text = "UCI HAR Dataset/test/X_test.txt"
test_Y_text = "UCI HAR Dataset/test/y_test.txt"
subject_test_text = "UCI HAR Dataset/test/subject_test.txt"

##############################
# Merge the training and the test sets to create one data set.
##############################
train_data = trimmed_dataset(train_X_text, train_Y_text, subject_train_text)
test_data =  trimmed_dataset(test_X_text, test_Y_text, subject_test_text)
total_dataset = rbind(train_data, test_data)


##############################
# From the data set, create a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
##############################

# Summarising by taking the average of all variables, grouped by Subject and Activity
tidy_dataset = total_dataset %>% group_by(Subject, Activity) %>% summarise_all(list(mean)) %>% ungroup()

# adding "Avg-" to the beginning of every column - excluding Activity and Subject - to make 
# descriptive variable names
new_names = c(names(select(tidy_dataset, Activity:Subject)), paste0("Avg-", names(select(tidy_dataset, -(Activity:Subject)))))
# fix small mistake in the column names - In some columns the word 'Body' is given twice - eg. fBodyBodyAccJerkMag
new_names = gsub("BodyBody","Body",new_names)
names(tidy_dataset) = new_names

# Writing tidy dataset to file 'tidy_dataset.txt'
write.table(tidy_dataset, "tidy_dataset.txt", row.names = FALSE)

