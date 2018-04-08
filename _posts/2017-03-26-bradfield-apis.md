---
layout: course_post
title: 'Program Interfaces, Patterns, and Anti-Patterns'
date: 2017-03-26 00:00
categories:
tags: [course, technical, programming, bradfield]
author: Bradfield
rating: 4
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/apis/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's APIs class"
---

## Notes

### 1 - Binary Formats for Integers and Characters

#### Binary Coded Decimal Wiki Page

- Class of binary encodings of decimal numbers where each decimal digit
  is represented by a byte
- Main virtue: more accurate representation and rounding of decimal
  quantities
  - Also ease of conversion into human-readable representations
- *Natural BCD* is 8421 in one nybble, encoding 0-9
  - *Unpacked*: each numeral is encoded into one byte, with padding
  - *Packed*: two numerals in each byte, with one in least sig nybble
    and other in most significant nybble
- Sum is easy; just binary addition first, then add 6 to the sum when
  the five-bit result has a value greater than 9. Whew
- Subtraction a smidge more difficult: use signed BCD to represent
  negative ten's complement of the subtrahend, and then add that to the
  first number to get the difference. Whew
- Vs. pure binary
  - Decimals have finite place value (e.g. 0.2 -> 0.0010)
  - Scaling by factor of 10 is simpler (just add empty nybbles)
  - Slower than binary
  - Smidge more space than binary (~ 20%)
  - Adding and stuff is more complicated, as you can see

#### Binary: Plusses and Minuses (Why We Use Two's Complement)

- How to represent negative numbers?
- Universally, leftmost bit is sign. 0 is positive, 1 is negative
- *Sign and magnitude* NO, since the sign bit isn't really part of the
  number, so you can't do natural addition/subtraction
- *One's complement*: flip all the bits to get negative representation
  - Bleh, two representations of 0 :/
  - Treat the sign bit as normal, if you get a final carry bit, bring it
    all the way back over to the right and do an add again
- *Two's complement*: do one's complement and add 1
  - If the carry into the sign bit is definitely different from teh
    carry out, then you have an overflow!

#### A History of Character Encodings

- Computers use binary character codes as "shadow representations" of
  graphical characters that it outputs to screen. Allows for efficiency
  and stuff
- Start: Morse code. Pretty efficient, uses shortest dots and dashes for
  most frequently used characters ("e", "t"), still in use today
- Baudot used 5-bit encoding (5 bits b/c of hardware constraints) with
  switching b/t two planes of characters. Gave him 64 chars to work
  with, okay okay
- For 1890 Census and stuff, Hollerith develops a punched card code. 12
  rows of punched card, but only 69 valid characters. Extra spaces are
  for ease of use (fewer punches needed on average to differentiate
  characters)
- 1963: American Standards Association announces ASCII, which has 32
  control characters and 96 printing characters, cool
  - Adopted by all main U.S. computer manufacturers except IBM
  - IBM makes EBCDIC, which is proprietary. Super yucky, 57 different
    standards (!) so international exchange is a nightmare, overall this
    sucks
  - Overall, you come out of the other side with ASCII-based OS's with
    OS-specific extensions for European languages and whatnot
- Lots of different standards and stuff for Korean/Chinese/Japanese
  encodings
- Xerox starts Unicode
- Unicode has been criticized as being little more than an exercise in
  cultural imperialism on the part of western computer manufacturers,
  the biggest problems with Unicode are in fact technical ones, which
  can be listed as follows:

  1) There is no information to identify the language being used, which
  affects sorting, etc.
  2) User defined characters, which cause problems in data transmission,
  are allowed
  3) There is no room for further expansion using two-byte (16-bit)
  codes
  4) There is an excess of similar characters
  5) Some characters are created through composition, which destroys the
  fixed-length scheme
  6) Conversion to/from Unicode is not simple for users of Chinese,
  Japanese, and Korean
- Sigh. Designed to avoid using escape sequences, use a maximum of 16
  bits (2 bytes)
