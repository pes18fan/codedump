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
}

void main() {
  var graph = UUGAL();

  graph.addNode();
  graph.addNode();
  graph.addNode();

  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(1, 2);
  graph.addEdge(2, 0);
  print(graph);

  graph.removeNode(1);
  print(graph);
}
