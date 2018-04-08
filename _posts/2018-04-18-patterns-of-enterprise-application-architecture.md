---
layout: book_post
title: Patterns of Enterprise Application Architecture
date: 2018-04-18 05:00
categories:
tags: [book, nonfiction, technical, programming, architecture]
author: Martin Fowler
rating: 2
length_pages: 170
length_loc: 3475
date_started: 2018-02-02
date_finished: 2018-04-12
goodreads_url: "https://www.goodreads.com/book/show/70156.Patterns_of_Enterprise_Application_Architecture"
image: /books/patterns-of-enterprise-application-architecture.jpg
summary: "Solid set of backbone concepts for enterprise applications. Many of his ideas have developed a lot since this book was released in 2002 but it strengthened my understanding to see them explained firsthand."
---

*TL;DR*: Fundamental concepts of enterprise application development.
While this book dates itself in a lot of areas, the vocabulary and
concepts it introduces will be quite useful for me moving forward.

## Notes

Note: Only read Part 1 (The Narratives), skipped Part 2 (The Patterns)

* **Patterns are useful starting points, but they are not destinations**
  * Do not be dogmatic about following patterns
* An important but often overlooked part of patterns is developing a
  common vocabulary
* "Architecture" is overblown. Used primarily to draw attention. "If
  something is easier to change than you thought before, it is no longer
  architectural".
  * Weird second point to make here, my understanding is that
    flexibility is a big part of architectural decisionmaking. If you
    find something easier to change later, then perhaps you optimized
    for the correct things architecturally.
* **Business logic**: an oxymoron, since nothing is logical in business
* Impact of architectural decisions: "If a system has business benefits,
  delaying those benefits costs money. However, you don't want to make
  decisions now that hamper future growth. But if you add it now and get
  it wrong, the complexity added for flexibility's sake may actually
  make it harder to evolve in the future."
* Performance vocab:
  * **Response time**: total time it takes to process a request from the
    outside
  * **Responsiveness**: amount of time it takes a system to acknowledge
    a request (as opposed to processing it)
  * **Latency**: minimum time required to get any form of response from
    system
  * **Throughput**: how much stuff you can do in a given amount of time
  * **Performance**: either throughput or response time -- whichever
    matters more to you
  * **Load**: description of how much stress a system is under (e.g. how
    many users are currently connected
  * **Load sensitivity**: how response time scales with load; if you
    double the load, what factor does response time scale up by?
  * **Efficiency**: performance divided by resources
  * **Capacity**: maximum effective throughput or load
  * **Scalability**: How does adding resources affect performance?
    Scalable = more hardware, more performance without other changes
    * Build for hardware scalability for maximum flexibility

### 1: Layering

* Canonical example: 5- or 7-layer network stack
* Benefits of layering:
  * Understand single layer without knowing about other layers
  * Substitute one layer without affecting other layers
  * Standardization
* Downside:
  * Don't encapsulate everything well, e.g. if you need a piece of data
    in the UI and the database it needs to exist in every layer in
    between
    * Hmm how would you avoid this in the first place though
* Generally three primary layers in enterprise application:
  * **Presentation**
    * Domain and data source should never be dependent on presentation
      * Test: if you add a radically different presentation layer, do
        you have to duplicate logic?
    * Display info to user, interpret commands from user to pass to
      domain
  * **Domain**
    * Business logic
    * "Work" application needs to do
  * **Data source**
    * Generally DB for storing persistent data

### 2: Organizing Domain Logic

* **Active Record**: row data gateway with domain logic (handles model
  actions and data and persistence all together)
  * Alternative: **Data Mapper** separates persistence from logic
    completely between domain layer and data source
* **BLOB**: Binary Large OBject (lol)

### 3: Object-Relational Mapping

* _"My first choice tends to be STI, as it's easy to do and is resilient
  to many refactorings. I tend to use the other two (Class table
  Inheritance, Concrete Table Inheritance) as needed to help solve the
  inevitable issues with irrelevant and wasted columns"_ (47)

### 4: Web Presentation

* Apply MVC to make sure models are completely separate from
  presentation

### 5: Concurrency

* _As long as you do all your data manipulation within a transaction,
  nothing really bad will happen to you_
* Enterprise application concurrency concerns:
  * **Offline concurrency**: concurrency control for data that's
    manipulated during multiple database transactions
  * Server concurrency (multi-threading)...easier to deal with, most
    frameworks deal with it for you
* Concurrency vocab:
  * **Lost update**: two people check both do work from the same
    starting point, one commits before the other, the first person's
    work is lost when the second commit happens
  * **Inconsistent read**: read two things that are correct but not
    correct at the same time (i.e. two reads five seconds apart that
    happen in the middle of another operation and thus return a bad
    value)
  * **Liveness**: how much concurrent activity a system can handle
* Execution contexts:
  * **Request**: single call for the outside world which app works on
    and responds to
  * **Session**: long-running interaction between client and server (can
    be stateful series of requests)
  * **Process**: heavier execution context on the OS with full isolation
    of memory
  * **Thread**: lighter execution context on the OS without memory
    isolation
* Base techniques:
  * **Isolation**: keep transactions and operations apart from each other
  * **Immutability**: immutable data can be confidently shared
* Lock types:
  * **Optimistic**: allow concurrent edits, deal with conflicts on
    commit. Conflict detection.
  * **Pessimistic**: do not allow concurrent edits. Conflict prevention
* ACID transcation:
  * **Atomic**: all or nothing
  * **Consistent**: system is in non-corrupt state at beginning and end
    of transaction
  * **Isolated**: no other open transactions can see what's happening in
    an in-progress transaction
    * **Serializable** transactions can be executed concurrently and the
      result is the same as if you'd executed them serially. Always choose
      this isolation level!!
  * **Durable**: result of committed transaction must be permanent
* Also need to deal with **business transactions** which occur over the
  course of a session (e.g. an action someone is taking with their
  banking software over multiple UI pages)
  * **Process-per-request** model is good. Scalable and more robust than
    thread per request (single thread can take down entire process).

### 6: Session State

* **Session state** is data that's only relevant for a particular
  session (distinct from persistent record data)
* Can store session state on client, server, or database
  * Only put small amounts of data on client so you don't have to keep
    passing big things back and forth
  * Database session state is harder to access and hard to keep isolated
    from record data
  * Server session state is good for most things

### 7: Dsitribution Strategies

* **First Law of Distributed Object Design: Don't distribute your
  objects**

### 8: Putting It All Together

* Meta good practices. Nice.
  * CI
  * TDD
  * Refactoring
* Start with the domain layer. This is the most imporatnt piece of the
  system. Lean towards using **domain model**
