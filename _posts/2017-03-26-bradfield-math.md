---
layout: course_post
title: 'Mathematics for Computing'
date: 2017-03-26 00:00
categories:
tags: [course, technical, math, bradfield]
author: Bradfield
rating: 4
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/math/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's math class"
---

## Notes

Schedule: Wednesdays 6pm-9pm and Saturdays 10am-4pm.

### 1 - Counting Things

#### LL Ch 2: Let us count!

##### Sets and the like

- Gg, combinatorials and permutations, okay
- Formalize these counting operations using a *set*, made up of
  *elements*. Deck of cards, people in a group are both sets
- *R* for real numbers, *Q* for rational numbers, *Z* for all integers,
  *Z+* for all non-negative integers, *N* for all positive integers, 0
  for empty set
- b ∈ A if b is in A
- *Cardinality* of A (number of items) is |A|
- Denote items in set with curly braces
- B is *subset* of C if every element of B is also an element of C. Would
  say B ⊆ C
- *Intersection* is set consisting of elements that are in both sets
  - *Disjoint* sets have the empty set as their intersection

##### The number of subsets

- **A set with n elements has 2^n subsets**
- Can use a binary representation of integers (on/off) to represent
  whether or not item is in a given subset. Helps you prove the above
  theorem
- Useful to play around with powers of 2 and 10 to get a ballpark
  estimate of the order of magnitude of a number or set

##### Sequences

- **Number of strings of length n composed of k given elements is k^n**
- **Suppose that we want to form strings of length n so that we can use
  any of a given set of k1 symbols as the first element of the string,
  any of a given set of k2 symbols as the second element of the string,
  etc., any of a given set of kn symbols as the last element of the
  string. Then the total number of strings we can form is k1 ·k2
  ·...·kn**

##### Permutations

- *Permuting* an ordered list of n objects is rearranging it in a
  different order. Each rearrangement is a *permutation*
- **The number of permutations of n objects is n!**
- **Stirling's Formula: n! ∼  (n/e)^n(√2πn)**

#### Lecture

- When in doubt about naive set theory/properties, draw the venn diagram
  inside the universe and look at it

### 2 - Advanced counting things

#### - LL Book Ch 4 - Binomial Theorem

##### Binomial stuff

- **The number of ordered k-subsets of an n-set is n(n-1)...(n-k+1)**
  - Or, n! / (n-k)!
- **The number of k-subsets of an n-set is n! / (k!(n-k)!)**
  - Call this n choose k
  - We overcounted by k!, duhhhhhhh
- N choose K are *binomial coefficients*
- **The Binomial Theorem**:
https://gyazo.com/231b62be4247dc22294f42387d585611

##### Distributing presents

- What if you need to distribute things
- **Number of ways to distribute n things between k children is n! /
  (n1!n2!...nk!)**. You overcounted all of the permutations (n!) where
  each child still got the same set of presents

##### Distributing money

- Presents are _distinguishable_, pennies are not. Thus, fewer distinct
  ways to distribute pennies
- **The number of ways to distribute n identical pennies to k children,
  so that each child gets at least one, is (n-1 choose k-1)**
  - n-1 points where you can swap out a child for another child, we have
    to select k-1 of those points (since first child always starts at
    beginning)
  - ** The number of ways to distribute n identical pennies to k
    children is (n+k-1 choose k-1)
- Man, my poor brain

#### LL Book Ch 5 - Pascal's Triangle

- I've seen this before
- Formula for finding the proportion between the middle entry and the
  entry at index t

##### Identities

- Every number is the sum of the two numbers immediately above it

##### Bird's-Eye View

- It's symmetrical
- Entries increase until middle, then decrease
- Identity: (n choose k+1) / (n choose k) = (n-k) / (k+1)
- This got real deep real fast fam

#### Lecture

- Draw out the combinations thing by with m or n = 3
  - Every time you choose down first, you're double-counting blah blah
- Note: function in math and function in programming are NOT equivalent
  - Function is mapping of inputs to outputs; programming "functions"
    are more like procedures
  - Function maps each item from set X to precisely one value of set Y
  - X is domain, Y is range
  - *Surjective* "on to": every value of X maps _on to_ a value of Y.
    The entire output range is covered/reachable
  - *Injective* "one to one": every value of X maps one-to-one to Y
    - Real numbers->Real numbers for a squaring function is injective
      but not surjective - it's a one to one mapping, but negative real
      numbers in the range are not reachable
  - *Bijective*: both surjective and injective
- Bijection: a one-to-one mapping that covers the entire output space

