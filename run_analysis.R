# set path to the data folder
dataPath <- "./UCI HAR Dataset"
outputFileName <- "run_analysis.txt"

# helper function to return a prepared test or train data
getData <- function(subjectDataPath, activityDataPath, sensorDataPath, featuresData, activityLabelsData) {
    subjectData <- read.table(subjectDataPath, col.names = c("subject_id"), stringsAsFactors = FALSE)
    
    activityData <- read.table(activityDataPath, col.names = c("activity_id"), stringsAsFactors = FALSE)
    
    sensorData <- read.table(sensorDataPath, col.names = featuresData$feature_name, check.names = FALSE)
    
    # subset mean and std columns
    sensorData <- sensorData[, grepl("mean|std", names(sensorData))]
    
    # merge activity labels
    activityData <- merge(activityData, activityLabelsData, by.x = "activity_id", by.y = "activity_id", sort = FALSE)
    
    # append activity labels
    sensorData <- cbind(activityData, sensorData)
    
    # append subject ids
    sensorData <- cbind(subjectData, sensorData)
    
    sensorData
}

# load common data
featuresPath <- paste(dataPath, "features.txt", sep = "/")
featuresData <- read.table(featuresPath, col.names = c("feature_id","feature_name"), stringsAsFactors = FALSE)

activityLabelsPath <- paste(dataPath, "activity_labels.txt", sep = "/")
activityLabelsData <- read.table(activityLabelsPath, col.names = c("activity_id","activity_name"), stringsAsFactors = FALSE)

# load test data
testSubjectPath <- paste(dataPath, "test/subject_test.txt", sep = "/")
testActivityPath <- paste(dataPath, "test/y_test.txt", sep = "/")
testDataPath <- paste(dataPath, "test/X_test.txt", sep = "/")

testData <- getData(testSubjectPath, testActivityPath, testDataPath, featuresData, activityLabelsData)

# load training data
trainSubjectPath <- paste(dataPath, "train/subject_train.txt", sep = "/")
trainActivityPath <- paste(dataPath, "train/y_train.txt", sep = "/")
trainDataPath <- paste(dataPath, "train/X_train.txt", sep = "/")

trainData <- getData(trainSubjectPath, trainActivityPath, trainDataPath, featuresData, activityLabelsData)

# combine the training and the test data sets
data <- rbind(testData, trainData)

# generate the second data set
library(plyr)
summaryData <- ddply(data, .(activity_id, activity_name, subject_id), numcolwise(mean))

# save the summary data set
write.table(summaryData, outputFileName, row.names = FALSE)