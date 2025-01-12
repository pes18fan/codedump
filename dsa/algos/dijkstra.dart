import "../data_structs/directed_weighted_graph.dart";

extension on DWG {
  bool _hasUnvisited(List<bool> seen, List<double> dists) {
    for (var i = 0; i < seen.length; i++) {
      if (!seen[i] && dists[i] < double.infinity) return true;
    }

    return false;
  }

  int _getLowestUnvisited(List<bool> seen, List<double> dists) {
    var idx = -1;
    var lowestDistance = double.infinity;

    for (var i = 0; i < seen.length; i++) {
      if (seen[i]) continue;

      if (lowestDistance > dists[i]) {
        lowestDistance = dists[i];
        idx = i;
      }
    }

    return idx;
  }

  /* This implementation of Dijkstra's has a running time of O(V^2 + 2E), where 
   * O(V^2) is for the functions _hasUnvisited() and _getLowestUnvisited(),
   * and O(2E) is because every edge is checked twice. We can simplify this
   * into O(V^2 + E).
   *
   * With a min heap, the running time can be decreased to O((V + E) log V).
   * I'll implement a min-heap based shortest path soon.
   */
  (List<int>, int) shortestPath(int source, int sink) {
    if (!hasNode(source) || !hasNode(sink)) {
      throw ArgumentError("Node $source or $sink doesn't exist.");
    }

    final seen = List<bool>.filled(nodes.length, false);
    final dists = List<double>.filled(nodes.length, double.infinity);
    final prev = List<int>.filled(nodes.length, -1);

    dists[source] = 0;

    while (_hasUnvisited(seen, dists)) {
      final curr = _getLowestUnvisited(seen, dists);
      seen[curr] = true;

      /* Look at all of the current node's neighbors and relax their distances 
       * if needed. */
      for (var edge in nodes[curr]) {
        if (seen[edge.to]) continue;
        final dist = dists[curr] + edge.weight;

        if (dist < dists[edge.to]) {
          prev[edge.to] = curr;
          dists[edge.to] = dist;
        }
      }
    }

    // construct the path backwards
    final path = <int>[];
    var curr = sink;
    while (prev[curr] != -1) {
      path.add(curr);
      curr = prev[curr];
    }

    if (path.length != 0) {
      path.add(source);
      return (path.reversed.toList(), dists[sink].toInt());
    }

    // There's no path between source and sink
    return ([], -1);
  }
}

void main() {
  // The graph here will be the same as shown in dijkstra.md
  var g = DWG();

  // Adding nodes 0 through 4, values in nodes don't matter
  g.addNode();
  g.addNode();
  g.addNode();
  g.addNode();
  g.addNode();

  // Adding all the edges
  g.addEdge(1, from: 0, to: 1);
  g.addEdge(5, from: 0, to: 2);
  g.addEdge(7, from: 1, to: 2);
  g.addEdge(6, from: 1, to: 3);
  g.addEdge(1, from: 2, to: 4);
  g.addEdge(1, from: 3, to: 2);

  var (path, dist) = g.shortestPath(0, 4);
  print("path: $path, dist: $dist");
}
