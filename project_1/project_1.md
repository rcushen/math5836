# Assessment 2
## Overview

| Key | Value |
|---|---|
| Type | Written Report |
| Weight | 20% |
| Due Date | Friday  Week 7 (30th October) at 10.00pm |

The assessment is split into two parts:

* **Part A.** You will complete this part of the assessment using Python or R in Ed. You will develop the learning model using the prescribed neural-network techniques and submit the model through the Ed platform. Consider the following steps to build and evaluate the model:
  * Understand the given problem and identify the respective inputs and outputs of the proposed model.
  * Break down your data mining task into the following sub-tasks:
  * Analyse the given data
  * Prepare the data for computational analysis
  * Build a model using the prescribed machine learning techniques
  * Evaluate the model using evaluation metrics.
* **Part B.** Write a report to describe the steps performed to develop the model and evaluate its performance. Provide written justifications, with clearly articulated reasons, for the steps you took to build the model.

## Part A: Case 1 (Classification)

Clean the data sets with data processing code and then prepare them for modelling using neural networks. Build a model either using Keras or scikit-learn in Python or R.

Consider the following steps to build and evaluate the model:

1. Analyse and visualise the given data sets by reporting the distribution of class, distribution of features and any other visualisation you find appropriate.
2. Investigate the effect of Adam and SGD on training and test performance.
3. Investigate the effect of learning and momentum rate for any of the selected data sets.
4. Investigate the effect on a different number of hidden layers (1, 2, 3, 4) with a selected number of hidden neurons for any of the selected data sets.
5. Investigate the effect of different combinations of the number of hidden neurons (eg. 5, 10, 15, 20, 25) for single hidden layer.

Evaluate the best model using a confusion matrix and show ROC and AUC, Precision-Recall curve and F1 Score for the classification problem.

Note that task 2 to 5 would require 10 experimental runs for each case where you report mean and 95% confidence interval. You need to select the appropriate metrics, i.e., for classification report performance on the train and test data set. You are free to you your personal computers for running experiments and uploading the results/code on Ed later.  You must upload code on Ed and ensure code can run on Ed (where N=1) for experiments. Ensure that you demonstrate the use of functions/methods in your code and you are free to separate or clump some of the methods/functions together.

## Part A: Case 2 (Regression)

Financial time series prediction. Select any stock-market dataset from  NASDAQ and use neural networks for multi-step ahead (5-step-ahead prediction).  The goal here to see the effect of COVID-19 on prediction accuracy.  (Updated 14th October, you can do this with 1 stock market dataset, 2 stocks is not a requirement but it's okay if you wish to present results with 2 stocks. )


You can do trial experiments to determine the model architecture, training algorithm (SGD vs Adam) and dropouts vs weight decay, etc for one dataset, i.e a 60-40 percent train and test split for the data set (consider data for the last 3 years from the day you begin your Project). You can provide one investigation after another, eg, compare SGD vs Adam first, then use the one which is better for checking topology, and then regularisation techniques. You need to do 10 experiments for each case as usual.

Next, you create two datasets in the following way.
* The training set features data prior to COVID-19. Test set features data during COVID-19 (i.e January till now). Note based on the country of the stock, COVID-19 dates will be determined by you.
* The training set features data prior to COVID-19 + first 50 % of data during COVID-19. The test set features the other 50 % data during COVID-19.

Use your best model architecture, learning algorithm, etc, and regularisation to compare the prediction accuracy of the


Note each of the above tasks should be the methods or functions in your main program.

Run 10 experimental runs and report mean and std RMSE and show visualizations for typical prediction from the best experiment for each case. Discuss your results and report major conclusions about the effect of COVID-19 on stock market predictions.
