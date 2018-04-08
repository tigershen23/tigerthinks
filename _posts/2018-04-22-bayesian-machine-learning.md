---
layout: article_post
title: Bayesian Machine Learning
date: 2018-04-22 18:51
categories:
tags: [article, technical, ml, ppl]
author: FastML
rating: 2
article_url: "http://fastml.com/bayesian-machine-learning/"
reading_time: 10
date_published: 2016-03-28
summary: "Intro to Bayesian Machine Learning"
---

## Notes

* Bayesians probabilistic, frequentists only use past beliefs.
* Start with a belief, your **prior**. Obtain data and use it to update
  the prior, resulting in the **posterior**.
  ![bayes_rule](https://i.imgur.com/96aTr3m.jpg)
* Bayesian ML: use Bayes rule to infer model parameters from data
* **Inference**: how you learn parameters of your model. Model is
  separate from how you train it!
  * Different from deep learning, where all training mechanisms use SGD.
    Bayesian inference has more different methods
  * **MCMC** and **variational inference**
* Two flavors of Bayesian methods: **statistical modeling** and
  **probabilistic ML**
