---
layout: article_post
title: Designing Very Large (JavaScript) Applications
date: 2018-05-06 17:07
categories:
tags: [article, technical, programming, architecture]
author: Malte Ubl
rating: 3
article_url: "https://medium.com/@cramforce/designing-very-large-javascript-applications-6e013a3291a3"
reading_time: 10
date_published: 2018-04-15
summary: "Lots of good architecture advice (not all JS-specific!) from a JS architect at Google"
---

## Notes

_Note_: adaptation of JSConf Australia talk

* Describes closed-source JS framework at Google that powers a lot of
  the biggest sites (Photos, Drive, etc.)
* What I think being senior means is that I’d be able to solve almost
  every problem that somebody might throw at me. I know my tools, I know
  my domain. And the other important part of that job is that I make the
  junior engineers eventually be senior engineers.
  * How to level up above senior:
    * **"I can anticipate how the API choices that I’m making, or the
      abstractions that I’m introducing into a project, how they impact
      how other people would solve a problem."** I think this is a
      powerful concept that allows me to reason about how the choices
      I’m making impact an application.
    * This is an application of **empathy**
* **The programming model** –- a word that I’m going to use a lot. It
  stands for “given a set of APIs, or of libraries, or of frameworks, or
  of tools–how do people write software in that context.” And my talk is
  really about, how subtle changes in APIs and so forth, how they impact
  the programming model.
* **Code splitting**: not every part of the app needs to be loaded on
  every page. Do it.
  * Established way to do it: split based on routes
    * Become infeasible when routes become huge. Think of Google search
      results page. Sometimes loads modules like weather, calculator,
      currency converter
  * Solution?: Dynamic imports. But this takes something that used to be
    static and makes it dynamic, which really increases complexity.
    _Changes the way you write the application_
  * Instead, invert it. Only load logic if it was rendered
* **Avoid central configuration at all costs**
  * E.g. avoid centralized CSS. Put component-specific CSS in
    components. Makes it much easier to delete code
    * Examples: routes.js. webpack.config.js
* **You want to get to a state where whatever the engineers on your team
  do, the most straightforward way is also the right way -- so that they
  don't get off the path, so that they naturally do the right thing.**
  * Otherwise, add a test that ensures the right way.
  * **Avoid human judgment outside of the application domain.
    Standardize!**

