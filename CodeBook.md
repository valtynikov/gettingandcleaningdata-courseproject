# Getting and Cleaning Data Course Project - Code Book

## Configuration
You may have to adjust the variables below in order to execute the script locally.
* `dataPath` - should point to the folder where the source data files are extracted.
* `outputFileName` - the name of the output file that will contain the resulting data set (the file will be saved in the current working directory).

## Transformations
The following transformations have been performed to generate the final data set for the project.
1. For the training and the test data sets
  * Descriptive column names are set for the sensor data.
  * Only the `mean` and the `std` columns are selected.
  * Activity labels and subject identifiers are appended to the sensor data.
2. The training and the test data sets are combined into a single data set.
3. The summary data set is created using the `plyr` package and the `ddply` function. The summary data set consists of the averages of each variable for each activity and each subject.
4. The summary data set is saved to a file with the name configured above.

## Dependencies
* `plyr` R package