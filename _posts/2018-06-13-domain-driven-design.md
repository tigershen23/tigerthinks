---
layout: book_post
title: Domain-Driven Design
date: 2018-06-13 19:51
categories:
tags: [book, technical, programming, architecture]
author: Eric Evans
rating: 5
length_pages: 560
length_loc: 8888
date_started: 2018-04-18
date_finished: 2018-06-11
goodreads_url: "https://www.goodreads.com/book/show/179133.Domain_Driven_Design?ac=1&from_search=true"
image: /books/domain-driven-design.jpg
summary: "Software should be optimized for the domain it is performing in, or else it will turn into an unmaintainable nightmare for both developers and domain experts."
---

*TL;DR*: One of the best software books I've ever read. Puts into words
a lot of the best advice I've received about building software.

## Notes

Note: Part IV, Strategic Design, was much less useful to me than the
rest of the book.

### Foreword (Martin Fowler)

* _The greatest value of a domain model is that it provides a
  **ubiquitous language** that ties domain experts and technologists
  together._

### Preface

* Premise:
  * For most software projects, the primary focus should be on the domain
    and domain logic
  * Complex domain designs should be based on a model
* Prereqs:
  * Development is iterative
  * Developers and domain experts have a close relationship

## Part I: Putting the Domain Model to Work

* A **model**:
  * Is a selective simplification
  * Consciously structured form of knowledge
  * Focuses information on a problem

### Ch 1: Crunching Knowledge

* **Conversations**
  * _It is the creativity of brainstorming and massive experimentation,
    leveraged through a model-based language and disciplined by the
    feedback loop through implementation, that makes it possible to find
    a knowledge-rich model and distill it. This kind of **knowledge
    crunching** turns the knowledge of the team into valuable models._
    (12)
* Techincal success requires **serious learning about the specific
  domain**
* Be **specific**: _Domain experts are usually not aware of how copmlex
  their mental processes are as, in the course of their work, they
  navigate all these rules, reconcile contradictions, and fill in gaps
  with common sense. Software can't do this._ (16)

### Ch 2: Communication and the Use of Language

* Issue: _across this linguistic divide, the domain experts vaguely
  describe what they want. Developers, struggling to understand a domain
  new to them, vaguely understand._ (24)
  * _A project faces serious problems when its language is fractured.
    Domain experts use their jargon while technical team members have
    their own language tuned for dicussing the domain in terms of their
    design._ (24)
* Solution: **ubiquitous language**
  * _Use the model as the backbone of a language. Commit the team to
    exercising that language relentlessly in all communication within
    the team and in the code. Use the same language in diagrams,
    writing, and especially speech._ (26)
* Speech is the lossiest form of communication. Thus, if you have a
  model you can explain in conversation, it's probably good.
  * "If we give the routing service an origin, destination, and arrival
    time, it can look up the stops the cargo will have to make, and,
    well...stick them in the database" --> vague, technical
  * "The origin, destination, and so on...it all feeds into the routing
    service, and we get back an itinerary that has everything we need in
    it." --> more complete, but verbose
  * **A routing service finds an itinerary that satistfies a route
    specification** --> bingo
* _If sophisticated domain experts don't understand the model, there is
  something wrong with the model_ (32)
* _It takes fastidiousness to write code that doesn't just do the right
  thing but also says the right thing._ (40)
* Written design docs:
  * Should complement code and speech, not replace them
  * Should work for a living and stay current
    * If can't stay current, get rid of it

### Ch 3: Binding Model and Implementation

* _Domain-driven design calls for a model that doesn't just aid early
  analysis but is the very foundation of the deisgn [...] tightly
  relating the code to an underlying model gives the code meaning and
  makes the model relevant._ (46)
  * _If the design, or some central part of it, does not map to the
    domain model, that model is of little value, and the correctness of
    the softwarte is suspect._ (48)
* How to bind model and implementation: _Design a portion of the
  software system to reflect the domain model in a very literal way, so
  that the mapping is obvious. Revisit the model and modify it to be
  implemented more naturally in software, even as you seek to make it
  reflect deeper insight into the domain. Demand a single model that
  serves both purposes well, in addition to supporting a robust
  **ubiquitous language**._ (49)
* Silent side affects are generally unacceptable.

