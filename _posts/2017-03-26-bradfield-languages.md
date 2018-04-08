---
layout: course_post
title: 'Languages, Compilers and Interpreters'
date: 2017-03-26 00:00
categories:
tags: [course, technical, programming, cs, bradfield]
author: Bradfield
rating: 5
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/languages/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's languages class"
---

## Notes

### 1: Overview and History

- Moving up in abstraction
- Binary->hex->ASM->compilers
- Need something cross-platform, enter C
- Compiler compiles an "object file" that includes assembly code and
  metadata. Run separately
- Interpreter takes source code and produces a running program, without
  giving you an intermediary runnable object
- Phases of interpreting/compiling code:
  - Lex(ical analysis): Get the array of characters and build pairs
    with categories (i.e. 1 + 1 -> (num "1") (op "+") (num "1")). Pairs
    of class and lexeme
  - Parsing: Build an AST with instructions
  - Semantic analysis: Hey, you declared this type but try to use
    something different here, what's up with that. Validate stuff
  - Optimize: Make stuff faster
  - Code generation: Output machine language
- Overengineering: Domain is wider in your head than it is in reality!
- Apple language toolchain
  - Start with microprocessors (i5, i7, a5, a6, a7, a8)
    - Different instruction sets (ISA = Instruction Set Architecture)
  - C language targeting both? From C straight to the architecture
    - Insert LLVM IR, which is for no machine in particular. And so if
      your code can run on LLVM IR, you don't have to care about the
      underlying CPU/hardware since LLVM will make it run there.
    - So now C programs compile to this Intermediate Representation
    - You've got a bunch of fancy new processors but can't make use of
      them cause you have to have backwards compatibility. Solution:
      another intermediate step! Add a "bitcode compiler" that interprets
      bitcode, no-ops on older generations, adds optimizations to newer
      generations
  - So now Apple has stuff written in C++/Obj-C/C, it is parsed out by
    the Clang compiler, which goes down to LLVM IR instructions
  - Later down the line, Swift->Swift IR->LLVM IR
    (optimized!)->bitcode->hooray
  - This is a crazy toolchain. Previously, it was just C->gcc->wtf this
    is just for one CPU
- Ambiguity in nouns and stuff is solved by very strict rules
- Nowadays optimization takes up the bulk of the stuff

### 2: Lexical analysis and FSAs

#### Students should understand

- The value of treating lexical analysis as a distinct concern
- The difference between lexemes and tokens
- How input buffering is used to scan ahead on input
- The concepts of transition diagrams and finite automata
- The relationship between deterministic and nondeterministic finite automata
- The technical definition of regular languages (and regular expressions)
- How a finite automata is implemented
- An intuition for how a program like lex/flex/jison-lex works

#### Students should be able to

- Draw state transition diagrams for simple tokenization problems
- Write simple regular expressions
- Given a simple transition diagram or regular expression, convert by hand to
  the other form
- Use [zaach/jison-lex](https://github.com/zaach/jison-lex) (or lex/flex) to
  generate lexical analyzers from Bison's lexical grammar format

#### Aiken videos

- Lexical analysis: _recognize_ lexical units (place dividers) and then
  _classify_ elements according to their roles (identifier, keyword, variable,
  etc)
  - Identifier: string of letter or digits starting with a letter (like Foo or
    B17)
  - Integer
  - Keyword
  - Whitespace
- *Goal*: Classify substrings of program according to role/class and communicate
  these tokens to the parser
  - Sends tuples to parser
- Lookahead may be required to decide where one token ends and the next begins
- More FSM stuff:
  https://www.youtube.com/watch?v=dmgX0jKoUJw&list=PLLH73N9cB21VSVEX1aSRlNTufaLK1dTAI

#### Let's look at Aiken videos for regexes and FSM

- Lexical spec helps you lex stuff
- Maximal munch: when you have a choice between two different both valid
  tokens take the bigger one
- Error is anything that doesn't match any rule
- Good algos known
- Choose highest priority, longest match if there are ambiguities
- Regexes are good!
- Regex = specification, finite automata = implementation
- Finite automata:
  - Input alphabet
  - Set of states
  - Start state
  - Set of accepting states
  - Set of transitions
- Notations and stuff
- If end of input and in accepting state -> accept that thing and move
  on
  - Otherwise, reject
- Can draw out finite automata as graphs
- Language of FA = set of accepted strings
- Can have self-loops :)
- Epsilon-move means state can change without changing input pointer
  - Free move
  - It's a choice :)
