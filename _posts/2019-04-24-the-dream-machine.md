---
layout: book_post
title: The Dream Machine
date: 2019-05-07 00:01
categories:
tags: [book, nonfiction, technical, cs, career, life]
author: M. Mitchell Waldrop
rating: 5
length_pages: 512
length_loc: 15131
date_started: 2019-02-21
date_finished: 2019-04-24
goodreads_url: "https://www.goodreads.com/book/show/722412.The_Dream_Machine"
image: /books/the-dream-machine.jpg
summary: "How the modern computer came to be, courtesy of the visionary JCR
Licklider. Incredible. None of this was an accident."
---

*TL;DR*: How the modern computer came to be, courtesy of the visionary JCR
Licklider. Incredible. None of this was an accident.

## Notes

### Prologue: Tracy's Dad

* At dinner every night, Lick asks his kids: "What have you done today that was
  altruistic, creative or educational?"

### 1: Missouri boys

* Lick was quite the character
* Bringing psychology/acoustics background to computing set him apart from
  others in the field
  * Deep appreciation for how humans can perceive, adapt, make choices, etc.
* Studied psych at Wash U, Rochester, Swarthmore
* Worked at Smitty Stevens' psycho-acoustics at Harvard during WWII
* "No one was a stranger to him"

### 2: The last transition

* Claude Shannon writes "A Symbolic Analysis of Relay and Switching Circuits" in
  1937, first use of relay circuits as logic gates which could _decide_
  * “A Symbolic Analysis of Relay and Switching Circuits” has just the kind of
    cerebral exuberance you’d expect from a very bright twenty-one-year-old.
    Shannon’s thesis is downright fun to read—and strangely compelling, given
    what’s happened in the six decades since it was written.
    * Arguably most influential master's thesis of the century, laying the
      theoretical foundation for computer design
    * Introduces the idea of _logic_ via relays and switching circuits
  * At MIT
  * Switching is a method to forward data packets coming in from the sender to the
    receiver at the destination address. Circuit switching and packet switching
    are the two most popular methods of switching. In circuit switching, data is
    transferred on a dedicated channel that is to be established between the
    sender and the receiver using a dedicated point-to-point connection. In packet
    switching, data is split into small units called packets with each packet
    being associated with a header containing signaling information about the
    source and destination nodes. The packets are transmitted independently and
    are processed at all intermediate nodes before reaching their destination. At
    the destination, the data packets are extracted and reassembled to get the
    original message.
* Grace Hopper finds the first bug in the summer of 1945. A moth had gotten
  crushed by a relay switch in the Mark II (IBM)
* von Neumann is the Einstein of mathematics: father of game theory, logic, and
  more
  * Crazy memory: could recite the entire opening chapter of A Tale of Two
    Cities
* VN interesects with Turing
* 1936: Turing publishes his paper on Turing machines
  * If a human mathematician can get there, a machine can get there. No matter
    how clever its design, no machine can do more than Turing's. Given enough
    time and memory capacity, the lowliest handheld PC can do anything the
    mightiest supercomputer on the planet can.
* 1943: Warren McCulloch and Walter Pitts come up with the neural network model
  at University of Chicago: model the brain as a big circuit made of neurons,
  each neuron receives input from other neurons, if total stimulation passes a
  threshold, neuron will "fire"
* VN starts sketching his architecture and is influenced by McCulloch and Pitts
  * Uses their notation
  * Five functions: input units, output units, CPU, memory, ALU
  * **Von Neumann architecture is a concrete implementation of a Turing
    machine**
  * Simplest scheme possible: fetch, execute, return.
* EDVAC/ENIAC in 1947 introduce the concept of the stored program. Just treat
  propgram instructions as another type of data. Separate problem-solving from
  hardware
  * SOFTWARE

### 3: New kinds of people

* Vannevar Bush introduces the Memex
  * "Memory index"
  * Hypothetical proto-hypertext system
    * Users copy and exchange trails of data
  * Also hires Claude Shannon to maintain the Differential Analyzer which sparks the
    following
    * This thing solves differential equations
* Claude Shannon has a fundamental theory of communication
  * Information source: thing generating message (person, computer)
  * Transmitter: changes message into signal (voice->sound wave, telephone->
    electric signal, etc.)
  * Channel: medium conducting signal (air, telephone wire, etc.)
  * Receiver: instrument that take signal and tries to reconstruct message (ear,
    other telephone, etc.)
  * Destination: thing the message is intended for
