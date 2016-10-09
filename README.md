==================================================================
Mean calculation - Project
==================================================================
G.Huet
================================================

This analysis is based on the data available from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script, run_analysis.R, does the following:

- Download the dataset if it does not already exist in the working directory
- Load the activity and feature info
- Loads the training and test datasets, keeping only the columns which reflect a mean or standard deviation
- Loads the activity and subject data for each dataset, and merges those columns with the dataset
- Merges the two datasets
- Converts the activity and subject columns into factors for the tidy dataset
- Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt.
