# Graphs.

Probably the most difficult data structure to implement.
A graph is a series of nodes, with some amount of connections.
All trees are graphs as well.

## Graph terminology:

- cycle: when you start at node A, follow the links, and get back to node A
- acyclic: a graph that has no cycles
- connected: a graph where every node can reach every other node
- directed: when each path between nodes has some kind of direction
- undirected: there's no direction associated with the paths
- weighted: the paths have a weight, like distance, associated with them
- dag: a directed acyclic graph

### Implementation terms

- node / vertex : a point on the graph
- edge : connection between two nodes

## Big O

Commonly stated in terms of V & E where V is vertices and E is edges
So, O(V * E) would mean we check every vertex, and on every vertex we check
every edge

## Implementation methods

There are generally two major ways:

- Adjacency matrix
- Adjacency list

### Adjacency List

These are much more commonly used. You represent the graph as a list of
vertices, where each vertex has a list of edges.

For this poorly drawn graph:

```
0 -> 1
^ \  ^
|  > |
2 <- 3
```

The adjacency list for this would be something like:

```
[
    [{to: 1}, {to: 3}], // vertex 0
    [],                 // vertex 1
    [{to: 0}],          // vertex 2
    [{to: 2}, {to: 1}]  // vertex 3
]
```

Here, each of the objects represented by {} is an edge. Each edge may also
have an associated weight field along with the `to` field, if the graph is weighted.

### Adjacency Matrix

We have a matrix, where each row and column represents a node. The cell where
the two intersect has the information about whether the two nodes are
connected or not.

For the above graph:
```
         0  1  2  3   // columns
    [
0       [0, 1, 0, 1], // 0 is connected to 1 and 3
1       [0, 0, 0, 0], // 1 isn't connected to anything
2       [1, 0, 0, 0], // 2 is only connected to 0
3       [0, 1, 1, 0], // 3 is connected to 1 and 2
    ]
```

Note that you could replace the 1's in the matrix with weights, in the case
of a weighted graph.

This uses up a lot of memory so its not generally used.

## Searching

All trees are graphs. So guess what, you can do both a breadth-first search
as well as a depth first search on a graph too!

### DFS

Just like on a tree, we start at some node and keep recursing as long as the
current node has some children (in this case, if its connected to at least
one edge).

### BFS

Works similarly to BFS on a tree, using a queue.
