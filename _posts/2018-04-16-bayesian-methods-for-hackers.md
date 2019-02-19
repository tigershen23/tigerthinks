---
layout: book_post
title: Bayesian Methods For Hackers
date: 2018-04-16 06:00
categories:
tags: [book, nonfiction, technical, ppl]
author: Cam Davidson-Pilon
rating: 2
length_pages: 256
length_loc: 7475
date_started: 2018-01-28
date_finished: 2018-04-12
goodreads_url: "https://www.goodreads.com/book/show/19089710-probabilistic-programming-bayesian-methods-for-hackers"
image: /books/bayesian-methods-for-hackers.jpg
summary: "The simplest explanation of Bayesian methods and probabilistic programming I've come across. Says a lot about the field that this book was still extremely difficult to get through."
---

*TL;DR*: The simplest explanation of Bayesian methods and probabilistic
programming I've come across. Says a lot about the field that this book
was still extremely difficult to get through. Enjoyed the writing style
quite a bit, and thought the examples were fascinating.

## Notes

Simple definition of Bayesian Inference: **updating your beliefs after
considering new evidence**. We can get more and more confident, but never
absolutely sure!

My notes on this book are in a series of Colab Notebooks, following the
book's format of being written in Jupyter notebooks:

1. [Introduction](https://drive.google.com/file/d/1whF74HRgB_YuWD_pUYNjJsXBwVqGaoHx/view?usp=sharing)
    1. Example: text message data inference ("can you detect the
       inflection point in a user's behavior given their text message counts
       by day?")
1. [A Little More on PyMC](https://drive.google.com/file/d/1x7OSIsGdqAIOimNbx-PuGYrZ4yqA15Ut/view?usp=sharing)
    1. Example: A/B testing -- finding a distribution for the delta of two
       sites, Site A and Site B, to probabilistically determine which
       performed better in the A/B test and by how much.
1. [Opening the Black Box of MCMC](https://drive.google.com/file/d/1qKEgcw2dbQIPjsHp_0cWMTdvBkrDs6Qk/view?usp=sharing)
    1. Example: unsupervised clustering of a dataset around two normal
       distributions using a mixture model.
1. [The Greatest Theorem Never Told](https://drive.google.com/file/d/1Po1KaT28qDY7s_6H0heGp3yppctVwlmN/view?usp=sharing)
    1. Example: how to order Reddit submissions (factors: vote count, time
       passed, etc.)
1. [Loss Functions](https://drive.google.com/file/d/16AwVu84R1eEmgYpNcjQESCSIuOxg5UoS/view?usp=sharing)
    1. Example: optimizing for The Showcase on The Price is Right
    1. Example: Bayesian Kaggle submission for observing dark matter
1. [Priors](https://drive.google.com/open?id=14ajIQOoI7z9icpzCxRJ--bZthNTeby1i)
    1. Example: predicting stock returns

Overall, this is some of the most challenging material I've worked on in
any field, not just machine learning. I'm really grateful for this book,
since I was completely drowning in the material before I found it. I
believe in the power of probabilistic programming and modeling, and I
look forward to exploring it more with libraries like Uber's Pyro and
Google's Tensorflow Probabilities.

After reading this book I don't feel like I have a great handle on MCMC
or building PyMC models, but I have at least enough of a foundation in
vocabulary and concepts to begin branching out.
