##Uses data collected from the accelerometers and gyroscopes on the 
##Samsung Galaxy S II smartphone
##Based on a group of 30 volunteer test subjects randomly selected for test (30%)
##and training (70%) groups. 
##Tracks six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
##STANDING, LAYING
##Features data estimates a set of variables (e.g. mean, sd, etc.) from a number 
##of different feature vector (XYZ) pattern signals

##Download and unzip the dataset from course website
if(!file.exists(".cleandata")){dir.create("./cleandata")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Dataset.zip")
unzip(zipfile = "Dataset.zip", exdir = "./cleandata")

##Unzipped files are in the folder 'UCI HAR Dataset'
##Get a list of the files
UCIpath <- file.path("./cleandata", "UCI HAR Dataset")
files <- list.files(UCIpath, recursive = TRUE)
files

##Inertial Signals files are not used for this project
##We want to use the files labeled subject_test/train (SUBJECT VALUES), 
##X_test/train (FEATURE VALUES), features (FEATURE NAMES), 
##y_test/train (ACTIVITY VALUES), and activity_labels (ACTIVITY NAMES)

##First read ACTIVITY VALUE files
ActivityTest <- read.table(file.path(UCIpath, "test", "Y_test.txt"), header = FALSE)
ActivityTrain <- read.table(file.path(UCIpath, "train", "Y_train.txt"), header = FALSE)

##Next read SUBJECT files
SubjectTest <- read.table(file.path(UCIpath, "test", "subject_test.txt"), header = FALSE)
SubjectTrain <- read.table(file.path(UCIpath, "train", "subject_train.txt"), header = FALSE)

##Finally, read FEATURE VALUE files
FeaturesTest <- read.table(file.path(UCIpath, "test", "X_test.txt"), header = FALSE)
FeaturesTrain <- read.table(file.path(UCIpath, "train", "X_train.txt"), header = FALSE)

##Now we can look at the properties of each of our tables
str(ActivityTest)
str(ActivityTrain)
str(SubjectTest)
str(SubjectTrain)
str(FeaturesTest)
str(FeaturesTrain)

##Test data set has 2947 observations; train data set has 7352 observations
##Activity and subject tables have 1 variable each; features table contains 561 variables

##Begin merging test and training datasets together by rows
AllActivity <- rbind(ActivityTest, ActivityTrain)
AllSubject <- rbind(SubjectTest, SubjectTrain)
AllFeature <- rbind(FeaturesTest, FeaturesTrain)

##Then we need to add variable names to the resulting tables
names(AllActivity) <- c("activity")
names(AllSubject) <- c("subject")
FeaturesNames <- read.table(file.path(UCIpath, "features.txt"), header = FALSE)
names(AllFeature) <- FeaturesNames$V2

##Bind the columns of the combined test/train data to merge everything into one table
Combine <- cbind(AllSubject, AllActivity)
CombineData <- cbind(AllFeature, Combine)

##Check the result and take a look at the resulting table
str(CombineData)

##Resulting table has 10299 observations of 563 variables

##Now that everything is merged together into one dataset, we want to 
##extract only measurements on the mean (mean()) and standard deviation (std())
##for each feature.

##Subset the feature names to exclude everything that doesn't include
##"mean" or "std"
subsetNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

##Subset the dataframe using the selected names
selectedNames <- c(as.character(subsetNames), "subject", "activity")
SelectData <- subset(CombineData, select = selectedNames)

##Check the structure of the resulting data frame after filtering
str(SelectData)

##We are left with 10299 observations of 68 variables
##66 features variables, plus subject and activity
##Getting cleaner, but still not TIDY!!

##Time to add some more descriptive labels to our data set
##First we want to add descriptive names for the activities
##We can pull these from the 'activity_labels.txt' file
activityLabels <- read.table(file.path(UCIpath, "activity_labels.txt"), header = FALSE)
library(plyr)
SelectData$activity <- plyr::mapvalues(SelectData$activity, from = c(1,2,3,4,5,6), 
                                 to = c("WALKING", "WALKING_UPSTAIRS", 
                                        "WALKING_DOWNSTAIRS", "SITTING", "STANDING", 
                                        "LAYING"))

##Now it is time to work on the variable names
##First let's take a look at the names in the dataset
names(SelectData)

##The variable names in the original features dataset aren't very meaningful,
##so let's take a closer look at what they actually represent
##from the 'features_info.txt' file:
##'t' means 'time'
##'f' indicates 'frequency'
##'Acc' means 'Accelerometer'
##'Mag' means 'Magnitude'
##'Gyro' means 'Gyroscope'
##'BodyBody' not sure what that means, but let's clean it up to 'Body'
##'Jerk' means 'Jerk' so no changes needed there
##'XYZ' is used to denote the 3-axial signals in the X, Y, and Z directions
##'mean()' is the mean
##'std()' is the standard deviation which could be renamed, but my personal feelings are 
##that variable names that are crazy-long aren't very tidy either, so I am leaving it
names(SelectData) <- gsub("^t", "time", names(SelectData))
names(SelectData) <- gsub("^f", "frequency", names(SelectData))
names(SelectData) <- gsub("Acc", "Accelerometer", names(SelectData))
names(SelectData) <- gsub("Mag", "Magnitude", names(SelectData))
names(SelectData) <- gsub("Gyro", "Gyroscope", names(SelectData))
names(SelectData) <- gsub("BodyBody", "Body", names(SelectData))

##Now just to check our work and make sure everything is looking the way we want it
names(SelectData)

##Much better; the variable names still have some things that are warned against
##such as capitalizations, but I find them useful and will be leaving them

##For the final step, we will create a separate dataset that contains the 
##average of each variable for each activity and each subject
GroupData <- aggregate(. ~activity + subject, SelectData, mean)
GroupData <- GroupData[order(GroupData$activity, GroupData$subject),]
write.table(GroupData, file = "MyTidyData.txt", row.names = FALSE)

##For more information, see the README file which provides further explanation
##of how the scripts work and flow from one step to the next.

##See codebook for further description of the variables, data, and transformation
##steps performed to process the data.