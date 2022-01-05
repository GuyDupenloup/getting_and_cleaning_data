
### Contents of this GitHub repo

This repo contains:
- A codebook that describes the contents of the myHAR dataset and the process that was used to create it. See file "CodeBook.md".
- A script that can be run in R or Rstudio to generate the dataset. See file "run_analysis.R".

### HAR dataset

The myHAR dataset was derived from the following dataset:

    _Human Activity Recognition Using Smartphones Dataset_
   
    Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
    Smartlab - Non Linear Complex Systems Laboratory
    DITEN - Universita degli Studi di Genova.
    Via Opera Pia 11A, I-16145, Genoa, Italy.
    activityrecognition@smartlab.ws
    www.smartlab.ws


Use this link to access the HAR dataset homepage:
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Generating the myHAR dataset

Follow these steps to generate the myHAR dataset:

  1. Download Version 1.0 of the HAR dataset zip file here:
      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	  
  2. Unzip the dataset files
  
  3. Change the working directory to "UCI HAR Dataset"
  
  3. Place the "run_analysis.R" script in the working directory and run it in R or Rstudio

Once the execution of the script finishes, you should have a text file called "myHAR_dataset.txt" in the working directory. It contains a table with 
a header that can be loaded in R as a data frame.
