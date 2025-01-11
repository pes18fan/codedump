/* An unweighted undirected adjacency-matrix based graph implementation. */
class GraphNode {
  int data;
  List<int>? from;
  List<int>? to;

  GraphNode(this.data, {this.from, this.to});

  @override
  String toString() {
    return "{$data, from: $from, to: $to}";
  }
}

/* UUGAM = Undirected Unweighted Graph as Adjacency Matrix */
class UUGAM {
  /* The list contains a tuple of a List<bool> and int, because the List<bool>
   * is the part that is used to determine if one node connects to the other,
   * and the int is the data stored by a node. */
  List<(List<bool>, int)> matrix = [];

  UUGAM();

  @override
  String toString() {
    var sb = StringBuffer();
    sb.writeln("[");

    int i = 0;
    for (var node in matrix) {
      sb.write("\t");
      sb.write("{");
      sb.write("index: $i, ");
      sb.write("connects_to: ");
      var nodeList = node.$1;

      int j = 0;
      sb.write("[");
      for (var connection in nodeList) {
        if (connection == true) {
          sb.write("$j, ");
        }
        j++;
      }
      sb.write("], ");

      sb.write("data: ${node.$2} ");
      sb.write("}\n");
      i++;
    }

    sb.write("]");

    return sb.toString();
  }

  /* Check if a NODE exists. */
  bool hasNode(int index) {
    if (index < 0 || index >= matrix.length)
      return false;
    else
      return true;
  }

  void addNode(int data) {
    var nodeList =
        List<bool>.generate(matrix.length + 1, (_) => false, growable: true);
    matrix.add((nodeList, data));

    for (var node in matrix) {
      node.$1.add(false);
    }
  }

  void addEdge(int from, int to) {
    if (!hasNode(from) || !hasNode(to)) {
      throw ArgumentError("Node $from or $to doesn't exist.");
    }

    matrix[from].$1[to] = true;
  }

  void removeNode(int index) {
    if (!hasNode(index)) {
      throw ArgumentError("Node $index doesn't exist.");
    }

    for (var node in matrix) {
      node.$1.removeAt(index);
    }
    matrix.removeAt(index);
  }
}

void main() {
  var graph = UUGAM();

  graph.addNode(20);
  graph.addNode(45);
  graph.addNode(69);

  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  print(graph);

  graph.removeNode(2);
  print(graph);
}
