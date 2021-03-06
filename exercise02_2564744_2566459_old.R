### Stats with R Exercise sheet 2

## This exercise sheet contains the exercises that you will need to complete and 
## submit by 23:59 on Monday, November 6. Write the code below the questions. 
## If you need to provide a written answer, comment this out using a hashtag (#). 
## Submit your homework via moodle.
## You are allowed to work together in group up to three students, but everybody 
## needs to submit the group version of the homework via moodle.


## Please write below your (and your teammates) name, matriculation number. 
## Name: Zeeshan Khan Suri, Alyona Morozova
## Matriculation number: 2566459, 2564744

## Change the name of the file by adding your matriculation numbers
## (exercise01_firstID_secondID_thirdID.R)


###############
### Cleaning Data
###############
#install.packages("lsr")
library(lsr)
#install.packages("tidyr")
library(tidyr)
#install.packages("effsize")
library(effsize)
#install.packages("dplyr")
library(stats)
library("dplyr")
library(ggplot2)


# set your wd and load the data frame digsym_clean.csv
setwd("D:/Studies_WS_17-18/Statistics with R")
data <- read.csv("digsym_clean.csv")
# str(data)
# glimpse(data)
# summary(data)

# get rid of the column "X"
data$X <- NULL
# Say you're interested in whether people respond with different accuracy to 
# right vs wrong picture-symbol combinations.
# In other words, you want to compare the average accuracy for the digsym-right 
# and digsym-wrong condition.
# Like the conscientious researcher you are, you want to take a look at the data 
# before you get into the stats.
# Therefore, create a barplot of the mean accuracy data (split out by condition) 
# using ggplot and the summarySE function (given below).
# Run the function to summarize data and try to understand what the function is 
# doing.

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE, conf.interval=.95) {
  library(doBy)
  
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # Collapse the data
  formula <- as.formula(paste(measurevar, paste(groupvars, collapse=" + "), sep=" ~ "))
  datac <- summaryBy(formula, data=data, FUN=c(length2,mean,sd), na.rm=na.rm)
  
  # Rename columns
  names(datac)[ names(datac) == paste(measurevar, ".mean",    sep="") ] <- measurevar
  names(datac)[ names(datac) == paste(measurevar, ".sd",      sep="") ] <- "sd"
  names(datac)[ names(datac) == paste(measurevar, ".length2", sep="") ] <- "N"
  
  # Calculate standard error of the mean
  datac$se <- datac$sd / sqrt(datac$N)  
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}


# apply the function on the accuracy data
summary <- summarySE(data, measurevar = "accuracy", groupvars = "condition")

# take a look at the sum object - what did the function do?
summary
# SummarySE summarised the accuracy of right vs. wrong picture-symbol combinations. It counts the total number of
# rights. The total number of wrongs and gives accuracy with standard deviation, standard error and Confidence
# intervals of both right and wrongs


# Create the barplot with error bars (which the function summarySE readily 
# provided)
# Gauging from the plot, does it look like there's a huge difference in accuracy 
# for responses to the right and wrong condition?
ggplot(data = summary, aes(x = condition, y = se)) + geom_bar(stat = "identity")
# From the plot it doesn't look like there is much difference in accuracy for right and wrong. Infact, it is very less

# Let's go back to our data frame "data", which is still loaded in your console
# Now that you've taken a look at the data, you want to get into the stats.
# You want to compute a t-test for the average accuracy data in the right and 
# wrong condition.
# Why can't you compute a t-test on the data as they are now? 
# Hint: which assumption is violated?


# we need to reshape( - cast) the data to only one observation (average accuracy)
# per subject and right/wrong condition 
# Collapse the data, using 
# cast(data, var1 + var2 + var3 ... ~, function, value = var4, na.rm = T)


# Create a histogram of the accuracy data depending on the right and wrong 
# condition and display them side by side


# Display the same data in a density plot 


# Based on the histograms and the density plots - are these data normally 
# distibuted?


# Create a boxplot of the accuracy data


# Compute the t-test to compare the mean accuracy between wrong and right picture
# combinations.
# Do you need a paired t-test or independent sample t-test? why?


# What does the output tell you? What conclusions do you draw?


# Compute the effect size using CohensD 


# How big of an effect is the difference in accuracy?


# In addition to the long-format data we've just been working on, you may also 
# encounter data sets in a wide format 
# (this is the format we have been using in class examples.)
# Let's do a transformation of our data set to see how it would like in a wide 
# format.
# Use "spread" in tidyr.


# Compute the t test again on the wide format data - note that for wide-format 
# data you need to use a different annotation for the t-test.


# Compare the t-test results from the wide-format and the long-format data.


# Compute CohensD on the wide format data.



# Let's try the t-test again, but for a different question:
# Suppose you are an interested in whether reaction times in the digit symbol 
# task differ depending on gender.
# In other words, you want to test whether or not men perform significantly 
# faster on average than women, or vice versa.
# Collapse the data again, using 
# cast(data, var1 + var2 + var3 ... ~, function, value = var4, na.rm = T)


# Take a look at cdat using head()



# Compute the t-test to compare the accuracy means of female and male 
# participants.
# Which t-test do you need and why? How do you interpret the result?