- Man, all kinds of wild stuff going on. This is from 1999. Unicode
  still in use today I guess

#### R@ Remembering the Origin of UTF-8

- http://doc.cat-v.org/bell_labs/utf-8_history
- Rob Pike da god
- IBM proposed a FSS/UTF format, asked Ken/Rob to look over it. They
  thought they could do better, so they went to dinner, outlined it on a
  placemat, implemented it, and ran with it.
- Dam son

  We define 7 byte types:
  T0  0xxxxxxx    7 free bits
  Tx  10xxxxxx    6 free bits
  T1  110xxxxx    5 free bits
  T2  1110xxxx    4 free bits
  T3  11110xxx    3 free bits
  T4  111110xx    2 free bits
  T5  111111xx    2 free bits

  Encoding is as follows.
  >From hex   Thru hex    Sequence        Bits
  00000000    0000007f    T0          7
  00000080    000007FF    T1 Tx           11
  00000800    0000FFFF    T2 Tx Tx        16
  00010000    001FFFFF    T3 Tx Tx Tx     21
  00200000    03FFFFFF    T4 Tx Tx Tx Tx      26
  04000000    FFFFFFFF    T5 Tx Tx Tx Tx Tx   32

#### Characters, Symbols, and the Unicode Miracle

- Knock off the leftmost two bits to get to alphabet index in ASCII
  (since A starts at 65...)
- Uh oh, this is bad because too small of a set, we start sending all
  kinds of crazy stuff over the web and we get screwed
- Unicode Consortium has 100,000 characters mapped!
- Set up UTF-8
  - Problem 1: tons of blank space for the most common characters if you
    just use 4 bytes!
  - Problem 2: Old computers interpret null bytes as end of stream! Can't have null
    bytes
  - Problem 3: Must be backwards compatible with ASCII
- Nice hack :)

#### Lecture

- Types of interface
- *Format*: how the data between two programs looks
- *Call*: conventions. Place-based, rules about where to get data and
  such
- *Protocol*: combination of agreed-upon format and agreed-upon calling
  convention. When you introduce stuff like sequencing, you get a
  protocol

- Gottlob Frege introduced:
  - Take 1 + 2
  - *Sign*: the + symbol is the sign of the plus
  - *Sense*: the operation you associate with the + symbol, which is
    addition for us
  - *Reference*: the concrete representation of the sense - 32 vs 64
    bit, signed vs unsigned, etc.

- Get the story straight about IBM and EBCDIC. Assumption is that IBM
  wanted to achieve vendor lock-in
  - But no, they were actually using those light things that look like
    8's and can have lights light up to represent numeric values
  - Constraints of the user interface device (the output channel)
    _always_ bubbles down to the program implementation (if it doesn't,
    your implementation sucks)
  - If you do what you say you're gonna do, faster and better than
    others, you win the market. Sometimes this requires cutting through
    layers of abstraction
- Now you have BCD, next you add IC (Interchange Code). Needs to include
  letters. Adds two more bits to each value (6 bits total)
  - This is optimized for the actual paper punch card interface, with 12
    holes
  - Then add the E, which adds two more bits (for stuff like
    punctuation). Now 8 bits. Now people are mad at IBM for breaking
    standard

- UTF-16 issues
  - Possibility of corrupt byte streams through combo of breaking in the
    middle of a byte + custom shift-based encodings on Japanese
    computers
  - Fixed by UTF-8, duh!

### 2 - Indirect Access vs. Direct Access

- High level interface or low level interface?

#### Stallman: My Lisp Experiences and the Development of GNU EMACS

- https://www.gnu.org/gnu/rms-lisp.en.html
- Welp, I guess Stallman wrote EMACS
- Dah dee dah, story time
- Initially, EMACS was written in some crappy other low level language
- But people wanted something with Lisp inside it that could be extended
  by rewriting or writing new Lisp
- So he rewrote Emacs in C from TECO; with a few Lisp things, but mostly
  C