### 3 - Probability

#### LL Book Ch 7

- *Probability theory*: way of modeling dependence of outcomes on chance
- *Probability space* or *sample space* is the set of possible outcomes
  - We only consider *uniform spaces*, where each outcome has the same
    probability

#####  Independent repetition

- *Independence* of events: information about one doesn't influence
  probability of other
- Null set independent from every event

##### The Law of Large Numbers

- **Let 0 ≤ t ≤ m. Then the probability that out of 2m independent coin
  tosses, the number of heads is less than m − t or larger than m + t,
  is at most m/t2.**
- Corollary: **With probability at least .99, the number of heads among
  2m independent coin tosses is between m − 10√m and m + 10√m.**
-

#### Lecture

- New information updates your model of the world!
- Bayes Bayes Bayes

### 4 - Logic

#### MCS Ch 1 (25 pages)

- A *mathematical proof* of a proposition is a chain of logical
  deductions leading to the proposition from a base set of axioms
- A *proposition* is a statement (communication) that is either true or
  false.
  - Up to us to prove or disprove
- For programmers, very important to be able to prove correctness of
  programs and systems if possible
- A *predicate* can be understood as a proposition whose truth depends on
  the value of one or more variables
  - e.g. "n is a perfect square"
- *Axioms* are things that are accepted as true
- *Theorems* are important true propositions
- *Lemmas* are preliminary propositions useful for proving later
  propositions
- *Corollaries* are propositions that follow in just a few logical steps
  from a theorem

- Hard to tell if you should or should not be assuming something, so
  best practice is to be very up front about your assumptions
- *Inference rules*, or logical deductions, are used to prove new
  propositions using previously proved ones
- *Modus ponens*: a proof of P + proof that P implies Q equals a proof
  of Q
- Written fraction-like, where *antecedents* are above the line and
  *conclusion* is below the line
- *Sound* inference rule: assignment that makes all antecedents true
  must also make the conclusion true
- Woohoo, some proof templates. See book
- You'll often need to do some scratchwork while you're trying to
  figure out the logical steps of a proof. Your scratchwork can be as
  disorganized as you like—full of dead-ends, strange diagrams, obscene
  words, whatever. But keep your scratchwork separate from your final
  proof, which should be clear and concise.
- Proofs typically begin with the word “Proof” and end with some sort
  of de- limiter like [square]  or “QED.” The only purpose for these
  conventions is to clarify where proofs begin and end.
- Read through the different types of proofs
  - Proof by contradiction, by cases, etc.
- Proofs are tough. Some tips:
  - State your game plan
  - Keep a linear flow
  - A proof is an essay, not a calculation
  - Avoid excessive symbolism
  - Revise and simplify
  - Introduce notation thoughtfully
  - Structure long proofs
  - Be wary of the "obvious"
  - Finish!
- Come back and do problems?

#### MCS Ch 3 - Logical Formulas (21 pages)

- Need a special language for precise communication because of
  ambiguities in other written/spoken language
- Not/And/Or change or combine propositions, just like in boolean logic
- *iff* is if and only if: true if both sides are the same
- An *implication* is true exactly when the if-part is false or the
  then-part is true. Okay
  - "If pigs could fly, then your account won't get hacked" is a valid
    mathematical implication, but remember that it _ignores causal
    connections_ :)
- This stuff comes up all the time as boolean (or otherwise) logic in
  computer programs
  - Simplifying these boolean expressions is nice
- Bleh, some cryptic notation
- Implications and their contrapositives are logically equivalent - "If
  I am hungry, then I am grumpy" == "If I am not grumpy, then I am not
  hungry"
  - *Converse* (If I am grumpy, then I am hungry) is not necessarily
    true though
- Formula is *valid* iff it is equivalent to T
- Formula is *satisfiable* if it can be equivalent to T under certain
  circumstances
  - E.g. if you need to fit all of the specs, the set of specs must be
    satisfiable (the && of all specs must be achievable)
- *Disjunctive form* of a propositional formula is pretty much the most
  naive way to write it - expand all of its terms and write it as ORs of
  all the AND terms: (true evaluation) || (true evaluation) ...
- *Conjunctive form* is the expansion of all terms that evaluate to
  false: (false evaluation) || (false evaluation) ...
- Using truth tables works for small expressions, but for larger ones
  may need to use algebra to prove equivalence
- Use properties of booleans and such
- Problem of deciding whether a proposition is satisfiable is *SAT*
  - This is np-hard
