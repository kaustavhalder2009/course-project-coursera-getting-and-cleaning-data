# course-project-coursera-getting-and-cleaning-data
This repository contains the solution for the project associated with getting and cleaning data course from coursera

Downloading Data:
Download the the data set for the course in R default work directory 
Extract the file from the zip file 
The file extracts into the folder 'UCI HAR Dataset' within the R work directory 
Run the script run_analysis.R attached in the repository:

Running the R script:
Script has 10 parts:
Part1: Load required packages for this project - plyr,dplyr & gdata 
Part2: read feature and activity files from root directory ~/UCI HAR Dataset
Part3:Reads test and train data from directors ~/UCI HAR Dataset/test & ~UCI HAR Dataset/train respectively & assigns column names to the datasets
part4: Merges all training data 
part5: Merges all test data 
part 6 : Merge Training and test data with required variables(mean & std type) to create sensor data
Part7:adding activity labels to sensor data and dropping activity_id . 
Part8:Converting to meaning ful and readable column names in sensor data
Part 9: Assign the meaningful column names in Part 8 to sensor data column names 
Part 10: Create a tidy data set from sensor data set as requested with mean of each column by Subject  and Activity lables. Export the tidy data set to a tab delimited text file "sensor_average_tidy.txt" 