## Part II: The Building Blocks of a Model-Driven Design

![model-driven-design](/images/books/domain-driven-design-model-driven-design.png)

### Ch 4: Isolating the Domain

* _Concentrate all the code related to the domain model in one layer and
  isolate it from the user interface, application, and infrastructure
  code. The domain objects, free of the responsibility of displaying
  themselves, storing themselves, managing application tasks, and so
  forth, can be focused on expressing the domain model. This allows a
  model to evolve to be rich enough and clear enough to capture
  essential business knowledge and put it to work._ (70)
  * Nice. The service layer

### Ch 5: A Model Expressed in Software

* Three patterns of model eelements express model:
  * **Entity** represents something with continuity and identity,
    tracked through different states
    * **Defined primarily by its identity**
    * YES: Person, city, car, lottery ticket
    * NO: color, etc.
    * _The model must define what it means to be the same thing._ (92)
    * _The most basic responsibility of entities is to establish
      continuity so that behavior can be clear and predictable. They do
      this best if they are kept spare. Rather than focusing on the
      attributes or even the behavior, strip the entity object's
      definition down to the most intrinsic characteristics,
      particularly those that identify it or are commonly used to find
      or match it. Add only behavior that is essential to the concept
      and attributes that are required by that behavior. Beyond that,
      look to remove behavior and attributes into other objects
      associated with the core enty. Some of these will be entities.
      Some will be value objects._ (93)
  * **Value object** is basically anything that does not fit the above
    * _Tracking the identity of entities is essential, but attaching
      identity to other objects can hurt system performance, add
      analytical work, and muddle the model by making all objects look
      the same._ (97)
    * _An object that represents a descriptive aspect of the domain with
      no conceptual identity is called a value object. Value objects are
      instantiated to represent elements of the design that we only care
      about for what they are, not who or which they are_ (97)
    * Color or Route
    * **Make it immutable**
  * **Service** is something that is done for a client on request
    * _When a significant process or transformation in the domain is not
      a natural responsibility of an entity or value object, add an
      operation to the model as a standalone interface declared as a
      service. Define the interface in terms of the language of the
      model and make sure the operation name is part of the ubiquitous
      language. Make the service stateless._ (105)
    * Three good characteristics
      * Operation relates to concept that doesn't fit in entity or value
        object
      * Interface defined in terms of other elements in domain model
      * Operation is stateless
    * Best at "medium" granularity. Varies project o project
* Implementing every real-life association complicates implementation
  and maintenance. Some strategies:
  * Impose a traversal direction
  * Add a qualifier to reduce multiplicity (scope down associations)
  * Eliminate nonessential associations
* **Modules** are also a part of the model. Package code together to
  organize objects.
  * **Low coupling**: force users to think about as few things as
    possible at a time
  * **High cohesion**: force users to think about related topics at the
    same time
  * Don't be too heavy-handed with module and package distinctions
* _The most effective tool for holding the parts together is a robust
  ubiquitous language that underlies the whole heterogeneous model._
  (121)

### Ch 6: The Life Cycle of a Domain Object

* Managing object life cycle: must **maintain integrity** and **manage
  complexity**
* **Aggregates**
  * _a cluster of associated objects that we treat as a unit for the
    purpose of data changes. Each aggregate has a **root** and a **boundary**.
    The boundary defines what is inside the aggregate. The root is a
    single, specific entity contained in the aggregate. The root is the
    only member of the aggregate that outside objects are allowed to
    hold references to, although objects within the boundary may hold
    references to each other._ (126)
* **Factories**
  * Cars aren't assembled and driven at the same time. Similarly,
    complex objects should be assembled separate from where they're
    used
  * A program whose **responsibility is the creation of other objects**
  * Each creation method is atomic and enforces invariants of the entity
    or aggregate being created
  * If not super complex, can still use a constructor, but still a
    very useful pattern to have available
* **Repositories**
  * **Reconstitution**: Creation of an instance from stored data
  * Why? _Domain logic moves into queries and client code, and the
    entities and value objects become mere data containers. The sheer
    technical complexity of applying most database access infrastructure
    quickly swamps the client code, which leads developers to dumb down
    the domain layer, which makes the model irrelevant._ (149)
  * _A repository represents all objects of a certain type as a
    conceptual set. It acts like a collection, except with more
    elaborate querying capability. Objects of the appropriate type are
    added and removed, and the machinery behind the repository inserts
    them or deletes them from the database._ (151)
  * Present simple interface to clients
  * Decouple application and domain design from persistence
  * Communicate design decisions about object access
  * Allow easy mocking
