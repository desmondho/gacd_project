#get the list of files
path_rf <- file.path("../data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files
#Read data from the files into the variables
#
#Read Activity
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
#Read Subject
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
#Read Features
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
#View properties of variables
#OPTIONAL
#str(dataActivityTest)
#str(dataActivityTrain)
#str(dataSubjectTrain)
#str(dataSubjectTest)
#str(dataFeaturesTest)
#str(dataFeaturesTrain)
