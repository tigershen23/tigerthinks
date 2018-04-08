---
layout: course_post
title: 'Distributed Systems'
date: 2017-03-26 00:00
categories:
tags: [course, technical, cs, bradfield]
author: Bradfield
rating: 4
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/distributed-systems/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's distributed systems class"
---

## Notes

Slides and stuff: http://people.inf.elte.hu/toth_m/osztott_rendszerek_c/

### 1 - Introduction to Distributed Systems

#### Tannenbaum 1.1 - 1.2

- More powerful microprocessors + development of high-speed LANs -> many
  machines cooperating to geet work done
- *Distributed system*: collection of independent computers that appears
  to its users as a single coherent system
  - Computers are autonomous
  - Users are dealing with one system
  - Means autonomous components need to collaborate
- Characteristics
  - Differences b/t computers + ways they communicate are hidden from
    users
  - Interaction with system from user perspective is consistent and
    uniform regardless of point of entry
  - Maintenance, single node down, etc. shouldn't be noticed by user

- Goals
- Make resources easily accessible
  - Resource: printer, computer, data, web pages, etc.
  - Stuff like e-commerce enabled by this connectivity
  - Connectivity increasing does come with security concerns :/
- Reasonably hide fact that resources are distributed across network
  (Transparency)
  - All types of transparency: access, location, migration, relocation,
    replication, concurrency, failure
  - In conclusion though, transparency is a nice goal but it needs to be
    considered alongside performance and comprehensability
  - Getting full transparency can have a high cost
- Open
  - Offer services according to standard syntax and semantics
    (protocols)
  - Describe interface via Interface Definition Language
  - Interface should be _complete_ and _neutral_: has everything
    necessary to implement interface, but doesn't push towards any
    implementation style
  - Should be extensible (add parts easily, run on diff OS or
    filesystem, etc.)
  - Separate policy (rules/implementation) from mechanism (actual thing
    being done), e.g. caching is mechanism, cache usage policy can
    differ
- Scalable
  - Size, geographical, administratively
  - Think about decentralizing services, data, and algorithms for size
    scalability :)
  - Geographic scalability related to size scalability a bit. Need to
    get around the clock/time problem :/
  - Administrative scalability: conflicting situations in all different
    domains, e.g. users installing applets. May not get all the
    permissions they need. Distributed systems need to protect
    themselves from the new domain, new domain needs to protect
    themselves from system. Hard! Need to resolve nontech problems
    (humans, orgs, bleh)
  - How to scale?
    - Hide communication latencies: try to avoid waiting for remote
      rservice requests as much as possible (do useful work on my side
      while remote request is happening). Async communication
    - Distribution: Split up component into different parts and spread
      parts across system. Hey check out DNS. Root TLDs make tree, all
      the way down the subdomains until you get where you need to go
    - Replication: copy your data. Increase availability and balance
      load. Caching is a type of replication (but decision made by
      client, not server). Leads to consistency problems though :/
- So many pitfalls!
- Bad assumptions:
  - Network is reliable
  - Network is secure
  - Network is homogeneous
  - Topology doesn't change (ASK)
  - Latency is 0
  - Bandwidth is infinite
  - Transport cost is 0
  - There is one administrator
- All of these things don't come up in nondistributed systems, hence the
  first rule of distributed systems: don't distribute your systems

#### Lecture

- Distributed system is *a collection of parts that communicate slowly
  and unreliably to do work*
- Can distribute compute or storage, compute is much more difficult to
  do
- First rule of distributed compute: don't distribute your compute
- *Open*: open for change, open for understanding, publicly
- When something is *transparent*, the client isn't doing the
  configuring (e.g. specifying exactly which port to go to)
- Communication is tough - almost all Wide-Area Network communication
  happens point to point, but in the cloud a distributed system wants to
  broadcast!

- *Cluster*: uniform, homogeneous set of nodes
- *Grid*: non-uniform, heterogeneous set of nodes. You would use maybe
your own protocol here if you understood the hardware

- Our networks are gonna be *asynchronous*: no guarantees about lockstep
  work and stuff
- Benefit of "immutable" data: you can transfer data between nodes without
  a consequence of overwriting data
  - Mutable data is not necessarily a performance increase/something you
    do if you don't care about history! Benefit of immutability is also
    that you're writing sequentially :). Can garbage collect to free
    space if you don't care about history

- Identity: how do identify data? Want to use them as pointers to
  content
  - Hard to come up with unique id's!
  - Useful to be able to order identities
  - Senior engineer question: design an ID scheme
    - 40 bits for time (ms granularity, choose your own epoch!), 14 bits
      for seq num, 10 bits for node id

- Modern regex: takes a linear time and space to match a string

### 2 - Communication Models and Patterns

#### Tannenbaum 4.1 - 4.4

- *Interprocess communication is at the heart of all distributed
  systems*
- *Multicasting*: general problem of sending data to multiple receivers
- Want more context on background behind RPC
- See slides

#### Lecture

- Even with TCP (reliable transport), you don't have reliable
  application transport!
