---
layout: course_post
title: 'Operating Systems'
date: 2017-03-26 00:00
categories:
tags: [course, technical, cs, bradfield]
author: Bradfield
rating: 4
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/operating-systems/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's operating systems class"
---

## Notes

### 1 - Introduction to Operating Systems

#### OSTEP Ch 2

- Von Neumann: fetch/decode/execute hooray
- Operating system is responsible for making it easy to run programs,
  allowing programs to share memory, enabling programs to interact
  with devices, etc.
- Virtualization: OS takes physical resource and transforms into virtual
  form that can be shared. OS is a VM
- Interface OS presents to users is in the form of system calls. System
  calls make up the standard library of the OS
- OS is also a resource manager - manages CPU, memory, disk for all teh
  running programs
- Three major themes: virtualization, concurrency, persistence

- Virtualizing the CPU: turning a single CPU into a seemingly infinite
  number of CPUs from the program's perspective
- Running multiple programs raises many hard problems. OS policies try
  to resolve these problems consistently (e.g. two programs want to run
  at same time, which gets precedence)
- Memory is also virtualized! Each process has its own private virtual
  address space, OS maps it onto physical memory

- Concurrency is difficult
- Thread: function running within the same memory space as other
  functions, with more than one of them active at a time
- Problems b/c fetch decode execute are not atomic

- Persistence :thinking\_face:
- Memory is volatile, we need to be able to store stuff longer. Usually
  in an SSD or hard drive
- _file system_ is the software in OS that manages the disk. Job is to
  store files in reliable and efficient manner
- Writing file to disk is very ugly, OS abstracts it in the standard
  library
- Lots of ways to try and make it so we can recover from crash in middle
  of write

- Design goals time
- Abstractions pls. Pick the right abstractions to create an easy to use
  system
- Performance is also important. OS overhead should be minimal
- Protection between applications, and b/t OS and applications,
  important to keep computer secure. Principle of _isolation_ to make
  sure that processes can't interfere in bad ways

- History
- Good ideas accumulate over time
- Started with a computer operator operating the computer
- Syscall vs procedure call: syscall transfers control to the OS while
  raising the hardware privelege level. Syscall: trap -> OS trap handler
  -> now in kernel mode -> service request -> return-from-trap -> home

#### xv6 Ch 0-1, 3 section on syscalls

- xv6 is a trimmed down version of Unix that is good for learning
- _kernel_ defined here: special program that provides services to
  running programs in the OS
- Shell is in user space, which shows how powerful the syscall interface
  is

- Processes/memory
- Processes consist of user-space memory (instructions, data, stack) +
  pre-process state private to the kernel
- To share registers, kernel can save state and restore when you want to
  resume a program's execution
- Each process has a pid
- Forking a process creates a child with same memory as the parent. It
  returns the child pid in the parent, and 0 in the child
- Running down a bunch of different syscalls rapid fire;
  open/read/write, exec, etc.
  - The main loop reads the input on the command line using getcmd. Then
  it calls fork, which creates a copy of the shell process. The parent
  shell calls wait, while the child process runs the command. For ex-
  ample, if the user had typed ‘‘echo hello’’ at the prompt, runcmd would
  have been called with ‘‘echo hello’’ as the argument. runcmd (8406) runs
  the actual command. For ‘‘echo hello’’, it would call exec (8426). If
  exec succeeds then the child will exe- cute instructions from echo
  instead of runcmd. At some point echo will call exit, which will cause
  the parent to return from wait in main
- File descriptor: small int representing kernel-managed object a
  process may read from or write to
  - Get one by opening a file, creating a pipe, duplicating existing
    descriptor
  - Abstracts diffs b/t pipes, files, devices; they all look like byte
    streams!
  - 0 is stdin, 1 is stdout, and 2 is stderr
- `read(fd, buf, n)` reads up to n bytes from descriptor fd, copies them
  into buf, returns number of bytes read. Write(fd, buf, n) is similar

#### Lecture

- Tradeoffs
- xv6: good for teaching, but slow and limited toolchain
- FreeBSD: comprehensive docs, dtrace is great, big tho
- macOS: see your implementations and stuff

- No nice abstractions like objects n stuff
- Instead, bit fields and such
- CPU reads/writes bytes from memory, moves them around
- Important jobs of OS: virtualization and memory protection
- Seg fault is because you're trying to access part of the stack that
  you haven't asked for before (NOT because you're trying to access
  another program's memory, since we're virtualized)
- Container: just virtualizes the disk, you can read/write to new areas
  and stuff
- Virtual machine: present to the OS running on top of it what looks
  like real hardware and it will run on top of that hardware

- Unix
- Unix is command line operating system
- Difference between Unix/Linux/Posix
- Multics is an early OS from Bell, used for mainframe time sharing.
  Multi process stuff
- Unix was a side project from Thompson/Ritchie (1969). Everyone bought in
  because C was so portable, could run easily on so many machines

- v6 source got distributed a bunch, but AT&T didn't like it so they had
  a lawsuit out so people stopped using "their" software
- Berkeley people took the source code and made BSD (Berkeley Software
  DIstribution). AT&T took offense. But BSD had already changed a bunch
  of stuff around, so they just changed the remaining AT&T code and
  released a new version without any AT&T code
- Stallman at MIT did the same thing and started the GNU project. Wrote
  GNU in user land and a HURD microkernel in kernel land
- HURD sucked though (very slow), so Linus Torvalds took Stallman's
  userland programs (cd, ls, etc.) and wrote the Linux kernel for it
- NeXT took FreeBSD and renamed userland Darwin and renamed kernel Mach,
  then Apple acquired them so that's the basis for MacOS
- POSIX standardizes so you can reduce ifdefs in your C code
  - e.g. signature of a `read` call

### 2 - Processes and the Process API

#### OSTEP Ch 3-6

##### Ch 4: Intro to Processes

- Process is a fundamental abstraction. Definition? A running program
- OS creates illusion that there are many CPUs by *virtualizing* the
  CPU: run one process, stop and run another, etc etc. This technique is
  called *time sharing*
  - Time sharing: let resource be used for a little while by one entity,
    then another, then another, it can be shared by many
  - Corollary is space-sharing, e.g. memory
- Time sharing is a *mechanism*; mechanisms are low-level methods or
  protocols that implement a piece of functionality
- *Policies* live on top of mechanisms. Policies are software for making
  decisions in the OS, e.g. scheduling
- Mechanism is _how_ you accomplishes something (_how_ do you context
  switch?), policy decides _which_ is appropriate (which process should
  be executed right now)

- *Process*: OS abstraction for running program
- What's in a process? Its machine state. Includes memory (its address
  space), PC, registers, I/O information, etc.

- The Process API
- *create*: create a process
- *destroy*: kill a process
- *wait*: wait for process to stop
- *miscellaneous control*: suspend and resume, etc.
- *status*: how u doin rn

- Creation
- First, load program's code and static data into memory in the
  process's address space. Usually program is on disk in executable
  format
  - Generally _lazy_ (only load what you need)
  - Uses mechanisms of paging and swapping
- Then, allocate memory for the stack and heap
- Other misc. initialization, e.g.  set up 0, 1, 2 file descriptors
- Now you can go into the main() routine of the program dn begin
  execution

- What states can a process be in?
- *Running*: it's running on the processor
- *Ready*: it's ready to be run, but scheduler holding for some reason
- *Blocked*: waiting on something else to happen first. Commonly,
  waiting for i/o request to disk
- State transitions: from running to blocked is initiate I/O, blocked to
  ready is done I/O, between running and ready is schedule/deschedule
- When process is blocked, CPU can run another processo
- *process list*: all ready processes, and some metadata on what's
  currently running. Also need to know what's blocked
- Each process list entry has the register context (what's in the
  registers of the stopped process) for context switching

##### Ch 5: Process API

- fork, exec, wait are Unix syscalls for process creation

- Fork is really strange at first glance
- Need to do conditional logic on the return value to determine if in
  child or parent
- Returns child pid to parent, returns 0 to child, returns -1 if fork
  failed
- PID in Unix is the process identifier, used to name/identify the
  process
- Ordering is non-deterministic of whether child or parent goes first.
  Need to call wait() from parent to wait for child to finish, in order
  to make fork execution deterministic

- exec() calls a different program (whereas fork invokes same program)
- Given the name of an executable, it loads code from that executable,
  overwrites its current code/data segments with it, re-initializes heap
  and stack, and then run that program with the passed-in args as the ARGV
  of that process
- Does _not_ create a new process; instead, transforms current program
  into different program
- Lampson's Law: Get it right. Not pretty, simple, abstract, w/e. Right.

- Using fork and exec to build a shell: important because shell can run
  code after fork() but before exec()
- Redirecting output:
- When creating child, before calling exec(), close STDOUT, open
  newfile.txt, and then anything from the program's STDOUT will be
  redirected to file. Wow. Literally close(STDOUT\_FILENO) and
  open("./p4\_output")
- Pipes similar to redirect: one process' output is redirected to an
  in-kernel pipe, another process' input is connected to same pipe
- Lots more to learn, this is just scratching the surface

- kill() kills process
- top/ps for analyzing current processes

