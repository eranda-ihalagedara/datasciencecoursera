# Load tidyverse and related libraries
library(tidyverse)
library(dplyr)
library(readr)
library(janitor)


# Load features and activity labels
activity_labels = read_table("UCI HAR Dataset/activity_labels.txt", col_names = c("act_label", "activity"))
features = read_table("UCI HAR Dataset/features.txt", col_names = c("idx", "feature"))


# Get mean/std features
mean_std_features = grep("(mean|std)\\(\\)", features$feature)
measurement_names = features[mean_std_features, "feature"]


# Load and compile training set

x_train = read_table("UCI HAR Dataset/train/X_train.txt", col_names= features$feature) %>% 
  select(all_of(mean_std_features)) 
  
y_train = read_table("UCI HAR Dataset/train/Y_train.txt", col_names = c("act_label"))

subject_train = read_table("UCI HAR Dataset/train/subject_train.txt", col_names = c("subject_id"))

train_set = bind_cols(subject_train, y_train, x_train)


#  Load and compile test set

x_test = read_table("UCI HAR Dataset/test/X_test.txt", col_names= features$feature) %>% 
  select(all_of(mean_std_features))

y_test = read_table("UCI HAR Dataset/test/Y_test.txt", col_names = c("act_label"))

subject_test = read_table("UCI HAR Dataset/test/subject_test.txt", col_names = c("subject_id"))

test_set = bind_cols(subject_test, y_test, x_test )


# Combine the training and test sets, look up activity label and clean column names
data_set = bind_rows(train_set, test_set)

data_set = data_set %>% 
  left_join(activity_labels, by = "act_label") %>% 
  select(!act_label) %>% 
  clean_names()


# Group by (subject, activity) and average all features
data_set_averaged = data_set %>% 
  group_by(subject_id,activity) %>% 
  summarise_all(mean)


# Write the cleaned and summarized dataset
write_delim(data_set_averaged, "tidy_data_set.txt", col_names = TRUE)
write_csv(data_set_averaged, "tidy_data_set.csv", col_names = TRUE)

