---
layout: course_post
title: 'Computer Networking'
date: 2017-03-26 00:00
categories:
tags: [course, technical, programming, cs, bradfield]
author: Bradfield
rating: 5
year_taken: 2017
course_url: "https://bradfieldcs.com/courses/networking/"
image: /courses/bradfield.png
summary: "Lecture notes from Bradfield's networking class"
---

## Notes

### Misc

- Book PDFs: https://people.cs.clemson.edu/~jmarty/courses/kurose/
- More: http://jpkc.ncwu.edu.cn/jsjwl/zjxx.asp?id=2
- Slides: https://people.cs.clemson.edu/~jmarty/courses/kurose/

### 1: The big picture: layers of protocols

#### K&R Ch 1: Computer Networks and the Internet

- Start at the Internet and go down into the links and switches
- After survey of implementations, look at things more abstractly -
  models for throughput, delay, transmission, propagation, queueing,
  architecting, etc.

- Nuts and bolts of Internet
- Internet is a network that interconnects a bunch of devices all over
  the world
- Each device is a *host*
- Connections made by *communication links* (cables, wires, fibers,
  etc., each with different transmission rates) and *packet switches*
  (takes a packet arriving on communication link and forwards packet on an
  outgoing communication link)
- Commonest packet switchers are *routers* (in network core) and
  *link-layer switches* (in access networks)
- Sequence of communication links and packet switches from start to end
  is the *route* through the network
- Mental model: similar to networks of highways, roads, intersections.
  Packets are trucks, links are highways/roads, switches are
  intersections, end systems are buildings
- Each ISP (internet service provider) is a network of switches and
  links. Conform to conventions so that they can all access internet
  similar way
- Protocols control send/receive info. TCP (Transmission Control) and IP
  (Internet) are very important. Together, TCP/IP
- Standards come from the IETF (Internet Engineering Task Force), whose
  RFCs define protocols and stuff

- Services of Internet
- It's an infrastructure that provides services to applications like web
  apps, social networks, IMs, etc.
- How do these apps communicate? By following an API (Application
  Programming Interface). Set of rules that sending program mnust follow
  so that the Internet can deliver data to the destination program
  - Postal service API: stamp, from address, return address, post
    office, etc.

- Protocols
- Human analogy: when meeting someone, "Hi how are you my name is
  Tiger", etc etc.
- There are specific messages we send and actions we take in response to
  the received reply messages or other events (like no reply)
- Human analogy: "Got a question?" "Yes" "Yay, what is it?"
- All Internet activity is governed by a protocol. *Protocol* defines
  the format and order of messages exchanged between two or more
  communicating entities, as well as the actions taken on the transmission
  and/or receipt of a message or other event
- Mastering networking === understanding what/why/how of protocols

- What's on the edge of the network? Hosts and what they immediately
  talk to
- Hosts can be clients (ask for stuff) and servers (return stuff)
- *Access network*: network that physically connects edge router (first
  router) on a path from one host to a distant host. Can be home
  network, mobile network, ISP network, or enterprise network
- DSL (digital subscriber line) piggybacks off the telephone company's
  access, at different frequencies
- Cable internet access piggybacks off of the cable TV company's
  infrastructure. Bit faster. Shared network, so it's slow if everyone's
  downloading video files at the same time
- Ethernet is a switch that is custom and connected to internet. Common
  for corporate/university/home networks
- Finally, wireless LAN connects to access point that is in turn
  connected to the wired internet. Based on 802.11 tech, more
  colloquially known as WiFi
- Wide-area access in the form of 3G and LTE. Use same tech as cell
  phones to send/receive packets through cell towers

- Overview of physical media
- Whenever you go from transmitter to receiver, you go through physical
  medium
- Guided media: waves guided along solid medium. Fiber, twister-pair
  copper wire, coaxial cable
- Unguided media: waves propagate in the atmosphere and outer space,
  such as in wireless communication
- Cost of materials dwarfed by cost of labor, so in buildings you'll lay
  down all three of twisted pair, fiber, and coaxial just in case
  another gets used in the future
- Twister-pair copper: least expensive, most common, used by phones. Up
  to 10Gbps
- Coaxial: used in cable TV. Shared medium
- Fiber optics: up to hundreds of gigabits per second. Immune to
  electromagnetic interference, used for overseas links and stuff. Cost
  a lot tho
- Satellites and terrestrial radio channels don't require physical wire
  to be installed, can receive signals over the air

- Okay, now the core of the network
- Packet switching
- Message broken down by source into chunks called packets
- Packets transmitted as fast as the communication link can do it
- *store-and-forward*: packet switch waits until it has the entire
  packet before it begins transmitting it