- Gradually got to re-implementing in all Lisp primitives
- Built a Lisp machine for Lisp primitives I guess, at the AI Lab
  - This is what Myles is talking about re: AI & Lisp
- Meh, lab goes to dump and there's rudeness and such, Stallman tries to
  keep Lisp Machines in business
- Because of GNU having Lisp implementations for userland programs,
  Stallman was led to write GNU Emacs. Okay

  **The crucial thing is that you are free to run the program, free to
  study what it does, free to change it to suit your needs, free to
  redistribute the copies of others and free to publish improved,
  extended versions. This is what free software means. If you are using
  a non-free program, you have lost crucial freedom, so don't ever do
  that.**

- HAVING EXTENSIBILITY IS GOOD
> There's an interesting benefit you can get from using such a powerful
> language as a version of Lisp as your primary extensibility language.
> You can implement other languages by translating them into your primary
> language. If your primary language is TCL, you can't very easily
> implement Lisp by translating it into TCL. But if your primary language
> is Lisp, it's not that hard to implement other things by translating
> them. Our idea was that if each extensible application supported Scheme,
> you could write an implementation of TCL or Python or Perl in Scheme
> that translates that program into Scheme. Then you could load that into
> any application and customize it in your favorite language and it would
> work with other customizations as well.
>
> As long as the extensibility languages are weak, the users have to use
> only the language you provided them. Which means that people who love
> any given language have to compete for the choice of the developers of
> applications — saying “Please, application developer, put my language
> into your application, not his language.” Then the users get no choices
> at all — whichever application they're using comes with one language and
> they're stuck with [that language].

#### Microcode Wikipedia page

- https://en.wikipedia.org/wiki/Microcode
- **A technique that imposes an interpreter between the hardware and the
  architectural level of a computer**
- Used in CPUs; the hardware instructions that implement the
  assembly/machine code instructions
- Lower-level than application programs :) differentiated with *micro*
  prefix (microinstruction, microassembler, etc.)
- Example horizontal microinstruction (executed in one cycle)
    Connect register 1 to the A side of the ALU
    Connect register 7 to the B side of the ALU
    Set the ALU to perform two's-complement addition
    Set the ALU's carry input to zero
    Store the result value in register 8
    Update the condition codes from the ALU status flags (negative, zero,
    overflow, and carry)
    Microjump to microPC nnn for the next microinstruction
- Must be super optimized!
- Microcode simplifies fetch/decode/execute cycle by allowing processor
  behavior to be defined with microprogram routines instead of dedicated
  circuitry. Can change the microcode without changing actual hardwire
  design, woohoo!!
- **Microprograms operate on a more primitive, totally different, and
  much more hardware-oriented architecture than the assembly
  instructions visible to normal programmers**
- Each microinstruction in a microprogram provides the bits that control
  the functional elements that internally compose a CPU.
- Compared to RISC? Many RISC and VLIW processors are designed to
  execute every instruction (as long as it is in the cache) in a single
  cycle. This is very similar to the way CPUs with microcode execute one
  microinstruction per cycle.
- Not really sure, but okay

#### Lecture

- Abstraction vs. Indirection
  - Example: pedestrians currently have access to the other side of the
    road (contract), but when you go to self-driving cars you may have
    to introduce a constraint that pedestrians can't cross to the other
    side
  - Indirection is any time you deny direct access, mediate the access
    through an interface. E.g. bridge over road vs. crosswalk is an
    indirection but not an abstraction
  - Abstraction allows you to think at a higher level than before
- Lisp interpreter -> Lisp ASM -> microcode
  - Abstraction! Indirect access to microcode; most people only write
    stuff in Lisp ASM, only a select few contribute to the
    implementations of the List ASM targeting specific microcodes
- BSD vs. Linux
  - Linus just wrote the Linux kernel, which he intended to combine with
    GNU tools to make a functioning operating system
  - BSD did it differently - encapsulates everything
  - Write a C program for Linux? Target a kernel version, and C version,
    and all kinds of other package versions
  - Write a C program for BSD - just target a BSD version
