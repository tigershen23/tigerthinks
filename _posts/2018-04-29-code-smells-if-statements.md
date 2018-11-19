---
layout: article_post
title: "Code Smells: If Statements"
date: 2018-04-29 09:26
categories:
tags: [article, technical, programming]
author: Trisha Gee
rating: 2
article_url: "https://blog.jetbrains.com/idea/2017/09/code-smells-if-statements/"
reading_time: 15
date_published: 2017-09-13
summary: "Avoid crazy conditionals by moving them to the correct place, collapsing them, extracting to methods"
---

## Notes

* If statements can go wild!
* Steps to refactor:
  * **Place guard conditions at the start**. Can go with `@NotNull`
  * Remove logic for controlling iteration. Use "normal" syntax man
  * Extract method for readability. Give it an expressive name
  * Replace multiple checks of the same value, try to short circuit
  * Collapse multiple conditionals into one if/else
  * Nice
* Differences between good and bad conditionals:
  * More else statements to make clearer distinction between code paths
  * Move early-exit code as close to the top as possible
  * Extract methods to encapsulate conditions
