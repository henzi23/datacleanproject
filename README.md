datacleanproject
================

This repo includes the R script to create a tidy dataset from wearable computing dataset found at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Instructions:
1) Download data set from :
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2) Extract dataset into your working directory (note: there is a README file with details about the dataset)
3) Run script "run_analysis.R" in R.  This script will:
    -Merge the training and test sets (including activity and subject info) into one dataset called rawdata
    -Extract the measurements on the mean and standard deviations for each measurements into a dataset selectdata
    -Rename the activity entries in selectdata to readable names
    -From selectdata create a tidy dataset called tidydata with the averages for each variable by activity and subject
    -Create a text file called tidydata.txt
    
    