* Norbert Wiener: first "skeptic" of new computer technology. Cautious optimist
  * "The first indsutrial revolution, the revolution of the dark, satanic mills,
    was the devaluation of the human arm by the comptetition of machinery. The
    moderd industrial revolution is similarly bound to devalue the human brain,
    at least in its simpler and more routine decisions."
  * Vision of information age: it tied together communication, computation, and
    control
  * This is "cybernetics": study of control and communication in the animal and
    machine

### 4: The freedom to make mistakes

* 1950: MIT physicist George Valley committee to upgrade Pentagon air defense
  strategy
  * Two recommendations: sub-contract to a technical organization. Use digital
    computers to cordinate surveillance, target tracking
* Project Lincoln’s goal of understanding how machines and humans could work
  together as a system was just an extension of Lick’s own inner quest:
  understanding how the human brain itself worked as a system.
  * Got the best psychology students in the country
* Indeed, Lick was already honing the leadership style that he would use to such
  effect a decade later with the nationwide computer community. Call it rigorous
  laissez-faire. On the one hand, like his mentor Smitty Stevens, Lick expected
  his students to work very, very hard; he had nothing but contempt for laziness
  and no time to waste on sloppy work or sloppy thinking. Moreover, he insisted
  that his students master the tools of their craft, whether they be experimental
  technique or mathematical analysis. On the other hand, Lick almost never told
  his students what to do in the lab, figuring that it was far better to let them
  make their own mistakes and find their own way. And imagination, of course, was
  always welcome; the point here was to have fun.
* Lincoln Lab + IBM collaborate on SAGE, the Semi-Automated Ground Environment,
  in 1954
  * Enormous impact on the history of computing
    * Brought brightest computer minds to MIT
    * Billions of $$$ of Pentagon money helped IBM become the biggest computer
      manufacturer in the world
    * Brought real-time computing to the business world
    * Planted the seed of the idea that computers and humans could work together
      and be more effective than working separately
* Turing writes "Computing Machinery and Intelligence" in 1950
  * Thinking machines: what does it mean to be a machine, and what does it mean
    to think?
  * Turing test: if a computer is indistinguishable from a human via chat
    interface, it is thinking
  * Accused of being gay, put on estrogen treatment, commits suicide in 1954
* von Neumann gets bone cancer and dies in 1957 :/
  * Surrounded by 4 members of the cabinet and all military chiefs of staff at
    time of death because he was so important to the country's nuclear weapons
    program
* George Miller is a psychologist who worked with Lick
  * Disagreement with the behaviorist movement. Behaviorists say that any
    internal states are inaccessible to outside observers, so the only way for
    organisms to be understood is by cataloging observable inputs and outputs
  * Miller focuses on cognitive processes. Starts the field of cognitive
    psychology with Noam Chomsky, and this replaces behaviorism. Invented the
    term "chunk" to apply to units of things you can remember
* Chomsky attacks behaviorism using language: how can you avoid talking about
  mental states when the whole point of language is to communicate things like
  ideas, images, feelings?
  * Language has almost infinite combinations of expression
  * There is a structure to sentences, which behaviorists cannot account for
  * The pinnacle of all possible mathematical machines -- the Turing machine --
    is also the baseline, the minimum for human cognition. This is part of a
    hierarchy
* Allen Newell and Herbert Simon work on the Logic Theorist in 1955
  * Solve mathematical proofs
  * Have to use heuristics because there is a combinatorial explosion of
    possibilities
    * _The unique power of heuristic reasoning lies in its ability to cope with
      the complex and the unexpected, to make acceptable choices when there
      isn't enough time to make the ideal choice, to hunker down and keep on
      going when a precisely defined algorithm would be overwhelmed by the
      combinatorial explosion. In effect, heuristic reasoning is what allows us
      to go through life in a chronic state of controlled panic._ (L3380)
* Trace the progression of ideas:
  * mid-40's: after cybernetics, we understand that a computer can have memory
    through the mechanism of feedback
  * After McCulloch and Pitts, we can understand that the brain uses neuron
    activations to process information
  * After Chomsky and Newell and Simon and Miller, we know that reasoning can
    come from information processing through heuristics. This is the birth of
    cognitive science
    * “Logic Theorist was a demonstration that you could have artifacts that
      would behave intelligently. Even if you didn’t believe the further
      assumption that the way the computer did it was the same way we do it,
      this in itself was enough to free the psychological imagination. If you
      talk about the computer’s having a memory, then certainly the
      behavioristic ban on concepts like memory was no longer necessary. And if
      a computer could be prepared to anticipate any one of n alternatives, then
      certainly the ban on expectations was no longer valid." - Miller
* Wesley Clark working on a computer called the TX-2 at MIT in 1957. Invites
  Lick to check it out

