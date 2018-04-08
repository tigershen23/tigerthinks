---
layout: course_post
title: 'Computer Architecture and the Hardware/Software Interface'
date: 2017-03-26 00:00
categories:
tags: [course, technical, programming, architecture, cs, bradfield]
author: Bradfield
rating: 5
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/architecture/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's architecture class"
---

## Notes

Everything is bits!!

### 1: The Big Picture

concepts that map to one instruction fall on the "hardware" side of the
hardware/software boundary
arithmetic: signed/unsigned additon, subtraction, multiplication,
division
bitwize operations: and, or, xor etc
read/write (load/store) of register values (words) to/from main memory
cpu makers continue to add new low level instructions to their hardware:
<!--https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets#BMI2_.28Bit_Manipulation_Instruction_Set_2.29-->
concepts that decompose into many carefully arranged instructions fall
on the "software" side
objects, arrays, methods, subroutines, functions

Jon Carmack has a good heuristic for how much stuff a CPU supports doing
natively hardware: how long would it take you to write an emulator for
it in software? Another good heuristic is to weigh the size of the
manuals :)

binary encoding

the contents of registers, main memory, files (and the disk in general)
is always bit patterns. or put another way: nothing isn't a bit pattern
the bit patterns only "mean" something in some context
a good example here is that output byte stream of the shell is hooked up
to the terminal, which is always interpreting bytes as teleprinter
instructions
so if some program is not generating binary data that corresponds to
values in the ascii table, and you feed that programs output to a
terminal (which is expecting bytes that do) you will get nonsense
(question marks, blanks, maybe the bell will ring)

the nybble to bit pattern table

```
----  : 0       0000 = 00
---+  : 1       0001 = 01
--+-  : 2       0010 = 02
--++  : 3       0011 = 03
-+--  : 4       0100 = 04
-+-+  : 5       0101 = 05
-++-  : 6       0110 = 06
-+++  : 7       0111 = 07
+---  : 8       1000 = 08
+--+  : 9       1001 = 09
+-+-  : a       1010 = 10
+-++  : b       1011 = 11
++--  : c       1100 = 12
++-+  : d       1101 = 13
+++-  : e       1110 = 14
++++  : f       1111 = 15
```

some programs related to last night's exercises

plain linear bitdump. we're basically asking for no formatting, just the
raw bitstream

```
ruby -e '
  puts(            # print argument bytes to stdout, followed by newline
byte
   ARGF            # file/stdin stream
    .read          # byte contents of stream (as ruby string type)
    .unpack("B*")  # convert bytes of string to binary string
representations
  )
  ' <<< 'hello world' # feed ascii bytes for hello world (plus newline)
as input on stdin
011010000110010101101100011011000110111100100000011101110110111101110010011011000110010000001010
```

obviously that's very hard for our wetware to interpret which is why we
hexdump

```
$ cat > hexdump.rb <<<'                 # save string in single quotes
to hexdump.rb
  ARGF.each_byte
    .map{|b|b.to_s(16).rjust(2,"0")}    # byte as hex digits
    .each.with_index                    # include indexes
    .each_slice(4)                      # groups of 4
    .each{|s| send :puts,               # print line with:
      s[0][1].to_s.rjust(6) +           #  first byte index, padded
      "  " +                            #  two spaces
      s.map{|b,_|b}.join(" ")           #  bytes, joined with spaces
    }
  ' && ruby hexdump.rb <<< 'hello world'
     0  68 65 6c 6c               <- bytes at index zero
     4  6f 20 77 6f               <- bytes starting at index 4
     8  72 6c 64 0a               <- bytes starting at index 8
```

and while we're trying to memorize those nybble to bit pattern
correspondences it's useful to bitdump

```
cat > bitdump.rb <<<
  ARGF.each_byte
    .map{|b|
      b.to_s(2).rjust(8,"0")          # eight ones and zeros
       .gsub("1","+").gsub("0","-")   # convert to +/-
    }
    .each.with_index                  # indexes
    .each_slice(4)                    # groups of 4
    .each{|s| send :puts,             # print line with
      s[0][1].to_s.rjust(6) +         #  byte index
      "  " +                          #  two spaces
      s.map{|b,_|b}.join(" ")         #  bytes separated with spaces
    }
 && ruby bitdump.rb x
     0  -++-+--- -++--+-+ -++-++-- -++-++--
     4  -++-++++ --+----- -+++-+++ -++-++++
     8  -+++--+- -++-++-- -++--+-- ----+-+-
```


hexload is useful for feeding raw bytes that don't correspond to any
keys on the keyboard straight into the terminal

```
$ cat > hexload.rb <<< 
print ARGF.read         # read contents of input file to string
  .split(/\s/)          # split on whitespace
  .map{|s|s.to_i(16)}   # convert from hex strings to ints
  .pack("C\*")           # convert int array into ascii string

$ ruby hexload.rb <<< '68 65 6c 6c 6f 20 77 6f 72 6c 64 0a'
hello world
```