##### Ch 6: Mechanism: Limited Direct Execution

- Some challenges in time sharing. Performance? Control? Security?

- *Limited Direct Execution*
- Direct execution: just run program on CPU
- Problem with direct execution? _Security_ (need process to be able to
  do kernel level stuff without kernel level priveleges) and _context
  switching_ (how do?)
- Limited: put clamps on process permissions
- *trap* instruction is what C uses to turn stuff like open() into a
  syscall
- Introduce permissions via user mode (restricted) and kernel mode (what
  the OS is in)
- Syscalls are interface between user mode and kernel mode
- Kernel code locations and jumps and stuff are configured when the CPU
  boots up
- trap will jump into the kernel code and set permissions to kernel mode
- When kernel code done executing, OS calls return-from-trap, which
  returns and sets privilege mode back to user
- Process state (PC, flags, registers) saved onto the kernel stack when
  kernel code is called
- How does kernel know which code is kernel code? Set up a *trap table*
  at boot time, telling CPU what code to run when signals get trapped

- How does the OS regain control of the CPU when a process is running,
  so that it can switch between processes?
- Cooperative: wait for a syscall from program to take back control.
  Doesn't really work if process doesn't cooperate. Infinite loop =
  restart, oops
- Non-cooperative: *timer interrupt*. Timer device interrupts every X
  milliseconds, and OS interrupt handler runs to see if any changes are
  needed. OS tells hardware what to run during timer interrupt at boot
  time. OS also must start the timer
- Hardware's job to save system state before timer interrupt so it can
  return from trap
- Context switching is basically switching the registers to those of
  another process (stored in process list) and the kernel stack of the
  other process
- Maybe come back and look at this later?
- How long do context switches take? Sub-microsecond on 2-3 GHz
  processors, yay

- Concurrency? What if you're in the timer interrupt and another one
  happens? Maybe disable interrupts while handling one? Put locks on
internal data structures?

- Cool, so limited direct execution!
- Analogous to baby-proofing a room; the OS baby-proofs the CPU :)

#### xv6 Ch 5

- Skim now (before lecture), come back and read later

#### Lecture

- All processes in process table also store ppid (parent process id).
  First process started by OS is pid 0, which initially forks as process
  1
- Fork shares memory and stuff and lots of stuff in the child
- Daemonize: don't kill the child when the parent dies. Assign the child
  to the original process before killing the parent so that it doesn't
  kill itself

- Data Oriented Programming is how all OS programming works. Need to
  increase throughput using data and by remembering how hardware
actually works

- dtrace time
- Bryan Cantrill was not pleased with the state of debuggers - either
  print debugging or step through debugging, but both of them have their
  own costs


### 3 - Scheduling Strategies

#### OSTEP Ch 7 - 12

##### Ch 7: Scheduling: Introduction

- Context switching a mechanism, scheduling a policy
- Q: How do we develop a framework for thinking about scheduling? What
  are assumptions/metrics/approaches?

- *workload*: all the processes (jobs) running in system. Assumptions:
  - Each job runs same amt. of time
  - All jobs arrive same time
  - Each job runs to completion once started
  - All jobs only use CPU
  - Run-time of each job is known
- Unrealistic!

- *Scheduling metric*: how to measure stuff. Use *turnaround time*: time
  @ which job completes - time @ which job arrived in system
  - This is completeness metric; can also measure fairness

- FIFO, or First Come First Served. Like queue
- Simple, not great when you have long-running jobs. Increases average
  turnaround by a lot. This is the *convoy effect*: # of short
  jobs get queued behind heavy, long job
- Relax assumption that ea. job runs to completion once started

- SJF: Shortest Job First. Take shortest one. Used IRL, like express
  lines at grocery markets. Solves convoy effect
- Schedulers are *preemptive* today: will stop in middle of running
  process in order to run another. Opposite is only re-scheduling when
  current process is done
- K, now what if jobs arrive at different times? Can still get convoy
  effect if short comes after long

- Then use STCF: Shortest Time-to-Completion First. During timer
  interrupt, see which one has longest time left
- Shit, what about interactivity? Need *response* time: T(first run of
  program) - T(arrival of program)

- Round Robin runs job for *time slice* then switches to next job in
  queue. Keep jobs in priority queue. Need to choose a good time slice:
  too high means higher response time, too low means context switching
  cost will dominate. Want it long enough to amortize switching cost
- *Fair*: evenly divides CPU among active processes on small time scale
- Round Robin = low response, high turnaround. SJF = high response,
  low turnaround
- What about I/O?

- During I/O process is blocked waiting for I/O completion. Should
  schedule another job
- After I/O is done, process moved from block to ready by interrupt
- Can treat each separated-by-I/O portion as a sub-job that gets
  re-enqueued, and process seperately. You can get overlap this way.
  Nice
- Okay, what if you don't know how long job will take? Shit

##### Ch 8: Multi-Level Feedback Queue

- Rule 1: if Priority(A) > Priority(B), A runs and B doesn't
- Rule 2: If Priority(A) = Priority(B), A & B run in RR
- Rule 3: When job enters system, it gets highest priority
- Rule 4a: If job uses entire time slice, its priority is reduced
- Rule 4b: If job gives up CPU before time slice is up (waiting, I/O),
- Rule 4 (combined): Once a job uses up its time allotment at a given
  level (regardless of # of times it has given up CPU), its priority is
  reduced
- Rule 5: After some time period, move all jobs in system to topmost
  queue (Boost)

- Multi-level Feedback Queue approach (MLFQ). Won Corbato a Turing award
  in 60s
- Problem: optimize turnaround time while minimizing response time
- Scheduler needs to learn through context over time; won't have perfect
  knowledge of job length beforehand.
- Learn-from-history approach good when jobs are chunked up and
  predictable. Break it down

- MLFQ has different *queues* with different *priority levels*. Ready
  job on one queue at a time
- Set priority using observed behavior heuristics :thinking\_face:
- If process waits for keyboard input, priority should be high, want to
  prioritize response time
- Approximate SJF, since you *assume* job is short-running until you
  have reason to believe it's long running. Okay

- Problem: program behavior can change over time. Processes can
  get *starved*, RIP
- Rule 5! Takes out starvation, and addresses changed behavior

- Problem: people can game scheduler and take up 99% of CPU time by
  never using a whole time slice
- Rule 4 combined. Different CPU time *accounting*. Prevents process
  from sticking in top level queue

- Bleh, PITA to tune this stuff. How many queues? What's the time slice?
- Generally high priority queues get low time slice b/c interactive ok
- Solaris uses a table of these values that can be alered. FreeBSD uses
  algorithms to calculate current job priority based on how much CPU
it's used

- Avoid magic numbers/constants

- Can also give scheduler advice about how long you're gonna take and
  stuff.
- MLFQ observes behavior patterns of jobs and adjusts accordingly,
  since it doesn't have previous knowledge. This good

##### Ch 9: Proportional Share

- Instead of optimizing turnaround/response, try and get all processes
  to a certain % of CPOU time
- *Tickets* represent the share of a resource a process should receive.
  I.e. A has 75 tix B has 25 tix, A should get 75% of the time
- Random approach. Why is random good?
  - Avoids strange corner cases
  - Lightweight
  - Fast
- Ticket mechanisms
- *Currency*: give each user/process a set of global tickets which
  they divide up. These are transferred to global tickets at scheduling
  time to run lottery on who goes next
- *Transfer*: process can temporarily hand off tickets to another
  process, e.g. client passing tix to server to get work done faster
- *Inflation*: process that is trusted by others can give itself more
  tickets to take priority

- Implementation v simple: random number generator, process table, track
  total number of tickets. Nice
- *Unfairness* (how long after first process ends does second process
  end) is negligible over time

- Optimal ticket assignment is a tough cookie

- Stride scheduling is alternate to lottery: each job has a pass value
  (counter of how many times it's run IG), and a stride value (total tix
  / your tix). Increment pass value by stride every time program runs,
  run the lowest pass value every time. Ends up being proportional
- Needs to maintain global state though, not the play
- Deterministic
- MLFQ more common
- Use case: virtualizingaaa, where you know you want Windows VM to have
  25% of CPU cycles and Linux to have 75%

##### Ch 10: Multiprocessor Scheduling

- Skim now, come back later
- Scheduling is hard af
- Kay

#### Lecture

- "Not Responding" in activity monitor = d e a d, taking all the cycles
  and not responding to events

- dtrace
- syscall:freebsd:execve:entry
- provider:package:function_name:name
- There are `sched` probes but I couldn't quite get them to work

- The process abstraction is quite powerful, scheduling is difficult

### 4 - Virtualizing Memory

#### OSTEP Ch 13: Address Spaces

- Every user address is virtual. Why? *Ease of use*. Each process gets
  an *address space* to put its stuff in. Also isolation and protection
  :)
- At first, no memory virtualization
- Then *multiprogramming*; CPU virtualization allowed concurrent
  processes. How to share memory between processes as well? Allows stuff
  like interactivity :thinking\_face:
- Abstraction is *address space*: running program's view of memory in
  system
  - Contains text (code), data, heap, etc.
- Problem this solves: multiple running processes need private address
  spaces on top of single physical memory