- Each switch has an output buffer for each attached link. This stores
  packets while the link is busy. Output buffer time is a *queuing
  delay*
- If you get new packet and output buffer is full, oops you got packet
  loss
- How does router know which link to forward packet onto? Each router
  has a forwarding table that maps destination addresses (or portions of
  them) to the outbound links. When packet arrives, router examines the
  destination and forwards to correct outbound link
  - Analogy: car driver that keeps asking for directions of more and
    more specific parts of his destination address (Florida -> Orlando
    -> 145 Lakeside Dr)
- How are forwarding tables set? Using the Internet's standard routing
  protocols. Use shortest path or something
- Packet switching is how internet operates

- Circuit switching e.g. for telephone lines. Analogous to making a
  reservation at restaurant so you have dedicated space (vs. packet
  switching using available resources)
- Packet switchers say it makes better use of resources and is easier to
  implement
  - Way more resource efficient!
- Packet switchers say circuit switching is wasteful during dead periods
- Circuit switchers say packet switchers can't do real time stuff b/c
  it's unreliable

- Where are we now? *The internet is a network of networks.* Gotta
  connect everyone to everyone else!
- Build up from the bottom! 
- https://gyazo.com/d1d1155212f7f875754566fbf96ab207
- Consists of a dozen or so tier-1 ISPs and hundreds of thousands of
  lower-tier ISPs. They have diverse coverage all over the globe. Low
  tier ISPs connect to higher tier ISPs, which interconnect to one
  another. Users are customers of lower-tier ISPs, who are customers of
  higher-tier ISPs. Sometimes the Googles of the world also create their
  own networks and connect to lower-tier ISPs

- Delay/loss/throughput in packet switching :'(
- Constraints make it so that we can't always have the throughput we
  want

- How do you get delayed?
- Nodal processing: time to examine packet header and determine where to
  direct packet, error checking. Microseconds. Negligible
- Queuing: wait for space on the outbound link. Micro to milliseconds.
  If traffic arrive much faster than output speed, this is large.
  - *Traffic intensity*: average rate at which bits arrive divided by
    the transmission rate
  - Don't have traffic intensity greater than 1! Exponential curve as
    traffic intensity approaches 1 too, so be carefuls
  - Higher traffic intensity = packet loss = sad face
- Transmission: time to push all packet's bits from switch onto link.
  Micro to milliseconds. Can be significant if slow link
- Propagation: time to move along the link. Supertiny, speed of light
  often? if a long area though, can be milliseconds. Longer for further
  away stuff
- All of these make up the total nodal delay. Get a feel for how much
  each of them affect things
- Total end-to-end delay is nodal delay for allll of the nodes in the
  path

- Traceroute used to see your network path. Sends special packets that
  get a return message from every router along the way, so you can build
  up the path you took to get to your destination

- Some stuff on network constraints. Today, it's generally the access
  network that creates a bottleneck because of lower capacity

- Okay, lots of words

- Protocol layers and service models. Important!
- Layers is best way to conceptualize complex systems
- Analogy of traveling by plane
- Layers are ticket, baggage, gate, takeoff/landing, and airplane
  routing. Each layer implements some functionality or service. Each
  layer has stuff happen below it that brings it back to that layer
- Okay, now bring back to networking
- Each network protocol belongs to a layer. What's important is the
  *service model* of a layer: what service does the layer offer to the
  layer above it?
- Layer performs service via actions and using services of layer below
  it

- *Five layers*: Application > Transport > Network > Link > Physical
- Application and transport in softwaare, link and physical in hardware,
  network is mixed
- All of these layers are distributed across hosts. One piece of each of
  these layers found in hosts
- Together, this is the protocol stack
- Application: HTTP/SMTP/FTP. Distributed over multiple hosts, protocol
  used to exchange messages with application layer in another host
- Transport: transport application-layer messages between endpoints. TCP
  and UDP. A transport-layer packet is a segment. TCP important for
  reliability and sequencing and throttling. Doesn't solve security. UDP
  has no reliability or sequencing or throttling. UDP is basically IP with
  the ability to address ports. UDP used for stuff like streaming games
  and video
- Network: move network-layer packets (datagrams) from one host to
  another. Takes a transport-layer segment and a destination address
  from transport layer, then provides the service of delivering segment to
  transport layer in the destination host. Generally uses IP here
- Link: routes datagram through routers between source and destination.
  At each node, network layer passes datagram to link layer, which
  delivers datagram to the next node along the route. They differ -
  could be Ethernet, WiFi, custom cable protocol. Link layer packets are
  *frames*