- "For all", "sometimes"  are statements that quantify how often a
  predicate is true. An assertion that a predicate is always true is a
  *universal quantification*, assertion that predicate is sometimes true
  is *existential quantification*
  - Changing order of quantifiers changes meaning of proposition most of
    the time
- Ayyah, okay, lots of this was over my head, but at least I got a
  somewhat general idea

#### Lecture

- All the set stuff translates to logic: the truth set is the set of
  values that satisfy a predicate or something

### 5 - Induction

#### LL Ch 3 (p21-p27)

- *Mathematical induction*: say you want to prove a property of positive
  integers, and you can prove:
  - 1 has the property
  - Whenever n - 1 has the property (n >= 1), then n has the property as
    well
- *Principle of induction* says that if you meet these two criteria
  every positive integer fits these criteria
- Process: try to prove statement for n, allowing to use that the
  statement is true if n is replaced by n - 1. If can't do this, can't
  prove :)
- Do exercises
- Okay, walkthrough of counting regions
  - The +1 comes from the bottom of the blackboard - if 4 intersections,
    5 regions

#### Lecture

- Reason through stuff! Use more rigor than "hackers" might
- *Rational numbers*: basically, every possible pair of integers that
  can be expressed as a fraction
- *Isomorphic*: bijection between these two things
- Induction: prove base case + continuation over anything that's
  countable
  - *Countable*: bijection with natural numbers
- Aliph naught (X0) is the size of a countably infinite set
- Can use induction to prove things about aliph naught sets

- Proof format
- Theorem:  blah blah
- Proof: we use mathematical induction
- Base case: .....
- Inductive case: suppose that [base case]. Then, [prove inductive case
  using inductive hypothesis] as required. Therefore, the theorem holds
  true

- Strong induction: basically, prove more stuff
- Induction step: If P(m), P(m+1), P(m+2)… P(k) is true then  P(k+1) is
  true as well for some k > m.
- Prove more stuffs
- Use strong induction if P(m-1) doesn't directly help you solve P(m)
- Graph with K connected components, number of edges is bounded by Sum
  from 1 to k of (ni choose 2) where ni is the cardinality of the ith
  copmonent's vertices

### 6 - Graph Theory

#### LL Ch 9 (p73-p81)

- *Graph* is *nodes* connected by *edges*
  - Each edge is a set {u, v}
- Use graphs whenever you have a "relation" between certain objects
  (atoms, connections, descendence, etc.)
- **In every graph, the number of nodes with odd degree is even**
- **The sum of degrees of all nodes in a graph is twice the number of
  edges**
- *Empty graph*: nodes but no edges
- *Complete graph* (clique, strongly connected component): make all th
  edges
- *Cycle*: connect consecutive nodes until you get back to the first
- H is *subgraph* of G if you can get H from G by deleting notes
- *Connected* graph: every 2 nodes can be connected by  apath
- Cool, playing around with graphs and such

#### LL Ch 12 (p98-p110)

- Ok
- *Bipartite graph* has two sides, connected from side to side in a
  given way, nodes on the same side don't have connections
  - *Perfect matching*: set of edges in bipartite graph such that each
    node is incident with exactly one of them
  - *Degree* is how many nodes each node is connected to
- **If every node of a bipartite graph  has the same degree d>=1, then
  it contains a perfect matching**
  - Or, for every k nodes on the left, there must be at least k nodes on
    the right connected to at least one of them (see below)
- *Marriage Theorem*: **A bipartite graph has a perfect matching if and
  only if |A| = |B| and for any subset of k nodes of A there are at
  least k nodes in B that are connected to one of them**
- Proof: try and prove that _if a "good" (satisfying conditions of
  marriage theorem) bipartite graph then it can be partitioned into two
  good bipartite graphs_, broken down so on and so forth
- Ayyah, okay
- Okay, now you can see if a bipartite graph has a perfect matching -
  but how to actually find it?
- *Matching*: a set of edges that have no endpoint in common
  - Becomes perfect when edges cover all the nodes as well, but regular
    matchings can be much smaller
- *Augmenting path*: path that starts and ends at nodes that are
  unmatched by your matching M; every second edge of P belongs to M
  - If we find one, delete edges of P that are in M an dreplace them by
    edges of P that are not in M
  - Keep doing augmenting path until you find perfect matching or
    there's no more augmenting path
    - If no more augmenting path, no perfect matching!
  - *Almost augmenting*: everything but the last edge in augmenting
    path; ends with a node in M

- *Hamiltonian cycle* is a cycle that contains all nodes of a graph
  - In perfect matching every node belongs to one edge, in Hamiltonian
    cycle every node belongs to two edge