- What are our _goals_?
  - *Transparency*: running program shouldn't realize anything's going
    on
  - *Efficiency*: as little performance impact as possible. Need
    hardware support
  - *Protection*: processes should be protected from each other
- This is *virtualizing memory*: program thinks it's at an address and
  has a lot of accessible memory, but in reality it's sharing

- Tip: isolation: one process can fail without affecting another.
  Isolation of processes is a better dynamic

- Again, *mechanism*s are low-level protocols or method for implementing
  stuff ("how"), *policies* decide "which" decision to make

#### OSTEP Ch 14: Interlude: Memory API

- Hope some of these concepts are from CompArch
- Yeah I know most of this
- Stack variables are inside scopes. Stack == automatic memory
- *Heap* allocations are handled by you, the programmer. *malloc*

- Don't need to require #include <stdlib.h> but it allows compiler to
  check if you're calling it correctly

- Best practice to cast result of malloc to be concrete about what
  you're doing: (double *) malloc(sizeof(double))
- free() reverses malloc, cool

- Ooh common errors
- Forget to allocate
  - SEGFAULT: tried to access memory you have not allocated yet
- Not allocating enough. You'll overwrite some poor other variable
- Make sure you fill in a value at the pointer you've malloc'd
- Forgetting to free. Oops, memory leak
- Free memory before you're done: results in a dangling pointer, which
  can now point to something you have no control over
- Double free (freeing something already freed) can wrreck you too

- Leaking memory in short-lived processes is "okay" because OS will
  reclaim memory after process dies anyways
- `brk` (set the location of the end of the heap) and `sbrk` (increment
  heap pointer) are what malloc and free use under the hood. They are
syscalls
- Cool, there goes malloc and free

#### OSTEP Ch 15: Mechanism: Address Translation

- Mechanism for CPU virtualization was *Limited Direction Execution*
- Crux: How to Efficiently and Flexibly Virtualize Memory
  - Flexible: don't restrict how programs use their own virtual memory
    space

- Tip: *interposition*: transparently make a change behind the scenes
  to make life easier for your client. Address translation is an example

- Alright, let's roll. Variables (start by assuming they're static):
  - Is virtual memory a contiguous block in physical memory?
  - Is virtual memory smaller than physical memory?
  - Is each address space the same size?

- Assume all these are static
- Virtual memory layout: code/text at the top, then heap directly below.
  Stack grows up from bottom up to a certain size
- How to translate address 15kb in program to its place in hardware?
- Aside: Software-based static relocation (loader rewrites executable to
  have physical addresses before it runs) is worse; doesn't have any
  protection, processes can generate bad addresses and overwrite other
  processes' stuff

- Dynamically (hardware-based)
  - *base and bounds* (dynamic relocation): one CPU register has the
    *base* of the physical memory location of the virtual memory of the
    currently-running process, and another has the *bounds*. Thus,
    physical address = virtal address + base
  - Dynamic since it happens at runtime
  - Bounds register makes sure addresses are within confines of address
    space
  - Having these values in registers is a big boost to performance
  - MMU (memory management unit) is the part of the CPU that contains
    this circuitry
- Aside: *Free list* is the data structure the OS has to keep track of
  which parts of physical memory have not yet been allocated
- Hardware support
  - Must support kernel (privileged) mode and user mode.
  - Need the base and bounds registers on the MMU
  - Ability to translate virtual addresses to physical ones
  - Provide special instructions to modify base/bounds (only allowed in
    kernel mode)
  - Raise exceptions when program tries to access memory illegally, and
    jump to the kernel exception handler
- OS requirements
  - Memory management: allocate memory for new processes, reclaim memory
    from terminated processes. Uses free list
  - Base/bounds management: set base/bounds appropriately on context
    switch. Keep these values in the process table
    - When process is stopped, can move its memory. Just copy the
      address space and then update the base value in the process table
  - Exception handling: provide code to run when CPU raises exception.
    Stuff like reclaiming its memory and cleaning up associated data
    structures
    - The address of the exception handler is configured when trap table
      is initialized at boot time

- This concept *builds upon* limited direct execution, just save extra
  stuff in the process context and add a bit more hardware
- Base and bounds approach
  - Efficient: done in hardware
  - Protection: no process can access outside memory
  - Wastes space that is not used by process. *Internal fragmentation*:
    space inside an allocated unit is not used at all. Solve with
    *segmentation*

#### OSTEP Ch 16: Segmentation

- Crux: How do you support a large address space with lots of space b/t
  stack and heap?
- Separate base and bounds pair per logical segment of address space
  (code, stack, heap)
  - Accomodate sparse address spaces
- Segmentation fault is when you access segmented machine at illegal
  address. RIP

- How to know which segment an address belongs two?
- Can reserve first two bits of address as segment ID, then rest as
  offset. e.g. 00 = code, 01 = stack
- Can look at how address was generated (if from stack pointer, it's
  in stack, if from PC, it's in code)
- Need to track whether address space/segment grows positively or
  negatively (stack grows negatively). Just use a bit for this
- Add in protection bits to enable sharing. Read-write, read-execute,
  read-only, etc. Thus, diff programs can look at same information,
  think it's their own, but in reality it's shared
  - Add support to hardware for checking permission bits as well

- Okay, now with segments, how do you allocate memory? Throw out
  assumption that each segment is the same size, because they're
  obviously not
- Don't want small holes of unusable free space (*external
  fragmentation*)
- Compacting physical memory by keeping on rearranging segments is an
  option, but bad because costly
- Rather, use a free-list management algorithm that tries to keep large
  pieces of memory available for allocation. Lots of options; no "best"
  way to do this

- Segmentation is good!
- Support sparse address spaces
- Performant: still in hardware
- Allows code sharing
- Still not flexible enough to support fully-generalized address space.
  Large but sparsely-used heap in a logical segment leads to
  fragmentation because entire heap still needs to be in memory
- Kay

#### OSTEP Ch 17: Free-Space Management

- Alrighty. Hard to manage with variable-sized blocks
- How do you manage free space? What strategies and tradeoffs are there?
- Assumptions
  - malloc/free-like interface for users to manage memory
  - free list data structure to keep track of free space
    - Literally a linked list of the contiguous blocks of free memory
  - Once memory is givent o client, it can't be relocated to another
    spot in memory
  - No brk or sbrk - assume each region is a single fixed size
    throughout its life

- Mechanisms
- Splitting and coalescing: When you get a request for less memory than
  one of your free chunks, split it up, return first part to the
  requester, second part replaces previous chunk in free list
  - *Coalesce*: when memory is freed and is right next to another free
    chunk, merge then together
- Allocator stores a header before the pointer it allocates that
  identifies it so free(void *) can just take a pointer, doesn't need to
  know its length
  - Header has *size* and *magic* number to provide integrity checking
  - Must search for space of size header + N bytes when allocating

- Where do you keep free list in memory?
- Allocate a heap with mmap, set up your list, whenever you add stuff
  you just move along your list
  - head points to the first free node. This location moves as you
    allocate memory, _before_ freeing it. This is contiguous
  - When memory freed, library figures out size of free region, adds it
    back to the free list by inserting at the head or something

- How does OS grow the heap?
- Sometimes fail
- Sometimes find free physical pages, map them into address space of
  requesting process, return value of end of new heap. Tight
- Skim some basic strategies for allocating memory
- All these strategies trade off cost of scaling (searching list) for
  more complex in memory data structures and stuff. Simplicity for
performance

### 5 - Paging

#### OSTEP Ch 18: Intro to Paging

- If you use different sized chunks of memory you get fragmenting. So
  why not use fixed-sized pieces? These are _pages_.
- View physical memory as array of page frames, each of which can
  contain a single virtual-memory page
- So, how to virtualize memory with pages to avoid fragmentation? With
  minimal time/space overhead
- Paging provides flexibility in the virtual memory abstraction :)
- Also simplicity - OS just tracks free list of pages, not a bunch of
  different types of free space

- Use *page table* to track where each virtual page of address space is
  placed in physical memory. This is per-process. Role of page table is
  to store address translations for each page
- How to translate?
- First, get a virtual page number and an offset in the page. Can just
  use separate bits in the virtual address to indicate these
- Use the page table to translate the virtual page number into the
  physical page number (PFN), and use that same offset, you can now go
  fetch the data from physical memory

- Where do you put page tables? They can get pretty darn big to do all
  the necessary address translations
- Gotta put em in memory
- Linear page table: use virtual page number to index into array, looks
  up the page-table entry (PTE) at that index, which should point to the
  desired physical frame number. Ezpz
- Each page table entry can have some bits
  - Valid bit: is your transition valid? E.g. have you asked for this
    heap
  - Protection bits: permissions on read/write
  - Present bit: is data on memory or on disk (swapped)
  - Reference bit: has this page been accessed? Used for swapping and
    such

- This too slow and takes up too much space! Some pseudo-code here for
  virtual memory paging
- Lots of extraneous memory accesses and such
- Okay, don't fully understand the diagram


#### OSTEP Ch 19: Paging: Faster Translations (TLBs)

- How do you speed up address translation and have it take up less memory?
- Add a *translation-lookaside buffer (TLB)* as part of the chip's MMU,
  which is a cache of virtual-to-physical address translations. Could
  call it an address-translation cache