- Physical: move individual bits within a link layer frame from one node
  to the next. Dependent on which link layer is used. Depend on the
  actual physical medium as well. E.g. ethernet has a protocol for each
  physical layer - copper wire, coax, fiber, etc.
- OSI model has two additional layers: presentation and session. If an
  app developer needs these for the Internet, they gotta build them into
  the application

- Encapsulation is important. Applicatio-layer message sent to transport
  layer, which adds some information so it becomes a transport-layer
segment. Thus, the segment encapsulates the message. Datagram
encapsulates segment, and frame encapsulates datagram. Each layer adds
its own headers

- Shpeel on some security stuff. What can go wrong?
- Malware can come across the Internet and do bad stuff to our device
- Maybe it becomes part of a botnet, which is a bunch of devices
  controlled by bad guys to send spam or something
- *Viruses* require some kind of user interaction to infect device.
  *Worms* can get in without user interaction (e.g. you're on a bad
  network and stuff gets in the side door)
- DDos: make a host unusable by legitimate users by slamming it with
  traffic
  - Vulnerability: send carefully-formed messages to a host to make it
    crash
  - Bandwidth flooding: send a shitt on of traffic so the host can't
    keep up
  - Connection flooding: lots of half-open or slow TCP connections
    established, host too bogged down to accept real traffic
- Packet sniffers can listen on your router or something and copies all
  the packets that flow through. Can deconstruct those later to see if
  there's anything useful
- Spooky

- Okay time for some history
- Packet switching as an alternative to circuit switching came up in the
  60s. ARPANet also conceived with packet switchers. By 1972 ARPAnet had
  15 nodes and was demo'd. It was a single, closed network
- Now in the 70s lots more networks from lots more places
- TCP, UDP, IP concepts in place by end of 70s. Ethernet protocol as
  well
- In the 80s, more stuff developed, ARPANet grew. French Minitel was a
  public packet-switched network that a bunch of French people had and
  that had a decent amount of good stuff
- Internet explodes in the 90s. Invented by da god Tim Berners-Lee.
  Developed HTML, HTTP, web server, and browser. We get email, the web,
  IMs, p2p file share. A ton of shit now of course

- Summary time
- Lots of stuff in the Internet
- Edge of the network: end systems, applications, and the service
  provided to those applications
  - Link and physical media in the access network: routers, cables, and
  such
- Now in the core, we've got different switches and the
  network-of-networks concept
- Then we got to delays/throughput/packet loss
- *Key* architectural principles of protocol layering and service models

#### Lecture

- OS abstractions for communication
- File: file descriptor, basic read/write/offset functionality.
  Permanent storage. Seekable - you can jump around at different offsets
- Pipe: returns two file descriptors, one for reading and one for
  writing. When you write to one the bytes are available for reading on
  the other end. No offset, once you read stuff it's gone
- Socket: Unix Domain Socket. Server process can bind to a socket address (e.g.
  /tmp/postgres.5123). Now clients can interact with that socket, and
  they get a r/w file descriptor to interface with
  - Like a phone call, cool
  - Does NOT specify connector vs. listener as client vs. server
  - The connector is usually the client, but doesn't have to be. It can
    make a connection and then serve requests. K. Connector/listener are
    fundamental roles, client/server are "technical", implemented roles

- More history
- Military needs to connect stuff better, relay stuff

- Why is there a need for layers above IP? No security, no reliability

- Kernel is between the application and transport layers
- SSL sits between application and transport, but don't write your own.
  Use a reliable one instead

- Use `file` to get file info for binary

### 2 - Application Layer: HTTP

#### K&R 2.1 - 2.2

- See slides

#### Lecture

- Why is text bad?
- Parsing sucks
- Wasted space
- How do you transmit non-text??
  - Content-Type: octet-stream
  - Base64 encoding
- Upside: human-parseable. -\_-

- Alternatives to request/response (HTTP model)
- push/pull: client pushes messages onto a stream, many hosts pull from
  the stream
- pub/sub: server publishes to a stream where the client is subscribed
  and can pull stuff off

- Why do you need to include the Host header? Isn't it redundant?
- Two ppl sharing a webserver and IP address

### 3 - Application Layer: DNS, FTP, SMTP, etc.

#### K&R 2.3 - 2.5

- See slides

#### Lecture

