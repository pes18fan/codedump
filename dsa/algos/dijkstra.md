# TODO

# Dijkstra's Shortest Path

It is an algorithm developed by Edsger Dijkstra to find the shortest path
between a source node to all other nodes in a graph. Once you know the shortest
distance to all nodes, therefore you can also find the shortest distance to one
specific node.

The Dijkstra's algorithm is part of a family of algorithms known as greedy
algorithms.

Make sure to check out `graphs.md` in the `data_structs` folder if you don't know
about graphs yet first.

The Dijkstra's algorithm can ONLY be used on graphs that have NO NEGATIVE
WEIGHTS FOR EACH EDGE.

Let's take this badly drawn graph:

```
(0) --5--> (2) --1--> (4)
 |        ↗ ▲
 |       /  |
 |      /   |
 |     /    |
 1    7     1
 |   /      |
 |  /       |
 ▼ /        |
(1) --6--> (3)
```

The numbers enclosed in the brackets represent a node, thus we have five nodes
0, 1, 2, 3 and 4. Each edge joining these nodes has an associated weight, and as
said before, there are no negative edges.

If someone asked you, "Hey, what's the shortest path between 0 and 4?", you can
just look at the graph and easily realize that the shortest path is 0-2-4 among
the three paths. But how does a computer figure this out?

This is where Dijkstra comes in.
