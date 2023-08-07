# Peer-graded Assignment


Please refer to the **run_analysis.R** [here](https://github.com/eranda-ihalagedara/datasciencecoursera/blob/master/3.Getting%20and%20Cleaing%20Data/analysis_run.R) for the related script that cleaned and transformed the data.\
You can find the **codebook** for the dataset [here]\
Further, the tidy dataset in both .csv and .txt formats [here]\

Data cleaning were done using [Tidyverse](https://www.tidyverse.org/) packages.
Feature names were loaded and extracted the feature names of means and standard deviations. Then training and test sets were loaded, selected only the requied columns and renamed the columns.
The activity label and the subject ids were combined with each of the training and test sets before merging them together to create a single complete dataset.
After cleaning column names and inserting activity names, the averaged dataset was calculated grouping by subject and activity.
Finally, the tidy dataset was written into .txt and .csv formats
