---
layout: course_post
title: 'Databases'
date: 2017-03-26 00:00
categories:
tags: [course, technical, cs, bradfield]
author: Bradfield
rating: 4
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/databases/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's databases class"
---

## Notes

### 1: Introduction to Database Engines

#### Architecture of a Database System (Hellerstein, Stonebraker, Hamilton)

- What goes into designing a database? Process models, parallelism,
  storage system, transaction system, query processor + optimizer,
  shared components

- Database architecture info isn't as well circulated as it should be
  because the community is small and traditionally people focus on
  algorithms not architecture
- Relational systems most common nowadays
- Five parts of a dbms: process manager, client communications manager,
  relational query processor, transactional storage manager, shared
  components and utilities
- Life of a query
  - Query initialized by a call or something, client server interaction
    Dbms assigns thread of computation to command. Makes sure client can get
    to output stream. Job of process manager. Admission control is important
    here - start processing query now or defer until more resources
    available?
  - Relational query processor checks that user is authorized to run query,
    compiles sql into a query plan. Then the plan executor, which is made up
    of operators for executing queries (join, select, etc) , takes the plan
    and runs it
  - Part of query plan is operator whose job is to request data. They make
    calls to the transactional storage manager, which manages data crud.
    Storage system is made up of tables and indices ("access methods") and
    whatnot. Also has buffers for storage and disk and memory and stuff.
    Lock must be acquired from lock manager to make sure no conflicts. If
    it's a write, interact with log manager to make sure transaction is
    durable
  - Now record access is happening, result being computed for client.
    "Unwind the stack": access methods return to query executor operators,
    which compute the results from db data, which are placed on buffer for
    client communications manager, which puts results on caller's plate.
    Then connection is closed and everyone cleans up. Txn manager cleans
    state, process manager frees control structures, communications manager
    cleans control state

- Overview
- Scope of this paper is mostly architectural yay

- Process models
- Models for highly concurrent systems
- *Process* is an OS program execution unit with a private execution
  space and address space
- *Thread* is an OS program execution unit without additional private
  context and without additional private address space. Each thread can
  get to same memory as other threads in the process. Execution scheduled
  by OS, called "k-threads". Compute isolation abstraction, whereas
  processes are memory abstracted
- *Lightweight thread package*: application-level construct for multiple
  threads in a single process. Scheduled at application level, not OS.
  Faster thread switches because you don't need to context switch to
  kernel code. However, blocking ops (e.g. synchronous i/o) stop all
  threads in process rather than just one. Remedy this by only doing async
  work. More difficult. Some DBMS's implement their own lightweight thread
  packages.
- *Client* is what talks to the database from application programs
- *DBMS Worker* is the thread of execution that does work on behalf of
  client. Each worker handles SQL requests from one client

- Some simple systems
- Assumptions: good OS thread support and uniprocessor hardware (these break
  later!)
- Process per DBMS worker: each client gets a process. Easy to
  implement, but getting data shared between workers is hard. Doesn't
  scale well. Shared data needs to happen with OS-supported shared
  memory (e.g. memory mapping)
- Thread per DBMS worker: Single process hosts all workers. Dispatcher
  thread listens for new client connections and allocates new thread.
  Hard because of lack of memory protection between threads. Scales to
  large number of connections. Use a DBMS worker if you're nixing the
  first assumption (implement your own lightweight threads)
- Process pool: similar to process per, but instaed of spinning up one
  process per client you have a pool of processes through which requests
  get multiplexed. Much more memory efficient
- How to deal with sharing? Share data structures and state.
  By using buffers: disk i/o and client communication
- (Disk i/o) *Buffer pool* is where all persistent data is staged.
  Thread generates request asking for an address on disk and provides a
  free buffer pool spot where it wants to read the memory from. To go from
  buffer->disk, thread gives a destination and a pointer to spot in buffer
  where data is stored. For thread per worker, it's just a structure on
  the heap. Otherwise, it's in shared memory