### 5: The tale of the fig tree and the wasp

* TX-2 group realizes in 1955 that if computers are going to ever go mainstream,
  must replace vacuum tubes with transistors. Smaller, faster, cheaper. Vacuum
  tubes are too large and gave off a ton of heat and were unreliable
  * Transistors were new
  * Clark sketches TX-0
  * Ken Olsen raises money to take transistor computers mainstream and starts
    Digital Equipment Corporation (DEC)
* Working with the TX-2 sparks idea for Lick
  * So, Lick wondered, what would happen if you put humans and computers
    together as a system? What would happen if you let the machines take over
    all those dreary, algorithmic chores they were so good at? How much of your
    time would be opened up for real creativity?
    * Empirically, he spent 85% of his "creative" time on clerical work
      * Could this be turned into some sort of symbiosis?
* In 1956 Lick is persuaded to join a firm called BBN (Bolt Beranek and Newman)
  as the director of psychoacoustics and engineering lab
  * He is given a lot of autonomy and set about building a dream team
  * “Lick collected people,” says his former student Tom Marill, who was struck
    by the way his mentor always tried to bring his favorites along as he moved
    from place to place. “He was very bright, he was very articulate, and
    because of that he was able to get very good people. They liked being
    collected.”
  * He buys a new IBM card machine to learn how to program
* The IBM computer is woefully insufficient. Around the same time, DEC releases
  their first computer
  * It's the PDP-1 (Programmed Data Processor) and BBN got the first one
  * Finally a serious cmoputer. 2x the price, 1000x the performance of the IBM
    LGP-30
    * "There had never before been a machine that was this much in front of the
      competition. And never since. It was a singular event." (Ed Fredkin)
  * Lick uses this computer to write educational software for his children
* John McCarthy joined BBN
  * Never impressed by much :)
  * Invented the field of AI
    * 1956 6-week conference: "Dartmouth Summer Research Project on Artificial
      Intelligence"
    * Thought the Logic Theorist was sloppy. Wanted to build an Advice Taker
      that draws from a database of propositions etc.
  * Invented Lisp, interactive symbol-processing programming language
    * Static resource allocation wouldn't work for AI because it is so dynamic
    * Lisp = List Processor
      * Functional programming. Most powerful and compelling feature
      * Introduced the idea of an interpreter
      * Allowed for composition of complex programs
  * Invented time-sharing
    * Idea "just popped in his head". Seemed obvious to him.
* Lick writes a paper called "Man-Computer Symbiosis" in 1960
  * Incredible paper. Laid out the entire vision for US computer research
  * “The fig tree is pollinated only by the insect Blastophaga grossorum [the
    fig wasp]. The larva of the insect lives in the ovary of the fig tree, and
    there it gets its food. The tree and the insect are thus heavily
    interdependent: the tree cannot reproduce without the insect; the insect
    cannot eat without the tree; together, they constitute not only a viable
    but a productive and thriving partnership. This cooperative ‘living
    together in intimate association, or even close union, of two dissimilar
    organisms’ is called symbiosis. ... The purposes of this paper are to
    present the concept [of] and, hopefully, to foster the development of
    man-computer symbioses.”
  * A relationship like having a colleague who can help you think when problems
    get hard
  * Knew way too much about the brain to be an optimist about AI. Pretty
    ambivalent.
  * Viewed programming as a profound activity. Solving programming problems can
    hint at the nature of intellectual processes
* Loved the idea of a model: "any convenient simulation of reality"
  * Ok so let's dive into MODELS
  * “Ordinary mathematical models are static models. They are representations in
    symbols, usually written in pencil or ink on paper. They do not behave in
    any way. They do not ‘solve themselves.’ For any transformation to be made,
    for any solution to be achieved, information contained in the model must be
    read out of the static form and processed in some active processor, such as
    a mathematician’s brain or a computing machine. A dynamic model, on the
    other hand, exists in its static form only while it is inactive. The dynamic
    model can be set into action, by one means or another, and when it is
    active, it does exhibit behavior and does ‘solve itself.’” The Curtiss Robin
    was a dynamic model in this sense, he explained: once the fan was turned on,
    it flew. It was active. The same was true of the analog electronic
    simulations he had once experimented with at the MIT acoustics lab.
  * In richness, plasticity, facility, and economy, the mental model has no
    peer.” Included among those mental models are images recalled from memory,
    expectations about the probable course of events, fantasies of what might
    be, perceptions of other people’s motives, unspoken assumptions about human
    nature, hopes, dreams, fears, paradigms—essentially all conscious thought.
    Of course, Lick and Taylor would continue, “[the mental model] has
    shortcomings. It will not stand still for careful study. It cannot be made
    to repeat a run. No one knows just how it works. It serves its owner’s hopes
    more faithfully than it serves reason. It has access only to the information
    stored in one man’s head. It can be observed and manipulated only by one
    person.” But if you could join mental models to computer models, Lick
    reasoned, and if you could get the two of them into just the right kind of
    symbiotic relationship, then you could overcome every one of those
    limitations.
    * Addresses complexity limitation by being able to handle huge amounts of
      data and represent knowledge as programs
    * Addresses the limitation of confinement of knowledge to a single head by
      allowing data to be displayed on many screens and viewed by many people
    * In addition, Lick wrote, this computerized system system would be of
      enormous help in meeting the challenge of “ordered information”: finding
      and applying the relevant research results, utilizing the expertise of
      outside consultants, coordinating the efforts of design engineers,
      analyzing a flood of test data, scheduling routine maintenance, planning
      for continual evolution and growth—and on and on.