remember, you can get to the ascii table with man ascii

test your twos-compliment conversion skills online:
http://www.free-test-online.com/binary/two_complement.htm

endianess
remember "LLL" (triple L):
IF the byte with the (L)owest index (i.e. the "(L)eftmost")
is the (L)east significant byte
THEN the byte order is (L)ittle endian
otherwise it must be big endian

you can't tell endianness by looking at just the bytes, someone has to
say "these 4 bytes 50 d6 12 00 encode the number 1234512 and then you
can say "oh it's little endian"

### 2: Overview of C (jk)

- Bit fields are sets of bits where each position means something
  - Why would you condense stuff into bit fields? Because _MEMORY ACCESS
    IS THE MOST EXPENSIVE THING A CPU CAN DO_ and you'd reduce how often
    this happens
- 6 bitwise ops
  - XOR NOT AND OR SLL (shift left logical) SRL (shift right logical)
- Floats are crazy
  - Bit field with 1 sign bit, a set of exponent bits, and an unsigned
    part
  - Arithmetic gets crazy since floats are crazy
  - Implemented by multiplying the unsigned by the exponent (which is
    two's complement so can be negative) and then applying the sign bit
  - Better to use decimals that don't repeat by default instead of
    floats by default
- Unicode! Because ASCII always had a leading 0 and didn't have enough
  space for all the characters (only 255)
  - Good thing they did is assign every character (not just English
    letters) a code. UNICODE IS A CHARACTER SET UTF-8 IS A SET OF BYTE
    ENCODINGS FOR THOSE CHARACTERS
  - Bad thing they did is come up with a new 2 byte encoding.. 2 bytes =
    64,000 possibilities. Not enough!
  - Still use Unicode mapping of characters to numbers, but for byte
    encoding we use UTF-8
  - UTF-8 pattern: if starts with 110, then follows ONE AND ONLY ONE
    byte that MUST start with 10. If starts with 1110, then two bytes
    follow that start with 10
- To print out a binary file: use `strings a.out`
- `xxd` hexdumps a file
  - "magic number" at the beginning of every binary file signifies the
    file/encoding type
  - Bunch of shit at the top of the file, meant for the kernel. Mach-O
    headers, then load commands (instructions for kernel to prep for the
    program)

### 3: MIPS

- Stored programs are _separate_ from the memory. Not in use rn rly,
  most stuff is loaded from disk into memory
- When your program runs the OS allocates space for ya
- CPU and OS collaborate on how to organize memory
- Segments of memory
  - Stack: contains stuff like function calls, local variables, etc.
  - Text (contains the contents of the running program. Most OS's don't
    let you write here)
  - Data (global constant, declare data)
  - Kernel (stuff that the program/OS can interact with close to metal)
  - I/O: constant
  - Heap: Grows as you ask the OS for more memory. How big is you heap?
    As big as you've asked for as your program is running
    - Heap grows down
    - `malloc` adds heap memory, `free` removes heap memory
- Jumps are short (relative bytes) or long (specific address)
- Special pointers
  - Stack pointer is end of stack (stack grows up)
  - Instruction pointer is next instruction (usually in text but can go
    to heap)
  - Global pointer before data segment
  - Heap pointer pointer to next spot you can add more heap to
- MIPS is big endian
- Instruction set
  - add/sub/div
  - jump
  - load/store
  - and/or/shift
- You can copy by adding to 0b00000000
  - In MIPS r0 is 0
- RISC vs CISC: reduced vs complex instruction sets
- MIPS command
  - First 5 bits is the op code (only 32 ops!)
  - Register command, immediate command, jump command have different stuff
  following op code

#### Berkeley Lecture Videos

- https://www.youtube.com/watch?v=zUYCZYKaUrk
- *Instructions* are primtive ops CPU may execute
- Early on, adding more instructions to instruction set. Helps with
  vendor lock-in
  - Led to RISC to address bloated CPUs; keep instruction set small and
    make it fast
  - Leave it up to software to do complicated ops
  - MIPS is the company that built a commercial RISC architecture
- "Variables" in assembly are registers
  - Supah fast (< 1ns access)
- 32 registers because of goldilocks cool
  - Each 32-bit register is a *word*
  - Each register got a name, use names!
- *Immediates* are numerical constants :) 1, 20, 30, 1512, etc.
  - `addi` to add immediate
  - $zero gets its own register
- Overflows yikes
  - addu, subu, etc. do not detect overflow
  - add, addi, sub, subi, etc. do detect overflow
- Store extra data in memory
  - Memory addresses are in bytes
  - Always fetch a whole word from memory (lw is load word)
  - Before parens is the offset; in an array, `lw $t0, 12($s3)` gets
    index 3 (12 is 4 * 3 which offsets you by 3 indices)
- lb "sign-extends" a byte by putting the index 7 bit in the rest ofthe
  empty space. lbu does not sign-extend
