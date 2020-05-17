##############################
# NOTE: This is a script to download the 'UCI HAR Dataset' dataset if the directory 'UCI HAR Dataset' 
# doesn't exist- or if the zip has been downloaded, simply unzips it

# Download Link
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

dataset_URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("UCI HAR Dataset")){
  # check if the original zip file is there - either the default name ('getdata_projectfiles_UCI HAR Dataset.zip')
  # or the name we give it ('dataset.zip')
  if(!file.exists("getdata_projectfiles_UCI HAR Dataset.zip") & !file.exists("dataset.zip")){
    print("Dataset zip not available locally")
    choice = readline(prompt = "Download dataset?(size = 59.7 MB) - Press 1 to continue, any other key to exit: ")
    if(choice == "1"){
      print(paste0("Downloading dataset from link '", dataset_URL, "' now..."))
      download.file(dataset_URL, "dataset.zip")
      print("File 'dataset.zip' successfully downloaded!")
    }
    else{
      stop("File not downloaded, exiting...")
    }
  }
  file = ""
  if(file.exists("dataset.zip")){
    file = "dataset.zip"
  }else if(file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
    file = "getdata_projectfiles_UCI HAR Dataset.zip"
  }else{
    stop("File not downloaded, try again...")
  }
  print(paste0("Unzipping from '", file, "'"))
  unzip(file)
  print(paste0("Folder 'UCI HAR Dataset' unzipped from '", file, "'"))
  
}
print("Folder 'UCI HAR Dataset' is ready for use.")