* By the beginning of the 1960s, then, a decade and a half before the
  microcomputer revolution began in the garages of Silicon Valley, and a full
  thirty years before the dawn of the Internet Age, the air around Cambridge was
  already alive with the essential ideas:
  * graphics-rich personal workstations and the notion of human-computer symbiosis
  * time-sharing and the notion of computer-aided collaborative work
  * networks and the notion of an on-line community
  * on-line libraries and the notion of instant, universal access to knowledge
  * computer languages and the notion of a new, digital medium of expression.
* MIT Model Railroad Club become the first "hackers" in Spring 1959 after
  participating in McCarthy's first-ever programming class
  * "hack" comes from MIT slang for a practical joke
  * Wrote little software like number converters, audio playing, etc.

### 6: The phenomena surrounding computers

* Eisenhower consolidates all space research under ARPA in 1957 (Advanced
  Research Projects Agency)
  * In 1962 Lick becomes director, one year leave of absence from BBN. Came with
    System Development Corporation contract ($6M), so his budget was $10M. Moves to
    Washington
* Didn't like the SDC batch processing approach, needed them to buy into time
  sharing
  * Brought MIT folks to Santa Monica in November and convinced them time
    sharing was better
* Starts assembling the TEAM
  * Traveled around everywhere trying to get talent together from universities
  * Wanted proposals for computer research. Carnegie, RAND, Stanford, Berkeley
  * One proposal that ended up on his desk was from Douglas Engelbart
    * FLASH-1: The difficulty of mankind’s problems was increasing at a greater
      rate than our ability to cope. (We are in trouble.)
    * FLASH-2: Boosting mankind’s ability to deal with complex, urgent problems
      would be an attractive candidate as an arena in which a young person might
      try to “make the most difference.” (Yes, but there’s that question of what
      does the young electrical engineer do about it? Retread for a role as
      educator, research psychologist, legislator... ? Is there any handle there
      that an electrical engineer could ... ?)
    * FLASH-3: Aha—graphic vision surges forth of me sitting at a large CRT
      console, working in ways that are rapidly evolving in front of my eyes
      (beginning from memories of the radar-screen consoles I used to service).
    * Within a few days, he said, the imagery of FLASH-3 had evolved into a vision
      of a general-purpose, computer-powered information environment. It would
      include documents mixing text and graphics on the same CRT display. It would
      include whole new systems of symbols and methodologies to help users do
      their heavy thinking. And it would include network-assisted collaborations
      to allow people to work together in ways that would be more effective than
      anything anyone had ever seen before. Within a few weeks he had committed
      his career to this vision, which he now called “augmenting the human
      intellect.”
    * Spoke about phases of human evolution:
      * Concept manipulation: non-verbal mental concepts
      * Symbol manipulation: words and numbers
      * Manual external symbol manipulation: graphic representations of concepts
      * Computers introduce _automated external symbol manipulation_: computers
        can run programs on their own
* Bob Fano, Minsky, and McCarthy need a proposal to get money from ARPA to MIT. They
  come up with Project MAC for Multiple-Access Computer
  * This was a time-shared information utility
* Needed to do it in 6 months. And without any ARPA funding yet
  * Corbato, Dennis, Greenberger, Minsky, Ross, Selfridgbe, Teager
* Galactic network in April 1963
  * Lick dictated to his Principal Investigators (Fano, McCarthy, Uncapher,
    Engelbart, Feigenbaum, Perlis) that they would have to join up with Arpanet
    * In short, he said, the various ARPA-funded sites would have to take all
      their time-sharing computers, once they became operational, and link them
      into a national system. “If such a network as I envisage nebulously could
      be brought into operation,” Lick wrote, “we would have at least four large
      computers, perhaps six or eight small computers, and a great assortment of
      disc files and magnetic tape units—not to mention the remote consoles and
      Teletype stations—all churning away.”
