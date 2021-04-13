
#packages 
library(dplyr)



#download and unzip
{
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

temp <- tempfile()
temp2 <- tempfile()

download.file(url, temp)
unzip(zipfile = temp, exdir = temp2)

#load column names

feature_names <- read.table(file.path(temp2, "UCI HAR Dataset/features.txt")) 
activity_names <- read.table(file.path(temp2, "UCI HAR Dataset/activity_labels.txt"), col.names = c("activity", "activity_descr"))



#load test and train data set
subject_test <- read.table(file.path(temp2, "UCI HAR Dataset/test/subject_test.txt"))
features_test <- read.table(file.path(temp2, "UCI HAR Dataset/test/X_test.txt"))
activity_test <- read.table(file.path(temp2, "UCI HAR Dataset/test/y_test.txt"))

#load train data set
subject_train <- read.table(file.path(temp2, "UCI HAR Dataset/train/subject_train.txt"))
features_train <- read.table(file.path(temp2, "UCI HAR Dataset/train/X_train.txt"))
activity_train <- read.table(file.path(temp2, "UCI HAR Dataset/train/y_train.txt"))

unlink(c(temp, temp2))
}


#bind train and test data
subject <- rbind(subject_test, subject_train)
features <- rbind(features_test, features_train)
activity <- rbind(activity_test, activity_train)


#set column names
colnames(features) = feature_names[,2]
colnames(activity) = "activity"
colnames(subject) = "subject"

#bind the data set together
data_all <- cbind(subject, activity, features)


#filter columns with std or mean
data_filtered <- cbind(subject, activity, data_all[,grepl("mean|std", colnames(data_all))])


#join the description of the activities
data_with_description <- left_join(data_filtered, activity_names, by = c("activity" = "activity")) %>% 
    select(-activity) %>% 
    rename(activity = activity_descr)


#rename the columns
{
names(data_with_description)<-gsub("[Aa]cc", "accelerometer", names(data_with_description))
names(data_with_description)<-gsub("[Gg]yro", "gyroscope", names(data_with_description))
names(data_with_description)<-gsub("[Bb]ody[Bb]ody", "body", names(data_with_description))
names(data_with_description)<-gsub("[Mm]ag", "magnitude", names(data_with_description))
names(data_with_description)<-gsub("^[Tt]", "time", names(data_with_description))
names(data_with_description)<-gsub("^[Ff]", "frequency", names(data_with_description))
}


#create tidy data set with average of each column
data_average <- data_with_description %>% 
    group_by(subject, activity) %>% 
    summarise_all(mean)
write.table(data_average, file = "Tidy.txt", row.names = FALSE)

