/* An weighted directed adjacency-list based graph implementation. */
class GraphEdge {
  int weight;
  int to;

  GraphEdge(this.weight, this.to);
}

class GraphNode {
  int data;
  List<GraphEdge> edges;

  GraphNode(this.data, this.edges);

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write("{$data, to: ");
    sb.write("[");

    for (var edge in edges) {
      sb.write("{");
      sb.write("${edge.to}, wt: ${edge.weight}");
      sb.write("} ");
    }

    sb.write("]}");
    return sb.toString();
  }
}

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
  bool _has(int index) {
    if (index < 0 || index >= nodes.length)
      return false;
    else
      return true;
  }

  // Add a node to the graph.
  void addNode(int data) {
    nodes.add(GraphNode(data, []));
  }

  // Remove a node from the graph.
  void removeNode(int index) {
    if (!_has(index)) {
      throw ArgumentError("No node exists with index $index.");
    }

    /* Remove any references to the node being removed present, that is, any
     * edges still pointing to that node (zombie edges). By the way, that
     * term "zombie edge" is something I just invented. Pretty proud of it. */
    for (var node in nodes) {
      for (var edge in node.edges) {
        if (edge.to == index) {
          node.edges.remove(edge);
          break;
        }
      }
    }

    // Actually remove the node.
    nodes.removeAt(index);
  }

  // Add an edge to the graph.
  void addEdge(int weight, {required int from, required int to}) {
    if (!_has(from)) {
      throw ArgumentError(
          "Can't add an edge starting at node $from, that node doesn't exist.");
    }

    // Check if a node pointing to `to` already exists.
    var possibleExistingNodesToTo =
        nodes[from].edges.where((edge) => edge.to == to).toList();
    if (possibleExistingNodesToTo.isNotEmpty) {
      throw StateError("The node $from already has an edge pointing to $to!");
    }

    nodes[from].edges.add(GraphEdge(weight, to));
  }

  // Remove an edge from the graph.
  void removeEdge(int weight, {required int from, required int to}) {
    if (!_has(from)) {
      throw ArgumentError(
          "Can't remove an edge starting at node $from, that node doesn't exist.");
    }

    if (nodes[from]
        .edges
        .where((edge) => (edge.to == to && edge.weight == weight))
        .isEmpty) {
      throw ArgumentError("No edge from $from to $to exists.");
    }

    nodes[from]
        .edges
        .removeWhere((edge) => (edge.to == to && edge.weight == weight));
  }

  // Change the weight of an edge.
  void changeEdgeWeight(int newWeight, {required int from, required int to}) {
    if (!_has(from)) {
      throw ArgumentError(
          "Can't modify an edge starting at node $from, that node doesn't exist.");
    }

    if (nodes[from].edges.where((edge) => (edge.to == to)).isEmpty) {
      throw ArgumentError("No edge from $from to $to exists.");
    }

    nodes[from].edges.singleWhere((edge) => (edge.to == to)).weight = newWeight;
  }

  // Remove all edges from `from` to `to`.
  void removeAllEdges({required int from, required int to}) {
    if (!_has(from)) {
      throw ArgumentError(
          "Can't remove an edge starting at node $from, that node doesn't exist.");
    }

    nodes[from].edges.removeWhere((edge) => (edge.to == to));
  }
}

void main() {
  var graph = DWG();

  graph.addNode(20);
  graph.addNode(45);
  graph.addNode(69);

  graph.addEdge(15, from: 0, to: 1);
  graph.addEdge(10, from: 1, to: 2);
  graph.addEdge(20, from: 0, to: 2);
  print(graph.toString());

  graph.removeNode(2);
  graph.removeEdge(15, from: 0, to: 1);
  print(graph.toString());
}
