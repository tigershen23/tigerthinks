---
layout: article_post
title: "Code Smells: Deeply Nested Code"
date: 2018-04-29 09:04
categories:
tags: [article, technical, programming]
author: Trisha Gee
rating: 2
article_url: "https://blog.jetbrains.com/idea/2017/08/code-smells-deeply-nested-code/"
reading_time: 12
date_published: 2017-08-16
summary: "Deeply nested code is bad. Encapsulate, use streams."
---

## Notes

* Deeply nested code: double for loop with inner if statement. Yuck!
* Solution: use **Java 8 streams**
* Solution **Better encapsulation**
  * Extract inner loops to separate methods, etc.
