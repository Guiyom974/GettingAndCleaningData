library(data.table)

## Download and unzip the dataset:
file <- "getdata_dataset.zip"
if (!file.exists(file)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, file, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(file) 
}

# Loading feature vector:
features <- read.table('./UCI HAR Dataset/features.txt')

# Loading activity labels:
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')
colnames(activityLabels) <- c("activity","activityType")

# Extract only the data on mean and standard deviation
selectedFeatures <- grep(".*mean.*|.*std.*", features[,2])
selectedFeatures.names <- features[selectedFeatures,2]
selectedFeatures.names = gsub('-mean', 'Mean', selectedFeatures.names)
selectedFeatures.names = gsub('-std', 'Std', selectedFeatures.names)

# Load the training data sets and bind them together
train <- read.table("UCI HAR Dataset/train/X_train.txt")[selectedFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

#Load the test data sets and bind them together
test <- read.table("UCI HAR Dataset/test/X_test.txt")[selectedFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
datafull <- rbind(train, test)
colnames(datafull) <- c("subject", "activity", selectedFeatures.names)

# include real activity names
dataWithActivity <- merge(datafull, activityLabels, by="activity", all.x = TRUE)

#Creation of the second table including averages
MeanSet <- aggregate(dataWithActivity, by=list(activity = dataWithActivity$activity, subject=dataWithActivity$subject), mean)
MeanSet$activity <- NULL # Not meaningful
MeanSet$subject <- NULL # Not meaningful
MeanSet$activitytype <- NULL # Not meaningful
MeanSet <- MeanSet[order(MeanSet$subject, MeanSet$activity),] # Ordering

write.table(MeanSet, "tidy.txt", row.names = FALSE) # File creation