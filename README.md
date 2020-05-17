# Getting-and-Cleaning-Data-Assignment
 

## About this repository 
 
This repository was created for the peer-graded assignment of: 

> Course 3: Getting And Cleaning Data, by Johns Hopkins University, on Coursera

The assignment asked to:

> You will be required to submit: 
> 
>   1. a tidy data set as described below 
>   2. a link to a Github repository with a script for performing the analysis, and 
>   3. a code book that describes the variables, the data, and any transformations or work that used to clean up the data called CodeBook.md. 
> 
> Also to be included is a README.md in the repository with your scripts. 
> This repo explains how all of the scripts work and how they are connected.

The R script 'run_analysis.R' performs this analysis as long as the folder 'UCI HAR Dataset' is present in the working directory. It should be able to do the following 5 steps:
> 1. Merges the training and the test sets to create one data set. 
> 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
> 3. Uses descriptive activity names to name the activities in the data set 
> 4. Appropriately labels the data set with descriptive variable names. 
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Details on the files that exist in this repository
### README.md 
It is the file you read right now and tries to explain the purpose and
the contents of the repository.
 
### download_dataset.R 
It is the script that was used to download and unzip the files, needed to perform the analysis in the first place. 
It is recommended to use it but not necessary, as long as the files for the 'Human Activity Recognition Using Smartphones Dataset Version 1.0' are present in a folder with name 'UCI HAR Dataset' in the working directory. 
If the file 'getdata_projectfiles_UCI HAR Dataset.zip' (the current default name of the zip file downloaded manually) or the file 'dataset.zip' (the zip file previously downloaded and renamed) exists in the working directory, then the script simply unzips the zip file without downloading anything.
If the a folder with name 'UCI HAR Dataset' already exists in the working directory it just informs the user about it's existence and doesn't download the files. 
 
### run_analysis.R 
 
It is the main script of the repository. In order to produce the 'tidy_dataset' table, the script  '[run_analysis.R](https://github.com/lesasi/coursera-data-cleaning-course/blob/master/Assignment/run_analysis.R)' was created and used. 
> It performs the following tasks: 
>  
> #### Merges the training and the test sets to create one data set with target variables. 
>  
>  1. Combines data from these files, 
>       - UCI HAR Dataset/train/subject_train.txt 
>       - UCI HAR Dataset/train/X_train.txt 
>       - UCI HAR Dataset/train/y_train.txt 
> 
>     into the 'train set' that contains the human subject, the activity performed and the values of the features. 
>  2. Combines data from these files, 
>       - UCI HAR Dataset/test/subject_test.txt 
>       - UCI HAR Dataset/test/X_test.txt 
>       - UCI HAR Dataset/test/y_test.txt 
>
>     into the 'test set' that contains the human subject, the activity performed and the values of the features. 
>  3. Combines the data frames created for test set and train set into one large dataset.
>
> #### Extracts only the measurements on the mean and standard deviation for each measurement. 
> 
>  1. Finds the target features, which are the features with measurements about mean and standard deviation, and extracts them as well as those that indicate the 'subject' and 'activity' and creates a new data table only with the target variables. 
> 
> #### Uses descriptive activity names to name the activities in the data set.   
>
>  1. Replace the variable about activity, that contains integers from 1 to 6, with a factor based on the levels and labels contained in the 'activity_labels' data file. 
> 
> #### Appropriately labels the data set with target variables with descriptive names. 
> 
>  1. Extracts the target variable names from 'features.txt'.
>  2. Fixes a small mistake in the feature names - a few names in 'features.txt' contain 'BodyBody' instead of 'Body'. 
>  3. Creates a new tidy dataset with the appropriate labels for the variable names.

> #### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
>
>  1. Group the tidy data table created in step 4, by 'subject' and 'activity'. 
>  2. Summarize each variable to find the average for the grouped values. 
>  3. Ungroup the data table. 
>  4. Add descriptive names to the variables of the new tidy data table by adding the prefix 'Avg-' in the names of the target feature averages.
>  5. Write the data in a text file in the present working directory, by the command: 
>    
>     ```
>     write.table(tidy_dataset, "tidy_dataset.txt", row.names = FALSE) 
>     ```

### tidy_dataset.txt 
 
The tidy dataset that was produced by the script 'run_analysis.txt', which contains the averages of selected features from the original 'Human Activity Recognition Using Smartphones Dataset Version 1.0'.
The '[CodeBook.md](https://github.com/lesasi/coursera-data-cleaning-course/blob/master/Assignment/CodeBook.md)'  contains the details about the 'tidy_dataset' table.

To read the table back on R correctly, you can use the following command:
``` 
tidy_dataset <- read.table(file = "tidy_dataset.txt",
                                header = TRUE) 
```
### CodeBook.md 

The code book contains informations on the 'tidy_dataset' table.
It consists of the following: 
 
  0. Table of Contents 
  1. Information on 'tidy_dataset' data table:
     - Identificators and averages of features 
     - Description for the variables of 'tidy_dataset' 
     - How to load 'tidy_dataset' in R
     - About the 'tidy_dataset' dataset 
  2. The process by which the 'tidy_dataset' dataframe was produced 
  3. Description of the features on which the averages were based:
     - Informations on how the features were produced from the raw data 
     - Informations on the collection of raw data 
     - About the original data set 
  4. License