- Registers are 100-500 times faster than memory
- Shift right arithmetic (sra) preserves sign to be shifted (fills in 1s
  to the left side)
- Branching for conditionals in MIPS: `beq register1, register2, label`
  - Unconditional branch is a jump (`j`)
- Computer words are instructions, vocabulary is instruction set
- Assembly code is assembled into object files, which are "linked" to
  machine code executable files
- VMM (virtual memory manager) built into CPU for managing virtual
  memory space efficiently
- To branch on equality, use bne and go to Exit label if u dead
- slt reg1, reg2, reg3
  - Set Less Than
  - reg2 < reg3 ? reg1 = 1 : reg1 = 0
  - slti uses immediate
- Fundamental steps in calling a function
  - These all happen in high level programs but we don't think about
    them as much
  - Put paramteres where function can access them
  - Transfer control to function
  - Acquire resources needed for function
  - Perform task of function
  - Put result somewhere calling code can find it, restore stack
    registers
  - Return control to point of origin (jump back)
- In MIPS:
  - $a\* registers are for arguments
  - $v\* registers are for value registers to return
  - $ra is return address to hop back to
- `jal` is to jump and link!
- So, caller puts params in registers $a0-$a3 then uses jal X to invoke
  X
  - jal puts the _address of the next instruction_ into $ra
- To save old register values after function call ($s\* registers), you
  gotta save those somewhere and restore after
  - Use a stack!
  - Grow from high to low address; so push decrements $sp (stack
    pointer), pop increments it
  - MIPS only tells you to save $s0 to $s7
    - use sw to store stuff in the stack before your function, then lw
      to bring them back after

### 4: Compiling, Linking, Assembling, Loading

#### Pre-work

- https://www.youtube.com/watch?v=Z4r9AWu8D18
- Translate vs. interpret
  - High-level languages are interpreted, which means they are executed
    by another program
  - Low level languages are translated into an intermediate step
  - Interpreting 10-100x slower
- C is compiled :). Let's compile foo.c
  - foo.c
  - Through compiler
  - Assembly program: foo.s
  - Through assembler
  - Object (mach lang module): foo.o
  - Linker
  - Executable (mach lang program): a.out
  - Loader
  - Come to memory papa
- Compiler
  - Input is C code, output is assembly code
  - Might produce pseudoinstructions like `move` (add 0 and copy)
