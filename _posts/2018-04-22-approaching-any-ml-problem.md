---
layout: article_post
title: Approaching (Almost) Any Machine Learning Problem
date: 2018-04-22 19:27
categories:
tags: [article, technical, ml, practices]
author: Abhishek Thakur
rating: 3
article_url: "http://blog.kaggle.com/2016/07/21/approaching-almost-any-machine-learning-problem-abhishek-thakur/"
reading_time: 10
date_published: 2016-07-21
summary: "Mental model for approaching ML problems. Very good breakdown."
---

## Notes

* 60-70% of your time will be data munging. Get used to it.

### Data

* Data must be tabular.

![data_munging](http://s5047.pcdn.co/wp-content/uploads/2016/07/abhishek_1.png)

### Types of labels

* Single column, binary values (classification problem, cat vs dog)
* Single column, real values (regression problem, prediction of one new
  value)
* Multiple column, binary values (multi-class binary)
* Multilabel (classfication problem, one sample can belong to several
  classes

### Evaluation metrics

* LOSS!!
* Multi-label or multi-class problems: categorical cross-entopry,
  multiclass log loss
* Regression: mean squared error

### Libraries

* To see and do operations on data: [pandas](http://pandas.pydata.org/)
* For all kinds of machine learning models: [scikit-learn](http://scikit-learn.org/stable/)
* The best gradient boosting library: [xgboost](https://github.com/dmlc/xgboost)
* For neural networks: [keras](http://keras.io/)
* For plotting data: [matplotlib](http://matplotlib.org/)
* To monitor progress: [tqdm](https://pypi.python.org/pypi/tqdm)

### Machine Learning Framework

![image_framework](http://s5047.pcdn.co/wp-content/uploads/2016/07/abhishek_2.png)

* **Identify the problem**: binary classification? Multi-class/multi-label
  classification? Regression?
* **Split data** into training and validation sets
  * Stratified splitting
* **Identify different labels** in the data. For categorical data: can use
  labels or one-hot encoding
* Next, we come to the **stacker** module. Stacker module is not a model
  stacker but a feature stacker. The different features after the
  processing steps described above can be combined using the stacker
  module.
* Once, we have stacked the features together, we can start applying
  machine learning models. At this stage only models you should go for
  should be **ensemble tree based models**. These models include:
  * RandomForestClassifier
  * RandomForestRegressor
  * ExtraTreesClassifier
  * ExtraTreesRegressor
  * XGBClassifier
  * XGBRegressor
  * We cannot apply linear models to the above features since they are not
  normalized.
* **Feature selection**
  * There are multiple ways in which feature selection can be achieved.
    One of the most common way is greedy feature selection (forward or
    backward). In greedy feature selection we choose one feature, train
    a model and evaluate the performance of the model on a fixed
    evaluation metric. We keep adding and removing features one-by-one
    and record performance of the model at every step. We then select
    the features which have the best evaluation score.
  * Also use best features, gradient boosting
* **Model selection and hyperparameter optimization**
  * Classification:
    * Random Forest
    * GBM
    * Logistic Regression
    * Naive Bayes
    * Support Vector Machines
    * k-Nearest Neighbors
  * Regression
    * Random Forest
    * GBM
    * Linear Regression
    * Ridge
    * Lasso
    * SVR
  ![hyperparameters](http://s5047.pcdn.co/wp-content/uploads/2016/07/abhishek_24.png)