* **Avoid find or create**. Distinction between new and existing object
  is important. Distinguishing between entities and value objects seems
  to get you most of the value.

### Ch 7: Using the Language: An Extended Example

![shipping-modules](/images/books/domain-driven-design-shipping-modules.png)
![shipping-applications](/images/books/domain-driven-design-shipping-applications.png)

## Part III: Refactoring Toward Deeper Insight

* Developing useful models:
  * Sophisticated domain models are **achievable** and **worth the
    time**
  * Domain models are developed through an iterative process of
    refactoring
  * Domain models may call for sophisticated design skills
* **Refactoring**: the redesign of software in ways that do not change
  its functionality
  * Instead of big up-front design, make a continuous series of small
    changes leaving existing functionality unchanged while making design
    more flexible and easier to understand
  * _The goal is that not only can a developer understand what the code
    dos; he or she can also understand why it does what it does and can
    relate that to the ongoing communication with the domain experts._
    (188)

### Ch 8: Breakthrough

![fixed-shares](/images/books/domain-driven-design-fixed-shares.png)
![share-pie](/images/books/domain-driven-design-share-pie.png)
![constraints](/images/books/domain-driven-design-constraints.png)

### Ch 9: Making Implicit Concepts Explicit

* Steps:
  * Recognize a concept that has been hinted at in discussion or
    implicitly in the design
  * Represent it explicitly in the model with one or more objects or
    relationships
* Before and after introducing **Itinerary** object:

  ![before-itinerary](/images/books/domain-driven-design-before-itinerary.png)
  ![after-itinerary](/images/books/domain-driven-design-after-itinerary.png)

### Ch 10: Supple Design

* _To have a project accelerate as development proceeds--rather than get
  weighed down by its own legacy--demands a design that is a pleasure to
  work with, inviting to change. A supple design._ (244)

![supple-design](/images/books/domain-driven-design-supple-design.png)

* **Intention-revealing interfaces**:
  * _In domain-driven design, we want to think about meaningful domain
    logic. Code that produces the effect of a rule without explicitly
    stating the rule forces us to think of step-by-step software
    procedures._ (245)
  * _If the interface doesn't tell the client developer what he needs to
    know in order to use the object effectively, he will have to dig into
    the internals to understand the details anyway. A reader of the
    client code will have to do the same. Then most of the value of the
    encapsulation is lost._ (246)
  * Therefore: _**Name classes and operations to describe their effect
    and purpose**, without reference to to the means by which they do
    what they promise. This relieves the client developer of the need to
    understand the internals. These names should conform to the
    ubiquitous language so that team members can quickly infer their
    meaning._ (247)
* **Side-effect-free functions**:
  * **Queries** obtain information from the system, e.g. retrieving
    variable data or performing a calculation
    * These should cause **no side effects**
  * **Commands** affect some change to the system
  * _Place as much of the logic of the program as possible into
    functions, operations that return results with no observable side
    effects. Strictly segregate commands into very sipmle operations
    that do not return domain information._ (250)
    * Example: extracting `Pigment Color` class from `Paint` that
      handles all of the mixing logic
  * _The necessity of tracing concrete execution defeats abstraction._
    (255)
* **Contours**:
  * _Find the conceptually meaningful unit of functionality, and the
    resulting design will be both flexible and understandable. For
    example, if an "addition" of two objects has a coherent meaning in
    the domain, then implement methods at that level. Don't break the
    add() method into two steps._ (261)
  * Make as many **conceptually independent** classes as possible
* **Closure of operations**:
  * _Where it fits, define an operation who return type is the same as
    the type of its argument(s). [...] Such an operation is closed under
    the set of instances of that type. A closed operation provides a
    high-level interface without introducing any dependency on other
    concepts._ (268)
* Goal (e.g. with Share Pie refactor): _producing code that begins to
  read like a conceptual definition of the business transaction, rather
  than a calculation._ (290)

### Ch 11: Applying Analysis Patterns