- Assembler
  - Input is assembly language
  - Output is object code
  - Reads and uses directives (.text, .data, .asciiz, etc.)
  - Expand pseudoinstructions
    - E.g. no subu, so do addiu with negative value
    - Multiplication: m x n = m + n bits product
      - Result goes into hi and lo; hi is the upper half, lo is the
        lower half
  - Produce machine language
    - Wat do
    - Simple case is just arithmetic, shifts, logic, etc. Easy
    - Branches tough :( Relative to where your pc is
      - Where is the label you want to jump to? Solved by taking two
        passes over the program, once to remember position and other
        using those label positions to generate code
  - Object file
    - object file header: size and position of other stuff in file
    - text segment: machine code
    - data segment: binary static data
    - relocation info: identifies lines of code to be fixed up (i.e.
      include directive)
    - symbol table: list of labels and static data references
    - debugging info
    - Standard format is ELF
- Linker
  - Combines a ton of .o files to make one a.out file
  - Input is .o files
  - Output is executable code
  - Combines several files into a single executable
    - Enables separate compilation of stuff, so you can change and
      recompile one file without doing the whole project
  - Takes the text/data/info from multiple o files and then sticks them
    together interleaved with each other
    - Resolves references in files. Go thru Relocation Table, look at
      each entry, and repace with absolute address
      - PC-relative address (beq, bne) never relocated
      - Absolute Function address (j, jal), External Function reference
        (jal), Static Data reference (lui, ori) always relocated
  - We assume the first word of first text segment is at 0x04000000
    (stuff below is reserved)
  - We know how long each text and data segment is, and how they are
    ordered
  - So we calculate the absolute address of each label and each piece of
    data being referenced after concatting
  - Resolve references:
    - Search for reference in symbol tables
    - if not there, search lib files
    - Finally, fill in correct machine code
  - Final output is machine executable file with header
- Loader
  - Takes executable code and runs it
  - Executable code is on disk, loader needs to load into memory and run
  - Read header to see how big file is
  - Assign amount of memory for each piece - text, data, stack
  - Copies instruction and data into address space
  - Copies arguments onto stack
  - Initializes machine registers to be usado
  - Jumps to start-up routine that copies program's arguments from stack
    to registers and sets the program counter
- This naive approach is statically-linked. We bring in the entire
  <stdio> library even if not all is used
  - Alternative is dynamically linking, which is common oon UNIX and
    stuff

#### Building Mach O executable

- https://www.mikeash.com/pyblog/friday-qa-2012-11-30-lets-build-a-mach-o-executable.html
- PAGEZERO load command blocks off lower 4GB of memory space, so that
  dereferencing NULL pointers causes a segmentation fault
  - What means? This is the \_\_PAGEZERO segment, which predefines the
    entire lower 4GB of the 64-bit virtual memory space as inaccessible.
    Because of this segment, which is marked unreadable, unwriteable, and
    nonexecutable, dereferencing NULL pointers causes an immediate
    segmentation fault.
- Load Commands - it’s kind of a table of contents, that describes
  position of segments, symbol table, dynamic symbol table etc. Each
load command includes a meta-information, such as type of command, its
name, position in a binary and so on.

#### Lecture

- Compiling a C file goes a long ways...
	- `cc` is just a frontend for clang and ld (linker)
- See compiling\_step\_by\_step.sh for deets

### 5: The Processor, Clock, and Datapath

#### Prework video

- https://www.youtube.com/watch?v=OOBwKAXZjlk
- Don't need much to run software in hardware!
- Take physical device and run programs on it? How?
- Let's do adder/subtractor
- Start with truth table, minimize and implement as we've seen before
  - Solve the subproblem! Add 1 bit before thinking about 32 bit
- Ok so let's think about instructions for adding 1 bit 3 times
  - Sum of three bits is XOR(a, b, c) (with three inputs, odd number of
    1s is a 1, even number of 1s is a 0)
  - The carry is MAJ(a, b, c) which is a&b + a&c + b&c (the sum of
    these)
- N 1-bit adders => 1 N-bit adder
- But you need to worry about overflow
  - If last carry bit is 1, you have overflow
- To do subtractor, take first number and add to negative of second
  number
  - Negative done by two's complement
  - Add another bit input to adder to designate whether second input
    should be flipped
  - AN XOR SERVES AS A CONDITIONAL INVERTER CAUSE YOU CAN INVERT EACH
    BIT
  - THEN TAKE THE SUM AND SUBTRACT ONE AND YOU'RE GUCCI
- Components
- Processor has a control and a datapath
  - Control tells datapath what to do (what registers to read, which
    operation to perform)
  - Datapath includes PC, Registers, ALU
- Processor connects to memory
- Memory connects to I/O
- So there's two boundaries: processor-memory interface and memory-I/O
  interface
- CPU
  - Processor is the CPU, active part of the computer that does the work
    - Datapath contains hardware to perform operations
    - Control: tells the datapath what needs to be done (brains)
- How to execute instruction?
  - Fetch: fetch the 32-bit instruction word from memory, returns them in the
    control unit, and then increment program counter
  - Decode: look at 32-bit instruction and figure out what it means.
    - First thing is obviously the opcode.
    - Then, read data from necessary registers (2 for add, 0 for jump)
  - ALU: do work like arithmetic, shift, logic. Also needs to be done
    for lw and sw to add the offset to the address
  - Memory access: only loads and stores do stuff here. Should be fast
    - To store, need to read a) base address, b) data value to store, c)
      immediate offset
  - Register write: write result back to register
    - For store instruction that writes to memory, work has been done in
      last stage
  - Many instructions don't use all stages!
- Lecturer walks through these steps, makes sense
- Immediate values come out of instruction memory
- Not all instructions use all stages, but for MIPS at least it's the
  union of all the operations needed by all instructions
  - Load instruction uses all 5 :)
- Datapath and control bois
  - Datapath->control feedback is from instruction memory
  - Controller makes sure right things happen at right time, can hook
    into all parts of datapath
- Processor design
  - Analyze instruction set to determine datapath requirements. Must
    support everything!
  - Select set of datapath components and establish clocking. Things
    happen on the rising edge
  - Assemble datapath components
  - Analyze implementation of instructions and set up control points
  - Assemble control logic (formulate equations, design circuits)
- 3 types of MIPS instructions
  - R type has op, register s, register t, register destination, shamt (shift
    amount), funct
    (add, subtract, etc.)
  - I type has op, register source, register taret, immediate
  - J type has op code then target address
- Register Transfer Langauge is a way of writing down what happens
  during execution of each instruction
  - Pseudocode ish. For ADDU instruction, RTL is like this: R[rd] <--
    R[rs] + R[rt]; PC <-- PC + 4
  - All instructions start by fetching instruction itself
- Requirements of instruction set for our MIPS light: stuff like MEM,
  Registers, PC, sign extender, ALU, PC incrementer, etc.
- So now for our components. Need combinatorial elements (don't respond
  to clock) and storage/sequential elements (respond to clock)
- Describes his class's architecture cool
- Clock stuff
  - "Critical path" (longest path through logic) determines the length
    of the clock period
  - Art of hardware design is moving clock edges closer together,
    shortening critical path
- State machine that reads the instruction, updates state, then awaits
  next instruction. Cool

#### Lecture

- Hertz is number of switches per second
- Clock cycle
  - Starts with rising edge with high current, then it has a down edge
    with lower current, then back to rising edge, ez
- To get faster, reduce critical path speed OR add flip flops/registers
  in the middle to save work
