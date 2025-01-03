# Dijkstra's Shortest Path

It is an algorithm developed by Edsger Wybe Dijkstra to find the shortest path
between a source node to all other nodes in a graph. Once you know the shortest
distance to all nodes, therefore you can also find the shortest distance to one
specific node.

Fun fact, Dijkstra invented this algorithm in a café in 20 minutes! What a
legend.

The Dijkstra's algorithm is part of a family of algorithms known as greedy
algorithms.

Make sure to check out `graphs.md` in the `data_structs` folder if you don't know
about graphs yet first.

The Dijkstra's algorithm can ONLY be used on graphs that have NO NEGATIVE
WEIGHTS FOR EACH EDGE.

Another thing to note about Dijkstra is that it inherently finds the shortest
path to ALL nodes rather than just ONE node. But it can be modified to just be
focused for a specific target node as I'll explain below.

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

Step 1. Firstly, you create a set of all unvisited nodes. This is the unvisited 
set. Generally, the best data structure to use for this set is any priority
queue that has the smallest value first, like a min heap for example; for
reasons I will explain.

Step 2. Then, assign to every node a distance from the start; this will 
generally just be referred to distance of any node N, and we'll denote it by D.
During execution, the distance is just the length of the shortest path 
discovered between the source and N so far. 

To begin with, all distances other than that of the source will be infinity, 
and of the source it'll of course be zero. The infinity here just means we don't 
know any path to these nodes yet.

Step 3. From the unvisited set, select the current node; this will be the one 
with the smallest distance (that isn't infinite, of course).  

This is where the priority queue comes into play. If we have the priority queue 
with the minimum distance at the front, it becomes really easy to get the node
with the smallest distance.

Let's call the current node C. To begin with, C is the source; in the above
badly drawn graph it's the node 0.

If the unvisited set has nothing when we arrive at step 3, just terminate the 
algorithm by jumping to step 6. Or, if we just want to find the shortest path 
to one target node rather than worrying about all nodes, terminate the algorithm
when C is the target node.

Step 4. For the node C, consider all of its unvisited neighbors and update their
distance through the current node. Compare this newly calculated distance to the
one currently assigned to them, and assign the one that's smaller.

Okay, so on starting the algorithm, C is node 0 right? Now, look at all its
unvisited neighbors, which would be all its neighbors since we've only visited 0
so far. 0 has two neighbors 1 and 2, both with D values of infinity. Looking at
the edges connecting them though, we can see that the distances to 1 and 2 from
the source are 1 and 5 respectively. So, we'll update the D of node 1 to 1, and 
the D of node 2 to 5.

Step 5. Once you've considered all of C's unvisited neighbors, remove it from the
unvisited set. This ensures a visited node is never rechecked. Now, repeat from
step 3.