* **Analysis patterns** are groups of concepts that represent a common
  construction in business modeling.
* Double-entry accounting pattern:
  ![analysis-patterns](/images/books/domain-driven-design-analysis-patterns.png)
* Reapplying organized knowledge. Kind of out of scope without reading
  Fowler's book?
  * _Analysis patterns focus on the most critical and difficult
    decisions and illuminate alternatives and choices. They anticipate
    downstream consequences that are expensive if you have to discover
    them for yourself._ (306)

### Ch 12: Relating Design Patterns to the Model

* Two levels:
  * Technical design patterns in code
  * Conceptual patterns in model
* **Strategy/Policy** pattern
  * _Factor the varying parts of a process into a separate "strategy"
    object in the model. Factor apart a rule and the behavior it
    governs. Implement the rule or substitutable process following the
    Strategy design pattern. Multiple versions of the strategy object
    represent different ways the process can be done._ (311)
  * Ex: route-finding can be "default strategy" or "leg magnitude
    policy" (fastest) or "cost strategy" (cheapest)

### Ch 13: Refactoring Toward Deeper Insight

* **Three main points**:
  * Live in the domain
  * Keep looking at things a different way
  * Maintain an unbroken dialog with domain experts

## Part IV: Strategic Design

### Ch 14: Maintaining Model Integrity

* _The most fundamental requirement of a model is that it be internally
  consistent; that its terms always have the same meaning, and that it
  contain no contradictory rules. The internal consistency of a model,
  such that each term is unambiguous and no rules contradict, is called
  **unification**._ (332)
  * _Through a combination of proactive decisions about what should be
    unified and pragmatic recognition of what is not unified, we can
    create a clear, shared picture of the situation._ (333)
* **Bounded Contexts** is the specific place in the domain where a
  model applies
  * Look out for **duplicate concepts** (same thing expressed in two
    different ways) and **false cognates** (sound the same but are
    not the same)
* Best processes for **continuous integration**:
  * Reproducible merge/build technique
  * Automated testing
  * Rules setting an upper limit on the lifetime of unmerged changes
  * Constant exercise of ubiquitous language in discussion of the model
    and application
* _A **context map** is in the overlap between project management and
  software design. The natural course of events is for the boundaries to
  follow the contours of team organization. People who work closely will
  naturally share a model context._ (344)

  ![bounded-context](/images/books/domain-driven-design-bounded-context.png)

* **Shared kernel** is where multiple teams share ownership over the
  core domain
* **Anticorruption layer**: _Create an isolating layer to provide
  clients with functionality in terms of their own domain model. The
  layer talks to the other system through its existing interface,
  requiring little or no modification to the other system. Internally,
  the layer translates in both directions as necessary between the two
  models._ (365)
  * _A **Facade** is an alternative interface for a subsystem that
    simplifies access for the client and makes the subsystem easier to
    use. [...] The **facade** belongs in the bounded context of the
    other system. It just presents a friendlier face specialized for
    your needs._ (366)
  * _An **Adapter** is a wrapper that allows a client to use a different
    protocol than that understood by the implementer of the behavior.
    When a client sends a message to an adapter, it is converted to a
    semantically equivalent message and sent on to the "adaptee"._ (366)
* Balancing boundaries
  * Larger bounded contexts:
    * Flow between user tasks is smoother
    * Easier to understand one model than two plus mappings
    * Translation overhead
    * Shared language fosters clear team communication
  * Smaller bounded contexts
    * Less coordination required between teams
    * Don't need to stretch as far for abstractions
    * Can cater to special needs or narrower domains
* _There is a range of strategies for unifying or integrating models. In
  general terms, you will trade off the benefits of seamless integration
  of functionality against the additional effort of coordination and
  communication. You trade more independent action against smoother
  communication. More ambitious unification requries control over the
  design of the subsystems involved._ (387)

![context-relationship-patterns](/images/books/domain-driven-design-context-relationship-patterns.png)

### Ch 15: Distillation

* _**Distillation** is the process of separating the components of a
  mixture to extract the essence in a form that makes it more valuable
  and useful. A model is a distillation of knowledge._ (397)
  * _The effort is motivated by the desire to extract that one
    particularly valuable part, the part that distinguishes out software
    and makes it worth building: the **Core Domain**._ (397)

