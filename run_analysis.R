# get the list of files
dataPath <- file.path("data" , "UCI HAR Dataset")
files<-list.files(dataPath, recursive=TRUE)

# Read data from the files into the variables
featuresNames <- read.table(file.path(dataPath, "features.txt"),head=FALSE)
activityLabels <- read.table(file.path(dataPath, "activity_labels.txt"),header = FALSE)
activityTest  <- read.table(file.path(dataPath, "test" , "Y_test.txt" ),header = FALSE)
activityTrain <- read.table(file.path(dataPath, "train", "Y_train.txt"),header = FALSE)
subjectTrain <- read.table(file.path(dataPath, "train", "subject_train.txt"),header = FALSE)
subjectTest  <- read.table(file.path(dataPath, "test" , "subject_test.txt"),header = FALSE)
featuresTest  <- read.table(file.path(dataPath, "test" , "X_test.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(dataPath, "train", "X_train.txt"),header = FALSE)



# Concatenate the data tables by rows
subject <- rbind(subjectTrain, subjectTest)
activity<- rbind(activityTrain, activityTest)
features<- rbind(featuresTrain, featuresTest)
# Set names to variables
names(subject)<-c("subject")
names(activity)<- c("activity")

names(features)<- featuresNames$V2
# Merge columns to get the data 
dataCombine <- cbind(subject, activity)
Data <- cbind(features, dataCombine)
# Extracts only the measurements on the mean and standard deviation for each measurement
subfeaturesNames<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]
selectedNames<-c(as.character(subfeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
# str(Data)

# Check data activity
Data$activity<-factor(Data$activity);
Data$activity<- factor(Data$activity,labels=as.character(activityLabels$V2))
# head(Data$activity,30)

#Header clean up
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

# Tidy data output
library(plyr);
tidyData<-aggregate(. ~subject + activity, Data, mean)
tidyData<-tidyData[order(tidyData$subject,tidyData$activity),]
write.table(tidyData, file = "tidydata.txt",row.name=FALSE)

