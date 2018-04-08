---
layout: article_post
title: "Code Smells: Null"
date: 2018-04-29 08:48
categories:
tags: [article, technical, programming]
author: Trisha Gee
rating: 3
article_url: "https://blog.jetbrains.com/idea/2017/08/code-smells-null/"
reading_time: 12
date_published: 2017-08-17
summary: "All about the Null code smell. Use `Optional`, `@NotNull` to combat it."
---

## Notes

* Scattered null-checks: sad!
* Things null can mean:
  * Value was never initialised (whether accidentally or on purpose)
  * Value is not valid
  * Value is not needed
  * No such value exists
  * Something went terribly wrong and something that should be there is
    not
  * Probably dozens of other things. Some avoidable if you're
    disciplined/use linter
* `Optional` solved the case of: no such value exists
* Smell: return null. Solution: `@NotNull` annotation for guard clause
  based null return. Explicit null return solvable with `Optional`
* Return an exception in exceptional case! Don't return null!
* Field-level null can be acceptable. Make sure it's well understood and
  well-documented what can be null and why
