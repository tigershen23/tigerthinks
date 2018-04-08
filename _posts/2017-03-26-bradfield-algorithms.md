---
layout: course_post
title: 'Problem Solving with Algorithms and Data Structures'
date: 2017-03-26 00:00
categories:
tags: [course, technical, programming, cs, bradfield]
author: Bradfield
rating: 4
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/algorithms/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's algorithms class"
---

## Notes

### 1: Introduction to technical problem solving and analysis

#### Prework: Hammock Driven Development (talk by Rich Hickey)

- Time for hard thinking is critical
- Solve problems! Don't just write features
- Users can specify problems, but not answers :)
- Gotta practice problem solving to get good at it

- First, state the problem (write it, say it please)
- Understand the problem. What do you know? What don't you know? Are
  there related problems? What are the solutions to those?
  - More input->Better Output. Get domain knowledge. When you come across
    other solutions, criticize them!
- Plan
- Execute
- Tradeoffs: must look at two or more possible solutions before you can
  talk about tradeoffs!
- Focus: get away from da computer boss. Recognize that focus itself is
  a tradeoff, and you'll drop the ball on some stuff
- Two parts of the brain for this
  - Waking mind is good at critical thinking. However, not good for
    thinking outside the box (only finds local maxima). Should be used
    to feed work to the background mind
  - Background mind is good at synthesis, connection, strategy, etc.
    Happens during sleeping mostly. Solves non-trivial problems creatively,
    finding hidden relations and stuff
- Still need to use silly brain to figure stuff out. Can only load some stuff
  in the brain, need to write other stuff down
- Now get back to the hammock and meditate on your solution
- Don't go crazy working on different things each day, but different
  projects over the course of months is fine

#### Lecture

- SOLVE THE SUBPROBLEM

### 2: Stacks, Queues, Lists

- _linear data strucutres_ means that when an item is added it stays in
  the same position relative to its neighbors
    - distinguished by where additions and removals may occur

#### Stacks

- Insertion order is reverse of removal order
- Can add or remove from top, other end is base
- Definitions
  - Abstract Data Type (ADT) - logical description of view of data,
    regardless of implementation. Hides implementation details and
    encapsulates data ("information hiding")
  - Data structure is an actual implementation of an abstract data type

#### Queues

- First in first out. Insertion happens at the rear, removal happens at
  the front

#### Deques

- Pronounced like deck
- Combined queue + stack, can add + remove from rear and front in O(1)
  time

#### Lists

- Pretty ez? Linked list, double linked list. Each node has a value and
  a next. Skim skim

#### Searching

- Pretty straightforward, can probably skim most of this
- Sequential search zzz, just look through list. Ordering list improves
  average case when item is not in list because you can fail fast but
  not much else
- Binary search on an ordered list is gucci. BUT in real world must
  always consider whether or not it's practical to sort first; doing a
  sequential search may beat sort then binary if you're only going to do
  one search, for example

### 3: Trees, tree traversal, and priority queues

#### Trees

- Hierarchical relationships :)
- Based on real trees :) root, branches, leaves
- Properties of trees:
  - Can be followed top to bottom getting more specific each time
  - Each leaf is independent of others
  - Each leaf is unique
  - Sections can be moved around without affecting lower levels
- Definitions
  - *Node*: a "piece" of the tree. Generally contains information,
    referred to as payload
  - *Edge*: connects two nodes to show a relationship. Each node except
    root has one and only one incoming edge, one node can have many
    outgoing edges
  - *Root*: top node of tree, no incoming edges
  - *Path*: ordered list of nodes connected by edges
  - *Children*: set of nodes that have incoming edges originating at a
    given node are the given node's children
  - *Parent*: the node from which the incoming of our node originated
    from
  - *Sibling*: Children with same parent are siblings (What if same
    level of nesting, diff parents?)
  - *Leaf Node*: node with no children
  - *Level*: level _n_ is the number of edges on path from root node to
    _n_. Root node's level is 0
  - *Height*: Maximum level of any node in tree
- Two definitions for a tree
  - Set of nodes and edges that connect pairs of nodes. One node is the
    root, every other node is connected by an edge from exactly one
    other node (its parent), there's a unique path from root to each node
  - Either empty or has a root and zero or more subtrees, each of which
    is a tree itself. Root of each subtree is connected to the main root
    by an edge
