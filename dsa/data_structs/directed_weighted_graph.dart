/* An weighted directed adjacency-list based graph implementation. */
/* NOTE: The adjacency list I implemented here is not a conventional one, that
 * happened by pure mistake. Will be fixed sometime soon. */
class GraphEdge {
  int weight;
  int to;

  GraphEdge(this.weight, this.to);

  @override
  String toString() {
    return "{to: $to, wt: $weight}";
  }
}

typedef GraphNode = List<GraphEdge>;

/* DWG = Directed Weighted Graph */
class DWG {
  late List<GraphNode> nodes;

  DWG() {
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

  // Check if a node exists at the provided index.
  bool hasNode(int index) {
    if (index < 0 || index >= nodes.length)
      return false;
    else
      return true;
  }

  // Add a node to the graph.
  void addNode() {
    nodes.add([]);
  }

  // Remove a node from the graph.
  void removeNode(int index) {
    if (!hasNode(index)) {
      throw ArgumentError("No node exists with index $index.");
    }

    nodes.removeAt(index);

    bool notLastOrFirst = false;
    if (index != nodes.length - 1 || index != 0) notLastOrFirst = true;

    /* Remove any zombie edges */
    for (var node in nodes) {
      node.removeWhere((edge) => edge.to == index);

      if (notLastOrFirst) {
        node.forEach((edge) {
          if (edge.to > index) edge.to--;
        });
      }
    }
  }

  // Add an edge to the graph.
  void addEdge(int weight, {required int from, required int to}) {
    if (!hasNode(from)) {
      throw ArgumentError(
          "Can't add an edge starting at node $from, that node doesn't exist.");
    }

    if (weight < 0) {
      throw ArgumentError("Edge weights can't be negative.");
    }

    var edge = GraphEdge(weight, to);
    nodes[from].add(edge);
  }

  // Remove an edge from the graph.
  void removeEdge(int weight, {required int from, required int to}) {
    if (!hasNode(from)) {
      throw ArgumentError(
          "Can't remove an edge starting at node $from, that node doesn't exist.");
    }

    if (nodes[from]
        .where((edge) => (edge.to == to && edge.weight == weight))
        .isEmpty) {
      throw ArgumentError("No edge from $from to $to exists.");
    }

    nodes[from].removeWhere((edge) => (edge.to == to && edge.weight == weight));
  }

  // Change the weight of an edge.
  void changeEdgeWeight(int newWeight, {required int from, required int to}) {
    if (!hasNode(from)) {
      throw ArgumentError(
          "Can't modify an edge starting at node $from, that node doesn't exist.");
    }

    if (nodes[from].where((edge) => (edge.to == to)).isEmpty) {
      throw ArgumentError("No edge from $from to $to exists.");
    }

    nodes[from].singleWhere((edge) => (edge.to == to)).weight = newWeight;
  }

  // Remove all edges from `from` to `to`.
  void removeAllEdges({required int from, required int to}) {
    if (!hasNode(from)) {
      throw ArgumentError(
          "Can't remove an edge starting at node $from, that node doesn't exist.");
    }

    nodes[from].removeWhere((edge) => (edge.to == to));
  }
}

void main() {
  var graph = DWG();

  graph.addNode();
  graph.addNode();
  graph.addNode();

  graph.addEdge(15, from: 0, to: 1);
  graph.addEdge(10, from: 1, to: 2);
  graph.addEdge(20, from: 0, to: 2);
  print(graph.toString());

  graph.removeNode(2);
  graph.removeEdge(15, from: 0, to: 1);
  print(graph.toString());
}
