Getting and Cleaning Data Course Project
----------------------------------------

See the **CodeBook** file for general information on the data and
variables.

Overview
========

The script (**run\_analysis.R**) for this project takes applicalbe files
from the original dataset and 1) merges into a single table; 2) removes
features data except for mean and std values; 3) replaces activity codes
with descriptive activity names; 4) replaces variable names with more
readable names; and 5) exports a final tidy dataset that calculates the
mean of each remaining variable by subject and activity.

Specific Steps
==============

1.  Download the dataset from the course website and unzip the files.
2.  Inspect available files and determine:
    -   What the structure of the tables are in relation to each other?
    -   Which files are needed for this project?

3.  Read necessary tables (*ActivityTest*, *ActivityTrain*,
    *SubjectTest*, *SubjectTrain*, *FeaturesTest*, *FeaturesTrain*) and
    inspect their properties.
4.  Merge test and training data tables together by rows (*AllActivity*,
    *AllSubject*, *AllFeature*).
5.  Add variable names to the resulting three tables.
6.  Bind the columns of the combined test/train tables to merge
    everything into a single table (*CombineData*).
7.  Subset the feature names to exclude everything that doesn't include
    'mean' or 'std' in the variable name.
8.  Subset the dataframe using the subset of names (*SelectData*).
9.  Use plyr package to map values from the coded values for activity to
    the descriptive names.
10. Replace original variable names with more descriptive and
    readable names.
11. Aggregate data by subject and activity and take the mean of each
    variable by groups (*GroupData*).
12. Write the resulting table to "**MyTidyData.txt**".