- *Framing*: you need to wrap a message such that the receiver knows
  when the message is over

- Messaging patterns
- Request/Response
  - Uses background processes as an internal application-level queue for
    messages. Helps with application-level reliability
  - Server replies to the client (conversation)
- Push/Pull
  - Contract: client creates data, drops it on a predetermined sharing
    socket for the server. Client does not actually expect a response
    from the server. Shouting in one direction, not a conversation
- Pub/Sub
  - Pretty much push/pull, but not one to one
  - Binding is what creates the socket in the first place, _generally_
    that's the publisher. Nodes that _connect_ later on are generally
    subscribers?
- You can describe all of your network communication in a system with
  these three primitives :) don't get fancier

- Making a chat protocol
- Naively: each client needs 3 sockets
  - One for fetching archive cmsgs (REQUEST)
  - One for sending cmsgs (PUSH)
  - One for subscribing to new cmsgs (SUB)
- Server:
  - Archive (REPLY)
  - ADD MSG (PULL)
  - SEND MSG (PUB)
- How to multiplex these onto one socket?

### 3 - Consensus: Paxos and Raft

#### Video: Introduction to Raft

##### Leader Election Demo

- One leader, elected to begin with, everyone else is a follower
- Followers wait for heartbeats from leader, if they don't receive
  within a certain amount of time they time out
  - At most 1 leader per turn
- Every message includes a term number. If you get one ahead of your
  current term, you advance
- To become a leader, you first vote for yourself in an election, then
  send out "request vote" RPCs to get votes from other servers
  - If you get a majority you're the leader for that turn
- What if you get split votes?
  - Two candidates each get half of votes :/
  - Just wait an extra timeout :)
    - Timeouts are all randomized (like Ethernet, gg)

##### Log Replication Demo

- RPC is "append entry" to catch up to log
  - After caught up to log, RPC is "heartbeat"
- Must commit to majority of servers in order to present uniform
  interface to client

- How to repair inconsistencies?
- Missing entries: fill in the missing entries if you get an
  append-entry with an index too far ahead. Back up until you match
- Extraneous entries: blindly overwrite if you hear from a later-on
  leader

##### Safety

- Request for votes includes candidate's last log entry. Don't grant any
  votes to people with worse logs than you (earlier term, or shorter)

#### Lecture

- Configuration for Raft:
  - Addresses
  - Snapshot of log
  - State machine
- Node state:
  - Log (array of pairs of [term, data])
- Out of scope: each node figuring out who else is in the cluster
- RPC's can all happen over ZeroMQ req/rep sockets
- *Non-Byzantine* conditions: all nodes are operating under the same
  policy
- Term acts as vector clock
- A term is the length of time of one leadership
- Each message has unique ID so that you know not to double-play retried
  request to two different leaders

### 4 - Naming and name services

#### Tannenbaum 5.1 - 5.3

- See slides in 04_naming

#### Lecture

- **The entity is the identity**
- Naming anti-patterns:
  - There is a place for random names/identities - it is better to give
    something a seemingly nonsensical name (esp. if it plays multiple
    roles) than misname it
  - False hierarchies where you don't need them. As soon as you come up
    with categories you come up with exceptions :/
- Gg

### 5 - Synchronization, time, and logical clocks

#### Tannenbaum 6.1 - 6.2

- See slides in 05_synchronization
- We asking about vector clocks out of order then I guess

#### Lecture

- NTP synchronizes real time (universally)
  - Predicated on belief that there is real time

- You also have a quartz crystal thingy not related to your CPU clock
  rate, used to time things locally

- Realtime operating systems: can run a function every 50ms, _on the
  dot_

- Causal ordering only matters for multiple machines! Event A fires at 451
  on node X, event B fires at 452 on node Y, depending on event A

- Vector clocks: each node keeps a map of nodes => vector clocks. When
  you get an update you update your own vector clock state. Whenever you
  synchronize with someone else, you send along your vector clock

### 6 - Replication and Fault Tolerance in Depth

#### Tannenbaum 7.1 - 7.3 (p273-p295)

- See slides

#### Tannenbaum 8.5 - 8.6 (p355-p373)

- No more slides RIP
- Hmm okay good stuff

#### Lecture

- *Availability*: high availability is all your requests getting good
  latency and succeeding; low availablility is failed requests, slow
  requests. Nothing to do with uptime! Think of a human being -
  responsiveness
  - What kind of bank would you want? High availability!
  - Alias to responsiveness
- *Reliability*: how often a system is up. Can have a highly available
  system (10ms response times) that is not reliable (goes down every 20
  minutes)
  - Maps to people: reliable person can only do something once a day,
    but they always do it. Bitcoin doesn't have this kind of guarantee
  - Contract isn't broken
- *Safety*: if a failure occurs, you can't take the next action. When
  one of the components crashes, you're not in a dangerous/corrupt state
  - i.e. in a bungee jumping system, if the failsafes are red, you can't
    step out onto the plank
  - Unsafe but reliable: there are bugs that can lead to bad stuff, but
    they still do the job
  - Safe: never allows you to enter a bad state