- Hardware first checks TLB before doing any computation to translate
  addresses
- If it gets a hit, you can do the same checks on permissions and
  validity and whatnot
- If no hit, then proceed as usual and also update the TLB
- Try to get as many hits as possible!
- e.g. sequential array accesses on the same page as memory are good.
  This is spacial locality
- Hit rate: % of accesses that are TLB hits
- If you re-reference the same stuff closely in time to each other, you
  get temporal locality

- Caching is a great performance technique in general :)
- At first hardware managed TLBs; had to know where on disk the page
  tables were, and their format, to be able to do this. x86 did this
  originally :)
- Nowadays we have software-managed TLBs. Hardware jumps to specific
  spot in kernel code when TLB miss happens
- How to avoid infinite TLB? Have some permanently-valid translations in
  the TLB (*wired*)
- Software-managed TLBs are more flexible (any data type can be used)
  and simple (hardware has less to do)

- TLB contents are *fully associative*: any given translation can be
  anywhere in the TLB, and hardware searches entire thing at any given
  time
- Each entry: VPN | PFN | other bits
  - Other bits can be stuff like *valid bit* (contrast with page table
    valid bit; page table one indicates whether program has access to
    that page, while TLB valid bit indicates whether the translation is
    "real" . When system first boots, no TLB translations are valid :)

- What do when you context switch? Need to pull in new TLB for new
  process
- You could just flush the TLB whenever you context switch, which sets
  all the valid bits to 0
- This works, but you have to re-populate the TLB whenever you context
  switch; if context switches happen often, you screwed
- Hardware can add an *address space identifier* to the TLB, and each
  process gets its own ASID. Then you only map VPNs that match your ASID
  to the correct PFN. Cool

- How do you decide which entry to replace when your TLB fills up?
- Could just do LRU
- Could also be random to avoid corner-case behaviors like "loop over n
  + 1 pages with TLB of size n", cause the one you want is always the
  last thing removed so you have to fetch it
- They use an example of the MIPS TLB, cool

- Summary: TLB on chip increases performance a lot :)
- But if you overrun the TLB (exceed TLB coverage) you may be fukked
- To get around this you can use larger page sizes; common in DBMS
- Cool

#### OSTEP Ch 20: Paging: Smaller Tables

- Okay, page tables are very large (they have to map all possible
  virtual page numbers to physical page numbers for every process!)
- Linear page tables suck
- One solution is just having bigger page sizes, buuuut that leads to
  internal fragmentation :/

- What about combining paging and segmentation? *Hybrid*
- Have one page table per logical segment (code, heap, stack)?
- Still use base and bounds for the segments
- Top two bits of virtual address refer to segment, then VPN number,
  then offset number
- Keep a bounds register per segment :) because it's separate from pure
  page table by having different bounds at each segment
- This hybrid approach is pretty good in general

- Okay, how about an approach that doesn't rely on segmentation, but
  attacks same problem: how to get rid of all invalid regions in the
  page table instead of keeping them all in memory? This is multi-level,
  turns page table into a tree
- Chop up page table into page-sized units
- If entire page of page table entires is invalid don't allocate that
  page of the table
- Use a *page directory* to track whether each page of the page table is
  valid or not
- Page directory has one entry per page table page. Each page directory
  entry (PDE) has a valid bit and a page frame number (PFN). Is
  pretty much like a page table entry
- Only allocates space in proportion to # of addresses you're using
- Each portion of page table fits into one page, so you can manage the
  memory easier :) just get next free page to find space more another
  PDE
- Adds a level of indirection (cost) to improve space usage (benefit)
- First N bits of the VPN can be used as page directory index :)
- Use page directory index to find which page table you're looking at,
  then get your physical address
- Can use a multi-level page directory if the situation calls for it
  :) pretty much just the same thing recursively
- We want the page directory to fit into one page of memory too!
- Cool that's pretty much the process of translation here: use a page
  table and have a TLB, nice
- Teaser: page tables can be swapped to disk

- Cool, so this is how real page tables are built, not just linear!
- All about dat time-space tradeoff; bigger page table = faster
  servicing of TLB misses, but more space

#### OSTEP Ch 21: Beyond Physical Memory: Mechanisms

- How can the OS make use of larger, slower device to transparently
  provide the illusion of a large virtual address space?
- Why do this? For convenience + ease of use of the userland program
- Also multiprogramming: run multiple programs concurrently
- Reserve space on disk for moving pages back and forth: *swap space*
- (since we swap pages out of and into memory from this space)
- Need disk address of a page that has been swapped!

- What do we need to add up above to support swapping?
- Add *present bit* to each page table entry. If 1, then page is in
  physical memory. If 0, then page is swapped out
- If you access a page not in physical memory, it's a page fault
- When this happens, hardware jumps to OS page fault handler
- Why does OS handle page faults instead of hardware? Accessing disk so
  slow that the OS overhead isn't the bottleneck. Also, hardware doesn't
  want to have to know about swap space/disk I/O, etc.
- OS may need to swap page back into physical memory. How sway
- In the part of the PTE normally used for memory address, put a disk
  address. Then OS just fetches from that address, puts it somewhere in
  physical memory, flips valid bit, and replaces value in PTE with the
  physical memory address

- Oh dear, how to swap in when memory is full? There's a very good
  page-replacement policy :)

- Alright family, with page faults you obvz add to the flow control.
  Some code examples here :zzz:
- When do you replace stuff? Want to do it proactively to help w/
  performance
- Hgh watermark: minimum number of free pages you want available
  whenever swap daemon runs
- Low watermark: when fewer free pages than this watermark, swap daemon
  runs and evicts until you reach high water mark
- Doing work in the background is good for efficiency :)

- Cool, so we have a way to swap memory. Use a present bit, if page
  isn't present run the page-fault handler, this all happens
  transparently to the process!

#### OSTEP Ch 22: Beyond Physical Memory: Policies

- How does OS decide which page(s) to evict from memory? This decision
  is made by the replacement policy of the system, which usually follows
  some general principles but also includes certain tweaks to avoid
  corner-case behavior

- Let's view main memory as a cache for virtual memory pages in system
- Thus, we want to minimize cache misses
- Average memory access time (AMAT) is the metric of choice. Computed
  from hit rate, miss rate, cost of accessing memory, cost of accessing
  disk
- "Optimal" replacement policy is to evict wpage that will be accessed
  farthest in the future (obviously can't do this ourselvs, but can
  compare our implementations against this to benchmark)
- Quickly, cache miss types
  - Compulsory: because nothing in the cache yet
  - Capacity: No space in the cache!
  - Conflict: limits on where item can be in hardware cache, oops

- FIFO is first-in first-out (like a queue). Simple! 36% hit rate

- Random is simple as well...

- LRU? Least Frequently Used? Let's use historical data
- Stuff like frequency a page is accessed, recency of access
- These use *principle of locality*: stuff tends to get accessed
  frequently and close by :)
- Compare approaches by looking at different workloads. Some of these
  workloads result in ugly corner cases :/

- How do you implement a historical approach like LRU?
- Approximating easier than doing the real thing :)
- Can use a *use bit* which is associated with a page table entry. Set
  to 1 by processor if that page in memory is accessed. And
  then have a "clock hand" that goes around all the page table entries
  in a circle. When time to evict, if currently-pointed-at entry has a
  use bit of 1, set it to 0, and track until you find one that's 0. If
  0, evict it

- Dirty pages suck to evict because you have to write them back to disk
  first. Can use a *modified bit* similar to use bit that indicates
  whether page has been modified, and try not to evict those

- Other policies: change up how you decide when to pull pages into
  memory, or cluster writes to disk. All help with VM

- *Thrashing*: systems running don't have stuff that fit into physical
  memory, so you're constantly swapping :(
- Deal with it by choosing a subset of processes to get done with first?

- Cool so those are policies for swapping

#### OSTEP Ch 23: The VAX/VMS virtual memory system

- Just read, no notes

#### Lecture

- *Cache pollution*: you keep doing disparate reads from memory, keep
  having to flush and replace the cache, very bad

- Benefits of paging
  - Code sharing for shared libraries
  - Page caching. Cache code blocks that are frequently used by
    processes!

### 6 - Concurrency

#### OSTEP Ch 26: Concurrency: An Introduction

- Multi-threaded processes! Need to manage memory accesses and whatnot
- OS needs to deal with *locks* and *condition variables*, OS itself is
  concurrent

- *Thread*: process that is multi-threaded has multiple instruction
  pointers. They do share memory
- Each thread has its own set of registers to work from (need to do a
  context switch when switching threads)
- Save execution state to a thread control block (TCB) for each thread
- Thread context switch does not need to switch address spaces :)
- Multi-threaded address space has different spaces for each thread.
  Called *thread-local* storage

- Why use threads?
- Parallelism: have multiple running processes at the same time on
  different processors
- Avoid blocking due to I/O; threading enables overlap of I/O within a
  single program (analogous to what multiprogramming does for processes)

- `pthread_create` to start a thread, `pthread_join` to wait for thread
  to finish