* MIT time-sharing becomes a huge success because people begin sharing programs
  with each other
  * Tom Van Vleck writes the MAIL command
  * Now, however, time-sharing had made exchanging software trivial: you just
    stored one copy in the public repository and thereby effectively gave it to
    the world. “Immediately,” says Fano, “people began to document their
    programs and to think of them as being usable by others. They started to
    build on each other’s work.”
* Lick decides to stay at ARPA
  * with rare exceptions—notably that first encounter with SDC—Lick was much
    more interested in being a mentor than in being a micromanager. As long as
    people made reasonable progress in the right direction, he would let them
    find their own way.
  * Things keep humming. He funds Newell, Simon, Perlis at Carnegie
* Mouse invented at Stanford Research Institute
  * They were working on interactive computing
  * Needed a screen selection device
  * Finally, as they were all sitting around brainstorming one day, Engelbart
    came up with the idea of a little gadget that the user could roll around on
    the desktop with one hand while the cursor tracked its motion on the screen.
    Since it didn’t seem any sillier than some of the other things they had
    tried, Bill English went off to the SRI machine shop and made one. It was
    essentially just a block of wood about the size of a pack of cigarettes,
    with some rollers set into the bottom and a wire coming out the front end to
    communicate the motion of the rollers to the computer. Engelbart wasn’t
    totally satisfied with this contraption, either. And yet when the NLS team
    hooked up all the selection devices to their computer and gave users a
    choice, they discovered that people were consistently choosing the little
    gadget. The preference was so strong, in fact, that they eventually
    abandoned everything else; the gadget had become their standard. And by that
    time, of course—though no one on the SRI team can now remember when, or how,
    or why it started—they had all taken to calling the thing a mouse. It was
    more of a joke than a name, really. They would surely find a more dignified
    term in time. But until then, well, it just seemed to fit.
* Around here, Lick sends out Intergalactic Network memo. This was the precursor
  to Arpanet, which was the precursor to the internet.
  * In short, he said, the various ARPA-funded sites would have to take all
    their time-sharing computers, once they became operational, and link them
    into a national system. “If such a network as I envisage nebulously could be
    brought into operation,” Lick wrote, “we would have at least four large
    computers, perhaps six or eight small computers, and a great assortment of
    disc files and magnetic tape units—not to mention the remote consoles and
    Teletype stations—all churning away.” Lick went on to discuss many examples
    of how people might use such a system, as well as the technical challenges
    of bringing it into being. At one point he even described something
    strikingly similar to the migratory Java applets that would appear at the
    turn of the millennium: “With a sophisticated network-control system, I
    would not [have to] decide whether to send the data and have them worked on
    by programs somewhere else, or bring in programs and have them work on my
    data.” The computer could make such decisions automatically, he said—meaning
    that software could float free of individual machines. Programs and data
    would actually live on the net. And so it went for seven pages, in what was
    arguably the most significant document that Lick would ever write. It’s true
    that his proposal was just an elaboration on the network of “thinking
    centers” he had envisioned in his 1960 “Symbiosis” paper—enriched, perhaps,
    by the more recent speculations around MIT about citywide information
    utilities. But in just a few years, this memorandum to the Intergalactic
    Network would become the direct inspiration for the Arpanet, which would
    eventually evolve into today’s Internet.
* Meanwhile, things humming along at Project MAC
  * Working on an operating system called Multics
    * Could run without interruption, multi-processor
    * In the meantime, System/360 by IBM is a batch-processing disaster
      * So IBM commissions a time-sharing approach. They hire Lick
* “When you look at Lick’s legacy, two very distinct things stand out,” says Bob
  Fano. “One is that he was a very imaginative, creative psychoacoustics man.
  Second, says Fano, when Lick was presented with a miraculous,
  never-to-be-repeated opportunity to turn his vision into reality, he had the
  guts to go for it, and the skills to make it work.
  * Lick: It was more than just a collection of bright people. It was a thing
    that organized itself into a community, so that there was some competition
    and some cooperation, and it resulted in the emergence of a field.”

### 7: The intergalactic network

* Bob Taylor is Lick's biggest fan. Works for NASA. Helps Lick a lot when Lick
  is at ARPA
* In 1965, Taylor proposes linking all 16 IPTO contractors together in one
  network
  * Timing is right because they are just starting to become operational
  * Obviously some pushback
  * Taylor was willing to let Roberts and the rest of the world believe anything
    they wanted—so long as the network got built.
