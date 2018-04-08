---
layout: article_post
title: "Code Smells: Mutation"
date: 2018-04-29 09:42
categories:
tags: [article, technical, programming]
author: Trisha Gee
rating: 3
article_url: "https://blog.jetbrains.com/idea/2017/08/code-smells-mutation/"
reading_time: 13
date_published: 2017-08-29
summary: "Make things immutable as much as you can!"
---

## Notes

* See Effective Java notes
* The point is this mf value is being changed, and this makes it even
  harder to reason about.  For example, when we check if it’s present
  later in the code, if the value is empty we don’t know if it’s empty
  because getMappedField returned no value or if it’s because
  getMappedFieldByJavaField returned no value. We just don’t know what
  it means if it is empty.
* StringBuilder for immutable string concats
* Don't mutate parameters! Make copies

* From the article:
  * If the code is altering an array or collection that it is also
    reading from, consider having a second collection or array to track
    changes and leave the initial values unaltered. Reading and writing
    from the same collection, while safe in our specific example, can
    lead to unexpected results and concurrency issues.
  * If it’s hard to tell which code branch a particular value came from,
    you may either want to store several values with readable names
    instead of reusing a variable, or move the code that changes the
    value into a separate method so that the changes are restricted to a
    small section of code.
  * If input parameters are being altered, consider adding a new value
    to the object that is returned so it contains all the data that
    needs to be returned.  If this isn’t possible, consider introducing
    a new type to wrap all the return values.
  * Counters or boolean primitives may not be the best way to keep track
    of state within a method. Removing them or moving them into an
    appropriate domain class may make it easier to refactor code into
    something simpler.
