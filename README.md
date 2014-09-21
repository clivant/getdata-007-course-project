How to run the script
==============================

I used only one script to contain the codes for this course project. The script is named as **run_analysis.R** and is found in the main directory
of this github repository.

Prior to running run_analysis.R, I call the setwd function to set the working directory to the **UCI HAR Dataset** directory. This is the directory that
contains two other folders: 1) test and 2) train which contains the data files to analyse.

I then run run_analysis.R with the source function. It took quite a while for me as the read.fwf function is quite slow.
 
Explanation of what run_analysis.R does
========================================

Explanation of what run_analysis.R does can be found in **CodeBook.md** in this same github repository.