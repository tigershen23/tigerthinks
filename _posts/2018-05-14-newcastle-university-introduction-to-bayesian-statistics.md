---
layout: course_post
title: 'Newcastle University MAS2317/3317: Introduction to Bayesian Statistics'
date: 2018-05-14 19:57
categories:
tags: [course, technical, ppl]
author: Dr. Lee Fawcett
rating: 2
year_taken: 2018
course_url: "http://www.mas.ncl.ac.uk/~nlf8/teaching/mas2317/notes/"
image: /courses/newcastle-university.jpg
summary: "Notes taken from lecture notes from Newcastle University Bayesian Statistics course, with James from Paper Club"
---

## Notes

### Ch 1: Introduction

* **Bayes Theorem**

  $$ P(A \mid B) = \frac{P(B \mid A) \, P(A)}{P(B)} $$

#### 1.2: Bayes Theorem

##### Example 1.2

* A: disease presence
* B: result test

  $$ P(has\ disease \mid positive\ test) = \frac{P(positive\ test  \mid has\ disease) \, P(has\ disease)}{P(positive\ test)} $$

* 95% effective when disease present
* 1% false positive
* 0.5% of population has disease

* (a) Calculate the probability that a person who tests positive
  actually has the disease.

  $$
  \begin{align}
  P(has\ disease \mid positive\ test) & = \frac{0.95 \times 0.005}{((0.995 \times 0.01) + (0.005 \times 0.95))} \\
   & = 0.323
  \end{align}
  $$

There is a 32.3% chance that a person who tests positive actually has
the disease.

* (b) Find the probability that a person who tests negative does not
  have the disease.

  $$
  \begin{align}
  P(no \ disease \mid negative\ test) & = \frac{P(negative\ test  \mid no\ disease) \, P(no\ disease)}{P(negative\ test)} \\
   & = \frac{0.99 \times 0.995}{((0.995 \times 0.99) + (0.005 \times 0.05))} \\
   & = 0.9997
  \end{align}
  $$

There is a 99.97% chance that a person who tests negative does not have
the disease.

#### 1.3: Likelihood

* Suppose that an experiment results in data x = (x1, x2, ... , xn)
T and we decide to model the data using a probability (density) function
f(x|θ). This p(d)f describes how likely different data x are to occur
given a value of the (unknown) parameter θ. However, **once we have
observed the data, f(x|θ) tells us how likely different values of the
parameters θ are**: it is then known as the likelihood function for θ. In
other courses you may have seen it written as L(θ|x) or L(θ) but,
whatever the notation used for the likelihood function, it is simply the
joint probability (density) function of the data, f(x|θ), regarded as a
function of θ rather than of x.

##### Example 1.5

The likelihood function for $$\theta$$ follows the formulation in the
section introduction.

$$
\begin{align}
f(x \mid \theta) & = \prod_{i=1}^n f\chi_i(x_i \mid \theta) \\
\end{align}
$$

##### Example 1.7

#### 1.4: Sufficiency