- All digital systems with time:
  - Current state sent from stateful part to combinatorial logic along
    with static inputs
  - Combinatorial logic does work and emits outputs, and next state is
    sent to the clocked chip
  - "Next state" from previous step is the state passed in during the
    next clock cycle
- C Pro Tip
  - Read `char *argv[]`. WHEN you invoke \*argv, you get the other part
    of the expression, which is `char[]`

### 6: Using Logic Gates to Build Logic Gates

#### Prework video

- https://www.youtube.com/watch?v=SstCrz0xUzw
- Why study hardware even if you don't work on hardware? Want to
  understand capabilities and limitations so you can utilize hardware
  effectively
- Basics of a computer system is a _synchronous digital system_
  - Synchronous: all operations coordinated by central clock
  - Digital: all values are discrete value (analog = voltage, etc.)
    - Binary (0, 1). Electrical signals are 1 and 0 (high and low
      voltage)
- Implement a circuit/switch
  - If you close a switch and complete a loop, then current flows and
    lightbulb can be on
  - Boolean logic based on Boole lol
- Transistors used to represent high/low voltage (they're the switches
  in computers)
  - Remove noise by setting a midpoint voltage; above is 1, below is 0
  - CMOS is ours: Complementary Metal Oxide on Semiconductor
- n-type transistor is open when no voltage, closed when voltage. p-type
  is opposite
  - Basically you can use complementary pairs to get strong signals
- https://gyazo.com/2cc4aaf3f68f6495f7646d6200068cd7
- NAND!
- Some combinatorial logic symbols are standard zzz
- Truth tables describe the inputs and outputs of a circuit
- Simplifying boolean logic is an art form rofl
- Boolean Algebra
  - + for OR (logical sum)
  - dot for AND (logical product)
  - Hat for NOT (complement/negation)
- Bunch of laws of boolean algebra
- Signals and waveform stuff
  - Can look across separate wires to aggregate a signal
- Propagation delay is difference between changing input and changing
  output

- Synchronous digital systems help abstract time/delays
  - Come with two types of circuits
  - Combinatorial logic: output is a pure function of the inputs,
    doesn't have history of execution
  - Sequential logic: circuits that remember or store information
    across time. Clocks synchronize systems!
- Slides are helpful
- https://gyazo.com/738b402a3fef46496bdfd7c8acc3fed6

#### Lecture

- Flip flop circuits are like camera shutters: open, snapshot, emit,
  close, etc

- CLOCKS ARE IMPORTANT. THEY MAKE EVERYTHING GO
- SIMD: Single Instruction Multiple Data
  - Can load 4 32-bit ints into a 128-bit register, then can do four
    adds in parallel

- Think about flow of electricity to model voltage in circuits

- How is NAND implemented in electric circuits?

### 7: Pipelining

#### Video

- https://www.youtube.com/watch?v=oIawE3IseRA
- Single Cycle processor review
  - See "processor design" segment
  - End up with cool datapath
  - Performance: for every instruction, need to wait until worst case
    time for worst instruction. Clock rate (cycles/second = Hz) =
    1/period (seconds/cycle)
- Pipeline increases clock rate over worst case performance
  - Increased clock rate means faster programs hopefully
- Can overlap the stages of stuff to make it more efficient
  - Analogy is laundry (washer, dryer, folder, stasher). Sequentially
    takes two hours, but if you do batches with pipelining you get more
    efficient. After first load is washed, you load it into the dryer
    and immediately add second load to washer
- Pipelining does _not_ help latency of single task, it helps
  _throughput_ of entire workload
- _Multiple_ tasks operating simultaneously using different resources
- Potential speedup = the number of pipe-able stages
- Time to "fill" pipeline and time to "drain" it reduces the speedup :)
- Pipeline limited by slowest pipeline stage (still better than being
  limited by the slowest entire instruction, which you are without
  pipelining)
  - Try to balance lengths of pipe stages
- Apply pipeline to MIPS assembly
  - Just add registers between stages (fetch, decode, execute, memory,
    write back)
  - These registers hold information produced by previous cycle
- Need to keep a copy of instruction bits and move them down the
  pipeline so each piece knows exactly what to do with that instruction
- Several ways to represent pipeline (graphical, etc)

- Pipelining performance
- Best case is Time of single cycle / number of stages (equality is only
  achieved if stages are balanced)
- Speedup reduced if not equally balanced
- Remember, pipelining increases throughput not latency
- Pipelining increases instruction latency (must match longest
  instruction latency), does not increase number of
  components

- Pipelining hazards precent starting the next instruction in next clock
  cycle
- Structural hazard: required resource is busy (e.g. needed in multiple
  stages)
  - e.g. Multiple registers need to be write/read simultaneously
  - Easy-ish to solve
  - Keep separate caches for instruction fetch and memory RW
  - Split RegisterFile access in two: write during 1st half and read
    during 2nd half of each clock cycle
  - So, read and write to registers during same clock cycle is okay
  - Can always be removed by adding hardware resources