- No guarantees on execution order of threads! This gets sad and
  complicated :(
- Uh oh, shared data
- `Pthread_create` (capital P) prints an error message if the thread
  doesn't create successfully
- Oh dear...accessing shared data (e.g. a shared counter) produces
  unreliable, incorrect results
- Yikes, if you get a timer interrupt before persisting the saved
  counter to the stack, you get screwed. So you can run the loop twice
  but only increment the counter once :(
- This is what a *race condition* is; results in *indeterminate*
  computation when multiple threads enter a critical section at the same
  time
- Code where multiple threads are executing is a *critical section*.
  Accesses a shared resource
- What we want is *mutual exclusion*: if one thread is in the critical
  section, it should be able to complete its work "as intended"

- *Atomic* operation: all updates happen at once time (as a unit, all or
  none). Grouping of many actions into an atomic action is a
  *transaction*
- Start with *synchronization primitives* in the hardware
- Dis should make your head hurt
- Another problem: one thread is dependent on another to complete action
  before it continues

- The OS is the first concurrent program, so that's why this concern is
  related to the OS
  - Example: two processes both want to write to a file at the same
    time. How do you accomodate this? Untimely interrupt throws
    everything off

#### OSTEP Ch 27: Interlude: Thread API

- pthread_create(pthread_t * thread, const pthread_attr_t * attr, void *
  (*start_routine)(void*), void *arg);
- Ezpz
- Pass pthread_t pointer to function to interact with thread
- Attr built with pthread_attr_init
- start_routine is a *function that takes one void pointer argument and
  returns a void pointer*. Left side is return, right side is argument
- Void pointer means anything can be passed in/returned
- `Pthread_join` waits for thread to complete
- Never return a pointer which refers to something allocated on the
  thread’s call stack! It'll be a seg fault next time you try to access
  it
- Mutual exclusion comes by way of *locks*:
  `pthread_mutex_lock(pthread_mutex_t *mutex)` and corresponding unlock
  function
- Initialize a lock, lock before critical section, unlock after critical
  section, nice. See man pages for more
- *Condition variable*: use when you must signal between threads, if
  one is waiting for another to finish something before it can
  continue. Like `flag`
- `pthread_cond_wait()` takes a cond_t and a lock mutex, puts calling
  thread to sleep until it gets a `pthread_cond_signal` from another
  thread that lets it continue. Use global variable `ready` for this
  signaling
  - wait() takes a lock because it needs to release lock before going to
    sleep. pthread_cond_wait() re-acquires lock before returning
- Cool, the pthread library is just built in to C, hooray. Some
  guidelines:
  - Keep it simple
  - Minimize thread interactions
  - Initialize locks and condition variables correctly
  - Check return codes!!
  - Be careful with how you pass arguments to, and return values from,
    threads
  - Each thread has its own stack!
  - Use condition variables to signal between threads
  - Use man pages
  - zzz
- Cool, get an idea for locks, condition variables, etc. by exploring
  thread API in C

#### OSTEP Ch 28: Locks

- *Lock variable* holds the state of the lock at any instant in time.
  Lock can be *available* (unlocked, free) or *acquired* (locked, held)
- One thread *owns* the lock at a time. If another thread calls lock(),
  it will not return until the owner relinquishes control

- *mutex* provides mutual exclusion
- Each lock is unique based on passed-in var, so you can have multiple
  locks going on at a time

- How do you build an efficient lock? Hardware? OS?
- Basic task: mutual exclusion
- *Fairness*: each thread contending for lock get fair share at it?
  - Flip side: does any thread *starve* (never get a chance)?
- *Performance*: time overhead using a lock adds
- Naive: disable interrupts during lock
  - Many disadvantages
  - Need to trust that locking thread is well-behaved
  - Only works on single processor
  - Interrupts (i.e. I/O done) can get lost if this runs for a long
    time; leads to big problems
  - Inefficient; masking interrupts is not easy
- Okay, what about *test-and-set* instruction? Also called atomic
  exchange
- Simplest: use a `flag` var that gets set to 1 while a thread is n
  critical section. Unfortch, this still suffers from
  concurrency/interrupt issue. Sad!
- `test-and-set` instruction returns an old pointer value and updates
  that pointer value, *atomically*
- Implement lock: *test* old lock value to see if you can get the lock,
  *set* new value at the same time
- Spin if you get an "old value" of 1, meaning that another thread had
  the lock
- To frame concurrency problems, imagine you are a malicious scheduler
  :)
- Spin lock: correct, unfair, nonperformant on single CPU 'cause you can
  have a lot of spinning processes

- Compare-and-swap? Pass in an expected and a new; set to new if actual
  == expected
- `lock` method just expects 0, sets 1. Cool
- Similar to test and set now

- Load-linked and store-conditional
- Acquire lock by spinning until loading flag is 0, doing a store conditional
  to the lock address for the value 1 (make sure this returns 1! If it
  doesn't, someone else snuck in and got the lock
- Unlock by setting flag to 0, duh
- Lauer's Law: more code is worse. Less code is better

- `Fetch-and-add` atomically increments a value while returning old
  value at the address
- `Ticket lock`: to acquire lock, do an atomic fetch-and-add on the
  ticket value. That's the thread's turn. Then, the `lock->turn`
  determines which thread's turn it is
- Unlock by incrementing the turn
- This introduces a tad bit of fairness :)

- How do you avoid spinning?
- Just yield? Better, but can still do N context switches before
  continuing your thread, where N is the number of threads trying to
  acquire lock

- Queue? Sleep, don't spin
- `park` puts calling thread to sleep, `unpark` wakes a thread
- Use a queue of lock waiters, unlock pops off the queue and hands off
  control
- Spin locks suffer from *priority inversion*: higher priority thread
  becomes the one that runs the most, but is not the one we want to run!
- All about addressing edge cases and stuff. setpark() just in case you
  get interrupted during a park
- Linux uses *futex*: each futex has a physical memory location,
  futex_wait and futex_wake are the interface to get yourself onto the
  queue and schedule the next thing on the queue, respectively

- All kinds of different lock types! Details differ and stuff; this is
  hard!

#### OSTEP Ch 29: Lock-based Concurrent Data Structures

- How to add locks to data structures? Making them *thread-safe*

- Counter?
- Can just add a single lock, invoke whenever you do anything with the
  data structure
- Scales poorly; we want *perfect scaling*, where a bunch of work is
  done in parallel so we can scale without a performance cost
- *Sloppy counting*: four local counters (one per CPU), one global
  counter, each has its own lock. Increment local counter when your code
  runs. Local values periodically transferred to global counter by
  acquiring global lock and incrementing by local counter value; local
  counter then set to 0
- Threshold S (for sloppiness) is how often the local-to-global transfer
  occurs
- Accuracy/performance tradeoff

- List?
- Side note: exceptional control flow sucks
- Basically can just try to lock/unlock around inserts
- Side note: simple is usually fine!! If you don't need to scale a ton
- General design tip: be wary of control flow changes that lead to
  returns/exits that halt function execution. You probably left some
  cleanup not done :/
- Hand-over-hand: Add a lock per list node. But you don't really see a
  performance benefit. Maybe a hybrid? Where you grab a lock every few
  nodes

- Queues?
- Like everything, could add a big lock
- Could maybe have separate locks for head and tail. :zzz:

- Hash table?
- Use a lock per hash bucket! Each bucket is a linked list, so we can
  lean on that implementation. Cool

- *Avoid premature optimization*!!!
- Okay, lists, queues, counters, hash tables, all good stuff that can be
  concurrentized

#### OSTEP Ch 30: Condition Variables

- How do you wait or a condition before proceeding in a thread?
- *Condition variable*: explicit queue threads can put themselves on
  when some state of execution is not as desired (*waiting* on the
  condition); some other thread, when it changes state can then wake one
  or more of these waiting threads and let them continue (by *signaling*
  on the condition)
- `pthread_cond_t` declares c as a condition variable. Has wait() and
  signal() operations, yee
- *Always hold the lock when calling signal or wait*, so that you can be
  sure about your operations. Otherwise, you can get infinite loops and
  such
- Got it, parent join()ing on child does a wait(), child does a signal()
  when it's done. Need to also keep a `done == 0` state between parent
  and child to ensure you don't end up with infinitely running thread

- *Producer/consumer* or *Bounded buffer* problem
- Producers generate data items and place them in a buffer, consumers
  grab items from buffer and consume them. E.g. a Unix pipe
- Producer only puts onto buffer when count is 0 (empty), Consumer reads
  from buffer when count is 1
- *Mesa semantics*: signaling a thread wakes it up (hint that world
  state has changed), but no guarantee that the state is still as
  desired when the woken thread runs!!
  - So if you have two consumers, and one sneaks in after other is
    scheduled but not run yet, then the second one will raise assertion
    when it tries to read from empty buffer
- With Mesa, *always use while loops* so you know about state fo sho
- Need to handle multiple producers and consumers - more direct
  signaling, not just one universal condition variable
- Producer waits on "empty", signals on "fill"; consumer does the
  opposite. So producer never wakes producer, consumer never wakes
  consumer
- *Correct* solution: allow buffer to fill up past 1 to be empty or
  full, in buffer put() and get() set the fill_ptr and use_ptr to make
  sure neither get up past the maximum you want, but otherwise, producer
  can fill up a bit more and buffer can read out until `count` reaches
  0. Cool
- Condition checking in multi-threaded programs should always use
  `while`
  - Avoids lots of bugs, such as when you get spuriously woken up. Make
    sure to check on your state whenever waking up!

#### OSTEP Ch 31: Sempahores

- Gg
- *Semaphore*: synchronization primitive that can be used instead of
  locks and condition variables
- Semaphore is an object wth an integer value that we can manipulate
  with sem_wait() and sem_post()
- Must be initialized (e.g. to 1)
- sem_wait() decrements value of semaphore by one, waits if value is
  negative
- sem_post() increments value of semaphore by one, if there are one or
  more threads waiting, wake one by e.g. signaling on condition variable
- Value of semaphore == number of waiting threads if negative
- Wait before ciritcal section, post after critical section
  - Use as locks is simple: initialize to 1. This is a *binary
    semaphore* because the only two states are held and unheld

- Can be used as condition variables
- Parent calls sem_wait(), child calls sem_post() when it's done. Cool
- Initialize to 0; will go to -1 when parent calls, wait, when child
  calls post() it will go to 0 and wake up the parent
- Even if child comes first, it will increment to 1, then parent sees
  value >= 0 when it runs so it just doesn't wait in sem_wait()_

- Bounded buffers?
- Can have separate full and empty semaphores, both used as condition
  variables
- Issue with this: no mutual exclusion! Critical section of filling
  buffer and incrementing index isn't guarded. Add a binary sempahore to
  use as lock :)