- np-hard to find them
- Not a ton known

### 7 - Linear algebra crash course

#### Essence of Linear Algebra Videos 1-7
https://www.youtube.com/watch?v=kjBOesZCoqc&list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab&index=1

- People end up understanding linear algebra on a numerical level (i.e.
  how to do a matrix multiplication from memory), but you'd rather have
  a geometric understanding so that you have an intuition for which
  tools to use when
- Core visual intuitions underlie the subject

##### Vectors, what even are they?

- Physics definition: arrow pointing in space; defined by length +
  direction
- CS definition: ordered list of numbers, i.e. [square footage, price]
  tuple for houses
- Math definition: generalizes both of these; anything that can be
  sensibly joined or added. Use more concrete setting most of the time
- When you hear *vector*, think about arrow in coordinate system
  starting at the origin
  - Then, coordinates can be used to translate into a list of numbers :)
- Pair of numbers is a bijection with vectors: (x, y)
  - In 3D, just add one more number
- Every topic in linear algebra centered around vector addition and
  multiplication by numbers
- To add: move tail of 2nd to head of 1st, then draw new vector from
  tail of 1st one to new head of 2nd one, new vector is the sum. Cool.
  Visual :)
- To multiply: Stretch out to be a multiple of original length
  - Called "scaling" --> *scalar* is the factor you stretch out by
- Visual visual

##### Linear combinations, span, and basis vector

- Subtlety to thinking about vector coordinates: think of both the x and
  y coordinates as scalars on the ^i (1, 0) and ^j (0, 1) vectors
  - Cool
  - ^i and ^j are the *basis vectors* (the things that are scaled by the
    coordinates zzz)
- Can reach any possible vector from any basis vectors
- *Linear combination* is scaling and then adding
- *Span* of two scalars is the set of all their linear combinations
  - Span of most pairs of 2D vectors is all 2D vectors
  - Unless they line up, then it's all vectors whose tip lines on that
    line
- Tip: **Think of individual vectors as lines, think of sets of vectors
  as points**
- What is the span of two 3D vectors?
  - A 2D plane? Yes
- Span of three 3D vectors is the entire 3D space
- *Linearly dependent* vectors: one vector in a set of three can be
  expressed in terms of the linear combinations of the other two vectors
  - If this isn't the case, they're *linearly independent*
- The *basis* of a vector space is a set of linearly independent vectors
  that span the full space
  - okay

##### Linear transformations and matrices

- Linear transformations* relationship to matrices :thinking_face:
- *Linear transformation*
  - Tranformation analogous to function; in linear algebra,
    generally a vector input and vector output
    - In 2D: think of transformation as operation on the entire 2D grid
  - Linear ones: all lines must remain lines, origin remains fixed in
    place
- How to describe linear transformation numerically? Just give the new
  basis vectors :)
- Ez visualization
- Any 2D linear transformation is described by the coordinates of new ^i
  and new ^j, woohoo
- Whoa, matrix-vector multiplication explained :)
  - Any transformation can be described by a 2x2 matrix
  - This is intuitive! Columns in 2x2 matrix are the new basis vectors,
    and the 2x1 vector is just the original coordinates
- Matrices transform space!!!!!!!!!!!!

##### Matrix multiplication as composition

- *Composition* can be defined by recording where ^i and ^j land
  after two successive transformations
- This is matrix multiplication: applying one transformation after
  another
- How to get composition without looking at animation? 2x2 matrix
  multiplication. zzz. Ayyah
- Apply first transformation to ^i, then multiply by second to get the
  final spot for ^i
- Order doesn't matter
- **Good explanation > symbolic proof**

##### Three-dimensional linear transformations

- Whew, [3x3][3x1]. Okay
- Zuggly

##### The determinant

- ¿Cuál es?
- How are areas squished or scaled by a linear transformation?
  - Measure factor by which area of given region increases or decreases
  - If the area bounded by the basis vectors goes from 1->6, then you
    say the transformation scaled the space by 6
  - Whatever happens to one square must happen to every other square!
- The *determinant* is the scaling factor of a transformation
- If determinant is 0, you got squeezed into a smaller dimension
- Focus on 1x1x1 cube for 3 dimensions, focus on 1x1 square for 2
  dimensions
  - In 3D, slant object that cube turns into is *parallelepiped*
- How to compute determinant?
  - ad - bc where matrix is [a b, c d]
  - With 3D, :zzz:
- Why does det(M1M2) = det(M1)det(M2)
  - Basis vectors end up in same place, so the area scale is the same

