library(dplyr)
library(stringr)
# Reading the test and train data sets
test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Reading the test and train data labels
testlabel <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
trainlabel <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Reading the features
features <- read.table("./UCI HAR Dataset/features.txt")

# Assigning the coloumn names for the test and train data sets using the features data frame
colnames(test) <- features[,2]
colnames(train) <- features[,2]

# Merging the test and train data frames
merged <- rbind(test, train)

## Part 2 answer: Extracting the coloumns with mean and std from the merged dataset and coloumn ninding them to
### make one dataset
df <- merged %>% select(contains("std"))
df1 <- merged %>% select(contains("mean"))
my_data <- cbind(df, df1)

# Reading the activities and the subject dataframe for both test and train
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#merging to form a singe dataframe for labels and subject
subject <- rbind(subjecttest, subjecttrain)
label <- rbind(testlabel, trainlabel)

# Part 3 answer: Assigning activity names to the labe data frame
n <- nrow(label)
for(i in 1:n){
  label[i,1] <- activities[label[i,1],2]
}

# Part 4 answer: Renaming the coloumns in the data frame to make it more readable
my_data <- my_data %>% rename_at(vars(starts_with("t")), funs(str_replace(.,"t", "TDS ")))
my_data <- my_data %>% rename_at(vars(starts_with("f")), funs(str_replace(.,"f", "FFT ")))
names(my_data) <- gsub("\\(\\)", "", names(my_data))
names(my_data) <- gsub("\\(", " - ", names(my_data))
names(my_data) <- gsub("\\)", " ", names(my_data))
names(my_data) <- gsub("- t", "TDS ", names(my_data))
names(my_data) <- gsub("- f", "FFT ", names(my_data))

## We now have the tidy data set in my_data

## Part 5 answer:
### cbinding the label coloumn to my_data
names(label)[1] <- "Label"
names(subject)[1] <- "Subject"
my_data <- cbind(subject, label, my_data)


reuslt_data <- my_data %>%
  group_by(Subject, Label) %>%
  summarise_all(funs(mean))