- Can be represented by "nodes and references", but that's tougher.
  Dictionaries and lists are okay for us
  - Nodes and references: tree made up of Node classes. Each Node has
    value, left, and right, where left and right are either empty or
    point to another node
  - List of lists: list of triplets, where index 0 is value, index 1 is
    the left node, and index 2 is the right node
  - Dictionary representation with keys and values is preferred though
    because it's more readable and easier to see the tree-like structure

- Let's look at building and traversing parse trees for simple math
- Building a tree we may need to traverse back up to the parent to
  continue. Use a stack for this, pushing and popping the parent on the
  stack
- After building parse tree, we can walk it recursively to evaluate each
  sub expression and then bubble all the way back up to the root

- Traversal!
- preorder, inorder, and postorder
  - preorder: visit root first, then recursively pre-order traverse the
    left subtree, then pre-order traverse the right subtree
  - inorder: recursively indorder traverse the left subtree, then visit
    root node, then recursively inorder traverse the right subtree
  - postorder: recursively postorder traverse the left tree, postorder
    traverse the right tree, then visit the node
  - Difference is just when you evaluate and order of traversal

- Priority queue is like a queue except highest priority (not first in)
  is popped off first
  - Can be implemented with sorting and lists, but that doesn't give us
    the best time complexity operations. Better to do da binary heap.
    O(logn) enqueueing and dequeueing
- Two types of binary heap
  - Min heap where smallest key at front
  - Max heap where largest key at front
- All based on maintaining the *heap order property*: in a heap, for
  every node x with parent p, the key in p is smaller than or equal to
  the key in x. Whew
- Heap structure property, Complete tree property, ??
- Start binary heap with a 0 at the first index so that you can begin
  adding elements. This zero is not used
- When adding a leaf to the heap binary heap, if it's smaller larger than its
  parent, swap it with its parent. Keep going until it's larger than its
  parent
  - PARENT OF CURRENT NODE IS ALWAYS CURRENT INDEX OF NODE DIVIDED BY 2
  - percolate\_up() is done to reset all dem nodes
- So to insert an item, append to items and then percolate
- Delete min returns the minimum value item and returns it (remember,
  this is a min heap)
  - First we take the top guy and pop it off, then move from the end of
    the array to the beginning. Then we have to percolate all da way
    back down
- Build a heap from list of keys by starting with the entire list and
  percolating over and over :thinking\_face:
- Use case: prioritize customer support requests from users of different
  access/VIP-ness levels

- Binary search tree time
- Map ADT has operations on key value pairs :)
- *BST Property*: keys less than the parent are found in the left
  subtree and keys that are greater than the parent are found in the
  right subtree
  - Means always O(logn) to search or insert in binary search tree
- Need to consider self rotation and whatnot. Hard problems but have
  been solved :)
- Implement using nodes an references.`TreeNode` has the lower level
  logic, `BinarySearchTree` has a reference to the root node and is the
  interface the user interacts with
- TreeNode must keep track of parent for deletion purposes, so that its
  children can come attached to parent
  - yield/__iter__/generator sugar for fun stuff
  - When you do 'for elem in TreeNode' it returns left all in a row then
    itself then right all in a row
- Now the actual map interface
- How to put something?
  - Start at root, search and compare new key to key in current node. If
    new key is less than current node, search left side and if new key
    is greater search right side
  - If there is no left/right child to search, we found the right spot
    for the node. Cool beans
  - Rip duplicate handling. Probably best to just have new value replace
    old value instead of trying to resolve both
- How to get something?
  - Search tree recursively until there's a non-matching leaf node or we
    found the thingy we want
  - Python calls __getitem__ under the hood for you when you do
    dictionary lookup
- Deletions?
  - Start off same as before, traverse tree until you find the node with
    the key you want (raise error if not found)
  - If node has no kids, easy, just remove the reference to this node in
    the parent
  - If node has one kid, couple steps. Need to promote the kid to the
    parent
    - If current node is a left child itself, update parent reference of
      left child to point to parent of current node, then update parent.left
      to point to the left child
    - If current node is a right child, do the inverse of the above
    - If current node is a root node, call `replace_node_data()` with
      the data from the promoted node
  - If node has two kids, we must find the `successor` (node that will
    preserve the BST property). This will be the next-largest key in the
    tree
    - Successor guaranteed to have one or fewer kids because it's the
      next largest, sooo it can't have a left subtree
    - Find successor with `self.right.find_min()`
    - If you have no right subtree, you find your parent's successor and
      use that insteaderino
