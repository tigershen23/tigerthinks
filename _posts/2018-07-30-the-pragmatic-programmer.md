---
layout: book_post
title: The Pragmatic Programmer
date: 2018-07-30 15:52
categories:
tags: [book, nonfiction, technical, programming, advice]
author: Andy Hunt, Dave Thomas
rating: 3
length_pages: 321
length_loc: 4721
date_started: 2018-06-11
date_finished: 2018-07-04
goodreads_url: "https://www.goodreads.com/book/show/4099.The_Pragmatic_Programmer"
image: /books/the-pragmatic-programmer.jpg
summary: "Collection of somewhat common sense but well-stated programming advice."
---

*TL;DR*: Andy Hunt and Dave Thomas have done a lot of programming. This
is what they have to say about it. Some pieces are outdated, others are
timeless, all are certainly worth the read.

## Notes

### 1: A Pragmatic Philosophy

* _Tip 1: Care About Your Craft_
* _Tip 2: Think! About Your Work_
* _<b>Kaizen</b> is a Japanese term that captures the concept of
  continuously making many small improvements_ (L239)
* Pragmatic programmers think beyond the immediate problem, always aware
  of the bigger picture
* _One of the cornerstones of the pragmatic philosophy is the idea of
  taking responsibility for yourself and your actions in terms of your
  career advancement, your project, and your day-to-day work. "The
  greatest of all weaknesses is the fear of appearing weak."_ (L239)
* Stone Soup and Boiled Frogs: kick off a small part of change yourself.
  People find it easier to join an ongoing success.
* _Great software today is often preferable to perfect software
  tomorrow. If you give your users something to play with early, their
  feedback will often lead you to a better eventual solution._ (L450)
  * Stop when you hit great!
* _An investment in knowledge always pays the best interest - Ben
  Franklin_ (L482)
  * Unfortunately, in tech, knowledge expires. Gotta keep the tools
    sharp.
* **WISDOM** of understanding audience
  * What do you want them to learn?
  * what is their Interest in what you have to say?
  * how Sophisticated are they?
  * how much Detail do they want?
  * whom do you want to Own the information?
  * how can you Motivate them to listen to you?

### 2: A Pragmatic Approach

* _Maintenance is not a discrete activity, but a routine part of the
  entire development process._ (680)
  * Don't bemoan it! You can try to cut down but it will still be there
    and it should be.
* **DRY**: Don't Repeat Yourself.
* Duplication types:
  * **Imposed duplication**, where developers feel like they have no
    choice
  * **Inadvertent duplication**, where developers don't realize they're
    duplicating
  * **Impatient duplication**, where developers get lazy and duplicate
    because it's easier
  * **Interdeveloper duplication**, where developers do the same work
* Things are **orthogonal** if changes in one do not affect any of the
  others, e.g. database code and user interface
  * Non-orthogonal systems are more complex to change and control. Make
    it so there's no such thing as a local fix.
  * _Tip 13: Eliminate Effects Between Unrelated Things_
  * Main benefits: **increased productivity** and **reduced risk**
* _Don't rely on the properties of things you can't control_ (L885)
* With DRY you're looking to minimize duplication within a system,
  whereas with orthogonality you reduce the interdependency among the
  system's components.
