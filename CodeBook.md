---
title: "CodeBook"
author: "Javier Clavijo"
date: "27 de septiembre de 2015"
output: html_document
---
See ReadMe File for description of the original experiment.

The data set contains 180 rows and 81 columns. The 180 rows correspond to the measures of 6 different activities for 30 different subjects. The 81 columns are distributed as follows:

###Column 1
SubjectID      
Contains numbers from 1 to 30, representing the ID of the 30 subjects in the experiment.

###Column 2
ActivityName  
Contains the name of the six different activities that the subject were performing when extracting the measures. The activities are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

###Column 3 to 81
Contains the set of the means of the different measures described by the          names of each column. The names are self-Descriptive, however, for                avoiding the presentation of extremely long names, some abbreviations are   included. These are explained hereby:
        


                        BodyAcc         Accelerometer (instrument of measure for linear acceleration)
                        BodyGyro        Gyroscope (Instrument of measure for angular velocity)
                        Time            Time (Type of measure)
                        Freq            Frequency (Type of measure Playing Fast Fourier Transform)
                        Jerk            Jerk Signals
                        Mag             Magnitude (using Euclidian Norm)
                        X               X-Axis measure
                        Y               Y-Axis measure
                        Z               Z-Axis measure
                        

Its important to take into account that the words Time and Freq at the beginning of each Column Name are indicating also the units of each column.

