/* An unweighted undirected adjacency-list based graph implementation. */
class GraphEdge {
  int from;
  int to;

  GraphEdge(this.from, this.to);

  @override
  String toString() {
    return "{from: $from, to: $to}";
  }
}

typedef GraphNode = List<GraphEdge>;

/* UUG = Undirected Unweighted Graph as Adjacency List */
class UUGAL {
  late List<GraphNode> nodes;

  UUGAL() {
    nodes = [];
  }

  @override
  String toString() {
    var buf = StringBuffer();

    buf.writeln("[");
    for (int i = 0; i < nodes.length; i++) {
      var nodeAsString = nodes[i].toString();
      buf.write("\t$i: $nodeAsString");

      if (i != nodes.length - 1) {
        buf.writeln(",");
      } else {
        buf.writeln();
      }
    }
    buf.writeln("]");

    return buf.toString();
  }

  bool hasNode(int index) {
    if (index < 0 || index >= nodes.length)
      return false;
    else
      return true;
  }

  void addNode() {
    nodes.add([]);
  }

  void removeNode(int index) {
    if (!hasNode(index)) {
      throw ArgumentError("The node $index doesn't exist.");
    }

    nodes.removeAt(index);

    bool notLastOrFirst = false;
    if (index != nodes.length - 1 || index != 0) notLastOrFirst = true;

    /* Remove any zombie edges */
    for (var node in nodes) {
      node.removeWhere((edge) => edge.to == index || edge.from == index);

      if (notLastOrFirst) {
        node.forEach((edge) {
          if (edge.to > index) edge.to--;
          if (edge.from > index) edge.from--;
        });
      }
    }
  }

  void addEdge(int from, int to) {
    if (!hasNode(from) || !hasNode(to)) {
      throw ArgumentError("Node $from or $to doesn't exist.");
    }

    var edge = GraphEdge(from, to);
    nodes[from].add(edge);
  }

  void removeAllEdges(int from, int to) {
    if (!hasNode(from) || !hasNode(to)) {
      throw ArgumentError("Node $from or $to doesn't exist.");
    }

    nodes[from].removeWhere((edge) => edge.to == to);
  }

  bool _walk(int curr, int needle, List<bool> seen, List<int> path) {
    // If already seen, go back, no point recursing in there
    if (seen[curr]) {
      return false;
    }
    seen[curr] = true;

    // pre
    path.add(curr);

    // if we found the needle, return back
    if (curr == needle) {
      return true;
    }

    // recurse
    final node = nodes[curr];
    for (var edge in node) {
      if (_walk(edge.to, needle, seen, path)) {
        // Found the path!
        return true;
      }
    }

    // post
    path.removeLast();

    return false;
  }

  /* A fun fact to note about depth first traversal in graphs is that it is
   * exactly the same problem as the maze solver that is in the "algos/"
   * folder.
   *
   * The running time of this algorithm is O(V + E), since we visit every edge
   * and every node once.
   */
  List<int> depthFirstTraversal(int source, int needle) {
    final seen = List<bool>.filled(nodes.length, false);
    var path = <int>[];

    _walk(source, needle, seen, path);

    return path;
  }
}

void main() {
  var graph = UUGAL();

  graph.addNode();
  graph.addNode();
  graph.addNode();
  graph.addNode();
  graph.addNode();

  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(0, 3);

  graph.addEdge(1, 3);

  graph.addEdge(2, 4);

  final path = graph.depthFirstTraversal(0, 4);
  print(path);
}