- DFA (deterministic) only have one transition per input per state. No
  epsilon moves. :)
  - Only one path through state graph per input
- NFA (nondeterministic) can hvae multiple transitions for one input in
  a given state, can have epsilon moves
  - Accepts if _some_ choices lead to acceptance at end of input

### 3: Parsing

#### Recursive Descent Parsing

- Top-down
  - Parse tree constructed top to bottom, left to right
- Start with a grammar for E and T
- Start with top-level non-terminal E
- Keep going as long as you have unexpanded non-terminals
- Try rules for E in order
  - Keep trying decisions, undo if wrong, keep going until right
  - Possibilities when you see something??
- Keep going till you get to something you accept .\_.
- Ok let's try an algorithm
- First define a bunch of boolean functions that check for matches
  - Given token terminal?
  - nth production of a non-terminal?
  - Try all productions of a non-terminal
  - Backtracking: save the pointer to the next token so that you can go
    back
- Starting parser
  - Initialize next to point to first token
  - Invoke the top thingy, E()

#### Bottom-up parsing

- More general than top-down parsing
- Just as efficient, uses similar ideas. Used more
- _reduces_ a string to the start symbol by inverting productions
- Reduction is the opposite of production
- To get back, keep doing the rightmost non terminal
  - Bottom-up parser traces a rightmost derivation in reverse
- Reduction: replace the children of the right hand side of a production
  with its parent?

#### Lecture

- Parts of a language
  - Reader
    - Just takes stuff in
  - Generator
    - Creates things that have been read
  - Translator
    - Changes generated output to some other output
  - Interpreter
    - Actually produces output
- Regular vs. context-free language
  - Regular language can be recognized with regular expression (e.g.
    emails)
  - Context-free language canNOT be recognized with regular expression
- Deterministic vs. Non-deterministic
  - Deterministic: can be parsed in one pass. Can tell you how long
    it'll take to parse just by looking at length
  - Non-deterministic: Cannot determine how long it'll take to parse
    just by looking at the length
- So, JS is context-free and non-deterministic
- LL vs LR are two types of parsers
  - First L is for read left-to-right, second char is whether you read
    from top or bottom
  - LL = top-down recursive descent
    - Use if backtracking required
  - LR = bottom up, faster
    - Use if no backtracking required
- All parsers come from EBNF

### 4: Semantic Analysis

#### Compilers as Assistants

- http://elm-lang.org/blog/compilers-as-assistants
- Compilers as assistants not adversaries
  - Good error messages
  - Incomplete pattern matches
    - If there's no else branch for an if, for example
  - Tail-call optimization
    - Some recursive functions can be turned into while loops which is a
      huge performance benefit
  - Remove unneeded syntax and code
- Explicit type errors and helpful messages and whatnot
- Cool, fancy stuff

#### Aiken Stuff (9-1, 9-4, 9-5)

- Lexing detects inputs with illegal tokens, parsing detects inputs with
  bad parse trees, now Semantic Analysis is the last "front end" phase
  and catches remaining errors
- Does checks
  - Declared identifiers
  - Type checking
  - Check inheritance
  - Check single definitions for classes/methods
  - Check that keywords aren't misused

- Let's look at types
- _Type_ is a set of values and a set of operations on those values
  - Type system *specifies which operations are valid for which types*
  - Type checking *ensures that operations are used only with the
    correct types*
- Static vs dynamic
  - Static catches errors at compile time instead of runtime, also more
    efficient because don't need to type check at runtime
  - Dynamic typing more flexible and restricts development speed
- Distinguish some terms
  - *Type checking* is process of verifying fully typed programs
  - *Type inference* is filling in missing type information :)

- Type checking bois
- Start with simple system, add features
- Notations
  - ^ is and
  - => is "if-then"
  - x:T is "x has type T"
  - Turnstile is "it is provable that"
- Soundness in type system
  - If it is provable that e is of type T, then e should always
    evaluate to type T
- In he type rule used for e:
  - Hypotheses are the proofs of type e's subexpressions
  - Conclusion is the type of e
  - Thus, types must be computed bottom up from the AST

#### Lecture

- SemAn can be done throughout compilation process. Can be done before
  or after AST
  - Lex time enforcement: "can't have star followed by snowman token"
  - Parse time enforcement: "let foo == bar", can't use equality like
    dat

