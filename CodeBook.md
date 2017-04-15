Getting and Cleaning Data Course Project
----------------------------------------

This project works with data from the 'Human Activity Recognition Using
Smartphones' dataset. The original source is
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>,
and data for our course project was obtained from
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.
The dataset uses experimental data from a group of 30 volunteers
(**SUBJECTS**) who performed six **ACTIVITIES** (walking, walking
upstairs, walking downstairs, sitting, standing, and laying) while
wearing the Samsung Galaxy S II smartphone. Researchers used the
smartphones embedded accelerometer and gyroscope to measure a number of
different movement **FEATURES**. The dataset was randomly split into
training (70%) and test (30%) data. For more information on collection
and processing of the original the data, see the README file included
with the original dataset.

The dataset includes a number of files. Only some were pertinent to this
project, while others were not used. The following is a list of the
files that were used for this project:

1.  subject\_train/test: Includes the **SUBJECT** values
2.  X\_train/test: Contains the **FEATURE** values
3.  features: Contains the **FEATURE** names (additional information on
    the variables used in the feature vector can be found in
    features\_info; features data estimates a set of variables (e.g.
    mean, sd, etc.) from a number of different feature vector (XYZ)
    pattern signals)
4.  y\_train/test: Contains the **ACTIVITY** values
5.  activity\_labels: Contains the **ACTIVITY** names

The script (run\_analysis.R) for this project takes these files and does
the following:

1.  Merges the training and test data into a single data table.
2.  Extracts only the features data estimates for mean and standard
    deviation (std) for all available pattern signals.
3.  Replaces the activity codes in the dataset with the descriptive
    activity names.
4.  Translates variable names into more descriptive field headers.
5.  Creates a final, tidy dataset (MyTidyData.txt) that contains the
    mean of each variable (i.e. the means and standard deviations for
    each feature variable) for each activity and subject.

The final dataset contains 180 observations (6 activities x 30 subjects)
and 68 variables (subject, activity, and 66 feature variables \[mean +
std\]).

Additional information on the performance of the script can be found in
the README.md file.