- Data hazard: data dependency between instructions, need to wait for
  previous instruction to finish up
  - Data flow _backwards_ is a hazard (e.g. an add happens in one
    instruction, a bunch of subsequent instructions need to use the
    value produced by that add
  - Cool. Register forwarding: forward result as soon as it's available,
    even if it's not stored in RegFile yet. Add a sneak path for
    forwarding value from output of ALU to input of ALU without
    writing/reading registers or memory
  - What's the datapath for forwarding?
  - Add a forwarding unit that checks source registers, compares them to
    registers written in earlier instructions, and if they match, then
    you do the forwarding. E.g. if $t0 written in one add (destination),
    then $t0 used in subsequent subtract (source), then mux in the new value
  - Loads are tough, cause you need the memory value. Can't forward,
    need to wait until load value is actually available. Must stall
    instruction dependent on load, and then forward
  - Called *hardware interlock* when hardware stalls pipeline
    - Replace stalled instruction with "bubble", which is a no-op
  - Slot after a load is a load delay slot, can't use loaded value for
    one slot.
    - Don't try and use a value once cycle after load :) `nop` instead
  - MIPS doesn't have interlocked pipelining stages :)
    - But adds back interlock because it's smelly to nop everywhere
  - Compiler can help with hardware interlock by inserting unrelated
    instruction into that space so you can take advantage of nop time
    - Can save stuff
- Control hazard: Flow of execution depends on previous instruction
  (branch or jump)
  - Branch determines flow control
  - Simple solution option 1: just stall on every branch instruction
    until branch resolved
    - Adds 2 bubbles/cycles for each branch :( (20% of instructions).
      Compare happens at ALU stage, so must wait till then
  - Optimize: insert special branc comparator after stage 2. Can only do
    equality check. Chop penalty down to only one bubble
    - RISC is about good pipelining not about few instructions
  - Optimize: Predict outcome, fix up if guess wrong
    - If you're wrong, must _flush_ pipeline
    - Can predict that all branches are NOT taken; just keep going and
      fall through :) Only need to flush if branch ends up being taken
  - Lots of effort spent on this!
  - Optimize: can rearrange instructions (compiler) to fill branch delay
    with an unrelated, still useful instruction

### 8: Memory Hierarchy

#### Mike Acton Data-Oriented Design and C++

- https://www.youtube.com/watch?v=rX0ItVEVjHc
- On the engine team - supports the runtime systems that games are built
  on top of
- Don't use templates in CPP
- Lots of language features are sad and not used for important stuff
- *Data oriented design*: the purpose of all programs is to transform
  data from one form into another
  - Corollaries: if you don't understand the data you don't understand
    the problem. You understand a problem better by understanding the
    data. If you have different data you have a different problem. If you
    don't understand the cost, you don't understand the problem. If you
    don't understand the hardware, you can't reason about the cost of
    understanding the problem. Everything is a data problem. :)
  - Solving problems you don't have will add to the number of problems
    you do
- Where this is one, there are many. Try looking at the most common
  problems and stuff first.
- Software does not run in a vacuum!
- Reason must prevail!
- Data-oriented: a reminder of first principles :). Not new ideas at all
- Lies of CPP
  - Software is a platform
    - Hardware is the platform fam. Reality isn't some annoying thing
      making your solution ugly, reality is the real problem
  - Code should be designed around your mental model of the world
    - Don't hide data in your mental model! Confuses maintenance with
      understanding properties of data (which is critical for solving
      problems). Don't try and idealize the problem
  - Code more important than data
    - No. Code exists to transform data. Programmer responsible for DATA
      not code
- Lies lead to poor performance, concurrency, optimizability, stability,
  testability. Oops
- Solve to transform data you have to where you want it given the
  constraints of the platform. Nothing else dude

- Solve for most common case first, not most generic
  - "Make the compiler do it". No. Compiler reasons about instructions,
    which is only 1-10% of the problem space
- Let's look at memory hierarchy stuff. Much much more expensive to go
  to main memory than to have compiler optimize away expensive CPU
  instructions. This is an order of magnitude
- Don't miss the cache!
- If cache line is 32 bytes let's see

- Don't re-read data or re-call functions that you already have answers for
- For bools, using `bool` is huge cost because lots of wasted space
  - Only fills 1 bit of 512 in the cache line. Can try and squeeze other
    stuff in as well

- Don't reason about stuff super locally if you can do it at a higher
  level

- Concentrate on common case first

#### P&H 5th Edition Memory Hierarchy (5.1 - 5.4)

- Create illusion of unlimited amounts of fast memory
- If you're writing a paper at a desk, you wanna keep the most important
  documents and references close by so you don't have to keep getting up
  to access stuff
  - Same principle here: create illusion of large memory by swapping
    stuff out of a small memory behind the scenes
- Principle of locality. Programs access a small portion of address
  space at any given time
  - Temporal (in time): if something referenced, likely to be referenced
    again. Keep it around
  - Spatial (in space): if something referenced, stuff around it is
    likely to be referenced soon