- *Consistency*: extent to which nodes agree on state, high consistency
  means you get the same thing when you ask over and over
- *Coherency*: data that doesn't make sense according to user-imposed
  constraints
  - e.g. you add a foreign key constraint but you do a table scan and
    see that it's violated
  - If a data store violates an application-level constraint, it can
    still be considered safe but it is incoherent
  - Related:
    - Adherent: believe something despite evidence (not part of one's
      nature). Glue is adhesive
    - Inherent: built-in (humans have two legs)
    - Coherent: two things fit together. Cohesive is working together
      (Lego)

- *Monotonic reads*: client never gets data older than what it has
  already received. Can always trust data you received later more tahn
  data you received earlier
- *Monotonic writes*: guarantee that writes occur in the order that the
  specific client sent them
- *Read your writes*: you always get what you wrote or something later
  when you write data

- One phase commit: node who services write just commits data locally
- Two phase commit: node who services write first sends new data to
  others and waits for acknowledgement of data before doing a hard
  commit. Don't write until you're satisfied that enough nodes have
  received the data

### 7 - Peer-to-peer systems

#### Tannenbaum 5.2.3

- Got slides from before

#### Chord: A Scalable Peer-to-peer Lookup Service for Internet Applications

- See PDF
- Look more into the SHA-1 collision thing
-

#### Lecture

- Problem with naive modulo hashing algorithm?
  - Have to re-hash everything if you add/delete a node
- Still don't get Chord, RIP

### 8 - Distributed file systems

#### Tannenbaum 11.1 - 11.4 (p491 - 513)

- Goal: allow multiple processes to share data over long periods of time
  in a secure and reliable way

- Client-server is most basic
- NFS (Network File System) by Sun is widely used
  - Each NFS server provides standardized view of FS, regardless of its
    internal storage
- *Remote file service* model:
  - Client has interface similar to its local file system, server
    responsible for implementing that interface
- *Upload/download* model:
  - Client accesses locally after downloading from server. E.g. FTP
- Ayyah, see slides
- Okay

#### Lecture

- Don't distribute your files fam
  - Instead of using files, can we just use flat key-value binary blobs?
    Any kind of smaller set of records?
- Only reason to distribute filesystem is that all programs already talk
  the filesystem API
- The filesystem is made up of *inodes and blocks*
  - Blocks are an address and associated byte data (file and directory
    contents)
- /tmp is all in-memory :)

- Distributed filesystems are a bad idea because they break implicit
  contracts by processes expecting certain performance, reliability,
  etc. characteristics of file accesses
- This changes with NFS v4, which makes you declare explicitly that
  you know you're using a distributed file system

- NFS, GFS is client-server model
- DropBox is download-upload model
  - Userland process monitors folder, listens to filesystem events from
    kernel, and uploads files to server on file changes
- Git is da best distributed file system
  - Everything is explicit: fetch, push, log, etc

- Merkle tree sync
- Node B wants content from node A, identified with a content hash
- Content hash isn't for entire file, it's for individual block or group
  of blocks
- This allows you to verify content hash on parts of data without
  downloading the entire file
- So B asks for block 0 using the content hash of the entire file, A
  sends block 0 _along with the entire Merkle tree so B can verify that
  the contents were correct_
  - Optimization: B may already have some hashes because it got and
    verified other data blocks, it can send those to A as well so A
    knows the state
- How to represent tree?
- Use flat in-order tree, which is binary addressable
  - How sway
  - # of trailing 1s in binary representation of indices is the depth of
    that node in the tree
- Missing a piece about signing the root of the Merkle tree

### 9 - Revision

#### Lecture

- Implied stuff in what we've studied: secure network, trusted nodes
  - In the Internet this isn't the case!
  - Intra-distributed systems: Cassandra/Riak/etc.d/Kafka
    - With ZMQ: super naive! Bare minimum
      - Why doesn't this work over the Internet? i.e what we did for our
        chat app
      - Doesn't scale with TCP sockets; we needed 3! Should try and use one
        per connection
      - Not designed for performance/reliability
  - Inter-distributed systems: dat, bittorrent, bitcoin, DNS. Require
    encryption/security
    - Use gRPC
  - Make this distinction clearly when you're dealing with distributed
    systems
- *Encryption is not about security, it's about verifying that the
  content hasn't been messed with in the middle (authenticity)*
- Important concepts for designing Internet application:
  - Where are keys?
  - What is signed?
  - How is signature checked
- Tor architecture:
  - All Tor nodes on a single graph
  - You want Silk Road? Distribute any single node's DNS request across
    multiple nodes
- ZeroMQ dealer/router stuff
  - Multiple clients, multiple servers - proxy in the middle sends xREQ
    and returns xREP to the client, and clients connect directly to the
    proxy
- Dealer/router: dealer on every node
  - Delivering message to dealer socket: it will go to all other dealers
  - Take TCP, add message framing, don't do anything else
  - Write to dealer, can send random stuff
- Router does what? Dealer connects to it, so it prefixes an identity to
  the message
  - First up, Dealer "greets" router
