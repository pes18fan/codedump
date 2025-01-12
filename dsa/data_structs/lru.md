# LRU

An LRU (Least Recently Used) cache is a caching mechanism which basically says, 
"The least used item will be evicted." How do we do that?

Basically, you have a linked list with a bunch of nodes each having a bunch of
values connected together, like so for instance:

```
V1 <-> V2 <-> V3 <-> V4
```

Let's say the user says, "Hey, I want value 2." So, of course, you give him
value 2. But after that, what you do is you also move value 2 to the head of this
list, so it becomes like so:

```
V2 <-> V1 <-> V3 <-> V4
```

V2 is our most recently used value, and it's at the head. And V4 here is the
LRU.

As we can see, a doubly linked list is an important part of this implementation. 
But can you guess what else? Like, how did we ask for the value V2? We need a
key to access it with. What does that sound like?

That's right, it's a hashmap. A hashmap is key to this implementation. Pun
intended.

The problem however, is how we combine these two structures.

The idea is this: you have a hashmap defined as this for example,

```
Hashmap<K, V>
```

Where K is the key you use to access your value, and V, the value, is in fact
the linked list node. So, you can instantaneously jump to any node by providing
a key. It kinda solves the problem with linked lists, which is the problem of
traversing one to get a value in the middle.

It's a weird one, because it's basically an array with nodes (because a hashmap 
under the hood is just an array), and those nodes also have pointers to other 
nodes that are also in the array. Would sorta look like this,

```
lru = [
    k: "foo", v: Node(id: 0, next: 1),
    k: "bar", v: Node(id: 3, next: 4),
    k: "baz", v: Node(id: 1, next: 2),
    k: "bop", v: Node(id: 2, next: 3),
    k: "idk", v: Node(id: 4, next: NULL)
]
```

The nodes are all out of order because the hash table array doesn't guarantee
that they will be.

What's the running time then? When you break the connections of a node in a
doubly linked list, in this case to move a just used value to the front, you'll
first perform 4 operations (2 for moving connections around and 2 for adjusting
the connections of the node you're moving), and 3 more operations to move that
node to the front. So, a total of 7 O(1) operations.
