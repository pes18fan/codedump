# Linked list

A linked list is made of nodes, that each have a pointer to another
node(s). A singly linked list includes each node having a pointer
to the next one, while a doubly linked list also has a pointer to
the previous one. So, you can't go back in a singly linked list.
Linked lists also have no index.

A node in a singly-linked list, in a TypeScript-like language is:

```
Node<T>
    val: T
    next: Node<T>?
```

And a doubly linked list:
```
Node<T>
    val: T
    next: Node<T>?
    prev: Node<T>?
```

A singly linked list has a `head` pointer that points to the
first element. This would be used to find where the list begins, to
add an item in an empty list, etc. A doubly linked list has a
`tail` pointer as well, pointing to the last element, that 
serves a similar purpose.

Deleting and inserting in a doubly linked list:

To insert D in A<->B<->C at B, do something like this:

```
     A -> D
     D -> B
     D <- B
     A <- D
```

That is, A points to D and is pointed at by D, and D points to B
and is pointed at by B.

Let's say we want to delete C from A<->B<->C<->D. Then:

```
B -> D
D <- B
C.prev = C.next = null
```

Or, if you were using a non-GC'd language like C, just free(C).

Deleting and insertion itself from a linked list is O(1), since we 
do the same number of operations, which each are setting stuff 
in memory (assumed to be constant) every single time. However, that
assumes that we already have found where the value we're deleting is.

Getting a value to delete is not constant though, since we need to
loop through it. An exception is getting head/tail, since that is
constant. Similarly, deleting at the ends is constant time since
we can just dereference head/tail, but we need to traverse the list
to delete in the middle so it's not constant there. Again, similarly,
prepending or appending something is constant time but doing so in
the middle? Not so much.
  
Go to https://gist.github.com/pes18fan/bc0b8e0be35d19fd8acb41fb70fcb6ab
to check out an doubly linked list implementation I made in C. I'm too 
bored to do so here cause it takes a lotta time.
