train <- read.table("train/X_train.txt", header = FALSE)
test <- read.table("test/X_test.txt", header = FALSE)
ytest <- read.table("test/y_test.txt", header = FALSE,
                    colClasses = "character")
ytrain <- read.table("train/y_train.txt", header = FALSE,
                     colClasses = "character")
subtest <- read.table("test/subject_test.txt", header = FALSE)
subtrain <- read.table("train/subject_train.txt", header = FALSE)
# 1 Merges the training and the test sets to create one data set.
dataset <- rbind(test,train)
# 2 Extracts only the measurements on the mean and standard
# deviation for each measurement.
features <- read.table("features.txt",header = FALSE,
                       colClasses = "character")
dataset <- dataset[,grep("mean\\(\\)|std\\(\\)",features[,2])]
# 3 Uses descriptive activity names to name the activities
# in the data set
activity_labels <- read.table("activity_labels.txt",
                              colClasses = "character")
dataset <- data.frame(rbind(ytest,ytrain),dataset)
for (i in 1:nrow(dataset)) {
  dataset[i,1] <- activity_labels[as.numeric(dataset[i,1]),2]
}
# 4 Appropriately labels the data set with descriptive variable names.
names(dataset) <- c("Activity",
                    features[grep("mean\\(\\)|std\\(\\)",features[,2]),2])
# 5 From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
dataset <- data.frame(rbind(subtest,subtrain),
                      dataset)
names(dataset)[1] <- "SubjectID"
tidy <- data.frame(matrix(ncol=ncol(dataset),nrow=30*6))
names(tidy) <- names(dataset)
counter <- 1
for (i in 1:30) {
  subset <- dataset[dataset$SubjectID == i,]
  for (j in 1:6) {
    activ_subset <- subset[subset$Activity == activity_labels[j,2],]
    tidy[counter,1] <- i
    tidy[counter,2] <- activ_subset[1,2]
    for (k in 3:ncol(activ_subset)) {
      tidy[counter,k] <- mean(activ_subset[,k])
    }
    counter <- counter + 1
  }
}
tidy
write.table(tidy, file="tidy.txt", row.names = FALSE)