- Analyze a BST
  - Insertion is log base 2 of n in a balanced tree
  - Everything is! Worst case is searching every level of the tree, which
    is log base 2 of n

- AVL Trees
- Basically keeps the tree balanced using a balance factor (height of
  left subtree - height of right subtree)
  - If balance factor becomes -1 or 1, do a tree rotation. This is
    constant time so we gucci
  - Balance factor > 0 is LEFT HEAVY, balance factor < 0 is RIGHT HEAVY
  - Fancy math derivations shows that at any time the height of AVL tree
    is 1.44 times log of number of nodes in the tree. Proves that search
    is O(log N)
- Implement by keeping a balance factor for each node/subtree
  - If a node is added to the right, balance factor of parent is -1; +1
    if added to the left
  - Once a parent balance factor is zero, all ancestors don't change any
    more. Cool
  - How to update balance? If current node is out of balance, just
    rebalance self and you're done
  - Otherwise increment parent balance factor and gogo
- There's some trickiness where you have a tree that is still unbalanced
  after rotating (e.g. it zigzags)
  - To correct: if subtree needs left rotation to balance it, first
    check balance of right child. If right child is left heavy then do a
    right rotation on right child before doing your originally intended left
    rotation
  - Do opposite for if subtree needs right rotation

#### Lecture

- Hashing
- Hashing algorithm that takes keys and produces index in a finite space
  (e.g. convert to ASCII and modulo 10)
- We've got collisions when we try to hash keys to a finite space when
  two things point to the same space
  - Can do _chaining_ which will put pointers in your finite space and
    then those pointers would point to a linked list
    - Each node of the linked list stores the original key, so that
      multiple keys that hash to the same value can be resolved still
  - Other way is open addressing
- In a hashing function you want to make entropy high so you get good
  even distribution
  - Commonly, take first 4 bytes of a key and xor them all against each
    other. Use xor instead of and/or because truth table is balanced
- Check out Ruby hashing conversation
- Results in a super nice API but a nightmare behind the scenes :)
- Implement a little hash map if you get time
- Load factor is 6/11 if 6 out of 11 spots in your hash table are filled
- _perfect hash function_ maps each item to a unique slot; only possible
  if we know all the inputs in the collection and that they will never
  change
- "Folding" is breaking up the key into parts (e.g. "asdfasd" broken
  into "as" "df" "as" "d") and then performing a function on it
- Collusion resolition boys
  - Open addressing: find an open address!
    - Linear probing just looks sequentially for the first open slot
    - Can do a "plus 3" probe too that searches every third
      thingymabobber
  - This process of computing a new place for the key to resolve
    collision is _rehashing_.
- Also chaining, described above
- What's the time complexity of these operations? Depends on the load
  factor!

- Lots of things are trees!
- If there isn't defined hierarchy, it's a graph :)
- Forest traversal is just lots of trees
- Depth first vs. Breadth first stuff
- Using a stack, if you start at the root, pop, then push children,
  and recurse, you've done a depth first traversal
- If you use a queue you do a breadth first traversal!
  - Both can be recursive!
- When use DFS vs when use BFS?
  - If going through everything it doesn't matter
  - If you can terminate early based on your choice, that's a better one
  - If you want to find the X closest to the root use BFS, or like the
    shortest way to get somewhere
- In AI: need to model all the states and check all of them
  - e.g. How do you find da bes tic tac toe move
  - For tic tac toe you can build out a game tree and see whats up
- Brute force sudoku: strategy called backtracking where you keep
  "building" the board that you're traversing to, and then you go back
  once you hit an impossible point
  - If you want to find if you have any paths > 10 use DFS
- Branching factor is "average" number of children for each node (binary
  tree has branching factor of 2)

- Binary Search Tree
- Need to keep 'em self balancing dawg
  - Check out red black trees
- B-Trees in database indices
  - Bunch of information packed into each node
  - Now each child of the "chunk" of info in each node is just a
    subsection
  - Ends up being very stumpy

### 4: Graphs

#### Graphs!

- *Vertex* or node is the fundamental building block. Can have a payload
- *Edge* is the fundamental connector. Connects two vertices to show a
  relationship. If one-way, it's a directed graph (digraph); if two-way,
  just a graph
- *Weight*: edges can be weighted to show the cost of going from one
  vertex to another. How expensive to traverse
