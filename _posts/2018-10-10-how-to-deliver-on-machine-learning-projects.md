---
layout: article_post
title: "How to deliver on Machine Learning projects"
date: "2018-10-10 14:15"
categories:
tags: [article, technical, programming, ml, practices, devops]
author: Emmanuel Ameisen
rating: 4
article_url: https://blog.insightdatascience.com/how-to-deliver-on-machine-learning-projects-c8d82ce642b0
reading_time: 5
date_published: 2018-10-04
summary: "Step-by-step pipeline from idea to production for an ML project"
---

## Notes

* Good set of practical tips and methods for ML
  * Just flashcarding the important parts for now, but can come back and
    reference?
  * Nah do it all. Will be starting an ML project very soon so good to have in
    back pocket.

* The ML Engineering Loop, where ML Engineers iteratively
  * Analyze
    * Training set error bottleneck:
      * Choose a different optimization algorithm or tune yours
      * Make sure you can memorize the dataset; model may be too small or
        inexpressive (underfitting)
      * Mislabeled/corrupt data. Manually inspect some training examples
    * Validation set error bottleneck:
      * Overfitting
      * Not enough training data
      * Training data distribution doesn't match validation/test sets
    * Test set error bottleneck:
      * Overfitting
  * Select an approach
    * Find simplest way to address bottleneck
    * Bias toward simple, fast solutions
    * If you need to tune optimizer for better fitting:
      * Change learning rate or momentum. Starting with a small momentum is
        usually the easiest to get working
      * Try different initialization strategies
    * If you need to fit more data:
      * Use a more expressive model class
      * Check examples model gets wrong. Invest time in data cleanup
    * If model is overfitting:
      * Add training data
      * Use data augmentation
      * Hyperparameter tuning
      * Try different regularization or different model class
  * Implement
    * Build only what you need to build, and do it fast
    * The goal of this phase is to prototype rapidly so that you can measure the
      results, learn from them, and go back around the cycle quickly.
    * If possible, for any problem, we recommend going through these successive steps:
      * Find an implementation of a model solving a similar problem.
      * Reproduce the implementation locally in the conditions of the existing
        model (same dataset and hyperparameters).
      * Slowly tweak the implementation of the model and the data pipeline to
        match your needs.
      * Rewrite any parts needed.
  * Measure
    * If each cycle of the ML Loop is relatively cheap
    * Print each relevant metric to decide if you're ready to ship
    * Build a dashboard

* Tips:
  * Build a dashboard so you don't have to do analysis manually

![ml-loop](/images/articles/deliver-machine-learning-ml-loop.png)

* Getting started:
  * Setting up training, development and testing datasets, and
  * Getting a simple model working.
  * Goal is not to solve the problem
  * The test set should reflect the needs of the product or business.
  * It’s helpful to know how well humans perform on the test set, or how well
    existing / competing systems perform. These give you a bound on the optimal
    error rate, the best possible performance you could achieve.