* When in doubt, choose the more **reversible** decision
* **Tracer code**: minimum viable deployable application, end to end
  * **Not** throwaway code (that's a prototype)
  * Benefits:
    * Users get to see something working early
    * Developers build a structure to work in
    * You have something to demonstrate
    * You have a better feel for progress (easier to scope)
* Questions to ask when prototyping:
  * Are responsibilities of major components well-defined and
    appropriate?
  * Are the collaborations between major components well-defined?
  * Is coupling minimized?
  * Can you identify potential duplication?
  * Are interface definitions and constraints acceptable?
  * Does every module have access to the data it needs during execution?
* **Domain language**: "ubiquitous language" concept from DDD.
  * _Whether it's a simple language to configure and control an
    application program, or a more complex language to specify rules or
    procedures, we think you should consider ways of moving your project
    closer to the problem domain._ (L1217)
* **Estimating**
  * First question is about context. Do you need high accuracy or just a
    ballpark?
  * Steps:
    * Understand what's being asked
      * Scope scope scope
    * Build a mental model of the system
    * Break the model into components
    * Give each parameter a value
    * Calculate the answers
  * **I'll get back to you.**

### 3: The Basic Tools

* **Plain-text**: universally portable, human readable, will never be
  obsolete, not tied to any implementation or parser
  * **Command shell** is the workbench for manipulating plain text
* **Editor**: know one. Well.
* **Debugging**
  * Debugging is problem solving.
  * _Beware of myopia when debugging. Resist the urge to fix just the
    symptoms you see: it is more likely that the actual fault may be
    several steps removed from what you are observing, and may involve a
    number of other related things. Always try to discover the root
    cause of a problem, not just this particular appearance of it._
    (L1758)
  * Start by gathering all relevant data
  * Go through all assumptions and verify
  * Tracer print statements: "I AM HERE"...
  * Rubber duck: just explain the problem out loud
  * **Test, test, test** when you make the fix
  * Checklist:
    * Is the reported problem a symptom or the real thing?
    * Is the bug in the compiler or in the OS?
    * How would you explain the problem to a coworker?
    * Are the tests complete?
    * Do the conditions that caused this bug exist anywhere else in the
      system?

### 4: Pragmatic Paranoia

* Don't trust yourself! You make mistakes. Be defensive
* Design by contract: Add contracts to your code (i.e. iContract for
  Java). Your code shøuld abide by the contract and do nothing more.
  * Meh
* **Liskov Substitution Principle**: Subclasses must be usable through
  the base class interface without the need for the user to know the
  difference
* Leave **assertions** in your code to call out non-negotiable contracts
* _Tip 34: Use Exceptions for Exceptional Problems._
* _Tip 35: Finish What You Start_
  * Close files, etc.

### 5: Bend, or Break

* Limit interaction between modules
* **Law of Demeter**: don't reach into an object to gain access to a
  third object's methods
  * More like a "guideline of Demeter"
* **MVC**: separate model (data), view (interpretation of model),
  controller (coordination and translation mechanism)

### 6: While You Are Coding

* **Program deliberately**
  * Don't "program by coincidence"; you must understand exactly why your
    code works
  * **Rely only on documented behavior**
    * If you can't, **document your assumption well**
  * How?
    * Always be aware of what you're doing
    * Understand the domain
    * Plan first.
* **Programming isn't construction, it's gardening**
  * Organic, changes, growth
  * Fowler's rules on refactoring:
    * Don't refactor and add functionality at the same time
    * Make sure you have good tests before you begin refactoring.
      Refactor tests as often as possible. Then you'll know quickly if
      you broke anything
    * Take short, deliberate steps. Line by line, method by method.
      Check your changes often.

### 7: Before the Project

* _Tip 51: Don't Gather Requirements, Dig For Them_
  * Requirements are not on the surface. People, especially domain
    experts, tend to leave out stuff that feels "basic" to them but is
    actually very important to the implementation
  * Shadowing is an effective technique
* **Project glossary** tracks all the commonly used words in the project
* **Specification trap**: don't try to get every single detail. Just get
  it to the point where the programmer's skill can take over.
  * Trick: try to describe how to tie their shoes.

### 8: Pragmatic Projects

* **Automate, automate, automate**
  * Appoint tool builders on the team to make sure things get automated
  * _People just aren't as repeatable as computers are._ (L4020)
* Types of tests to write:
  * Unit tests
  * Integration tests
  * Validation and verification (does it actually work the way the user
    wants?)
  * Resource exhaustion, errors, recovery
    * Memory, disk space, CPU bandwidth, wall-clock time
  * Performance testing
  * Usability testing
* Make **well chosen and meaningful** variable names
  * Never make misleading names!! These trigger the **Stroop Effect**
    and the brain gets super confused
* Document concisely but thoroughly
* Small usability wins:
  * Tooltip help