- Cache faster than SRAM faster than DRAM faster than disk
  - S = Static
  - D = Dynamic
- Take advantage of locality with a hierarchy
  - Faster but smaller the closer you get to processor
- Data only copied between two adjacent levels at a time
- "Upper" = closer to processor, "Lower" = further away
- Block/line: minimum unit of information that can be present or not
  present. Library analogy is a book
- If present, it's a _hit_. If not, it's a _miss_. Hit rate is the
  fraction of accesses that are in the upper level; Miss rate is 1 - hit
  rate
- Hit time is amount of time taken for a hit. Miss penalty is time to
  replace block in upper level with the missed data from lower level,
  then deliver data to processor

- SRAM are memory arrays that keep values indefinitely as long as power
  is applies. DRAM stores stuff as a charge on a capacitator, must be
  refreshed (read and write back) periodically. Organized in rows for
  read and write (?)
- Hardware stuff over my head
- Flash memory is older stuff, it wears down over time so you have to
  use a technique called wear leveling to distribute load over the whole
  thing
- Magnetic hard disk supah slow. They are a series of magnetic disks
  connected together and moving in conjunction
  - Three steps. First, seek, which moves the head to the proper disk
    track. Average seek times 3-13ms. Then, when head is on correct
    track, must wait for the right sector to rotate to the head.. Average is
    like 5ms. Finally, transfer time is how long it takes to move a block to
    the head. Transfer rates in 2012 ~ 100-200MB/sec.
- Primary diff between magnetic disk and semiconductor memory is that
  disks are way slower because they're mechanical.

- Caches are memory levels between processor and main memory
- How to find where in cache something is stored? Similar to naive
  hashing algorithm: block address module number of blocks in cache.
  This is direct mapping
- Add tags to the cache data decribing where it originally lived
- How do you know if cache has valid data? (e.g. stuff can be stale
  after a processor startup). Add a `valid` bit that is on if entry has
  a valid address
- Caching part of *prediction*. Rely on principle of locality to try and
  find desired data, and retrieve the correct data if can't find it in
  the caches. Today computers are 9% cache hit
- Using this modulo approach we'll have block conflicts. Uhh how to
  resolve idk yet
- "The tag from the cache is compared against the upper portion of the
  address to determine whether the entry in the cache corresponds to the
  requested address. Because the cache has 210 (or 1024) words and a block
  size of one word, 10 bits are used to index the cache, leaving 32 −10 −
  2 = 20 bits to be compared against the tag. If the tag and upper 20 bits
  of the address are equal and the valid bit is on, then the request hits
  in the cache, and the word is supplied to the processor. Otherwise, a
  miss occurs."
