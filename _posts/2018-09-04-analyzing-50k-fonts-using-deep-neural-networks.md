---
layout: article_post
title: "Analyzing 50k fonts using deep neural networks"
date: "2018-09-04 00:02"
categories:
tags: [article, technical, ml, dyslexia, programming, ppl]
author: Erik Bernhardsson
rating: 4
article_url: https://erikbern.com/2016/01/21/analyzing-50k-fonts-using-deep-neural-networks.html
reading_time: 14
date_published: 2016-01-21
summary: "Perfect dataset for training fonts, trained model even has 40 latent factors."
---

## Notes

* I started with 512 * 512 bitmaps of all character. For every font you find the
  max y and min y of the bounding box, and the same thing for each individual
  letter. After some more number juggling I was able to scale all characters
  down to 64 * 64.
* Some notes on the model
  * 4 hidden layers of fully connected layers of width 1024.
  * The final layer is a 4096 layer (64 * 64) with sigmoid nonlinearity so that the output is between 0 (white) and 1 (black).
  * L1 loss between predictions and target. This works much better than L2 which generates very “gray” images – you can see qualitatively in the pictures above.
  * Pretty strong L2 regularization of all parameters.
  * Leaky rectified units (alpha=0.01) of nonlinearity on each layer.
  * The first layer is 102D – each font is a 40D vector joined with a 62D binary one-hot vector of what is the character.
  * Learning rate is 1.0 which is shockingly high – seemed to work well. Decrease by 3x when no improvements on the 10% test set is achieved in any epoch.
  * Minibatch size is 512 – seemed like larger minibatches gave faster convergence for some weird reason.
  * No dropout, didn’t seem to help. I did add some moderate Gaussian noise (of sigma 0.03) to the font vector and qualitatively it seemed to help a bit.
  * Very simple data augmentation by blurring the input randomly with sigma sampled from [0, 1]. My theory was that this would help fitting characters that have thin lines.
* In particular, if I had more time, I would definitely explore generative
  adversarial models, which seems better at generating pictures. Another few
  things should be relatively easy to implement, such as batch normalization and
  parametric leaky rectifications. And finally the network architecture itself
  could probably benefit from doing deconvolutions instead of fully connected
  layers
* Output: 40D embedding of all fonts
* Things to do with model:
  * Recreate characters from fonts
  * Come up with new fonts
  * Map font vectors with PCA or t-SNE