- Welp, deadlock: consumer runs, waits on full signal, producer runs,
  waits on empty signal, they're both stuck. Deadlock occurs when all
  processes are stuck in a lock at the same time
- Just change order of ops: check on binary semaphore _after_ checking
  on empty/full :)

- Reader/writer lock: writes must have an exclusive lock, but reads can
  be concurrent as long as there is no write happening
- Only a single writer can acquire the lock at a time
- _First_ reader acquires write lock too, so anyone who wants to write
  has to wait for all readers to finish
- Okay, kinda yucky, readers can starve writers
- Implement semaphores with one condition variable and one lock
- Tip: be careful when generalizing! There are subtle differences that
  will bite you in the ass, and it's rarely even needed

- Semaphores are a nice primitive for concurrency, okay

#### OSTEP Ch 32: Concurrency Bugs

- Mostly skim, come back later
- What concurrency bugs to look out for? Can divide into non-deadlock
  and deadlock
- Non-deadlock: *atomicity violation* and *order violation*

#### Lecture

- Realtime API/functionality allows you to run a block of code every N
  ms, but you will get interrupted, must finish within N ms

- C convention to capitalize functions and wrap syscalls with uniform
  error handling

- `ifndef` header guard in C programs makes sure you don't include same
  stuff twice

- When you use a lock, you claim that *everything else* outside of the
  critical section can be interleaved with no issues

- Struct with two void pointers and array with two void pointers take up
  the exact same amount of space

- `volatile` keyword tells the compiler "don't reason about this value,
  let it be"

### 7 - I/O devices, hard disks and flash based SSDs, and introduction to file systems

#### OSTEP Ch 36: I/O devices

- I/O is important. How should it be integrated into systems? What are
  the general mechanisms? How can we make them efficient?
- CPU<-> memory by memory bus. Other devices by *I/O bus*
  - Could be PCI (graphics), or lower down like SCSI, SATA, USB
  - It's a hierarchy because shorter buses are more performant
- Two parts of device: hardware interface, internal structure
  - *Firmware*: software within hardware device
- Say a device presents an interface with a status register, command
  register, and data register (to pass data to device)
- First instinct is to have the OS poll the status register to see if
  the device can receive data, but that is inefficient
  - When CPU involved with I/O directly, it's programmed *I/O*
- Duh, interrupt. Overlap computation and I/O
- Interrupt has a context switching cost; if device is responsive, maybe
  polling is ok
  - *Coalesce* by holding onto interrupts for a little bit in hopes of
    batching up multiple completed ops in one interrupt

- We hate PIO because it's costly, how do we eliminate?
- Use DMA: *Direct Memory Access*
- DMA engine is a device that facilitates memory<->device without CPU
  help
- OS just tells DMA engine address of data in memory that should be sent
  to device, and DMA carries out request, then DMA controller raises
  interrupt to tell OS that transfer is complete

- How should hardware communicate with device?
- Can used privileged hardware I/O instructions (e.g. `in`/`out`,
  specifying CPU registers with data and port)
- Also can do *memory-mapped I/O*, where OS issues load/store to
  specific address to communicate with ddevice

- How to keep OS mostly device-neutral, hiding device interaction
  details?
- *Device driver* abstraction: software that tells OS how to interact
  with device
- Device drivers make up 70% of Linux kernel! Also sometimes written by
  scrubs, cause a lot of kernel crashes
- OS code to interact with these devices just uses calls as you'd
  expect, based on the driver interface

- This chapter: interrupt and DMA for device efficiency, I/O
  instructions and memory-mapped I/O for device communication

#### OSTEP Ch 37: Hard Disk Drives

- How do hard disk drives store data? What is the interface? How is the
  data laid out and accessed? How does disk scheduling improve
  performance?

- Modern disk
- Atomic 512-byte operations. *Torn write* when you want to do a larger
  write but you die in the middle
- *Platter*: one circular hard surface on which data is stored
  persistently by inducing magnetic changes to it
- Disk can have multiple platters, each with two surfaces
- Platters bound together around *spindle*, connected to motor that
  spins it around
- RPM: platter rotations per minute
- *Track*: one of the many concentric circles on each surface
- *Disk head*: reads/writes magnetic patterns
- *Disk arm*: moves across surface to position disk head over desired
  track

- Request processing
- *Rotational delay*: how long it takes for desired sector to rotate
  under disk head
- *Seek time*: moving disk arm to the correct track :). Takes an
  acceleration, coasting, deceleration, settling
- After rotation and seek, *transfer* can happen
- Disks have caches to hold some small amt of data, ez
- Blah blah, doing some fraction simplification

- I/O time?
- Size of transfer / time transfer took = rate of I/O
- Two scenarios: random workload, sequential workload
- Order of magnitude difference. Use sequential whenever possible!

- *Disk scheduler* schedules disk operations
- Estimate seek and rotational delay, greedily pick the one that will
  take the shortest amount of time :)
- SJF (shortest job first)
- This stuff is easier to estimate on disk than job scheduling
- Want to seek as few times as possible
  - Need to avoid starvation though, where you get a steady stream of
    local requests and a request farther away never executes
- SCAN goes from inner to outer tracks in order, ez?
- Doesn't account for rotation :/
- End up at SPTF (shortest positioning time first) (also shortest access
  time first)
- Estimate seek delay and rotation delay, go to the smallest one
- Can age requests to help with starvation

- Some issues
- Merging disparate I/O  from the same origin
- How long should system wait before issuing I/O request? Wait a lil bit
  just in case you get a "better" request, or so that you can do
  *vectored* interrupts
- :thik

- Good intro to hard disk drives :)
- Outdated a bit, but need the foundation

#### OSTEP Ch 38: Redundant Arrays of Inexpensive Disks (RAIDs)

- Large, fast, reliable disk?
- RAID is super complicated
- Advantages:
  - Performance. Parallel access super fast
  - Capacity. Can store lots
  - Redundancy. Can tolerate loss :)
- *Transparency* is a darn good principle - can you add functionality
  without imposing more of a burden on your user/client?

- System issues *logical* I/O to RAID, which does some calculation and
  then does the rgiht corresponding *physical* I/O
- RAID can be thought of as a specialized computer system running
  special disk access software

- Fault model critical to understanding these things
- *Fail-stop*: disk can be working or failed. Working = do stuff, failed
  = assume permanently lost

- Properties:
- Capacity (total capacity - redundant copies)
- Reliability
- Performance (workload-dependent :/)

- Patterson/Gibson/Katz at Berkeley came up with important RAID designs
- Keep in mind *mapping problem*: how to translate logical I/O request
  to exact disk and offset in RAID
- Level 0: *striping*: stripes, 0 1 2 3, 4 5 6 7, etc. across disks
- 0 1 2 3 is a stripe there
- Chunk size is how much of one stripe is on one disk before moving to
  next one
- Level 0: perfect capacity, wacko reliability (any failure leads to
  loss), performance is great since all disks are used :)
- Some metrics: single-request latency (how long one request takes),
  steady-state throughput (total bandwidth of many concurrent requests;
  how much can you handle?)
- Same random/sequential access measurements as before
- Raid-0 has same single request latency as one disk :)
- Okay

- Level 1: Mirroring, make one extra copy of each block in system, on a
  separate disk
- Half capacity
- Decent reliability (can handle one disk failure, cool)
- Reaad latency is good, write latency is up to double since it has to write
  to two places. IRL writes are parallelized, but still have to wait for
  longer one
- *Consistent-update problem* in RAIDs: if crash in between write 1 and
  write 2 of same data, you screwed.
- To fix, use a write-ahead log that keeps track of operations you were
  about to do if you lose power at a bad time. When you recover, just
  apply those transactions
