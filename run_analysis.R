


# Set the URL of the zip file
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Set the path of the data folder in R
data_folder <- "data"

# Check if the data folder exists
if (!file.exists(data_folder)) {
        # Create the data folder if it does not exist
        dir.create(data_folder)
}

# Set the path of the zip file
# zip_file <- ".//data//descarga.zip"

zip_file <-file.path(".", "data", "descarga2.zip")

# Download the zip file from the URL
download.file(url, destfile = zip_file)

# Extract the contents of the zip file
unzip(zip_file, exdir = data_folder)

# Set the width of each column in the text file to 16
widths <- rep(16, 561)

# Read the text files into dataframes 
# X files have 16 character width for columns and 561 features
# y files have 1 character width for column and only 1 feature
# I also read the subjects information which has one column and one feature

path_X_test <- file.path(".", "data", "UCI HAR Dataset", "test", "X_test.txt")

df_X_test <- read.fwf(path_X_test, widths = widths)

path_y_test <- file.path(".", "data", "UCI HAR Dataset", "test", "y_test.txt")

df_y_test <- read.fwf(path_y_test, widths = c(1))

path_subject_test <- file.path(".", "data", "UCI HAR Dataset", "test", "subject_test.txt")

df_subject_test <- read.fwf(path_subject_test, widths = c(10))



path_X_train <- file.path(".", "data", "UCI HAR Dataset", "train", "X_train.txt")

df_X_train <- read.fwf(path_X_train, widths = widths)

path_y_train <- file.path(".", "data", "UCI HAR Dataset", "train", "y_train.txt")

df_y_train <- read.fwf(path_y_train, widths = c(1))

path_subject_train <- file.path(".", "data", "UCI HAR Dataset", "train", "subject_train.txt")

df_subject_train <- read.fwf(path_subject_train, widths = c(10))

# Combine the three dataframes vertically
combined_X_df <- rbind(df_X_test, df_X_train)

combined_y_df <- rbind(df_y_test, df_y_train)

combined_subject_df <- rbind(df_subject_test, df_subject_train)

# Combine the three dataframes horizontally
complete_df <- cbind(combined_subject_df, combined_y_df, combined_X_df)


# Read the names of the features

path_names <- file.path(".", "data", "UCI HAR Dataset", "features.txt")

names <- read.csv(path_names, sep = ';', header = FALSE)

# Select the features of interest

selected_features <- lapply(names$V1, grep, pattern = "std|mean", value = TRUE)

selected_positions <- lapply(names$V1, grepl, pattern = "std|mean")

selected_df <- complete_df[, unlist(selected_positions)]

selected_names <- names[unlist(selected_positions),]

tidy_names <- tolower(gsub("[^[:alpha:][:space:]]", "", selected_names))

# Set the column names to the vector of characters
colnames(selected_df) <- c('subject', 'activity', tidy_names)

# Read the names of the activity values

path_activity <- file.path(".", "data", "UCI HAR Dataset", "activity_labels.txt")

activity_names <- read.csv(path_activity, sep = ' ', header = FALSE)


# Change the values of activity column

# Define a function to replace values
replace_values <- function(x) {
        ifelse(is.na(activity_names$V2[activity_names$V1 == x]), x, activity_names$V2[activity_names$V1 == x])
}

# Apply the function to the column
selected_df$activity <- apply(selected_df["activity"], 1, replace_values)

selected_df$activity <- tolower(selected_df$activity)

library(dplyr)


# Group the data by subject and activity and average all the variables
df_mean <- selected_df %>% 
        group_by(subject, activity) %>% 
        summarize_all(mean)