- What does DNS solve? People have a bunch of addresses but the
  addresses keep changing (they're treated like home addresses), so we
  need a way to map names onto addresses
- What is DNS? It's a protocol for a distributed database
- No forced cache invalidation is a tradeoff
- Feature: extensible record types (hierarchical)
- Who has authority?

- There's one root DB, but it pretty much just has NS records for the
  TLD's

- Dig is for looking at DNS

- DNS requests happen in parallel with HTTP. Uses UDP because everything
  fits in one packet

### 4 - Transport Layer: TCP and UDP

#### K&R Ch 3

- See slides

#### Lecture

- UDP always needs to fill source port field

- SYN flood by forcing server to allocate a ton of resources that'll
  never be used
- Fix with Syn cookie - on initial SYN, don't allocate anything, make a
  cookie. This cookie needs to come on the next ACK (since it's on the
  SYN of the SYN ACK response) or else you won't actually allocate resources

### 5 - Network Layer: IP

#### K&R Ch 4

- See slides

#### Lecture

- How does a router's forwarding table get established?
- Procedures convert routing algorithm into forwarding table at each
  router
- Why have a "transport protocol layer" in the IP datagram header? So
  you know which code to jump to after parsing out the IP header!
- *Risk-based* problem-solving: where's the biggest risk? Can I mitigate
  that first? If I can't, there's no point in continuing


### 6 - Link Layer: Ethernet

#### K&R Ch 5

- See slides

#### Lecture

- Didn't go over much, there was a wireshark lab. See mostly stuff in
  slides. This is a protocol that operates over hardware /shrug

### 7 - Multimedia streaming and realtime communication

#### K&R Ch 7

- See slides

#### Lecture

- Switching adds less noise to hubs, because not everything is broadcast
- MAC address can identify a node as being on a specific VLAN
- VLAN makes it even quieter, need specific translators between VLANs
  though
- VPN tries to interpose one network over a set of other subnets, okay
- If you TCP connect to a VPN, you can send requests from that VPN and
  it looks like your computer is just having one TCP connection /shrug

- Streaming stored video time
- TCP control channel for stuff like "start halfway through, send at
  this rate", UDP channel for the actual data

### 8 - Security

#### K&R Ch 8

- See slides

#### Lecture

- Everything is bolted on!
- To brute force decrypt: helps to have a ciphertext-plaintext pair
- Cipher block: not byte by byte, but chunk by chunk
- Chaining: Start with just one random seed, XOR with first message
  block, encrypt that block, then XOR next with (first xor'd w/
  random) then so on and so forth
- So if you have symmetric encryption, how do you exchange keys?
- Use asymmetric public/private key exchange _to exchange symmetric keys
  for the rest of the session_
- RSA is 300x slower than AES to encrypt!

- So now:
  - From Alice (plain)
  - Alice makes message key
  - Alice encrypts message with message key
  - Alice encrypts message key with Bob public key
  - Alice encrypts ^ with Alice public key
  - Alice hashes ^^ and encrypts the hash with her own public key and
    puts it at the end of the message (this is *signing*)
  - First thing Bob does is take the encrypted hash off the end of the
    payload, decrypt with Alice's public key, and compare to hashing the
    payload
- *Certificate*: 3rd party certificate authority gets _your_ public key
  with a proof of identity. CA verifies this, and if you pass, they
  verify your public key by hashing it and signing it with _their_
  (super secret) private key, which becomes your _certificate_

### 9 - The Future of Networking

#### IPFS White Paper

- See PDF in 09_future
- In business, a white paper is closer to a form of marketing
  presentation, a tool meant to persuade customers and partners and
  promote a product or viewpoint

#### Van Jacobson on A New Way to Look at Networking

- Network research is dead end
- Everything is about paths

- Phone number is a _program_ for directing your line on a switchboard
- How do you amortize setup cost and worry about reliability?
- But everyone thought telephony was the only model for networking
- But then people came along with packet switching: focus on endpoints,
  not paths
- Lots of paths from one endpoint to another. Split data into packets
- But just overlayed over telco

- Then Stanford peeps came up with TCP/IP stack
  - To concatenate paths
- Reliability increases exponentially with system size (more failure
  correction)
- No call setup - high efficiency
- No hot spots because topology can self adjust
- *Connecting* is binary: either connected or not
- Man I can't take no notes, just listen

- TCP/IP rescued us from plumbing at the wire level but we still have to
  do it at the data level. A dissemination based architecture would fix
  this
- Many ad-hoc dissemination overlays have been created (CDN, BitTorrent,
  etc.) - there's a need!

#### Lecture

- Packet switching had great diagrams, but how to implement?
- At first had to piggyback on the telephone lines
  - Objection: "it's basically the same thing"

- Key: *dissemination*. Internet is designed for conversations, not for
  *dissemination* (disseminate information and stuff)
- Bad at broadcast
- Binary connection - 2 participants

- Ideas: address *data* not machines. Sign/Auth data
- Big buffers/caches
- Immutable data
