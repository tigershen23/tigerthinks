---
layout: article_post
title: "Web Architecture 101"
date: "2018-08-02 17:23"
categories:
tags: [article, technical, programming, architecture, devops]
author: Jonathan Fulton
rating: 3
article_url: https://engineering.videoblocks.com/web-architecture-101-a3224e126947
reading_time: 12
date_published: 2017-11-07
summary: "Walkthrough of Web Application Architecture"
---

## Notes

![web-architecture-101-overview](/images/articles/web-architecture-101-overview.png)
* Horizontal scaling means that you scale by adding more machines into your
  pool of resources whereas “vertical” scaling means that you scale by adding
  more power (e.g., CPU, RAM) to an existing machine.
* Back to load balancers. They’re the magic sauce that makes scaling
  horizontally possible. They route incoming requests to one of many application
  servers that are typically clones / mirror images of each other and send the
  response from the app server back to the client. Any one of them should
  process the request the same way so it’s just a matter of distributing the
  requests across the set of servers so none of them are overloaded.
* Typical data pipeline: events to the data firehose, data transformation, save
  to cloud storage, loaded to data warehouse for analysis