- Most of these performance metrics are intuitive :)

- Level 4: Disk with parity!
- You have a parity disk that has the xor of the stripe from all the
  other disks
- If one disk goes down, you can recover what it had by returning to the
  same xor values
- Better capacity than level 1
- But can only tolerate one disk failure
- Boring performance analysis, zzz

- Level 5: Rotating parity
- Parity block for each stripe is now rotated across the disks, in order
  to remove the parity-disk bottleneck from RAID-4
- Better random read performance
- Most of analysis is the same :)
- This is dominant now
- Cool, table of performances here

- Transform independent disks into large, more capacious, more reliable
  single entity *transparently* :) :)
- More of art than science to pick correct RAID layout and such
- Cool

#### OSTEP Appendix: Flash-based SSDs

- Pretty applicable. Solid-state storage, with no moving parts
- Retains info during power loss
- Write a *flash page* by erasing a *flash block* first; writing same
  page too often will *wear it out*
- How sway
- Hierarchy: block->page->content
- Operations: read page, erase block (must happen before writing),
  program page
- States: invalid (start), erased (after erase), valid (after
  programmed)
- Okay. Read is easy, write is harder. Must copy data we care about
  somewhere else first, and also have to deal wit wear out

- Evaluate flash
- Latency is p good; reading is superfast, programming is okay, erasing
  takes a ton of time
- More reliable than hard disk since no moving parts
- Can have disturbances when you write to one page and bits get flipped
  elsewhere. dang

- How to use this as storage?
- Flash chips for persistent storage :)
- Must provide standard block interface on top of your flash chips
- *Flash translation layer* satisfies client reads and writes and turns
  them into flash operations if need be
- Performance achieved by parallel flash chip usage
  - Reduce write amplification (total write traffic from flash chips to
    FTL / total write traffic)
- Direct mapping of logical page to physical page sucks. Tons of erases
  and writes. Wear out of hot paths is RIP
- Log structure is better
- On a logical write, write appended to next free spot in
  currently-being-written-to block (this is logging)
- Mapping table stores physical address of each logical block
- Okay, example. Think I get it. Compact stuff so you can avoid wear
  out, do as few erases as possible, avoid program disturbance
- Big improvement :)

- Garbage collection
- Get garbage when you have old versions of data around the drive (stuff
  that's been overwritten elsewhere)
- Find a block that contains one or more garbage pages
- Read live pages from that block
- Write those pages to the log
- Reclaim entire block for use in writing
- Each block needs metadata on whether or not data in page is live

- Mapping table gets big; page-based mapping is impractical. Maybe try
  with block-level FTL? Akin to having bigger page sizes in virtual
  memory :)
- Bleh, lose granularity so you need to do a copy and stuff on every
  write
- Issue when writes are smaller than physical block size. Sigh
- *Hybrid mapping*: reserve specific blocks for writing, keep a page
  mapping for those. Keep a block mapping for everything else
- Page mapping = log table, block mapping = data table
- Look at log table adn then page table when searching for a logical
  block
- Okay
- All this time, make sure to keep wear leveling in account

- Is everything flash chips? Where do you keep the other stuff
  persistently?
  - Flash chips for persistent storage, cool. Tricky part is just
    knowing that stuff can get moved around, got it
- More performant, more expensive than hard disk drives
- State of the art is a doozy

#### Lecture

- Device drivers suck :( hardest part of kernel development
- *Livelock* is opposite of deadlock: so many interrupts that you can't
  tell the machine to stop accepting them!!
- DMA: devices don't map to virtual addresses, they map to physical
  memory when the kernel boots up
- *inode*: struct that represents a file or directory object
- time updated, time created, type (file/dir)
- blocks[64], where the blocks to get this file at are from?

### 8 - File Systems

#### OSTEP Ch 39: File Systems: Introduction

- How should the OS manage a persistent device? What are the APIs?

- *File*: linear array of bytes, each of which can be read or written
  - Has a low-level name (number of some kind): its *inode number*
  - FS doesn't know what type of file, it just stores the bytes
- *Directory*: contents are a list of <user name, inode name> pairs
  - Has an inode number of its own
  - Each entry refers to a file or other dir
  - Results in directory tree
- *Root directory* is start of the hierarchy on Unix
  - Separator like "/" names subdirectories until desired subdir or file
    is named
- Naming is hard!! Everything on Unix can be named on file system, which
  is a handy abstraction

- File system ops
- `open()` to create or open file. Returns a *file descriptor*
  - A private per-process integer used to access files. It's an opaque
    handle giving you power to perform certain operations
  - 0 is stdin, 1 is stdout, 2 is stderr, so the first open() gives you
    3
- `strace` handy! Checks system calls made by program while it runs
- `lseek` to move the *file offset* to a specific place. Doesn't
  actually move disk head! Just changes value in software
- `fsync` persists writes that are in-flight, :zzz:
- `rename` is _atomic_ op to rename a file
- `stat <file>` gives you info about file
- `unlink` to remove a file. Why "unlink"?
  - Opposite of `link` which creates another way to refer to same file.
    Remove yourself from list of links from that file == "delete". File
    deleted when *reference count* becomes 0, sigh
- *Symbolic link* different from hard link
  - Has pathname of linked-to file as data of symlink file
  - If original file removed, you have a *dangling reference*, oops
- Finally, `mount` takes existing dir as a target *mount point* and
  pastes a new file system into directory tree at that point. Many diff
  file systems on your system!

- Then directory stuff

#### OSTEP Ch 40: File Systems: Implementation

- How can we build a simple file system? What structures are needed on
  disk? What do they need to track? How are they accessed?

- Mental models of filesystems
- *Data structures*: what types of on-disk structures are utilized by
  the file system to organize data and metadata?
- *Access methods*: how does it map calls made by process
  (open/read/write) onto its structures? What data structures do you
  read/write from to make this stuff happen?

- Start FS by dividing disk into 4kb blocks
- *Data region* is blocks for actual stuff, majority of our space should
  be for this
- *Inode table* stores all of our inodes
  - Inode table size limits # of files you can have on disk!
  - Inode short for *index node*
- Need a *free list* or *bitmap* to track free space in inode table/data
  region
  - Bitmap: each bit is 1 or 0 to indicate whether block at that index
    is free or nah
- Finally, *superblock* has metadata about FS; # of inodes, # of data
  blocks, where inode table lives, etc.
  - OS reads this when first mounting a filesystem

- Index into inode table to find your inode, then you can jump to place
  on disk where your file lives!
  - Bunch of data on the inode - permissions, size, owner, etc.
- Can have *direct pointer* from inode to location on disk
- Say you have 12 direct pointers and run out - keep one *indirect
  pointer* that points to a separate block that contains many more
  pointers which point to user data. Indirection hooray
  - Can also do an extent (pointer+length), but whatever
  - Also you can nest all of these pointers, of course...
- Why this design? Most files are small, so can be covered by the direct
  pointers :)

- Directories! Store info about each child file/dir
  - inode number, record length (length of name + padding), string length
    (actual length of name), and name itself
- Stored in the same way as files! Inode has direct pointer to space on
  block for dir

- Free space management is a doozy as usual. Our bitmap works for simple
  filesystem though. Could get fancy with B tree

- Now let's consider access methods
- Data structures to be touched for reading /foo/bar:
  - Data bitmap
  - inode bitmap
  - Root inode
  - Foo inode
  - Bar inode
  - Root data
  - foo data
  - bar data[0]
  - bar data[1]
  - bar data[2]
- File read timeline is straightforward
- Write to the /foo/bar inode with the last access time whenever you
  continue your read
- Allocation structures only accessed for allocations (writes, creates),
  not reads

- As you can tell, this is a LOT of I/O :| how fix?
- Keep a fixed-size LRU cache in memory for frequently accessed files
  and such
- Can use *write buffering* to batch up writes close together, wait to
  see if maybe file gets deleted so no write needed, etc.
- *Durability/Performance tradeoff*: think of the types of applications
  you are servicing, and make the pragmatic decision. E.g. databases
  need durability
- Cool beans, this is filesystems!

#### OSTEP Ch 41: Locality and the Fast File System

- First file system as outlined last chapter was slow, got slower as
  disk filled up, treated disk like it was RAM (BAD!), got fragmented :/

- How do you organize file system data structures to improve
  performance? What type of allocation policies should live on top of
  those data structures? How do we make the file system "disk aware"?

- First pass: FFS (Fast File System)
- Keep same interface, but with different implementation
- Divide disk into *block groups* or *cylinder groups*, basically for
  spacial locality of data on disk
- In each group, keep a supernode, inode bitmap, data bitmap, inodes,
  and data!
- Aside: file creation is a lot of work! Need to update data bitmap,
  data block, directory, inode of directory, whew
- *Keep related stuff together*
  - dirs: balance across groups by finding a group with low # of dirs
  - files: allocate data blocks of file in same group as its inode, put
    all files in same directory in the same group as their directory.
    Cool
- These aren't research heuristics :) they are simply based on *common
  sense*: files in same dir are often accessed together