- Graph made up of vertices and edges. Each edge is made up of (v, w)
  tuple where v and w are vertices, and possibly a weight as well
- *Path* is sequence of vertices that can be traversed directly
- *Cycle* is a path that starts and ends at same vertex. Graph with no
  cycles is *acyclic*. Digraph with no cycles is *directed acyclic*.
  This will be important

- How to represent a graph?
- Adjacency matrix
  - Just a 2d matrix with all vertices on both sides, and intersections
    with vertices filled in with weights
  - Results in sparse data, which is no bueno because matrix operations
    are expensive
  - Only good for when number of edges is large relative to number of
    vertices
- Adjacency "list" (bad name) (most intuitive and flexible)
  - Keep a master collection of all vertices, and then each of those
    vertices maintains a list of other vertices that it connects to (and
    the weights of the connection). Cool got it. List of connections is
    `neighbors`
  - We can compactly represent a sparse graph :)
  - Also lets you easily find all links directly connected to particular
  - Can be represented as just a dictionary and you can interact with it
    directly. Cool. Demonstration purposes of wrapping Vertex and Graph
    classes was helpful though

- Word ladder
- Get from one word to another by swapping one letter at a time; each
  intermediate must also be a word
- Can represent relationships between all words as a graph, then use
  breadth first search to find the quickest path from start to end
- Process for creating graph: Start with your word. "Wild card" one
  letter at a time, plug in all possibilities for that letter, and if
  you do this for all letters in the word you have the list of all words
  that are one letter away. This is the word's "bucket". See
  `word_ladder.py`
- Okay let's do a breadth first search
- Starting at vertex s, breadth first search first goes to all vertices
  with an edge from x. Then goes out from those to the next level.
  Visualize it as building a tree, one level at a time, where height of
  tree is distance from starting point
- Use a set to keep a record of which vertices have been visited already
- Use a queue to contain the paths from our starting vertex that have
  been processed already
- Process
  - Pop a path from our queue to explore
  - Retrieve the last vertex visited from that path
  - Retrieve neighbors from graph
  - Remove vertices that have been visited already
  - For each of the remaining neighbors, add the vertex to visited and
    add a path consisting of the path so far plus the vertex
- Visualization in the book
- Run time performance is O(V + E) where V is number of vertices in
  graph and E is number of edges

- Knight's Tour
- Heuristics wow
- Why does this have such an improvement

- General depth first search goal is to connect as many nodes in the
  graph as possible and search as deeply as possible
- Can create multiple trees. Group of trees is a *depth first forest*
- To produce a forest just DFS from all vertices
- If you track the discovery and finish times of a depth first search,
  you see the *parenthesis property*: all children of a node have a
  later discovery time and earlier finish time than their parent

- Top sort!
- Pancake recipe instructions: stuff needs to be done with dependencies,
  is there a best way to do it?
- Top sort takes a DAG and produces a linear ordering of all of its
  vertices such that you always do the dependencies of a vertex before
  the vertex itself. Indicated precedence of events
- Adaptation of depth first search
- First, do a depth first search to compute finish times
- Store the vertices in a list in decreasing order of finish time
- Return ordered list as result of topo sort. Wowza

- Dijkstra's Algorithm to find shortest path :)
- Example of routers directing internet traffic. Can be represented as
  weighted graph
- Want to find the path with the smallest total weight to route a
  message
- Algorithm is Dijkstra's Algo
- Iterative. Similar to breadth first search
- Use priority queue to arrange "next move"s according to total distance
  from start. Always dequeue the lowest total distance and move
  accordingly
- Wut da furq
- Ok cool
- Need to implement

- Strongly Connected Components
- Let's think about very big graphs (web pages, etc.)
- By looking at the graph of links to and from a site you can get an
  idea of how to categorize things on the web and such
- Strongly Connected Component is the largest subset of vertices such
  that we can go to any other vertex from any vertex in the SCC
- *transpose* of a graph is the graph where all of the edges have
  been reversed (i.e. edge from node A->B becomes edge from B->A)
- To get the SCC for a graph:
  - Perform DFS for the graph to compute finish times for each vertex
  - Compute the transpose
  - Perform DFS of the transpose but explore each vertex in _decreasing
    order_ of finish time from first step
  - Each tree in the forest computed in step 3 is an SCC. Output vertex
    id's for each vertex in each tree in the forest to identify the
    component
- Cool, must implement

