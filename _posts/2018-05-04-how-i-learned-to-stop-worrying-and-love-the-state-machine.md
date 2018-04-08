---
layout: article_post
title: How I Learned to Stop Worrying and Love the State Machine
date: 2018-05-04 14:58
categories:
tags: [article, technical, programming]
author: Rag Anwald
rating: 3
article_url: "http://raganwald.com/2018/02/23/forde.html"
reading_time: 10
date_published: 2018-02-23
summary: "Any reasonably complex domain object degenerates into a state machine, so you might as well get ahead of the curve."
---

## Notes

* **I LOVE STATE MACHINES. I NEED TO GET BETTER AT USING THEM**
* Almost every mutable domain object degenerates into a state machine
  * Over time, they build up a lot of logic around how and when they
    transition between states, and without diligence this becomes
    smeared everywhere.
* A state machine:
  * Has a notion of a **state**. This is a named way of
    being that comes with certain invariants. (open, closed)
  * Formally defines a starting state, and allowable transitions between
    states (open to closed)
  * Transitions between states in response to **events** (deposit,
    withdraw)
* Transitions: always does same thing
* Use a **transition table**

|        | open              | held      | closed |   |
|--------|-------------------|-----------|--------|---|
| open   | deposit, withdraw | placeHold | close  |   |
| held   | removeHold        | deposit   | close  |   |
| closed | reopen            |           |        |   |

* Code serves dual purpose: implement functionality and documenting what
  is possible. Enter **executable state descriptions**

Bad code:

```javascript
let account = {
  state: 'open',

  close () {
    if (this.state === 'open') {
      if (this.balance > 0) {
        // ...transfer balance to suspension account
      }
      this.state = 'closed';
    } else {
      throw 'invalid event';
    }
  },

  reopen () {
    if (this.state === 'closed') {
      // ...restore balance if applicable
      this.state = 'open';
    } else {
      throw 'invalid event';
    }
  }
};
```

Good code:

```javascript
const account = StateMachine({
  balance: 0,

  [STARTING_STATE]: 'open',
  [STATES]: {
    open: {
      deposit (amount) { this.balance = this.balance + amount; },
      withdraw (amount) { this.balance = this.balance - amount; },
      placeHold: transitionsTo('held', () => undefined),
      close: transitionsTo('closed', function () {
        if (this.balance > 0) {
          // ...transfer balance to suspension account
        }
      })
    },
    held: {
      removeHold: transitionsTo('open', () => undefined),
      deposit (amount) { this.balance = this.balance + amount; },
      close: transitionsTo('closed', function () {
        if (this.balance > 0) {
          // ...transfer balance to suspension account
        }
      })
    },
    closed: {
      reopen: transitionsTo('open', function () {
        // ...restore balance if applicable
      })
    }
  }
});
```