- React vs jQuery
  - React is an abstraction (you're not even talking to the browser
    directly), jQuery is indirection (allows you to talk to browser
    differently)

### 3 - The System Call, the Function Call, and the Method Call

#### The Definitive Guide to Linux System Calls

- This'll be a bit of revision from operating systems
- More of a reference than an actual thingy

#### The FreeBSD developer's handbook, x86 syscall section (short)

- Same

#### The History of Calling Conventions

- Ayyah

#### Let's Build objc_msgSend

- Code tutorial, notes are rough, just read
- In general, any small piece of code that serves to redirect code
  somewhere else can be called a trampoline.

#### Lecture

- Problems with Assembly?
  - Want a way to address lines of code: labels!
  - This is the beginning of subroutines
  - Add jump, JAL, RET
  - What differentiates subroutine from function? Subroutines cannot be
    nested, also don't have formal parameters/state
- To implement a function call:
  - Store return address
  - Store registers that function will clobber
  - Store args (or at least agree on location)
  - Where to get return values
- Function is stack space and lexical scope for a subroutine
- Method: expands on function by having an instance environment.
  Invisible argument is self
  - Fucking yucky, need to go up the inheritance tree to find the method
- Lambda: does not need an entry on the symbol table
  - Also implements a closure, gg
  - Has reference to the lexical scope under which it was invoked, as
    well as its own stack frame
- Fork/exec/syscall is pretty much review

### 4 - Command (Line) Interfaces

#### AOSA Book - The Bourne-Again Shell

- http://aosabook.org/en/bash.html
- Okay okay
- Input -> Lex/Parse -> Expand (braces, tilde, substitution, word
  splitting, filename generation) -> Execute -> Exit status

###### Syntactic Units

- Tokens:
  - *Reserved words* like if and while
  - *Operators* like +, -, etc.
  - Everything else is just normal *words*
- Dollar sign introduces a parameter or variable, yep
- Support for arrays, integers, and strings
- Hash table for storing and retrieving variables, linked lists of these
  hash tables to implement variable scoping
  - Different scopes for each function call, etc
- All built on top of primitive data structures - arrays, trees,
  singly-linked, doubly-linked lists

###### Input Processing

- *Readline* library to provide functions allowing users to edit command
  lines, functions to save command lines as they are entered, recall
  previous commands, expand history, etc.
- This is for interactive input processing. For noninteractive input,
  uses buffered input routines

###### Parsing

- Bash needs to be lexed and parsed just like any other language
- Parser returns a command struct to the word expander

###### Word Expansion

- Not much to see here
- Implemented using a small pipeline: each stage takes a word, and,
  after potentially transforming it, passes it along
- Uses the same word data structure as the rest of the system

###### Command Execution

- Yeah, skimmed :/

###### Lessons Learned

- Important to have *change logs*!
- Regression testing if appropriate
- Standards, documentation often ignored by developers but are very
  important
- Okay

#### PowerShell Wikipedia page

- Administrative tasks performed by *cmdlets* which implement a specific
  operation. Can be combined into scripts
  - *Providers* make the file system/registry available to cmdlets
- Works with Windows OS
- Core grammar based on POSIX /shrug
- Yeah yeah yeah some history cool
- Similar command line interface to bash, where parameters are
  translated from arguments by PowerShell and passed to the cmdlet