- Nice diagrams buddy
- Larger block = lower miss rate b/c of spatial locality
  - There's a sweet spot b/t block size + number of blocks that fit in
    the cache
  - Larger block also means worse miss penalty :( takes longer to load
    missed data into the cache

- How does processor control handle miss?
- Most of the time, just introduce a stall until missed data has been
  loaded (if cache hits, just proceed as normal)

- Writes different from reads
- After write to memory, cache and memory are inconsistent. Solve this
  with write-through: write to both spots each time. But this is sucky
  and slow. Need to spend a lot of cycles writing to main memory
  synchronously
- Better? *Write buffer* stores data while waiting to be written to
  memory. Processor just needs to write to the buffer (fast), and it
  goes from there to main memory. If write buffer is full, processor still
  has to wait for free space
- *Write-back* also possible. When write occurs, new value only goes to
  cache, then written to lower levels when it is replaced. Hard to
  implement but better performance

- How do miss rate and execution time relate to each other? Let's see

- How to measure and improve cache performance
- Two techniques: reduce miss rate by reducing probability that two
  different memory blocks dispute over the same cache spot, reduce miss
  penalty by adding more levels to hierarchy
- CPU time = (CPU execution clock cycles + Memory-stall clock cycles) x
Clock cycle time
- Memory-stall clock cycles can be read or write. Intuitive equations
  for those. Reads: reads/program x read miss rate x read miss penalty
- Sometimes can assume hit time is just factored into a clock cycle, but
  if you want to get granular about that too you can use a metric called
  Average Memory Access Time (AMAT): time for a hit + miss rate x miss
  penalty

- Can you have same block in multiple locations? i.e. not direct mapped.
- Opposite of direct mapped is _fully associative_; any block can be
  anywhere. Search whole block for what you want
- Middle range is *Set associative*. Set number of spots where each
  block can be placed in n locations (descript would be "an n-way
  set-associative cache")
  - Calculate where block can go by (block#) % (#*sets* in cache)
  - Must search all tags in set when looking for a block
- Tradeoff of increasing associativity: lower miss rate but increase hit
  time
- Definitely diminishing returns; in 64KiB with 16-word block,
  associativity from 1 to 2 is like a 1.7% improvement in miss rate, 2
to 3 is like 0.3%
- Searching n-associative cache for your data :thinking\_face:
  Sequential search too slow! Instead, search them all in parallel. Need
one comparator for each level of associativity you add. So cost is extra
hardware + cost of doing compares

- Which block do you replace? Need to choose among blocks in set.
- Commonly just do LRU

- Multilevel cache to improve performance even more
- Primary cache usually smaller than secondary...can use smaller block
  size as well. Also lower associativity
- Interesting comparison between radix sort and quicksort. Radix sort
  algorithmically quicker, but since quicksort has fewer misses per item
it can still perform better

- How to use in software?
- e.g. if you're working on an array or list or matrix that won't all
  fit into memory at the same time, instead of going row by row or
column by column you want to go by block size so you can fit the entire
block you're operating on into memory at the same time. Compute block
size with pointer arithmetic and only fetch what's necessary. Muy bien

- Summary?
- Cache performance, using associativity to reduce miss rates,
  multilevel hierarchies to reduce miss penalties, software
optimizations to improve cache usage

#### Lecture

- Registers: 1ns access, ~ 1kb, CMOS tech, managed by compiler/programmer
- L1: 3ns, 32KB, SRAM, CPU
- L2: 6ns, 256KB, SRAM, CPU
- L3: 12ns, 8MB, SRAM, CPU
- RAM: 60ns, 16B, DRAM, OS

- Half of each cache is for instructions, half for data
  - Why? Different data access patterns. e.g. if iterating through
    array, iteration code is static (keep the instruction cache), but
    get all the new data (evict data cache)
- Struct packing: wise about ordering of elements in C Structs because
  of how compiler will organize your memory

- Misses
- Compulsory: nothing in those spots, just go fetch it
- Conflict: gotta try searching in the set
- Evict: least recently used thing tossed out to make room

### Parallelism, Flynn taxonomy, Amdahl's law

#### Berkeley lectures (CS 61C 3-31-2015 and 4-2-2015)

- New school architecture is crazy. Parallelism :thinking\_face:
- Use a whole bunch of processors to make things faster
- Two ways:
  - Multiprogramming: different independent programs in parallel
  - Parallel computing; run multiple at the same time on same machine.
    Way harder
- SIMD: single-instruction/multiple-data
  - Multiple data streams against a single instruction stream. GPU
    stuff. Take a "pool" of data and apply same operation to all of them
    at the same time
- MIMD: multiple processor cores executing different instructions on
  different data
- MISD: not very common at all. Odd design
- SIMD/MIMD: Flynn taxonomy.
- Software: SPMD programming. Single Program Multiple Data. Run same
  program on different sets of data in different places
- Big idea: Amdahl's (heartbreaking) law. Speedup due to enhancement E
  - Only speedup to parallel steps, suequential steps still neeed to go
    sequentially
  - Speedup w/E = exec time w/o E DIVIDED BY exec time w/E
  - Basically, parallelization speedup is less than you'd intuit

- Strong/weak scaling: getting good speedup on parallel processor while
  keeping problem size fixed is hardeer than getting good speedup by
  increasing the size of the problem
- Strong: speedup can be achieved on parallel processor without
  increasing size of problem
  - Example: graphics (parts of the screen aren't dependent on others)
- Weak: speedup can be achieved on a parallel processor by increasing
  size of problem proportionally to increase in number of processors
- Load balancing: each processor should do just about the same amount of
  work! Always have to wait for slowest processor

- SIMD architecture
- _Data parallelism_ is executing same operation on multiple data
  streams
- Example: multiply a coefficient array by data array (all elements)
- Sources of improvement:
  - Only one fetch/decode
  - All operations known to be independent
  - Pipelining/concurrency in memory access
- Intel calls it Advanced Digital Media Boost -\_-
  - MMX: Multimedia Extensions. Used 64 bit registers that would be
    considered broken up. Then parallel ops could be done (1992)
  - SSE: Streaming SIMD Extensions: Added 128 bit registers (1999)
  - Now AVX: 256 bit registers (2011). Space for expansion to 1024 bit
    registers!

- Array processing in SIMD
- Without parallelism, need to load each element into float register,
  calculate sqrt, write result back
- With parallelism, Load 4 members into the SSE register, calculate 4 in
  one operation, stoe them all from register to memory
- This kinda stuff is expressed in programs as for loops
  - In MIPS, this would just be a sequential set of instructions as
    described above "without parallelism"
  - Can unroll a scalar loop to do 4 elements at a time. Only 1 loop
    overhead every 4 iterations. Uses different registers for each
    iteration to eliminate data hazards in the pipeline
    - Now schedule things by doing all loads, then all adds, then all
      stores. Cool
    - If not in multiple of 4, have a separate loop that handles odds
  - SIMD this thing by just converting unrolled instructions into one
    SIMD instruction
    - MOVAPS: move aligned, packed, single. Cool
    - ADDPS: add packed single precision
