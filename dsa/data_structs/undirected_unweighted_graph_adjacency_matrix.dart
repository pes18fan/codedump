/* This adjacency matrix is a list of tuples of a List<bool> and int, which each
 * represent a single graph node. This is because the List<bool> is the part 
 * that is used to determine if one node connects to the other, and the int is 
 * the data stored by a node. */
typedef GraphNode = (List<bool>, int);

/* UUGAM = Undirected Unweighted Graph as Adjacency Matrix */
class UUGAM {
  List<GraphNode> matrix = [];

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

  /* Traverse breadth-first through the graph, looking for a node with index of
   * value `needle`, and return a path between these nodes. */
  List<int> breadthFirstTraversal(int source, int needle) {
    if (!hasNode(source) || !hasNode(needle)) {
      throw ArgumentError(
          "Node $source or $needle can't be used as the source because it doesn't exist.");
    }

    final seen = List<bool>.generate(matrix.length, (_) => false);
    final prev = List<int>.generate(matrix.length, (_) => -1);

    seen[source] = true;

    /* This weird type-having queue consists of tuples of the GraphNode and
     * the index to each node. This is because the index is necessary in this
     * breadth first search and not putting it explicitly here would leave
     * no other way to find out what the index of a node is. */
    final q = [source];

    do {
      final curr = q.removeAt(0); // Deque
      if (matrix[curr] == needle) {
        // Found the needle in the haystack!
        break;
      }

      // Loop through all of current's children
      final adjs = matrix[curr].$1;
      for (int i = 0; i < adjs.length; i++) {
        // See if the connection actually exists.
        if (adjs[i] == false) continue;

        // If already seen, move on to the next
        if (seen[i]) continue;

        seen[i] = true; // Set this node as seen
        prev[i] = curr; // Set this node's parent in this BFS
        q.add(i);
      }
    } while (q.length != 0);

    // build it backwards
    // walk the prevs till we get to a -1
    var curr = needle;
    final path = <int>[];

    while (prev[curr] != -1) {
      path.add(curr);
      curr = prev[curr];
    }

    if (path.length != 0) {
      var ret = [source];
      ret.addAll(path.reversed.toList());
      return ret;
    }

    return [];
  }
}

void main() {
  var graph = UUGAM();

  // graph.addNode(20);
  // graph.addNode(45);
  // graph.addNode(69);
  //
  // graph.addEdge(0, 1);
  // graph.addEdge(0, 2);
  // print(graph);
  //
  // graph.removeNode(2);
  // print(graph);

  graph.addNode(0);
  graph.addNode(1);
  graph.addNode(2);
  graph.addNode(3);
  graph.addNode(4);

  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(0, 3);

  graph.addEdge(1, 3);

  graph.addEdge(2, 4);

  final path = graph.breadthFirstTraversal(0, 4);
  print(path);
}
