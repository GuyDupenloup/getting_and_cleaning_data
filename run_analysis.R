
## Load useful packages
library(dplyr)

## Load the training data
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

## Load the test data 
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

print("Loaded HAR training set and test set data:")
print(sprintf("  Training set: %d records, %d measurement variables", nrow(X_train), ncol(X_train)))
print(sprintf("  Test set: %d records, %d measurement variables", nrow(X_test), ncol(X_test)))

## Merge the training data and test data (stack the tables)
measurements <- rbind(X_train, X_test)
activities <- rbind(y_train, y_test)
subjects <- rbind(subject_train, subject_test)

print("Merged training set and test set data:")
print(sprintf("  %d records, %d measurement variables", nrow(measurements), ncol(measurements)))

## Get the names of measurement variables that are provided in file "features.txt"
feature_names <- read.table("features.txt")[,2]

## Name the columns of the measurements, activities and subjects data frames
names(measurements) <- feature_names
names(activities) <- "activity"
names(subjects) <- "subject"

## Only keep in the measurements data frame the variables that are mean or standard deviation variables
## The names of these variables include the string "-mean()" or "-std()".
measurements <- measurements %>% select(contains("-mean()") | contains("-std()"))

print("Filtered out variables that are not mean or standard deviation variables")
print(sprintf("  %d records, %d measurement variables remaining", nrow(measurements), ncol(measurements)))

## Replace integer activity values in the activity data frame by their corresponding names
## Use the "activity_labels.txt" file that provides the integer to name mapping
activity_names <- read.table("activity_labels.txt")[,2]
activities$activity <- tolower(activity_names[activities$activity])

## Add the activity and subject columns to the left of the measurements data frame to create the dataset
dataset <- cbind(activities, subjects, measurements)

## Change the type of the activity and subject columns to factors
dataset$activity <- as.factor(dataset$activity)
dataset$subject <- as.factor(dataset$subject)

## Group the records by activity and subject (in this order)
## Then, calculate the average of each variable across records
dataset <- dataset %>%
           group_by(activity, subject) %>%
           summarise(across(names(dataset)[3:length(dataset)], mean))

## Add the "-avg" suffix to each variable name to indicate that they are now average values
last_col <- ncol(dataset)
names(dataset)[3:last_col] <- paste(names(dataset)[3:last_col], "-avg", sep = "")

## Save the dataset to a text file
print("Saving dataset to file")
write.table(dataset, "myHAR_dataset.txt", row.names=FALSE)
