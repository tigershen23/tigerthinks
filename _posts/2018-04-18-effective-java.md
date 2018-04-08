---
layout: book_post
title: Effective Java, 2nd Edition
date: 2018-04-18 05:01
categories:
tags: [book, nonfiction, technical, programming]
author: Joshua Bloch
rating: 3
length_pages: 350
length_loc: 7500
date_started: 2018-02-02
date_finished: 2018-04-12
goodreads_url: "https://www.goodreads.com/book/show/105099.Effective_Java_Programming_Language_Guide"
image: /books/effective-java.jpg
summary: "Very good grab bag of tips and tricks for Java. Many were immediately applicable. Explained at the perfect level of abstraction for me."
---

*TL;DR*: Very good grab bag of tips and tricks for Java. Many were
immediately applicable. Explained at the perfect level of abstraction
for me.

## Notes

Note: skipped over Ch 10 (Concurrency) and Ch 11 (Serialization)

* Looking forward to picking up Core Java after this

### 2: Creating and Destroying Objects

* Avoid memory leaks by nulling out references once they become
  obsolete...but don't do it all the time!

### 3: Methods Common to All Objects

* Override `Object.equals` when a class has a notion of _logical
  equality_ separate from object identity
* Provide programmatic access to all of the information contained in the
  return value of `toString()`
* Override clone judiciously
  * The clone method functions as another constructor; you must ensure
    that it does no harm to the original object and that it properly
    establishes invariants on the clone.

### 4: Classes and Interfaces

* **Minimize the accessibility of classes and members**
  * Well-designed module hides all of its implementation details,
    seaprating API from implementation. Modules communicate with each
    other only through their APIs
  * **Information hiding** or **encapsulation**
  * Do not use public static final array fields in classes. These are
    accessible and mutable.
* To make a class immutable:
  * Don't provide any methods that modify the object's state
  * Ensure that the class can't be extended (make it final)
  * Make all fields final
  * Make all fields private
  * Ensure exclusive access to any mutable components (don't allow
    chained access to them)
* **Classes should be immutable unless there's a very good reason to
  make them mutable.**
* **Favor composition over inheritance**
  * Inheritance violated encapsulation
  * Instead of extending an existing class, give new class a private
    field that references an instance of the existing class (the new
    class is composed of the existing class)
  * If you declare a member class that does not require access to
    enclosing instance, make it static

### 5: Generics

* Class with **type parameters** in declaration is a **generic**
  * Each generic type defines **parameterized types** (`List<String>`)
    and a **raw type** (`List<E>`)
    * Don't use raw types tho. You lose safety and expressiveness
* If you eliminate all warnings, you are assured typesafe code.
* Arrays are not generic
  * Arrays are **covariant**: `Sub[]` is a subtype of `Super[]`.
    Generics are **invariant** (`Sub[]` is not a subtype of `Super[]`)
  * Arrays are **reified**. They know and enforce their types at
    runtime. Generics are **erasure**, check these at compile time.
  * **Non-reifiable type** has a runtime representation with less
    information than compile-time representation.
* Generic methods are safer and easier to use than methods that require
  their clients to cast input parameters and return values.

### 6: Enums and Annotations

* Use enums!!
* Associate a different behavior with each enum constant: declare an
  abstract apply method in the enum type, and override it with a
  concrete method for each constant in a **constant-specific class
  body**:
  * `PLUS { double apply(double x, double y) {return x + y;} }`
* **Prefer annotations to naming patterns**
  * First-class support, better semantics, less brittle
* **Use marker interfaces to define types**
  * Interface with no method declarations that designates a class that
    implements that interface as having some property
  * Use marker annotations if you want to allow for possibility of
    adding more information to marker in the future

### 7: Methods

* Every time you write a method, think about the restrictionos that
  exist on its parameters. Document and enforce these descriptions; the
  work it takes will pay for itself many times over.
  * Use `assert` statements to check parameters in non-public methods
* Defensively copy mutable components that you get or return to clients
  to ensure they aren't messed with.
* Method signatures:
  * **When in doubt, leave it out.**
  * Shorten long parameter lists by creating **helper classes** (e.g.
    Card class instead of suit/value parameters to everything)
  * **Favor interfaces over classes** for parameter types
  * **Prefer two-element enum types to boolean parameters**. They are
    more expressive
* Try not to overload. It's confusing and error-prone.
* JavaDoc comments should be considered mandatory for all exported API
  elements.

### 8: General Programming

* **Minimize the scope of local variables**
* **Know and use the standard libraries**
* **Don't use float/double for money**. Use BigDecimal
* Differences between primitives and boxed primitives:
  * Boxed primitives can be null
  * Primitives are more space-efficient
  * Primitives can only have their values, boxed primitives have
    distinct object identities
    * **Never use == with boxed primitives**
* **Avoid strings where other types are more appropriate**
  * Write a class to represent the aggregate (private static member)
* **Refer to objects by their interfaces** (generalization of Item 40)
  * Much more flexible
  * `List<Subscriber> subscribers = new Vector<Subscriber>();`
* Mantras for optimization:
  * _More computing sins are committed in the name of optimization
    (without necessarily achieving it) than for any other single reason
    -- including blind stupidity._ (Wulf, 72)
  * _We should forget about small inefficiencies, say about 97% of the
    time; premature optimization is the root of all evil._ (Knuth, 74)
  * _Two rules in the matter of optimization: Rule 1. Don't do it. Rule
    2 (for experts only). Don't do it yet -- that is, not until you have
    a perfectly clear and unoptimized solution._ (Jackson, 75)
  * **Strive to write good programs rather than fast ones.**
  * **Strive to avoid design decisions that limit performance.**
* Type parameter names:
  * **T**: arbitrary type
  * **E**: element type of a collection
  * **K**: key type of a map
  * **V**: value type of a map
  * **X**: exception

### 9: Exceptions

* **Use exceptions only for exceptional conditions.**
* **Use checked exceptions for recoverable conditions and runtime
  exceptions for programming errors.**
  * Checked exception: must be caught or declared in the method in which
    it is thrown
  * Make sure checked exception contains enough info for programmer to
    recover
* A **failure atomic** method leaves object in the state it was prior to
  invocation when the method fails. Strive for this.
  * Check parameters for validity before performing operation
* Implement Serializable judiciously; it drastically reduces portability
  and flexibility of the class.
