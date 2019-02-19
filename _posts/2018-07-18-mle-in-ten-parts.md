---
layout: course_post
title: 'Machine Learning Engineering in Ten Parts'
date: 2018-07-18 00:00
categories:
tags: [course, technical, cs, paper-club]
author: Paper Club
rating: 5
year_taken: 2018
course_url: "https://medium.com/paper-club"
image: /courses/handson-ml.jpg
summary: "Machine Learning Engineering in Ten Parts, with Paper Club"
---

## Notes

In mid-2018, Paper Club welcomed a few new members to learn machine
learning engineering together. This is a more currently practical side
of ML than the fancy deep learning we started the group with, and we're
all excited to be able to build real-world, interpretable models using
machine learning.

The main source materials are the [Hands-on ML
book](http://shop.oreilly.com/product/0636920052289.do) and Andrew Ng's
Machine Learning [Coursera
course](https://www.coursera.org/learn/machine-learning/home/welcome)
with other helpful pieces interspersed.

### 1: Ch 2, Hands-on ML: End-To-End Machine Learning Project (2018-07-18)

Colab notebook: https://colab.research.google.com/drive/1aiFLy1fUxW6YpJ7J-mqzYKeHJqZI7Oj-

The steps of a machine learning project:

1. Look at the big picture
2. Get the data
3. Discover and visualize the data to gain insights
4. Prepare the data for ML algorithms
5. Select a model and train it
6. Fine-tune your model
7. Present your solution
8. Launch, monitor, and maintain your system

#### Frame the Problem

* Predict house prices
* _The first question to ask your boss is what exactly is the business
  objective; building a model is probably not the end goal. How does the
  company expect to use and benefit from this model?_ (35)
  * i.e. Does the company need dollar estimates or will buckets like
    low/medium/high work?
* _The next question to ask is what the current solution looks like (if
  any). It will often give you a reference performance, as well as
  insights on how to solve the problem._ (36)
  * This might be a manual process

#### Select a Performance Measure

* **Loss function**. "How accurate is my model?"
* RMSE (Root Mean Squared Error) $$d_i$$ = prediction, $$f_i$$ = true label:
  * Penalizes values far away from true label a lot more heavily
  * Generally used for regression problems

  $$ \sqrt{\frac{1}{n}\Sigma_{i=1}^{n}{\Big(\frac{d_i -f_i}{\sigma_i}\Big)^2}} $$

* MAE (Mean Absolute Error) (use for datasets with more outliers)

  $$  \frac{1}{n}\sum_{i=1}^{n}|d_i - f_i| $$

#### Get the Data

* Data loaded to Pandas **DataFrame** (`housing` variable)
* `housing.head()` to inspect first N rows and their attributes
* `housing.info()` for description of data (type, n-rows, n-non-null
  values)
* `housing.describe()` shows summary of numerical attributes (mean,
  stdev, etc.)
* `housting.hist()` -> histogram of each attribute
  * Look for **tail-heavy** attributes; will affect model choice
* Create a test set
  * Do it blind
    * _Your brain is an amazing pattern detection system, which means
      it is highly prone to overfitting; if you look at the test set,
      you may stumble upon some seemingly interesting pattern in the
      test data that leads you to select a particular kind of model.
      When you estimate the generalization error using the test set,
      your estimate will be too optimistic and you will launch a system
      that will not perform as well as expected. This is called *data
      snooping bias*._ (47)
  * JBenn: in practice, you'll be looking at this. /shrug
  * `train, test = sklearn.model_selection.train_test_split(housing,
    test_size=0.2, random_state=42)`
  * **Stratified sampling**: instead of purely random, make sure it
    represents the true distribution of an important attribute
    * i.e. 51.3% male, 48.7% female

#### Discover and Visualize the Data to Gain Insights

* Do visualizations, etc. on training set only
* `corr_matrix = housing.corr()` to get correlations between every
  attribute
  * `corr_matrix['median_house_value'].sort_values(ascending=False)`
* Play around with combined attributes, i.e. `bedrooms_per_room`
* _This round of exploration does not have to be absolutely thorough;
  the point is to start off on the right foot and quickly gain insights
  that will help you get a first reasonably good prototype._ (59)

#### Prepare the data for ML algorithms

* Write reusable functions. Why?
  * Reproduce on new data in same project
  * Build a library to use in future projects
  * Use same functions in live systems to ensure consistency
  * Try various transformations to see which combination works best
* `Imputer` used to fill in null values
  * Good idea to use even if no null values in training set, can't make
    any guarantees about test set and live data
* Text attributes:
  * Encode as an enum
  * `ocean_proximity` holds values like 1H OCEAN, NEAR OCEAN, INLAND,
    etc.
  * `housing_cat_encoded, housing_categories = housing_cat.factorize()`
  * `housing_categories` maps values to indices, `housing_cat_encoded`
    has values 0, 1, 2, 3, etc.
  * _One issue with this representation is that ML algorithms will
    assume that two nearby values are more similar than two distant
    values. Obviously this is not the case. To fix this issue, a common
    solution is to create one binary attribute per category. This is
    called <b>one-hot encoding</b>._ (63)
    * `housing_cat_1hot =
      sklearn.preprocessing.OneHotEncoder().fit_transform(housing_cat_encoded.reshape(-1,
      1))`
      * Need to reshape since fit_transform expects 2D array 
* Custom transformer
  * _You want your transformer to work seamlessly with Scikit-Learn
    functionalities (such as pipelines), and since Scikit-Learn relies
    on duck typing (not inheritance), all you need is to create a class
    and implement three methods: `fit()` (returning self),
    `transform()`, and `fit_transform()`._ (65)
    * Add `TransformerMixin` and `BaseEstimator` as base classes to get
      goodies
* **Feature scaling**
  * All features should be on the same scale. With no feature scaling,
    room totals range from 6 to 39,320, while median income only rated
    from 0 to 15. This throws things off
  * **Min-max scaling**
    * Scale to 0-1. Bad if there are outliers.
    * `MinMaxScaler`
  * **Standardization**
    * Subtract the mean from all values, divide by variance so that
      resulting distribution has zero variance
    * No specific range, which can negatively affect some models
    * Less affected by outliers
    * `StandardScaler`
* `Pipeline` is a great abstraction. You can use it to set off sequences
  of transformations
  * Exposes same methods as final estimator

```python
num_pipeline = Pipeline([
    ('imputer', Imputer(strategy='median')),
    ('attribs_adder', CombinedAttributesAdder()),
    ('std_scaler', StandardScaler()),
  ])

housing_num_tr = num_pipeline.fit_transform(housing_num)
```

#### Select and Train a Model

* Start with linear regression to establish baseline
* Decision tree (example code):

```python
from sklearn.tree import DecisionTreeRegressor

tree_reg = DecisionTreeRegressor(random_state=42)
tree_reg.fit(housing_prepared, housing_labels)

housing_predictions = tree_reg.predict(housing_prepared)
tree_mse = mean_squared_error(housing_labels, housing_predictions)
tree_rmse = np.sqrt(tree_mse)
tree_rmse
```

* _The main ways to fix underfitting are to select a more powerful
  model, to feed the training algorithm with better features, or to
  reduce the constraints on the model._ (70)
* Better evaluation using **K-fold cross-validation**
  * _randomly splits the training set into 10 distinct subsets called
    folds, then it trains and evaluates the Decision Tree model 10
    times, picking a different fold for evaluation every time and
    training on the other 9 folds. The result is an array containing the
    10 evaluation scores._ (71)

#### Fine-tune Your Model

* JBenn: **Model selection and data cleanliness are 95% of performance.
  Hyperparameter tuning is only the last 5%**
* Can use `GridSearchCV` (you specify the hyperparameter space to
  search) or `RandomizedSearchCV` (for large search spaces)
* Once model is fine-tuned, it's ready for showtime

#### Launch, Monitor, and Maintain Your System

* Considerations:
  * Monitoring
  * Sample predictions and verify (most of the time with human help)
  * Pipeline to retrieve fresh data
* Deploy with SciKit `joblib`
* Can deploy separate data prep pipeline and actual prediction pipeline

### 2: Ch 3, Hands-on ML: Classification

[Notebook](https://colab.research.google.com/drive/1CCvLsfbkK6KT9Rgs-kd4Abv-eX6esmIe)

#### MNIST

#### Training a Binary Classifier

* Two classes
  * `y_train_5 = (y_train == 5)`: neat shorthand. Results in array like
    [0, 0, 0, 0, 1, 0, 0] where 0 indicates "not a 5", 1 indicates "yes
    a 5"
* `SGDClassifier` good starting point. Fast and scalable since it treats
  each example independently

```python
sgd_clf = SGDClassifier(random_state=42)
sgd_clf.fit(X_train, y_train_5)

sgd_clf.predict([x]) # => True/False
```

#### Performance Measures

* Evaluating classifier is more difficult than evaluating regressor
  * :question: why? Intuitively, discrete is simpler than continuous
* **Cross-validation** (introduced Ch. 2): split training set into N
  subsets, train on N - 1, use last set for evaluation. Rotate so that
  every subset is the "evaluation set" once
  * `sklearn.model_selection.cross_val_score(sgd_classifier, X_train,
    y_train_5, cv=3, scoring='accuracy'`
    * `cv`: number of folds
* **Confusion matrix**: count # times instances of class A are
  classified as class B, plot in an MxM table where M = number of
  classes
* **Precision**:
  $$\frac{tp}{tp + fp}$$
  * "What are the chances of my True guess being correct?"
* **Recall**:
  $$\frac{tp}{tp + fn}$$
  * "What are the chances of me guessing True for an actual True?"
* **F1 score** to combine precision and recall;
  $$2 x \frac{precision x recall}{precision + recall}$$ **OR**
  $$\frac{tp}{tp + \frac{fn + fp}{2}}$$
  * Favors classifiers with close precision and recall. This may not be
    what you want, e.g. for finding shoplifters some false positives are
    okay but false negatives are not
  * `sklearn.metrics.f1_score(y_train_5, y_train_pred)`
![precision-recall](/images/courses/mle-in-ten-parts-precision-recall.png)
* **Precision/recall tradeoff**: increasing one decreases the other.
  Intuition: if you guess more trues, your recall is likely to be higher
  since you're making fewer negative guesses overall, but your precision
  will suffer because some of your "extra" true guesses will be
  incorrect
  * Higher decision threshold -> higher precision, lower recall
* **ROC Curve**: receiver operating characteristic: plots **sensitivity
  (recall) vs. 1 - specificity (true negative rate)**
  * :question: origin of name ROC? Intuition for it?
  * Metric: **ROC AUC** (ROC area under curve). Random: 0.5. Goal: 1.
![roc](/images/courses/mle-in-ten-parts-roc.png)

#### Multiclass Classification

* Some models (Random Forest) can directly do multiclass
* Otherwise, you can do multi-class with a bunch of binary classifiers
  * **One-versus-all**: one classifier per class. Prediction = class
    whose classifier outputs highest score
  * **One-versus-one**: one classifier for every pair of digits (1 vs.
    2, 1 vs. 3, etc.). Prediction = class whose classifier wins the most
    of these pairs.
  * Choose OvA most of the time, way fewer models. Choose OvO only if
    your model (e.g. SVM) scales poorly
* :question: "Scaling inputs increases accuracy" --> aren't all inputs
  0-255 already?

#### Error Analysis

* Good to print out examples of TP, FP, TN, FN in order to visualize
  what types of errors model is making
  * `true_positives = X_train[(y_train == a) & (y_train_pred == a)]`
  * `false_positives = X_train[(y_train == a) & (y_train_pred == b)]`
  * `true_negatives = X_train[(y_train == b) & (y_train_pred == b)]`
  * `false_negatives = X_train[(y_train == b) & (y_train_pred == a)]`

#### Multilabel Classification

* Model trained on three faces: Alice, Bob, Charlie
  * If Alice and Charlie in a picture, model should output [1, 0, 1]
  * Can use `KNeighborsClassifier`
  * Evaluation: measure F1 for each label and compute average score

#### Multioutput Classification

* Example: add noise to MNIST images. Use noisy images as X, clean
  images as Y. Prediction is the "cleaned" image.

### 3: Ch 4, Hands-on ML: Training Models

[Colab Notebook](https://drive.google.com/file/d/1o3hgXYDVM3gmcPFhdinWbW8nkAEGi2oz/view?usp=sharing)

#### Linear Regression

* Prediction: weighted sum of input features + **bias** (**intercept term**)
  * $$\theta$$: parameters
  * $$n$$: number of features
  * $$x$$: inputs
  * $$\hat{y}$$: prediction
  * $$h_\theta(x)$$: (vectorized) hypothesis function, using model parameters.
  * $$\theta^T$$: transpose of theta
* Loss function: MSE

  $$MSE(X, h_\theta) = {\frac{1}{m}\Sigma_{i=1}^{m}{\Big(\theta^T \cdotp x^{(i)} - y^{(i)}\Big)^2}}$$

  * How far away are predictions from actuals?
  * Penalize big error more than small error

##### The Normal Equation

* **Closed-form solution** to linear regression
  * Not used a ton, no need to memorize

##### Computation Complexity

* Normal equation doesn't scale well. Computational complexity of inverting matrix is
  $$O(n^{2.4})$$ to $$O(n^3)$$

#### Gradient Descent

* _The general idea of Gradient Descent is to tweak parameters
  iteratively in order to minimize a cost function._ (111)
* Start with a random value (**random initialization**) then take steps
  down the valley until you hit a minimum
  ![gradient-descent](/images/courses/mle-in-ten-parts-gradient-descent.png)
* **Learning rate**: size of each step
* MSE is **convex** (bowl-shaped) and **continuous** (no abrupt slope
  changes)
  * This guarantees that GD will approach global minimum
* Make sure to **scale inputs**. Makes it easier for GD to find minimum
  across all dimensions more quickly

##### Batch Gradient Descent

* Compute **partial derivative** of cost function with regards to each
  parameter $$\theta_j$$
  * Keep all other parameters constant
    * Parameter 1: "What is the slope of the mountain under my feet if I
      face East?" Parameter 2: "North?"
  * **Batch** GD: compute gradient vector over the entire training set
* Once you have gradient vector (highest uphill direction), just go the
  opposite direction to go downhill
  * Multiplied by **learning rate** $$\eta$$

```python
eta = 0.1
n_iterations = 1000
m = 100
theta = np.random.randn(2,1)

for iteration in range(n_iterations):
  gradients = 2/m * X_b.T.dot(X_b.dot(theta) - y)
  theta = theta - eta * gradients
```

* Set a high number of iterations, and stop the algorithm when gradient
  vector becomes very small
  * When **norm** (magnitude) becomes smaller than **tolerance $$\epsilon$$**
  * This indicates GD has reached minimum
* **Convergence rate** of GD is approx. $$O(1/\epsilon)$$, so it slows
  down as you lower the tolerance

##### Stochastic Gradient Descent

* **One random training example at a time** to adjust parameters
  * Pro:
    * Converges and scales much faster
    * Adds element of randomness, to escape local minima
  * Cons:
    * Less stable cost function, will not find the exact optimal solution
      * Add **simulated annealing** (gradually reduce learning rate) to
        help with this
      * **Learning schedule** determines learning rate at each
        iteration. SK-Learn has defaults
* :question: why does shuffling training set and going instance by
  instance converge more slowly than picking random instances with the
  possibility of duplicates? Seems like they should be the same.
* :question: What does `y.ravel()` do?
  * Flattens array to 1D

##### Mini-batch Gradient Descent

* Middle ground between BGD and SGD. Splits training set into small sets
  and updates parameters after processing each mini batch.
  ![gradient-descent-paths](/images/courses/mle-in-ten-parts-gradient-descent-paths.png)

#### Polynomial Regression

* Basically the same as linear regression, add more parameters using
  `sklearn.preprocessing.PolynomialFeatures(degree=2, include_bias=False).fit_transform(X)`

#### Learning Curves

* How to decide # of parameters?
  * _If a model performs well on the training data but generalizes
    poorly according to the cross-validation metrics, then your model is
    overfitting. If it performs poorly on both, then it is
    underfitting._ (125)
  * **Learning curve**: plot of model performance on training set and
    validation set as function of training set size or iteration #
  ![learning-curve](/images/courses/mle-in-ten-parts-learning-curve.png)
  * Underfitting curve: both curves reach a plateau at larger training
    set size, close to each other and with fairly high error
  * Overfitting curve: training set error is much lower than validation
    set. Large gap between curves
* **Bias/variance tradeoff**: generalization error can be expressed as
  sum of several components
  * **Bias**: wrong assumptions, such as assuming data is linear when
    it's actually quadratic. High bias -> underfitting
  * **Variance**: model is too sensitive to small variations in training
    set, e.g. with too many parameters. High variance -> overfitting
  * **Irreducible error**: noisiness of data, unavoidable. Can be
    reduced by cleaning up data
  * **Increased model complexity -> increased variance, reduced bias.**

#### Regularized Linear Models

* Constraining model weights makes it harder for model to overfit data

##### Ridge Regression

* Add a **regularization term** to the cost function based on the sum of
  squares of model parameters (L2 norm)
* Regularization term: $$\alpha\frac{1}{2}\Sigma_{i=1}^{m}\theta_i^2$$
* Hyperparameter $$\alpha$$ controls how much to regularize. 0 = no
  regularization. High = all weights converge to 0.
![ridge-regression](/images/courses/mle-in-ten-parts-ridge-regression.png)

##### Lasso Regression

* **Least Absolute Shrinkage and Selection Operator Regression** (:flushed:)
* Uses L1 norm instead of L2 norm
* Regularization term: $$\alpha\Sigma_{i=1}^{n}\|\theta_i\|$$
* Completely eliminates weights of least important features
* Can behave erratically. Use Elastic Net instead.

##### Elastic Net

* Combine Ridge and Lasso with mix ratio $$r$$
  * When r = 0, it's Ridge
  * When r = 1, it's Lasso
* Always use some regularization
  * Ridge is a good default, but Elastic Net is better if you think only
    a few features are useful.
    * Just make it a hyperparameter! :)

##### Early Stopping

* Just stop training as soon as validation error reaches a minimum
![early-stopping](/images/courses/mle-in-ten-parts-early-stopping.png)

#### Logistic Regression

* Aka **Logit Regression**
  * The logit function is the inverse of the sigmoidal "logistic"
    function or logistic transform used in mathematics, especially in
    statistics. When the function's variable represents a probability p,
    the logit function gives the log-odds, or the logarithm of the odds
    p/(1 − p).
  * Effectively, pushes probability towards 0 or 1
![logit](/images/courses/mle-in-ten-parts-logit.png)

##### Estimating Probabilities

* Estimated probability function:

$$\hat{p} = h_\theta(x) = \sigma(\theta^T \cdotp x)$$

* Sigmoid function: $$\sigma(t) = \frac{1}{1 + exp( - t)}$$

##### Training and Cost Function

* _The objective of training is to set the parameter vector $$\theta$$
  so that the model estimates high probabilities for positive instances
  (y = 1) and low probabilities for negative instances (y = 0)._ (137)
  * Cost function uses **log loss**
    * Intuition: use -log(prediction) if the actual value is 1.
      -log(prediction) will grow very large as prediction approaches 0,
      penalizing a "wrong" guess of 0 when the actual is 1. Same logic
      applies for using -log(1 - prediction) if actual value is 0.

$$J(\theta) = - \frac{1}{m}\Sigma_{i=1}^{m}[y^{(i)}log(\hat{p}^{(i)}) + (1 - y^{(i)})log(1 - \hat{p}^{(i)})]$$

  * Convex (bowl-shaped) so gradient descent will find the minimum

##### Decision Boundaries

* Thresholds where logistic regression will make different predictions:
![decision-boundary](/images/courses/mle-in-ten-parts-decision-boundary.png)

##### Softmax Regression

* Generalized version of logistic regression to support multiple classes
  * _When given an instance x, the Softmax Regression model first
    computes a score $$s_k(x)$$ for each class $$k$$, then estimates the
    probability of each class by applying the softmax function to the
    scores._ (141)
    * Softmax sums all of them to one
    * Picks the highest probability after softmax
* Goal: model should estimate a high probability for the target class
  and low probability for the other classes.
  * Cost function: **cross entropy**
    * When only two classes, it's the same as log loss
    * $$J(\Theta) = - \frac{1}{m}\Sigma_{i=1}^{m}\Sigma_{k=1}^{K}y_k^{(i)}log\Big(\hat{p}_k^{(i)}\Big)$$
      * $$k$$: classes
      * $$y_k^{(i)}$$ = 1 if target class for ith instance is k,
        otherwise = 0
    * Measure how well a set of estimated class probabilities match
      target classes
    * :question: are cost function and loss function the same?
      * Nope, even though they are used loosely: https://stats.stackexchange.com/a/179027
      * A loss function is a part of a cost function which is a type of
        an objective function.

#### Exercises

* Assigned: #5, #11

##### Exercise 5

* Suppose you use Batch GD and you plot the validation error at
  every epoch. If you notice that the validation error consistently goes
  up, what is likely going on? How can you fix this?

You want to plot the training error alongside the validation error to
get a complete picture of your learning curve. If your training error is
going down while your validation error is going up, it's likely that
your model error is overfitting. If your training error is bouncing
around, it's possible that you've chosen a suboptimal learning rate and
it's causing your model to have a difficult time generalizing.

##### Exercise 11

* Suppose you want to classify pictures as outdoor/indoor and
  daytime/nighttime. Should you implement two Logistic Regression
  classifiers or one Softmax Regression classifier?

You should implement two Logistic Regression classifiers. Softmax
Regression classifiers are able to perform multi-class classification,
not the multi-output classification this problem calls for.

* ~From here on out, I took notes exclusively through Anki~, sorry!