- Always processes objects individually (doesn't work on collections)
- Each cmdlet implements Begin(), Process(), End()...
- Differences in pipelining from Bash: all happens in same process, and
  passes .NET objects rather than byte streams

#### Lecture

- PowerShell passes around _structured data_, Bash passes around text
- The shell exists to interface with the operating system
- OS startup: kernel -> initd/launchd -> bash (connected to teletype
  terminal or tty)

###### Myles walking through bash execution

- Lex into words
- Parse into AST
- Expand words
- Execute
  - Look for pipe chars
  - If no job:
    - Resolve command (aliases, etc.)

### 5 - Interprocess Communiation (IPC)

#### Pipes: A Brief Introduction

- Pipes transfer standard output of a process to another destination
- Can create a pipeline of commands
- Made *modularity* possible as part of Unix philosophy
- Buh I know all dis

#### BSD Sockets: A Quick And Dirty Primer

- *Socket* is the method for accomplishing IPC. Allows processes to
  speak to one another. *Analogy is a telephone*
- *UNIX sockets* use UNIX pathnames to identify sockets, used for same
  machine
- *INET sockets* use an IP address, include a port, used for remote
  accesses
- *bind* binds socket to an address on which to receive calls
- *listen* to set max # of requests to buffer
- *accept* to finally start getting data on the socket
- Usually fork off jobs to handle each new connection that gets accepted
- *connect* to a socket to start dropping data onto it
  - Calls particular port number on particular host. Returns socket
    through which data can flow
- Now you can talk via read() and write()
- close() to hang up the call

#### ZeroMQ Guide: Socket Stuff

- Socket-like API doesn't come for free!
- Bind in one node, connect in others. _Generally_ (not always), the
  server binds and clients connect. Bind to a well-known address,
  connect to arbitrary network addresses
- Differences with TCP sockets:
  - zmq sockets carry messages not a stream of bytes
  - i/o in background thread, messages always sent and received locally
    no matter what application is doing (?)
  - one-to-N routing is built-in
- Dealer/Broker used for n-n connections and such
>>> The built-in core ZeroMQ patterns are:
    Request-reply, which connects a set of clients to a set of services.
    This is a remote procedure call and task distribution pattern.
    Pub-sub, which connects a set of publishers to a set of subscribers.
    This is a data distribution pattern.  Pipeline, which connects nodes
    in a fan-out/fan-in pattern that can have multiple steps and loops.
    This is a parallel task distribution and collection pattern.
    Exclusive pair, which connects two sockets exclusively. This is a
    pattern for connecting two threads in a process, not to be confused
    with "normal" pairs of sockets.

#### Lecture

- Pipes for one process to one process, socket for multiple

- Advantage of multi-process architecture is that if a component
  crashes, the whole process doesn't go down
  - Single process can still load fast because of how OS lazily pages
  - Better reliability, but it's very annoying

- *Zombie* process: got killed, but parent didn't call wait() in its
  SIGCHILD handler, so it stays as an entry in the process table but is
  unreachable

- Pipes don't touch the file system!

### 6 - "Human Readable" (i.e. Text Based) Interchange and Archival Formats

#### The Rule of Least Power

- **Choose the least powerful language suitable for a given purpose**,
  where language doesn't necessarily a programming language (English,
  diagrams, etc.)
- Principle: **Powerful languages inhibit information reuse**
- What is Turing complete? Can compute anything a computer can compute
  - Give you memory and jumping
  - Tradeoff: hard to tell what it'll do without actually running it
- Less powerful = easy to secure, easy to analyze
- Practice for the Internet: *Use the least powerful language suitable
  for expressing information, constraints or programs on the World Wide
  Web*
- Still needs to solve your problem!
- HTML/CSS is least power, Java applet is more powerful

#### My history of the (Internet) Robustness Principle

- Robustness Principle: **Be liberal in what you accept, and
  conservative in what you send**
- Applies to life!
- Getting looser as time goes on :/ early formulation was
  "Implementation must be conservative in its sending behavior, and
  liberal in its receiving behavior", latest is "Be strict when
  sending and tolerant when receiving"
- aka Postel's Principle

#### EDN Format

- Extensible Data Notation

#### Lecture

- Why use text based formats?
- Pros
  - Human readability (terminals, text editors, anything that can read
    UTF-8)
  - Open for extensibility
  - Platform independence (don't need to worry about stuff like
    endianness)
- Cons
  - Space
  - Time to parse

- Postel Principle in action:
- HTTP takes \r\n or just \n as line break
- HTML has super optional stuff, ew