![distillation](/images/books/domain-driven-design-distillation.png)

* _Boil the model down. Find the **core domain** and provide a means of
  easily distinguishing it from the mass of supporting model and code.
  Bring the most valuable and specialized concepts into sharp relief.
  Make the core small. Apply top talent to the core domain, and recruit
  accordingly. Spend the effort in the core to find a deep model and
  develop a supple design--sufficient to fulfill the vision of the
  system. Justify investment in any other part by how it supports the
  distilled core._ (401)
* _When the field already has a highly formalized and rigorous model,
  use it. Acccounting and physics are two examples that come to mind._
  (408)
* **Domain vision statement**
  * _Write a short description (about one page) of the Core Domain and
    the value it will bring, the "value proposition". Ignore those
    aspects that do not distinguish this domain model from others. Show
    how the domain model serves and balances diverse interests. Keep it
    narrow. Write this statement early and revise it as you gain new
    insight._ (415)
  * Corollary: the **Distillation document**
    * _Write a very brief document (three to seven sparse pages) that
      describes the core domain and the primary interactions among core
      elements._ (417)

![domain-vision-statement](/images/books/domain-driven-design-domain-vision-statement.png)

### Ch 16: Large-Scale Structure

* _A **large-scale structure** is a language that lets you discuss and
  understand the system in broad strokes. A set of high-level concepts
  or rules, or both, establishes a pattern of design for an entire
  system. This organizing principle can guide design as well as aid
  understanding. It helps coordinate independent work because there is a
  shared concept of the big picture: how the roles of various parts
  shape the whole._ (442)
  * _Devise a pattern of rules or roles and relationships that will span
    the entire system and that allows some understanding of each part's
    place in the whole--even without detailed knowledge of the part's
    responsibility._ (442)

![large-scale-structure](/images/books/domain-driven-design-large-scale-structure.png)

* **Evolving order (my favorite)**
  * _An up-front imposition of a large-scale structure is likely to be
    costly. As development proceeds, you will almost certainly find a
    more suitable structure, and you may even find that the prescribed
    structure is prohibiting you from taking a design route that would
    greatly clarify or simplify the application._ (444)
  * _Let this conceptual large-scale structure **evolve** with the
    application, possibly changing to a completely different type of
    structure along the way. Don't overconstrain the detailed design and
    model decisions that must be made with detailed knowledge._ (444)
* **Responsibility layers**
  * _Layers are partitions of a system in which the members of each
    partition are aware of and are able to use the services of the layer
    "below", but unaware of and independent of the layers "above"._
    (450)

![responsibility-layers](/images/books/domain-driven-design-responsibility-layers.png)

* Espousing **minimalism** in refactoring towards a fitting structure
  * _One key to keeping the cost down is to keep the structure simple
    and lightweight. Don't attempt to be comprehensive. Just address the
    most serious concerns and leave the rest to be handled on a
    case-by-case basis. Early on, it can be helpful to choose a loose
    structure, such as a system metaphor or a couple of responsibility
    layers._ (481)

### Ch 17: Bringing the Strategy Together

![part-four](/images/books/domain-driven-design-part-four.png)

* **Assessment first** of a project
  * Draw a context map. Is it consistent?
  * Attend to use of language. Is it using a ubiquitious language?
  * Understand what is important. Is the core domain identified? Is
    there a domain vision statement? Can you write one?
  * Does the technology work for or against a model-driven design?
  * Do the developers have the necessary technical skills?
  * Are the developers knowledgeable about the domain?
* **Six essentials for strategis design decision making**
  * Decisions must reach the entire team
  * The decision process must absorb feedback
  * The plan must allow for evolution
  * Architecture teams must not siphon off all the best and the
    brightest
  * Strategic design requires minimalism and humility
  * Objects are specialists; Developers are generalists
* _The success of a design is not necessarily marked by its stasis. Take
  a system people depend on, make it opaque, and it will live forever as
  untouchable legacy. A deep model allows clear vision that can yield
  new insight, while a supple design facilitates ongoing change. The
  model they came up with was deeper, better aligned with the real
  concerns of the users. Their design solved real problems. It is the
  nature of software to change, and this program has continued to evolve
  in the hands of the team that owns it._ (502)
