import "../data_structs/directed_weighted_graph.dart";

class DijkstraNode {
  GraphNode node;
  int nodeIdx;
  int distance;

  DijkstraNode(this.node, this.nodeIdx, this.distance);

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write("{");
    sb.write("idx: $nodeIdx, dist: $distance");
    sb.write("}");
    return sb.toString();
  }
}

extension on DWG {
  /* Use Dijkstra's algorithm to find the shortest path between `start` and
   * `end` and return a tuple with the path and distance. */
  (List<int>, int) shortestPath({required int start, required int end}) {
    if (!has(start) || !has(end)) {
      throw ArgumentError("Node $start or $end doesn't exist in the graph.");
    }

    /* Insert the indices of all unvisited nodes; to begin with that's just all
     * nodes. We'll treat this as a priority queue. */
    List<DijkstraNode> unvisited = [];
    Map<int, int?> predecessor = {}; // Track the previous node for each node
    for (int i = 0; i < nodes.length; i++) {
      var distance = i == 0
          ? 0
          : 9999999; // Set starting value very high to indicate unvisited-ness
      var uv = DijkstraNode(nodes[i], i, distance);
      unvisited.add(uv);
      predecessor[i] = null; // Initialize with no predecessor
    }

    List<DijkstraNode> visited = [];

    while (!unvisited.isEmpty) {
      /* Grab the node with the least distance. This will always be at front of
       * unvisited, and we'll ensure that later in this loop. */
      var currentNode = unvisited.removeAt(0);

      /* In this implementation of the Dijkstra's algorithm, I only want the
       * shortest path to `end` rather than all the paths. So, I end here. */
      if (currentNode.nodeIdx == end) {
        visited.add(currentNode);
        break;
      }

      /* This code monstrosity is used to look at all of the current node's
       * neighbors and relax their distances if needed. */
      var node = currentNode.node;
      for (var edge in node.edges) {
        var neighborIndex = unvisited.indexWhere((uv) => uv.nodeIdx == edge.to);
        if (neighborIndex == -1) continue; // Already visited
        var neighborNode = unvisited[neighborIndex];
        if (currentNode.distance + edge.weight < neighborNode.distance) {
          neighborNode.distance = currentNode.distance + edge.weight;
          predecessor[neighborNode.nodeIdx] = currentNode.nodeIdx;
        }
      }

      // Sort the unvisited list to ensure the next node has the smallest distance
      unvisited.sort((a, b) => a.distance.compareTo(b.distance));
      visited.add(currentNode);
    }

    // Now, construct the path using the predecessor map
    List<int> path = [];
    int? current = end;
    while (current != null) {
      path.insert(0, current);
      current = predecessor[current];
    }

    // Ensure the path starts at the correct node
    if (path.first != start) {
      throw StateError("No path exists from $start to $end.");
    }

    return (path, visited.singleWhere((v) => v.nodeIdx == end).distance);
  }
}

void main() {
  // The graph here will be the same as shown in dijkstra.md
  var g = DWG();

  // Adding nodes 0 through 4, values in nodes don't matter
  g.addNode(0);
  g.addNode(1);
  g.addNode(2);
  g.addNode(3);
  g.addNode(4);

  // Adding all the edges
  g.addEdge(1, from: 0, to: 1);
  g.addEdge(5, from: 0, to: 2);
  g.addEdge(7, from: 1, to: 2);
  g.addEdge(6, from: 1, to: 3);
  g.addEdge(1, from: 2, to: 4);
  g.addEdge(1, from: 3, to: 2);

  var (path, distance) = g.shortestPath(start: 0, end: 4);

  print(path);
  print(distance);
}