- Rule of Least Power
- It was an inevitability that JavaScript would subsume HTML and CSS
  because it was the only general purpose language of the three related
  to the web
- Web succeeds because it is _open_, in spite of all of its design
  failures
- Rule of Least Power failed?

### 7 - Binary Interchange and Archival Formats

#### ProtoBufs
https://developers.google.com/protocol-buffers/docs/encoding

- A language-neutral, platform-neutral, extensible way of serializing
  structured data for use in communications protocols, data storage, and
  more
  - XML, but smaller, faster, and simpler
- Define in `.proto` files, run compiler, you get generated source code
  for interacting
- vs. XML:
  - Simpler
  - Order of magnitude smaller
  - Order of magnitude faster
  - Less ambiguity
  - Easier to use programmatically/semantically
- Protobufs introduced at Google for request/response without needing to
  have ugly versioning code :)
  - Introduce new fields easily
  - Self-describing formats that can be used in multiple languages

###### Encoding

- Use varints to encode integers - okay, zzz, I can get this
- Protobuf message is a series of key-value pairs; binary version
  just uses field numbers as keys, concats keys and values into a
  byte stream
- For backwards compatibility, encode key with a _wire type_ indicating
  how long the following value is. This allows you to add new fields
  without breaking existing parsers
- Boring stuff for how each field type is encoded
- Better to serialize fields in order

#### Redis Protocol
https://redis.io/topics/protocol

- RESP: REdis Serialization Protocol
- Balance these things:
  - Simple to implement
  - Fast to parse
  - Human readable
- For client-server communication (client sends array of strings
  representing command arguments, server responds with command-specific
  data type)
- First byte indicates the datatype
- Okay and there's a bunch of different types
- Kind of a balance between binary and text protocol?

#### Fressian
https://www.youtube.com/watch?v=JArZqMqsaB0

- Takes ideas from Hessian/EDN
- Datomic distributed database on Clojure...?
- _Not serialization_
  - Data structures/objects drive decisionmaking
  -
- Use *data encoding* instead
  - Encoding drives decisionmaking
  - In 6 years you'll just have your data
  - No objects
  - No identity
  - Consumers don't need to understand everything!
- EDN is like Fressian
  - Language neutral (even though it's made for Clojure, it's important
    to be able to read data in 10 years with different language)
  - Self-describing
  - Immutable values
  - Namespaces
  - Extensible
  - Composable
  - Batteries-included
    - Enough stuff in the format to get rolling without wondering about
      ints being in the encoding and stuff
- Why EDN _and_ Fressian? *Performance*
  - Fressian is aware of primitives in language
  - Domain-specific compression in Fressian

- Design-time
- *Sufficiency, then efficiency*
  - Requirement is language neutrality; helps you avoid
    language-specific serialization
  - Requirement is rich types; helps you avoid extra-message convention
    (everyone does custom JSON)
  - Extensibility: helps you avoid arbitrary extension points, that
    no one can understand
  - Self-describing; helps you avoid contextual description (e.g.
    language-specific)

- Efficiency tricks
  - Primitive and array support
  - Byte code language: the encoding is a bytecode
  - Packed encoding (e.g type and data encoded together - ints 0-63
    encode themselves)
  - Chunked encoding (can stream in parsing)
  - Domain-aware caching
    - In the bytecode stream you can have a cached value indicated by
      something
    - Writer chooses what to cache (super dynamic!)
    - Cached items represented once in full, then all following
      representations are by alias/code
    - Beats generic compression by a bunch
    - Entirely transparent to readers
- Tagged stuff like EDN, can be ignored by intermediaries
- More clojure-specific stuff

- Language-neutral is the most important! Don't make Clojure a private
  island

#### BitMap image file

