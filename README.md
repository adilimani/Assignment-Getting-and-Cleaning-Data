# Assignment-Getting-and-Cleaning-Data
The contents of this repo are for the Getting and Cleaning Data Course Project .
The "run_analysis.R" code included downloads the Samsung fitness data to a working directory on your machine.
Once the file is downloaded and unzipped, the code reads in all the relevant text files needed for this analysis.

The source data has the testing and training data seperately. The R code merges these two data together.
In addition, the code formats the data and column headers to be more descriptive and easy to read.

While there are 561 measurements in the source data, the R code filters this down to measurements involving the mean and standard deviation. This leads to 66 measurement variables, in addition to the SubjectID and Activity Name. 

The final output file produced by this code summarizes the measurement data for each Subject and Activity. 
Since there are 30 subjects and 6 activities, the output file contains 180 rows of data.

Please contact the repo owner for any additional questions or clarifications.