### 5: Stack-based virtual machines

#### Python interpreter in python

- Take compiled machine code and run it!
- Byterun is a python interpreter in python :)
- Disadvantage is speed
- Goal is to understand the interpretation process
- Most modern VM's are stack-based cool
- Test your interpreter vs. reference implementation :) test stdout,
  exception state, etc.
- Stack machine means it manipulates stacks to do everything
- Interpreter needs a stack, and a way to interact with that stack :)
  - Value loader is what interacts with the stack
- Arguments to instructions are packed into bytecode. Okay
- Disassembler gives you information about the instructions in bytecode:
  name, index, arguments. `dis` is one for python bytecode
- Call stack is made up of frames. Each frame is a "context" or "scope";
  module, function, etc.
- Actual implementation of C interpreter of Python is just a huuuge
  switch statement on opcodes
- Should be one data stack per frame not one for the whole interpreter
  - Need this for generators
- Whoaa string formatting is done with binary modulo
- "In absence of types, every instruction must be treated as
  invoke\_arbitrary\_method" :feels:
- kool

#### Lecture

- Let's look at object format for our VM
- Data for string literal in *const pool*
- *Code* is bytes where instruction + arguments are in there (e.g. the
  string "Hello World" goes here)
- *Globals* is where global keys are stored. So if you declare "foo =
  bar" globally, "foo" is a global and the value for "bar" is in the
  const pool
- *Locals* is a map of string to object (we call env)
- *ip* is the instruction pointer
- *env* is environment variables
- *local stack* is what we start up for looking @ what we got
- *call stack* is another thing we start up, for tracking function call
  nesting
- It's much easier to target the JVM than a processor
  - Processor has so many physical constraints that instruction set is
    limited. Can abstract that away in a virtual machine
  - Slower but cross-platform :)
- The JVM is a bytecode interpreter in general, but is a just in time
  compiler on hot code paths

### 6: Code Generation

- We basically just worked on converting our AST into a flat list of
  instructions. Cool beans
- Basically do a post order depth first traversal to generate set of
  instructions

#### Dragon Book 8.1 and 8.2

### 7: Optimization

#### Dragon Book 9.1

- Languages can have a lot of overhead if we naively translate each
  construct independently to machine code! Making this better is called
  optimization
- Most important thing is to preserve semantics of program
- Most programming languages abstract away stuff like pointer
  arithmetic. Compiler can help manage this stuff well :)
- Example of array access. Must be transformed by compiler to do pointer
  arithmetic to find address of next array element, and then you access
  whatever is at that address

- Here are some transformations
- Common-subexpression elimination. E.g. if you compute an array index by
  doing 4 * (i) a bunch of times, you can just do it once and have
  subsequent references use the first calculation. Must be sure the
  calculation is the same though!
  - Common subexpression is when an expression has been previously
    computed and values of variables have not changed since
- Copy propagation
  - Use original value instead of the copy wherever possible
```
x = t3
a[t2] = t5
a[t4] = x
goto B
```
    to
```
x = t3
a[t2] = t5
a[t4] = t3
goto B
```
  - Helps with dead code elimination
- Dead-code elimination
  - Can eliminate stuff that cannot be reached
  - Deducing at compile time that an expression is constant and using
    constant instead of variable is called _constant folding_
  - Can now eliminate `x = t3` after copy propagation above
- Loops can def be optimized. *Code motion* takes an expression that
  is constant inside the loop and moves it outside the loop so that it
  can only be computed once. `while (i <= limit - 2)` -> `t = limit - 2;
  while ( i<= t)`
- Also want to optimize induction variables in loops. Induction
  variables change by a constant value in each iteration (e.g. the
  iterator)
- Okay maybe these videos will help

#### Aiken Videos (14-02 and 14-03)

- Why optimize? Tradeoffs?
- Largest, most complex phase
- When to optimize?
  - On AST: machine independent, but too high level
  - On assembly: exposes more opportunities, but machine dependent, yuck
  - On IR: Machine independent and exposes opportunities. Nice
- Basic block: maximal sequence of instructions with no labels (except
  first instruction) and no jumps (except last). Good for optimization
  - Guaranteed to go from beginning to end with no break
  - Single entry single exit straight line code segment
- Can look at stuff and try to optimize by hand :)
- Control flow graph is a directed graph with basic blocks as nodes.
  Edge goes from A to B if last instruction in A can go to first
  instruction in B
  - Can always represent method with control flow graph