- The BMP file format, also known as bitmap image file or device
  independent bitmap (DIB) file format or simply a bitmap, is a raster
  graphics image file format used to store bitmap digital images,
  independently of the display device (such as a graphics adapter),
  especially on Microsoft Windows[1] and OS/2[2] operating systems.

  The BMP file format is capable of storing two-dimensional digital
  images both monochrome and color, in various color depths, and
  optionally with data compression, alpha channels, and color profiles.
  The Windows Metafile (WMF) specification covers the BMP file
  format.[3] Among others wingdi.h defines BMP constants and structures.
- See image in 07_binary_formats

#### Lecture

- RESP is a good choice for the most basic host-to-host communication,
  where you don't want to pull in any dependencies and such
- Schema === non-self-describing (JSON is self-describing, schemaless)
- Diff between text and binary:
  - num = buffer.read32LE(8) is constant time (movement)
  - num = parseInt("1234567") is linear time (computation)
- In-memory format concerns:
  - Alignment
  - Padding
  - These things don't matter as much over the wire; this
    alignment/padding allows you to do constant time lookups
- *Packing* is putting values next to each other (without identifiers),
  differing from compression because compression looks for patterns in
  the values from themselves as well
- Protobuf: you need a schema
- How do you know which object type is in protobuf
- Myles thinks out-of-band schemas are always a disadvantage because of
  the unnecessary overhead

- Fressian is a bytecode format
  - Very complicated but still half the size of JSON parser
- *Binary safe* format can have arbitrary binary in it without
  transformations and parse successfully

### 8 - Distributed systems: remote call interfaces, formats, and protocols

#### HATEOAS
http://restfulapi.net/hateoas/

- **Hypermedia as the Engine of Application State**
- Sets apart REST from other network application architectures
- *Hypermedia*: any content that contains links to other forms of media
- Add links in JSON responses so client can dynamically navigate to
  another resource :)
  - I.e. Response includes { "link": { "href": "10/employees" } }; thus,
    the hypermedia returned from the server drives the application's
    state
```
{
    "departmentId": 10,
    "departmentName": "Administration",
    "locationId": 1700,
    "managerId": 200,
    "links": [
        {
            "href": "10/employees",
            "rel": "employees",
            "type" : "GET"
        }
    ]
}
```
- If HATEOAS is implemented the REST client requests an initial URI,
  then the server provides links to dynamically discover the rest of the
  stuff. This means **clients no longer have to hard code the URI
  structures for different resources**
- Okay

#### gRPC (Google RPC)
http://www.grpc.io/docs/guides/index.html

- gRPC lets client applications directly call methods on server
  applications on different machines as if they were local objects
- Client/server stubs just like normal RPCs
- Uses protobufs
- Okay

#### GraphQL Fields
http://graphql.org/learn/queries/#fields

- You query a GraphQL server by specifying fields on objects
- Req:
```
{
  hero {
    name
    # Queries can have comments!
    friends {
      name
    }
  }
}
```
- Resp:
```
{
  "data": {
    "hero": {
      "name": "R2-D2",
      "friends": [
        {
          "name": "Luke Skywalker"
        },
        {
          "name": "Han Solo"
        },
        {
          "name": "Leia Organa"
        }
      ]
    }
  }
}
```
- So on and so forth :)
- Okay

#### Lecture

- Networking gives you the ability to make phone calls, you have to
  build application level protocols above that
  - TCP illusion is sequential passing of messages back and forth
  - *Connection*: link between two hosts that they can pass data back
    and forth on
  - *Packet*: message sized by some link or network layer constraint
  - *Fragment*: zzz, break up a piece of data into smaller sizes so that
    you can be more granular with requests (e.g. YouTube videos)
  - *Stream*: sequence of bytes made available over time (conveyor belt
    one at a time, not large batches)
- High level concepts:
  - *Service*: something that interacts with a network
  - *Endpoint*: the thing you're targeting; could be URL, IP address,
    port. When you add a feature to a service, you are adding an
    endpoint
  - *Message*: single unit of communication between two nodes