* ARPA would make a series of massive long-distance calls and just never hang
  up. More precisely, the agency would go to AT&T and lease a series of
  high-capacity phone lines linking one ARPA site to the next. A diagram of the
  resulting network would thus look something like a road map of the interstate
  highway system,
* The farther a message traveled, the greater the chances that one or more bits
  would be garbled by static and distortion on the line. And in the digital
  world, one erroneous bit might easily spell disaster. Thus the digital
  postcards, or “packets,” in modern parlance.
* So in sum, said Roberts, that was the plan: full-time access, messages divided
  into packets, and distributed control. Now, who wanted to help?
* How to route stuff?
  * Wes Clark: routing computers are responsible for moving stuff
    * IMPs: Interface Messaging Processors
    * Simplify life for everybody. ARPA could take responsibility for designing
      and implementing the network proper—meaning the information highways and
      the digital interchanges—without having to worry that some contractor
      somewhere would mess up his site’s programming and thereby bollix up the
      whole system. And the contractors, for their part, could focus on one
      comparatively simple task—establishing a link from their central computer
      to the routing computer—without having to worry about all the ins and outs
      of all the other computers on the network.
* The first RFC comes from SRI/Utah/UCLA/Santa Barbara meetings in '69. They were the
  first 4 members of Arpanet.
* Around same time (1968) Engelbart gives the first demo of interactive
  computing at the Fall Joint Computer Conference in SF
* BBN wins the right to build Arpanet
* J. C. R. Licklider again and again took jobs that required him to be an
  administrator—and then was almost contemptuous of the skills it took to do
  those jobs right.
  * Made Project MAC almost go off the rails
* Multics comes out in 1970
  * Witness the fact that the Association for Computing Machinery would award
    Corbató its 1991 Turing Award, computerdom’s most prestigious honor. For all
    its complexity and delay, Multics gave living proof that a grown-up
    operating system was possible—that sophisticated memory management, a
    hierarchical file system, careful attention to security, and all the rest
    could be integrated into a single, coherent whole. In that sense, Multics
    was a prototype for virtually all the operating systems to follow.
* Ken Thompson and Dennis Ritchie launch Unix in mid-1970s from Bell Labs
* In 1972 Arpanet is released to the world at large at ICCC, International
  Conference on Computers and Communications, in Washington
* A BBN engineer named Ray Tomlinson adds email as an add-on to Arpanet and it
  takes off
* There are tons of ways Arpanet could have failed, but it didn't
  * ARPA directorship style: progress, not progress reports
  * Larry Roberts starts the Network Working Group
    * Most democractic forum!!
    * These young researchers who built hardware, debugged software, got hands
      dirty, made the whole thing happen
* People start leaving ARPA for Xerox PARC (Palo Alto Research Center)
  * They join Bob Taylor there

### 8: Living in the future

* George Pake hires Taylor to run the lab
* Taylor’s motto was “Never hire ‘good’ people, because ten good people together
  can’t do what a single great one can do.”
  * “Taylor is very good at getting ... a collection of extremely intelligent
    and opinionated egomaniacs to work together reasonably well without fighting
    each other,” he noted. “Damned if I know how! I can’t do it, but he does.”2
  * All of the various gadgets had to be part of that system. And to achieve
    that goal, Taylor knew, he somehow had to get all these maverick geniuses
    moving in the same direction, without forcing everyone to move in lockstep.
    Somehow he had to give them a sense of purpose and group cohesion, without
    crushing spontaneity and individual initiative. Somehow, in short, he had to
    set things up so they would freely follow their own instincts—and end up
    organizing themselves. This is arguably the fundamental dilemma of modern
    management, not to mention the fundamental political challenge in any
    democracy; leaders have been grappling with it for centuries.
  * And when the arguments got heated, which they often did, the minister’s son
    would do his best to convert a “class-one” disagreement—one in which the
    combatants were simply yelling at each other—into a “class two”
    disagreement, in which each side could explain the other side’s position to
    the other side’s satisfaction. You don’t have to believe the other guy, he
    would tell them. You just have to give a fair account of what he’s saying.
    And it worked.
    * LOVE THIS!!
* Bill English. Alan Kay
  * Kay was a very insubordinate person
  * Had the idea to include procedure for unpackaging data _with the data
    itself_
  * Object-oriented programming!! From a system called Simula where everything
    was described in nouns and verbs
    * “For the first time,” he recalled, “I thought of the whole as the entire
      computer and wondered why anyone would want to divide it up into weaker
      things called data structures and procedures. Why not divide it up into
      little computers, as time-sharing was starting to? But not in dozens. Why
      not thousands of them, each simulating a useful structure?”