- (Disk i/o) *Log Tail* is where all logs from processes/threads go, and it is
  flushed to disk first in first out. Key point: threads/processes need
  to be able to request that log records be written and that log tail be
  flushed. Shared memory
- Client communication buffer preps stuff it thinks the client will
  need, prefetching so it's already available
- Postgres, Oracle use process per DBMS worker, MySQL uses thread per DBMS
  worker
- SQL Server, Microsoft SQL Server use DBMS workers multiplexed over a
  thread pool
- *Admission Control*: don't accept new work unless there are available
  resources. Two tiers
  - Dispatcher keeps # of client connections below a certain amount
  - After parse and optimize, query processor determines whether to run
    immediately, postpone, or start execution with fewer resources. Uses
    info about how long the optimizer expects it to take. Memory
    footprint generally the most crucial aspect

- Processes and Memory Coordination (Parallel Architecture)
- Modern hardware has *shared memory and disk* with equally access time
  from all cores, works well for all models, supporting execution of
  multiple independent queries in parallel
- Another model is *shared-nothing*, where you have a bunch of nodes ina
  cluster and you horizontally partition your data between them. Each
  node can accept requests and then send out requests to other nodes to
  try and find the data they're looking for. Query run in parallel a bunch
  of times, data returned back
- *Shared disk*: processor can access the same disk, but have separate
  RAM. Advantage over shared-nothing is lower cost of administration
  (don't need to think about partitioning). Nice b/c failure of one node
  doesn't affect other nodes' ability to access entire database. Because
  memory isn't shared, need a distributed lock manager and cache coherency
  protocol to resolve conflicts between each node's copy of the data

- Now if we break the assumption of uniprocessor hardware things get
  interesting
- If you do thread per DBMS worker, you can only have one process, so
  you lose all advantages of multi-processor hardaware. Instead, you
  should map DBMS threads onto multiple processes. Generally have one OS
  process per processor, and then allocate them evenly?

- Same theme in terms of support: most DBMS's support multiple
  parallelism models. Shared memory is almost ubiquitious. Then, systems
  make choiec between shared disk and shared nothing

##### Relational Query Processor

- Bit finer-grained
- Job: take a declarative SQL statement, validate it, optimize it into
  a query plan, execute that plan on behalf of the client program
- Client pulls the result tuples one at a time or in pages
- Concurrency managed at lower levels, so this can be abstracted as
  single user single thread

- Parsing and authorization
- Query correctly specified?
- Resolve names and references
- Convert query into internal format
- Verify user is authorized for query
- Four part name for unique table: `server.database.schema.table`
- Asks *catalog manager* to make sure tables are registered in the
  catalog so you can quit if they aren't. Catalog contains metadata

- Query rewrite
- Simplify and normalize query without changing semantics

#### Stonebraker retrospective

- https://www.youtube.com/watch?v=9K0SWs1mOD0
- Spent lots of time since 70's trying to make RDBMS's the truth (added
  ADTs, triggers, etc)
- Realized in 2005 that this wouldn't work, streaming was so so
  different
- One Size Fits None now :(
- Data Warehouses: column stores are way faster than row stores, column
  stores will replace them soon enough
- OLTP (online transaction processing): just put all your data in main
  memory, pay that cost
- NoSQL has no standards and none are same as row stores from legacy
  vendors
- Analytics: lots of more complex stuff than SQL, data scientists will
  do fancier stuff than table operations (arrays not tables)
- Graph Analytics: can simulate in a column store/array engine, or use
  special purpose graph engine. Row stores will not work here
- Huge diversity of engines, all oriented towards specific
  verticals/applications. Traditional row stores are good at none of
  these markets :(
- Lots of different engines and new ideas
- Elephants in the room have a hard time going from old to new without
  losing market share
- Hekaton is main-memory implementation behind the interface of SQL
  Server
- 80's and 90's "dead on our feet" because of One Size Fits All
  philosophy
  - Now better because we don't believe that any more

#### Lecture

- Relational vs non-relational
- Relational: define relations strictly, with column names. E.g. _all_
  employees have id, name, salary
- Non-relational: relations are not defined strictly, hierarchical,
  arbitrarily nested

- SQL vs NoSQL
- SQL: supposed to be super simple (it isn't now), databases that can be
  queried with the SQL language. SQL defines and manipulates data
- NoSQL: document based, key-value pairs, graph DBs, no schema

### 2: Sorting, Hashing, Single-table queries

#### CS186 Lectures (2015-01-22, 2015-01-27)

- Slides and stuff:
  https://sites.google.com/site/cs186spring2015/home/schedule-and-notes

- Why sort? Data locality, eliminate duplicates, ordering results
- Fundamental: sort-merge join algorithm (rendezvous)
- Fundamental: First step in bulk loading tree indices (ordering)
- Problem: how to sort 100GB data with 1GB RAM? Can't just allocate
  100GB of virtual memory :|
- Must be intelligent about accessing data on disk

- Constraint: data stored on disk. Can only read/write; no pointer
  derefs and shit
- Stuff on magnetic disk is cheap but slow
- Focus on memory hierarchy at the level of RAM vs. disk as our order of
  magnitude
- Disk access: 2-4ms seek time, 2-4ms rotate delay, transfer fast
- Arranging pages by disk: try to put blocks on same track, followed by
  same cylinder, followed by adjacent cylinder
  - For a seq scan, you can pre-fetch stuff!
  - minimize seek/rotation delay
- SSD are faster, but uh still way slower than RAM

- Storage trends: data isn't that big! Choose wisely, you probably don't
  need something super heavy
  - All weather: 20GB, English Wikipedia: 14GB, US Census: 200GB
- Data is important :)
- Bottom line: large DBs are still around and they all use disk. Smaller
  DBs can definitely use SSD, many fit in RAM now! Change on the
  hardware storage tech side, and uncertainty on the software side - where
  to put stuff? That's the current debate

- Algo: map over records, write out result. Want to minimize RAM. Simple
  approach is to read from input buffer, write to output buffer, and
  then you can minimize how much you actually read/write which blocks in
  your algo
- Double buffering even better, uses two threads to do I/O. If main
  thread is ready for new buffer, switch! While one thread is doing
  background I/O, another is in use. Okay

- Spec of sorting and hashing
- Given:
  - File f containing r records and taking up N storage blocks
  - Two disks with >> N blocks of storage
  - Fixed amount of RAM space (== B disk blocks)
- Sort: procude output file with contents sorted according to criterion
- Hash: produce output file with contents arranged so that no 2 records
  that are equal are separated by a greater or smaller record (i.e.
  matching records always stored consecutively)

- Sorting!
- Conquer and merge :) like the second part of merge sort. Take one page
  at a time and sort on first pass, then two pages on second pass, etc.
  - nlogn
- Better: general external merge sort. Use all input buffers in your RAM
  instead of just one at a time to start off with
  - log(base of b - 1) (n/b)
  - Just do each pass in parallel with all of your available buffer
    pages
  - Most of the time, takes two passes. Can sort, like, 8 at a time
    rather than 2 at a time always. Got it
- Heapsort: use two heaps, w/e w/e
- Okay this is all very good and such

- Hashing sometimes better than sorting because we don't need order,
  just need to remove duplicates and/or form groups
- Streaming partition, use a hash function (i.e. modulo) to stream
  records to the appropriate disk partition. Divides things up
  - Each partition is N / B records large. Each partition should be no
    more than B pages in size
- Then conquer by reading each partition into RAM hash table one at a
  time. Use a second hash function here with different granularity
- Can hash large data sets by just recursing on your partitions to
  generate new partitions before doing the conquering

- I/O cost is same for hash and sort. Hash: random writes and sequential
  reads. Sort: random reads and sequential writes
- How to parallelize: just add a new hashing function to the beginning,
  higher granularity even than your partitioning function, this function
  will assign the record to a machine to be processed at
- Hard to carve up data equally! Maybe try taking a random sample at
  first to get an idea of how data is distributed

- These are just two ways of organizing data. Same memory requirement
  and same I/O cost...
- Sorting good if data needs to be sorted anyways, or if input already
  sorted (duh). Not sensitive to data skew
- Hashing eliminates duplication, scales better with # of different
  values. Sometimes one-pass! E.g. if just sorting male-female
- Hashing divide and conquer, sorting conquer and merge. Sorting
  overkill for rendezvous most of the time. K

- Single table queries. Can we just look at slides?
- Okay

#### Lecture

- Why use a connection pool? To avoid overhead of establishing
  connection

- Oz's life and death of a query
- Browser makes HTTP request
- DBMS gets SQL query over TCP at the connection manager. Pass off to
  process manager, then the meaty relational query processor
  - Parse
  - Rewrite: rewrite views, simplify algebra, etc. on the query plan
  - Optimize: use stuff like pg\_stats to make a better query plan
  - Execute: based on relational iterators. Get data, stream data,
    output, etc.

```
class iterator {
  void init(); // i.e. for sort, this pulls all of the data, sorts it to
  set up
  tuple next();
  void close();
  iterator &inputs[];
  // additional state goes here
}
```

- Anatomy of a query plan
- First row and anything following arrow is a relational operator

Hash Join (cost=4.25..8.88 rows=33 width=28) (actual time=0.189..0.275 rows = 44 loops = 1)
// Hash Join is the operator, cost is in notional units. 4.25 is the
// time the first tuple is available, 8.88 is when the last record is
// available. Actual time is an actual unit
  Hash Cond: (individual.manager = manager.id)
  Filter: (individual.salary > manager.salary)
  Rows removed by Join Filter: 56
  -> Seq Scan on employee individual
  -> Seq Scan on employee manager // ka chow

- Vacuuming updates stats so you can get a clean, context-free slate for
  analysis
- Composite indices: index on two different fields that are often
  queried together
  - A criterion for combining indices: what's the cardinality? Try to
    narrow data more first. E.g. use salary index (wider range) before
    age index

- Implement executors
- "SELECT * FROM ciadocs WHERE title = __
  - Maybe title is input to function
  - Additional iterator for *

### 3: Joins

#### CS186 Lecture (2015-01-29)

- How to implement iterators?
- INIT, then NEXT, then CLOSE. Got it
- Okay cool

#### Lecture

- Cool, got most of it from the CS186 lecture
- Three main types: nested loop (+index), hash join, sort merge
- Nested loop does work with inequality predicates (>, <, >=), the other
  two types do not

### 4: Indexes

#### CS186 Lecture (2015-02-10)

- How to implement indices?

#### Lecture

- Bit map index is translating two sets (doing a join, for example)
  into a binary representation so you can use bitwise operators to
  quickly find properties of your data

### 5: Relational Algebra

#### CS186 Lecture (2015-02-12)

- How to implement indices?

#### Lecture

- Relational: relational schemas and relational instances
- Table is a relational instance
- Worthwhile because of high analysis, ability to create primitives

### 6: Query Optimization

#### CS186 Lecture (2015-03-12, 2015-03-17)

- How to optimize queries? Let's see

### 7: Transactions and Concurrency

#### CS186 Lecture (2015-04-07, 2015-04-10)

- See slides

#### Lecture

- Transactions are in DBMS's for business reasons, e.g. debit/credit at
  the same time

- A: All or nothing steps
- C: abort on constraint (e.g. uniqueness) violation
- I: illusion of you being the only DB user
- D: after transaction commits, it'll be there forever

- Two phases of 2PL: acquiring is the first phase, releasing is the
  second phase

- *Database object*: anything the database engine operates on. Page,
  row, table, collection of tables, wawawa
- Lock manager in DBMS picks which unit of database object to acquire
  locks over

- Deadlock detection beats avoidance and stuff for practicality reasons

- Why maintain a write-ahead log? You need to write it to disk which is
  an added cost
- Cost of writing to log is cheaper - in better storage, or kept in a
  memory buffer

### 8: Distributed Databases

#### Red Book Ch 6 Intro

- In theory, serializable transactions are all you need
- In practice, DBMS's have weak, non-serializable concurrency control
  - Why?
  - It's expensive
  - Decrease throughput, increase latency, not good
  - Anywhere from threefold to order of magnitude performance penalty
  - Race to the bottom in competitive market
- Alternative: *weak isolation*
  - Can do weird "anomalies" like reading intermediate data from another
    transaction, reading aborted data, etc.
  - Obviously you want to reason about and make tradeoffs here.
    Invariants in serializable execution change around when you loosen
  - Hard to specify :/ and difficult to use
  - How is this better than "no isolation"? Seems dummy hard to reason
    about
  - In practice, few apps experience super high concurrency /shrug
  - New research is focused on trying to preserev semantics and improve
    programmability without giving up serializability

#### Dynamo paper

##### Background

- Tradeoff here: more availability, less consistency
- Specific business case for Amazon: downtime (unavailable) = lost money,
  double-purchase (inconsistent) = fine, we can resolve this
- Presumption that at Amazon's scale, there's always a node in the
  network that's down
- RDBMS has a lot of overhead with complex querying and management. Hard
  to scale, choose consistency over availability, shard
- By constrast, Dynamo is highly available, efficient, scales simply
  - Runs on own instances

- Properties
- Query model: key-value, identify everything by unique key. Can't get
  multiple items, no need for relational schema. Store < 1 MB each
  object
- From ACID: Trade less C for more A, no isolation guarantee
- Paper doesn't go much into security, that's handled by others I guess

- SLA
- Optimize for 99.9th percentile. Want _all_ customers to have a good
  time
- Dynamo: give services control over durability and consistency, let
  services make tradeoffs b/t functionality, performance,
  cost-effectiveness. Wtf this is hand-wavy and I don't get it

- Design considerations
- *When to resolve update conflicts*? Dynamo tries to be *always writeable*,
  so conflicts are resolved at read time. This is a business-application
  decision. Different from other DBMS's
- *Who does conflict resolution*, data store or application? Data store
  only has simple mechanisms, let app developer do fancier stuff because
  they know more
- *Incremental scalability*: scale out without impact on the system
- *Symmetry*: No one host is more important than others
- *Decentralization*: P2P better than having a "main" host, SPOF
- *Heterogeneity*: work distribution should be proportional to
  capabilities of each server :)

##### Related Work

- There's previous p2p work but it doesn't line up with Dynamo design
  considerations - makes other assumptions
- Same with distributed filesystems and databases
  - They use block stores, but key-value is better because objects are
    smaller and easier to configure on a per-application basis
  - Also, don't reject updates because of network partitions :)
- Basically a bunch of comparisons
- Dynamo:
  - Always writeable
  - In a trusted network
  - No need for hierarchical namespaces (flat structure) or relational
    schema. Ask pls
  - Latency sensitive!

##### System Architecture

- Core distributed systems techniques in Dynamo: *partitioning,
  replication, versioning, membership, failure handling, scaling*
- Partitioning
- Damn, annotate the PDF for the rest of this

#### Lecture

- NoSQL: trade off transactions/serializability for availability
- Again, it's all about your context :)
- Q: What about that pk access pattern?

### 9: Big Data

#### Lecture

- Google File System
  - Problem: need to store the web on commodity hardware because we're
    broke
- Large files, each containing many web pages, replicated
- Keep appending, read sequentially, k
- GFS foundation for Hadoop filesystem
- Run on many machines, make data smaller, do stuff to it
  - Map and Reduce
  - Scan all your disks, Map function emits tuple if you match something
  - Reduce to other stuff, then Map, then Reduce
- Hive next, allowed for declarative query processing, which allows for
  better attempts at optimization
  - Easier for business analysts to use than just thinking about
    MapReduce