- Application level concepts:
  - *Idempotency*: more than just "no side effects". It should produce
    the same output state regardless of how many times you perform an
    operation
    - POST isn't idempotent :*(
    - PUT is idempotent because applying the same update over and over
      should produce the same state
      - Client should generate ID for creating a record so that it can
        generate a message that can safely be retried
    - Ensure consistency with client applications
  - *Transactions*: two things need to happen together or not at all
  - *Sagas*: transactions are above the level of the technology, but
    sometimes rollback involves a physical side effect out of the time
    band where you need to respond to the user. In this case you use a
    saga
    - Example: 50k tickets available, will hvae demand for 100k, but
      payment processor can only process one payment per second
      - So when user makes purchase, issue "optimistic" ticket to the
        user but on the backend the transaction is still in a queue
      - Payment fails -> write a record saying "this ticket ID has an
        associated payment failure". Ticket only valid if you have an
        associated successful payment
      - Payment succeeds -> you good

- Metaphors
- Calling *Procedures*
  - RPCs
  - Around since 1950s
  - Get a bad rap because they sucked at first
  - Can't tell which lines of code do things slowly because they're
    going over the network! Impossible to profile code and estimate
    performance
  - Yuck
  - Treat an endpoint like a function, treat payload like parameters to
    function, you'll receive a response that is in a certain agreed-upon
    format
  - gRPC
    - Protobuf message formatting
    - Built-in timeouts
    - Not everything is one request-one response
      - gRPC allows you to stream stuff up and down
    - Very good for primarily mobile client on cloud-based backend!
      - Then if you need HTTP later you can pull out what you need
    - Google's woe: reduce resource load because HTTP is freaking noisy
- Exchanging *Resources*
  - HTTP 1.0 - 2000
  - Now, message should be a document that lives at a location
  - _Resource_ based (URIs)
    - Can have different representations of resources (HTML, etc.)
    - To have a different representation, you put it in a header, in the
      query string, or as a URL file extension
    - Blahblah
  - *Semantic web*: failed attempt at stuff
  - REST - 2005
  - HATEOAS - 2010
    - Other URIs should be embedded in the response that help the client
      do the next thing
- Querying *Graphs*
- GraphQL - mid-2010s
  - Facebook time
  - Problem: client code needs to know about a crap ton of different
    endpoints to render a simple UI; round-trips, different formats
    - But the killer: different clients may have different needs for
      the same endpoint, you end up with a monster response but each
      client only uses a part of it
    - New clients like the watch, ayyah
  - Database engines get queries that include a projection (the
    properties of the object you want, i.e. SELECT *)
  - GraphQL is like this, for the web
  - GraphQL allows client to specify exactly what it wants from your
    backend database, which is represented as a graph
  - Why not adopt this right away? You don't have Facebook's problems
  - Also kinda immature, stuff like caching isn't super clear

### 9 - The web: call interfaces, formats, and protocols

#### Lecture

- Web web web
- Future:
  - WebRTC
    - I/O, networking
    - At first, no way to make network request without requesting new
      page
      - 2003: introduce XMLHttpRequest (never actually used XML!)
    - WebSockets: message-based server push
      - Can't have raw TCP because then client can issue arbitrary
        network requests through that socket, port scan
    - WebRTC time
    - Combines audio/video/text in one :/
    - Still getting there
  - WebAssembly
    - Based on asm.js
    - Take existing C/C++ programs, compile into web bytecode/asm, then
      browser compiles that into local hardware ASM, then it runs
    - Right now it has to run in isolation, may change in the future
  - WebGL
    - GPU stuff
    -
  - Beaker
- Bad stuff
  - Didn't accomplish original goals
  - Ayyah
  - Text-based :/
  - Cross browser compatibility
  - Performance
  - Lagging platform integration
- Good stuff
  - Deployment for web is great! Can have users using your just-written
    software within seconds!
  - Multi-platform
  - Security model
    - It's built-in; web is designed for documents, and documents
      should never be able to `rm -rf /`
    - *Sandboxed*
    - End-to-end encryption
  - Open source on the client (you can still maintain software if
    companies go out of business)