- Prim's spanning tree algo
- Problem: need to broadcast to everyone on a graph
- e.g. broadcast host needs to hit every listener to get all of the
  sound data out
- Brute force: just send one copy of the data to each listener. Need to
  send n copies for n listeners.  Routers see extra, unbalanced traffic
- Uncontrolled flooding: each msg starts with a time to live value set
  to a number >= number of edges b/t broadcaster and furthest listener.
  Each router receives message and passes to all neighbors. When message
  is passed, ttl decreased, messages keep getting sent until ttl reaches
  0. Way more messages than is necessary
- Solution involves constructing a minimum weight *spanning tree*
- This is an acyclic subset of original graph that connects all
  vertices. Sum of weights of edges in the spanning tree is minimized
- So now, one copy of message gets sent, and each router just forwards
  it to other routers who are a part of the min spanning tree. This
minimizes message passing and every listener still gets the message
- Prim's algorithm is "greedy", since it chooses the cheapest next step
  at every step
  - In this case, follow edge with lowest weight
- While T is not yet a spanning tree, find an edge that is safe to add
  to the tree and add it :)
  - Safe edge is any one that connects a vertex that is in the spanning
    tree to one that is not in the spanning tree
  - Assures no cycles
- Cool beanss

#### Lecture

- Implement breadth first search for pancake problem

- Weighted nodes
- Uniform cost search/Djykstra is the same as BFS but using a priority
  queue
  - The stuff you enqueue and dequeue is the total length

- Strongly connected component means you can get to any node from any
  node
  - Clique means everything is connected to everything

- Topological sorting is finding the most efficient way thru a DAG
  - Put stuff into a stack to go through

- Min spanning trees
  - What means? Connect everything in the least amount of space
- Take shortest edge connected to ur stuff. Cool

### 5: Recursion

- Compute sum of a list of numbers. How do without a loop?
- Imagine it's parenthesized. Can evaluate each subexpression and bubble
  up
- Recursion: call yo self
- Nice

- Three laws
- Must have a base case
- Must change state and move towards base case
- Must call itself recursively
- Nice to see it broken down like this

- Example of converting int to string representation in another base
- Example of Tower of Hanoi. Cool

- Dynamic Programming: solve subproblems just once
- When a problem has overlapping subproblems, dynamic programming is
  better than recursion to avoid recomputation
- Avoid redundant calls!
- "Bottom up" counterpart to recursion
- Fibonacci example: straightforward dynamic solution
- Lattice traversal example k cool

- Tail call optimization uses recursive syntax to do iterative action

### 6: NP-Completeness

#### Lecture 23 Skiena

- When you can't find fast algorithm: can either say "I can't find a
  good solution", "there is no fast algorithm" (lower bound proof), "I
  can't solve it but no one else in the world can" (NP-completeness
  reduction)
- Lots of problems that can't be solved! Theory of NP-Completeness says
  that all of these problems are related. If you can prove your problem
  is NP-hard, you good :)
- Main idea!! If you translate from instances of one type of problem to
  instances of another type such that answers are preserved is called a
  reduction.
  - Isomorphic: same thing in different forms
  - If there is no fast way of solving a problem, then there is no fast
    way of solving the reduction either wtf
- For the purpose of proving hardness, take a problem we know is hard
  and reduce our problem into that problem
- Couple of definitions
- *Problem*: general question, with parameters for the input and
  conditions on what is a satisfactory answer or solution. Must be
  specific! E.g. traveling salesman problem: given a weighted graph G,
  what tour {v1, v2, ...vn} minimizes sum of edge weights on the tour
- *Instance*: input to a problem with the input parameters specified.
  E.g. weighted graph is an instance of the traveling salesman problem
- *Decision problem*: answer restricted to "yes" or "no". Most
  interesting optimization problems can be phrased as decision problems.
  Easier to think about things this way since fewer cases to deal with.
  For traveling salesman: given a weighted graph G and integer k, does
  there exist a traveling salesman tour with cost <= k? Now a yes-no
  problem. Now can binary search around k, to narrow down the actual
  answer
- *Satisfiability*: logic problem. Given: a set V of boolean variables
  and a set of clauses C over V. Does there exist a satisfying truth
  assignment for C? wtf
  - Some things are not satisfiable!

#### Lecture

- Why do we think np-complete problems are unsolvable? Because they are
  all reductions of one another and none have polynomial solutions
- P = NP: Polynomial = Non-polynomial