- Mostly want to optimize to improve execution time. But can also
  optimize code size, network activity, etc.
- Different granularities of optimization
  - Local: occur within one basic block
  - "Global": apply to control flow graph in isolation (just in one
    function)
  - Inter-procedural: apply across a collection of functions
- Most do local, many do global, not many do interprocedural
  - Better payoff at more local levels
  - Goal: max benefit, min cost :)

- Let's look at local optimizations
- Delete temp vars
- Anything times 0 is 0
- Anything squared is just it times itself (simpler)
  - These are algebraic simplifications zzz
- Compute constant operation results at compile time not runtime :)
  - x = 2 + 2 -> x = 4
  - Constant folding
  - Dangerous! Don't mess up the code! If you cross-compile you might
    mess something up
  - Floating point ops are super messy
    - Represent floating point ops as strings and then do operations
      with all sig figs, then export with large numbers and let other
      architecture figure it out?
- Can also eliminate unreachable basic blocks
  - If you have conditional that is always false, can remove one branch
  - Also remove unused parts of stdlib or something?
- Write intermediate code in single assignment form :) at most assign
  one register once
- Explains copy propagation again :)
  - Only useful in conjunction with other optimizations
- Each optimization does little by itself, but they can interact (one
  enables another) and they eventually add up

#### Lecture