* Kay: Dynabook
* Cerf and Kahn: TCP/IP

### 9: Lick's kids

* Back in his natural habitat of Tech Square, meanwhile, he had reverted to
  being Lick at his best: not functioning as a manager and paper pusher, a role
  in which he was a disaster, but serving as visionary, teacher, mentor, and
  friend. Around the late 70's
* In the mid 70's, the "whitecoats" start to get overrun by the hobbyists
  * Hardware: could buy cheap, less-powerful computers and run them all the time
    (PDP-8, PDP-11, etc.)
  * Software: Unix!! Built with hacking in mind
    * A response to the complexity of Multics
    * Sweet, quick, and clean
    * Then they released C as well, and all of a sudden, tons of people could
      program
* Then began the Usenet migration
  * Started having user groups
  * “Life will be happier for the on-line individual because the people with
    whom one interacts most strongly will be selected more by commonality of
    interests and goals than by accidents of proximity.” - Taylor and Licklider,
    1968
* They were the spiritual brothers of the MIT hackers and the freewheeling Unix
  mavens. They were the people who had been ham-radio operators and/or stereo
  buffs since they were teenagers, often using equipment they had built
  themselves from mail-order kits, or from scratch. They were the guys who had
  gotten intrigued by the minicomputers they’d encountered at work or at school.
  And for no “logical” reason whatsoever—certainly none that they could explain
  to their spouses—they were the people who wanted computers of their own at
  home, to play with, to experiment with, to experience. Enter the Altair.
  * Altair was the first commercially successful microcomputer
    * Received over 10k orders, expecting only a few hundred
    * Bill Gates and Paul Allen write Altair BASIC
  * Eventually the founder, H. Edward Roberts, sold out to a big hardware
    company because he was so exasperated with the "soap opera". He became a
    doctor
* Apple Computer Company was next in line
  * Founded by Homebrew Computer Club members
  * Apple II had a ton of commercial success
  * On the software side, Microsoft releases MS-DOS operating system
  * Microcomputer revolution goes huge into the 80s
* So there it was: the “personal” part of the personal-distributed-computing
  paradigm was diffusing outward in the form of workstations, while the
  “distributed” part was doing the same in the form of Ethernet.
  * Ethernet standard is an agreement licensed to Intel and Xerox. Initially
    proposed by Gordon Bell at DEC
* That left the Smalltalk graphical user interface, together with all the other
  Alto software—the embodiment of computing as a medium of expression and
  exploration. But this idea was making its way into the world, too, thanks to a
  fateful show-and-tell at the very end of the 1970s.
  * Steve Jobs's visit to PARC has become something of a mythology
    * When Jobs and his top engineers finally showed up for an afternoon visit
      in December 1979, the presentation was as minimal as Goldberg could make
      it. She and her Smalltalk colleagues gave Jobs and company the standard
      visitor’s tour: the Alto, the mouse, Bravo word processing, some drawing
      programs—nothing that the whole world hadn’t seen before. And afterward
      their guests departed, apparently satisfied. Two days later, having
      realized almost at once that they’d been shortchanged, Jobs and his crew
      showed up in the PARC lobby with no advance warning. They wanted to see
      the good stuff, they said—now. There ensued several hours of argument
      between the Smalltalk team and its bosses. But in the end, after a direct
      order, with Xerox headquarters’ backing up XDC, a red-faced Goldberg did
      indeed show Jobs and his people the good stuff. This included education
      applications written by Goldberg herself, programming tools created by
      Larry Tesler, and animation tools cooked up by Diana Merry for combining
      pictures and text in a single document—all of it increasingly irksome.
* And that was the essential tragedy, he says: whereas headquarters understood
  marketing but not computers, the wizards out on Coyote Hill Road understood
  computers but not marketing. They had gone into the design process believing
  fervently in the PARC vision, in personal distributed computing as a whole,
  integrated system. They knew that it far transcended anything else on the
  market. And they couldn’t imagine that customers would want anything less.
  They’d also been given to understand that cost was no constraint: their target
  was the corporate world, the Fortune 500—scale customers that were used to
  shelling out hundreds of thousands of dollars for computer equipment. The
  result was an unfettered exuberance that led the Star’s designers into at
  least three critical errors. The first and most obvious was a rampant case of
  feature-itis: they loaded up the Star software with every neat thing they
  could think of, until it had grown to roughly a million lines of code and was
  at the ragged edge of what the 1981-vintage hardware could support. Indeed,
  that was the first thing users noticed: the Star was painfully, maddeningly
  sloooow.
  * Also: made it a closed system
    * All software and hardware had to come from Xerox
    * Had to guess what customers wanted instead of tapping into wider
      community. No spreadsheet program on the STAR. Nobody at PARC ever thought
      to write one because nobody in a research lab ever needed one. Inverse of
      priorities of the business world
    * No inexpensive, low-risk entry path for customers. Minimal installation
      cost $100,000. Apple II was $1500
  * Passed up tons of chances to make something simpler