- *Large file exception*: instead of filling all space in one group with
  large file, spread across multiple groups.
  - Performance hit :/ but try to make the cost of moving b/t groups
    *amortized*; if you spend most of your time transferring data from
    disk (since it's a large file), cost of seeking is amortized
- For small files: use a set of 512B sub-blocks, allocate those, when
  you allocate a 4kb page worth of sub-blocks, copy to a new location
  and free the sub-blocks :). Can also buffer small file writes. Cool
- Lesson for all CS: FFS was *usable*, included several nicety features
  that can't necessarily be researched (symlinks, long file names,
  atomic rename), which drove adoption

- FFS was a big step. Major takeaway: *treat the disk like it's a disk*

#### OSTEP Ch 42: Crash Consistency: FSCK and Journaling

- System may crash/lose power between writes, leaving on-disk state
  partially updated. Given that crashes occur at arbitrary points in
  time, how do we ensure that the file system keeps the on-disk image in
  a reasonable state?

- Take one write. Must write to the inode, the bitmap, and the data
  block. At minimum
- When can you crash?
  - Just data block written todisk
  - Just inode written to disk
  - Just updated bitmap is written to disk
  - Any combination of two of these
  - Sigh
- *Crash consistency problem*: How can you make this write *atomic*,
  even though disk only commits one write at a time?

- Naive/early: `fsck` (File system checker). Run before file system is
  mounted/made accessible
  - Sanity check superblock. If bad, maybe use a copy
  - Check free blocks - if inodes/bitmaps inconsistent, trust the inodes
  - Check inode state - valid enums, etc. Suspect inodes cleared
  - Check inode link count by building its own link count map and
    comparing to values in inodes
  - Check duplicate inodes pointing to same block. Can copy or clear
  - zzzzz
- Doesn't scale well. Also inefficient - basically,
  search-the-entire-house-for-keys instead of doing a smarter search

- *Write-ahead logging*, called *journaling* in file systems. We've seem
  this before :)
- When updating disk, before overwriting structures, write a log entry
  describing what you're about to do
- If crash during update, go back and look at node and see exactly what
  needs fixing and how to fix it
- Tradeoff: adds work during updates to reduce work during recoveries
- Each entry is associated with a *transaction identifier*. Naive
  approach is to have each log entry keep the exact contents of blocks
  (*physical logging*) that you are updating
- *Checkpointing* is looking at the log and applying the actions. If all
  actions complete, you've successfully checkpointed and are basically
  done. So the two steps are *journal write* and *checkpoint*
- What if you crash when writing to journal?
  - First, write everything except TxnEnd block to journal
  - When the writes complete, write the TxnE block
  - If you see that there's no TxnE block, you know that the journal
    write was incomplete
  - This *journal commit* step is b/t journal write and checkpoint

- Simple recovery: *redo logging*, just replay all the things in the
  log. A few redundant writes don't hurt, since you don't do this often
  (hopefully)
- Buffering helps avoid excessive write traffic again - if you have two
  close-by file creates, can batch them into one transaction :)

- What do about journal size?
- Similar to a *ring buffer*, make it circular by just keeping a pointer
  to the first non-garbage transaction :)
- After checkpointing, mark the transaction free in the journal by
  updating the journal superblock
- What about cost of *data journaling*, basically dual writing
  everything?
  - Try *metdata journaling* instead (this is more common!)
  - Journal only keeps inode and block info, do the _data write_ before
    you do anything to the journal. Ensure pointer never points to
    garbage
- Tricky corner case: if you reuse a block in your log that used to be a
  dir but is now a file, your metadata log contains info about writing
  dir info but not user data (since dir info considered metadat). If you
  add a *revoke* entry to your log, recovery will look for all entries
  that have been revoked and not apply them

- Lots of other approaches to this problem! Cool beans ig

- If you don't wanna write "COMMIT", you can write a checksum of the
  journal entry contents at the beginning and end of the entry instead.
  Saves one step

#### OSTEP Ch 43: Log-structured File Systems

- New file system. Why?
  - System memory growing, more space for cache
  - Large gap between random and sequential I/O is felt more
  - Existing FS perform poorly on common workloads; simple write takes a
    lot of I/O
  - FS aren't RAID-aware; to do small amount of parity writing, yucky
    amount of I/O takes place
- *Log-structured file system*: buffer all updates in an in-memory
  *segment*; when segment is full, it is written to disk in one long,
  sequential transfer to unused part of disk
  - Always to a free location
  - Large segment = efficient disk use

- How can a file system transofrm all writes into sequential writes?
  Can't do this for reads since you don't decide, but can control for
  writes!
- Basically, instead of writing inodes and data in separate places,
  write it all in a row
- *Write buffering*: LFS keeps track of updates in memory before writing
  to disk. When it has enough stuff, it writes the entire segment at
  once, which is efficient

- How much to buffer?
  - Every time you write, you pay a fixed overhead of positioning cost.
    Need to make write big enough to amortize that cost. Wait too long
    though, and you may be screwed

- How do you find an inode? Use *inode map* (imap). Take inode number as
  input and produces disk address of most recent version of inode
- Imap is also written sequentially!! How tho **ask**
- Now how to find these disparate imap locations? With the disk's
  (fixed) *checkpoint region*
  - Pointers to latest pieces of inode map so you can start to find your
    way around
  - Only update this every 30 seconds or so
  - Can be read into memory first, following checkpoint region all the
    way down
- Directory structure basically identical to other FS - <name, inode
  number> pairings
- To access /tiger/foo, first look up location of tiger dir in imap,
  readthe dir inode, which gives you location of dir data, which gives
  you mapping of name to inode number, then look up the inode for foo,
  once you find it you can get to foo. Cool
- *Recursive update problem*: happens if FS doesn't update in place, but
  rather moves to a new spot
  - When inode updated, location on disk changes, which changes the dir
    pointing to that file, which causes changes all the way up the tree
  - To solve: rather than updating the dir itself, update the imap
    structure to point to new location:)

- Garbage collection? Old versions are hanging around because you only
  write new versions of files
  - Done by *compacting* M existing segments (with mixed live and dead
    data) into a smaller number N new segments with just the live data.
    Can then clean all of M
- Use *segment summary block* at head of segment describing inode number
  and offset of each data block in the segment. Look up inode of file
  from imap, if the offset in your segment matches the data that is in
  the imap, you know your data is live

- Recovery?
- Crash during CR write: a) keep two copies of CR, one at each end of
  file system, for atomicity. b) When writing to CR, write a header with
  timestamp, then update, then a footer with timestamp - if header
  present but not footer, you don't have a complete picture
- Lose stuff since last checkpoint though? Not quite. Try a *roll
  forward* using log stored in the CR, try to apply any of the changes
  you can

- This *copy-on-write* approach enables highly efficient writing :)

#### OSTEP Ch 44: Data Integrity and Protection

- Basically, new storage mechanisms open up new types of faults, and we
  need to come up with new solutions

#### xv6 ch 6:

#### Lecture:

- Really great problem solving here by journaling, folks
- Everything hinges on *commit* keyword

### 9 - Review

#### Lecture

##### Gary Bernhardt - The Birth and Death of JavaScript

- https://www.destroyallsoftware.com/talks/the-birth-and-death-of-javascript
- JavaScript sucked in the beginning
- Yikes, at first you get a ton of weeeeeeeird language stuff
- Then ASM.js which allows you to get native integer adds and stuff, if
  you type annotate your code (i.e. x|0 (bitwise or) casts to integer)
  finally in JavaScript
  - An extraordinarily optimizable, low-level subset of JavaScript. NOt
    bad. Helps run games and terminals in browser
  - C programs can compile to asmjs

- Digression: how computers actually work
- Virtual Memory: ez
- Protection: Ring 3 protection (userland, can't manipulate physical
  memory and stuff)
  - Kernel runs in Ring 0, which has these permissions
- Function calls - jump around in instruction pointer
- Finally, syscalls
  - Userland pushes registers, firest interrupt
  - Kernel traps interrupt, switch to ring 0, switch Virtual Memory
    Table, jump to syscall code
    - Context switch is overhead
    - If you compile to JS, you can have your VM in the kernel and no
      context switches plz

- ASM goes through VM still -20%; on metal, you get 20% performance gain
- His definition of metal: Kernel + asm.js + DOM at native speed

##### Booting Up

- Press power button, current flows, detect RAM
  - No RAM? Gotta do some beeps, cause can't display anything without
    RAM
- Load program from BIOS into RAM and run (512kb)
  - Basic Input/Output Sytem (Read-only memory)
  - Checks for connected devices
  - Comes with computer
- Look for boot sector - this is on desk
  - _Contains_ boot loader (512 bytes)
  - Must find one on one of the disks
  - Pick a kernel to boot up into
- Kernel is loaded
  - Climb to long mode (go up from 16 bit instructions to 64)
  - Configure CPU
    - Interrupt handlers - syscall, etc.
    - How often to do a timer interrupt. Can have multiple!
    - Configure page table
    - Configure protection rings
  - Configure other hardware
  - Load kernel threads into schedule table
  - Load process 0
  - Execute process 0
    - Start daemon processes (will run forever) in dependency order
  -
- Check out Mozilla OS Guide?

### Extras

- Inode has id, type, blocks, permissions, times (modified, created),
  nlinks, size