- Optimization with cc
- `cc -S -O 1 -masm=intel -o grain-O1.s grain.c

### 8: Runtime environments, stack management, garbage collection

#### Aiken videos (17.1 - 17.3)

- Storage management and memory management sucks
- Bugs! Forgetting to free, dereferencing dangling pointer, overwriting
  parts of data by accident. Hard to find!
  - Suck b/c they show themselves far away from the source
- Automatic memory management popularized by Java
- Strategy:
  - When object created, unused space automatically allocated
  - After a while all space is used up
  - Some space occupied by objects that will never be used again
  - This space "garbage collected" to use later
- How to know if object never used again?
  - Program can only use objects that it can find...if an object is
    unreachable (no more pointers to it), toss it
- Object _reachable_ iff a register contains a pointer to x _or_ another
  reachable object y contains a pointer to x
- Can find all reachable objects by starting at registers and following
  all pointers
  - Kinda an approximation for using stuff again. Just because object is
    reachable does _not_ mean it will be used again
- Unreachable object can never be used, is _garbage_
- Accumulator and stack pointer cover all the pointers you may need
- Some unreachable objects have pointers to them, but those will come
  from other unreachable object
- Garbage collector:
  - Allocate space as needed for new objects
  - When space runs out compute what objects may be used again, free
    space used by objects that won't be used again

- Mark and Sweep GC
- Two phases
- Mark: trace reachable objects
- Sweep: collect gargbage objects
- Every obj has extra bit: _mark_ bit
  - Reserved for memory management
  - Set to 0 originally
  - Set to 1 for reachable objects in mark phase
- Sweep phase scans heap looking for objects with mark bit 0
  - Add items with mark bit 0 to free list
  - Objects with mark bit 1 have mark bit reset to 0
  - Free list ends up being linked list of free space
- Tricky details :( typical!
- Sweep phase starts when we are out of space, but it needs somewhere to
  construct the todo list! Sizeof todo list is unbounded oops
  - Trick: pointer reversal. When pointer followed, it is turned around
    to point to parent
  - Move up and down todo list by flipping your pointers
  - Keep last pointer I traversed to in one register, so you can go from
    there up to the parents and grandparents
- Free list is stored in the free objects themselves
- Space for new object comes from free list
  - Block with enough size picked
  - Area of correct size allocated
  - Leftover put back in free list
- Mark and sweep can fragment and merge blocks :)
- Advantage of mark and sweep: objects not moved during GC. Means no
  need to update pointers to objects, can work for C and C++

- Stop and Copy
- Old space used for allocation, new space used as reserve for GC.
  Program only allowed to use half the space
- Heap pointer points to next free word in old space
- Allocation just advances the heap pointer
- GC starts when old space is full
- Copy all reachable objects from old space to new space
  - Garbage left behind
- Swap role of new and old space
- Problem: find all reachable objects!
- Difference: _copy_ not mutate. Find and fix all pointers
  - As we copy, store in old copy a forwarding pointer to new copy
    - When we reach an object with forwarding pointer we know it's been
      copied
- How to traverse without using extra space? Partition new space in
  three regions: start, scan, alloc
  - start: copied objects whose pointer fields have been followed all
    the way through
  - scan: copied objects whose pointer fields have not been followed
    yet. "work list"
  - alloc: empty working space after scan space. When scan catches up
    with alloc we're done
- Step by step
- 1: Copy objects pointed to by roots and set forwarding pointers
- 2: Follow pointer to next unscanned object in tree. Copy. Fix pointer
  in copied version of root. Set forwarding pointer. Keep going until
  done?
- Stop and copy generally believed to be fastest
- Allocation is cheap! Just incrememnt heap pointer
- Collection relatively cheap, especially if lots of garbage. Only touch
  reachable objects

#### Lecture

- Java OO and GC language :)
- GC tradeoff is dev productivity vs program performance
- Basic manual memory management: brk is a syscall that sets the heap
  pointer to different places. malloc/free wrap this syscall
- Reference counting: count how many times an object is referenced by
  another object
  - Storing the number of references, pointers, or handles to a resource
    such as an object, block of memory, disk space or other resource.
  - Automatic reference counting: when reference count is 0, then that
    space can be reused
- Cool this is all background for garbage collection
- Generational: have different object pools with different frequencies
  of GC if you can tell that some big objects that won't need to be
  checked for GC much

### 9: Language Design Considerations and Applications

#### Hamming on Hamming - Software

- Context of software
- Books/paper with programs handstamped in
- Von neumann reports about software
- Primitive step of programs - Symbolic names for assembly programs
  (recognize ADD and convert to binary)
- GG people just wanted to keep using binaries
- Logical languages don't last long, psychological languages do
- Fortran survived; starts 50's
- Then Lisp in 60's
- People who speak first get credit
  - Person who discovers something rarely understands it

- Everything in  a language is contained in subroutines
- Rules for his language: easy to use, easy to learn, easy to debug,
  easy to run subroutines

- Gotta think about your languages more deeply than "this is literal"
  - We say a lot of stuff that isn't black and white
- Must understand the nature of language :)
- Two languages: you to machine (want terse), machine to you (want
  verbose)

- Think before you write!
- Don't write one line of code until you decide what your acceptance
  test is
- Good programmers are 10x better. Thanks Hamming

- Programming like writing novels
- Most great writers don't take courses in creative writing. Way to
  become a great writer is not to take creative writing courses.
- Experience, using many languages - not good criteria for good
  programmer
- Programmer who knows the constraints of problem and fills it in,
  _thinking first_, is good
- Top-down approach - start with everything, fill it in. Cool
- Come up with rules for yourself :) Helps with pattern recognition

- Team programming very different from individual

#### Lecture

- Egan Understanding Hierarchy:
- Somatic: subconscious training of looking at stuff and recognizing
  patterns. Chess players seeing patterns, doctors, etc. Custom
  circuitry
- Mythic: big binary distinctions (children); old and young, black and
  white. "Mythic" from old Greek/Roman myths that carve up the world
  like this
- Romantic: reading and writing forms of communication
- Philosophic: math and stuff. Assign meaning
- Ironic: meta (puns)
- As you move between these levels you lose and gain things!
  - Missed goal of programming languages: fix-all languages that try to
    not let you think in some of these ways
- Why is this important?

- Language fundamentals
- Data vs code: it's bad when you conflate code and data. Express what
  you can of your program in data (stuff that doesn't have conditions,
  looping, etc.). Data more important! If you had to choose between data
  and code, take data every time. Try to move immutable things from code
  to data
  - Antipattern: Gemfile, gemspec. Package.json better. Gemfile.lock
    best
- Complexity: don't confuse complexity/simplicity with
  difficulty/easiness
- Primitives: what are the _most basic_ parts of your program? Don't get
  bogged down in anything else until you nail this down
- Tools and tooling: tools and tooling get built up over a long time
  - Languages are products of passion, tools products of rage

- Comparing languages is apples and oranges and people do it wrong
- Some good ideas in languages
- bash: REPL-first! Interactive, fast feedback. Good for its problems.
  Large user base. Systems integration
- C: cross platform assembler! That's the goal and we did it
- Clojure: it's a lisp on the JVM. It's a DSL for immutable data types.
  - Parasite language: no runtime of its own. Just uses the underlying
    types (int, string, etc.)