#### Lecture

- Don't get too attached to geometric or non-geometric definitions of
  vector - still need to conceptualize a 26-dimensional vector
  sometimes!
- Dot product is the projection of one vector onto another (using right
  angle yaya)
- Fractal is an object with infinite surface area, bounded volume

### 8 - Cryptography

#### LL Ch 8: Integers, divisors, and primes (p55-73)

- Properties of integers, AKA *Number Theory*
- *1|a* means a is divisible by 1
- *Primes* are not divisible by any other integer than 1, -1, p, and -p
- Lots to understand still!
- Every number has a unique basic prime factoring :)
- Difficulty of prime factorization and finding new primes is still
  ridiculous
- **Fundamental Theorem of Number Theory: Every positive integer can be
  written as the product of primes, and this factorization is unique up
  to the order of the prime factors**
  - No integer can have two different prime factorizations
- **The number sqrt(2) is irrational (cannot be written as the ratio of
  two integers)**
- **There are infinitely many primes**
- **For every positive integer k, there exist k consecutive composite
  integers**
  - Big gaps between primes!
- *Composite Integer*: integer n > 1 that is not a prime
- *Twin primes*: primes that are two apart
- **Prime number theorem: number of primes among 1, 2, ...n is ~ (n/ln(n))**
  - Sketchy

- More, more, more!
- **Fermat's Little Theorem**: If p is a prime and a is an integer, then
  a^p - a is divisible by p

- So what do we do with these primes and prime factors?
- Find the *GCF* (greatest common factor) - biggest thing that is a
  common factor
  - *Relatively prime* numbers have a GCF of 1
- *LCD* is the least common divisor, can get it from the common prime
  factors, okay
- Ugh I remember this shitty way to find the GCD using Euclidean
  algorithm. Fine maybe it's not shitty I just didn't much enjoy doing
  it
- **The number of steps of the euclidean algorithm, applied to two
  positive integers a and b, is at most log2(a) + log2(b)**

- How to test number for primality?
- Whew

#### LL Ch 15: A glimpse of cryptography (p117)

- *Cryptography*: the science of secret communication
- Message to send is *plaintext*
- *Key* is what unlocks the translation from ciphertext to plaintext
- Naive/simple: *substitution code*, replace each letter of alphabet
  with another one :)

#### LL Ch 16: One-time pads (p117-123)

- Safer cryptography
- *One-time pad* is randomly generated string of 0's and 1's
- Both parties share the pad, do a bitwise operation on the plaintext to
  produce ciphertext, and vice versa
- Chess move example, read and intake please
- Primes!
- **It is easy to test whether a number is a prime (and thereby it is
  easy to compute the encryption), but it is difficult to find the prime
  factors of a composite number (and so it is difficult to break the
  cryptosystem)**

- RSA encryption
- K

#### Lecture

- Use a clock metaphor for modulo arithmetic
- The multiplicative inverse of a(mod b) exists if gcd(a, b) is 1

- Oz walking through RSA
- "RSA is computer science's most successful bijection"; function from
  set of all possible plaintext messages to all ciphertext messages
  - D(E(m)) = m; for there to be an equivalent D for E, E must be a
    bijection
- Generaate two large primes p and q
- n = p * q
- Message will be integer m so that 0 less than m less than n
- Encryption: E(m) = x; x = rem(m^e, n)
- Decryption: D(x) = m; m = rem(x^d, n)
- GCD: tiling problem (biggest tiles you can use to perfectly tile a
  rectangular space?)
- Fermat: you can always construct a bijection because if p is prime,
  then a and p must be coprime. Now you can check if a number is prime
  - a^(p-1) ~= 1 (mod p)
- Okay, now for RSA
- Rewrite Fermat: a^((k)(p-1)) = 1 (mod p)
  - Because 1^(anything) is 1
- Then a^((k)(p-1) + 1) = a (mod p)
- Can't find private key given public key!
- Used extended Euclid (GCD) algorithm (or the Pulverizer) to find the
  multiplicative inverse of e, which is d, which is part of the private
  key
- Need to show that n | (m^(ed) - m)
  - Know that n is the product of two primes p and q
  - So if p and q both individually divide into that expression, then n
    must divide into that expression
  - Remember, ed ~= 1 (mod (p-1)(q-1))
  - So, ed = k(p-1)(q-1)
- Combine all this, need to prove:
  - p | m^(k(p-1)(q-1)+1) - m
  - q | m^(k(p-1)(q-1)+1) - m