* Back in the 1970s, it seems, computer users in corporate America had been
  facing much the same frustration faced by researchers such as Steve Wolff: the
  “whitecoats,” or management information service (MIS) departments, dictated
  the terms. Big companies relied on mainframes, a few minis here and there,
  and, for “desktop” applications, lots of dedicated word-processing machines
  from vendors such as Wang and IBM. You played by the MIS rules or not at all.
  Ah, but then the micros came along, the high-tech embodiment of individual
  autonomy, hands-on control, and freedom—not to mention the source of a
  spreadsheet application, VisiCalc, that you couldn’t get any other way.
  Naturally, the MIS types tried to outlaw the things. But it was hopeless; the
  micros were cheap enough that a manager with any imagination could easily hide
  them in the petty-cash budget. Within a very few years, the steady trickle of
  surreptitious Apple IIs had become a flood of IBM PCs, PC clones, and Macs,
  and the MIS departments had effectively given up. In fairness, they did have a
  legitimate gripe. With the flood of micros had come a flood of new software,
  some of it very good—WordPerfect, dBase, and Lotus 1–2–3, for example—but much
  of it flaky and bug-ridden, and all of it incompatible with most companies
  existing applications. Too often, the resulting chaos wasted more of a
  company’s time than it saved. But there was no way to keep personal computers
  out of the office, especially not when more and more employees were using them
  at home. So instead the MIS managers bowed to the inevitable and started
  linking the various PCs together into local-area networks, which let them at
  least get some of the data moved onto a central server where they could be
  shared. 3Com had helped jump-start the process in 1982 by being among the
  first to offer an Ethernet card for the new IBM PC. And the company had
  prospered accordingly throughout the 1980s and 1990s, as the office norm
  increasingly came to resemble what Bob Taylor and his crew had first imagined
  two decades earlier: individual computers, Ethernet networking, digital
  printing, WYSIWYG text editing and graphics programs, a windowing
  interface—personal distributed computing in full.
* In 1983, physicist and integrated circuit specialist William J. Spencer became
  director of PARC. Spencer and Taylor disagreed about budget allocations for
  CSL (exemplified by the ongoing institutional divide between computer science
  and physics) and CSL's frustration with Xerox's inability to recognize and use
  what they had developed. By the end of the year, Taylor and most of the
  researchers at CSL left Xerox. A coterie of leading computer scientists
  (including Licklider, Donald Knuth and Dana Scott) expressed their displeasure
  with Xerox's decision not to retain Taylor in a letter-writing campaign to CEO
  David Kearns.
* In retrospect, of course, Berners-Lee’s combination of hypertext and browsing
  would prove to be one of those brilliantly simple ideas that change
  everything. By giving users something to see, it set off a subtle but powerful
  shift in the psychology of the Internet. No longer would it be just an
  abstract communication channel, like the telephone or the TV; instead, it
  would become a place, an almost tangible reality that you could enter into,
  explore, and even share with the other people you found there. It would become
  the agora, the electronic commons, the information infrastructure, cyberspace.
  Because of Berners-Lee’s hypertext browsing, users would finally begin to get
  it about the Internet. And they would want more. ...
  * 1990: Release of the World Wide Web. Following trend of streamlining
    networks etc.
* An integrated, open, universally accessible Multinet wouldn’t just happen on
  its own, he pointed out. It would require cooperation and effort on a time
  scale of decades, “a long, hard process of deliberate study, experiment,
  analysis, and development.” That process, in turn, could be sustained only by
  the forging of a collective vision, some rough consensus on the part of
  thousands or maybe even millions of people that an open electronic commons was
  worth having. And that, wrote Lick, would require leadership. Good luck. The
  pessimistic scenario, in contrast, would require nothing more than laissez
  faire
* Technology isn’t destiny, no matter how inexorable its evolution may seem; the
  way its capabilities are used is as much a matter of cultural choice and
  historical accident as politics is, or fashion. And in the early 1960s history
  still seemed to be on the side of batch processing, centralization, and
  regimentation.
  * Licklider's generous funding to paradigms like time-sharing, packet
    switching, TCP/IP, led to technology as we know it today
