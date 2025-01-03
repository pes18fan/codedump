/* An unweighted undirected adjacency-list based graph implementation. */
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

/* UUG = Undirected Unweighted Graph */
class UUG {
  late List<GraphNode> nodes;

  UUG() {
    this.nodes = [];
  }

  @override
  String toString() {
    var buf = StringBuffer();

    buf.writeln("[");
    for (int i = 0; i < this.nodes.length; i++) {
      var nodeAsString = this.nodes[i].toString();
      buf.write("\t$i: $nodeAsString");

      if (i != this.nodes.length - 1) {
        buf.writeln(",");
      } else {
        buf.writeln();
      }
    }
    buf.writeln("]");

    return buf.toString();
  }

  bool has(int index) {
    if (index < 0 || index >= this.nodes.length)
      return false;
    else
      return true;
  }

  void addNode(int data, {int? from, int? to}) {
    var currentListLength = this.nodes.length;

    if (from != null) {
      if (!this.has(from)) {
        throw ArgumentError("Value for from is invalid.");
      }

      // Update the references to the existing graphs.
      for (var entry in this.nodes.asMap().entries) {
        if (entry.key == from) {
          if (entry.value.to != null)
            entry.value.to!.add(currentListLength);
          else {
            entry.value.to = [currentListLength];
          }
        }
      }
    }

    if (to != null) {
      if (!this.has(to)) {
        throw ArgumentError("Value for to is invalid.");
      }

      // Update the references to the existing graphs.
      for (var entry in this.nodes.asMap().entries) {
        if (entry.key == to) {
          if (entry.value.from != null)
            entry.value.from!.add(currentListLength);
          else {
            entry.value.from = [currentListLength];
          }
        }
      }
    }

    var fromList = from != null ? [from] : null;
    var toList = to != null ? [to] : null;
    this.nodes.add(GraphNode(data, from: fromList, to: toList));
  }

  void removeNode(int index) {
    if (!this.has(index)) {
      throw ArgumentError("No node exists with index $index.");
    }

    var froms = this.nodes[index].from;
    var tos = this.nodes[index].to;
    this.nodes.removeAt(index);

    if (froms != null) {
      for (var idx in froms) {
        this.nodes[idx].to!.removeWhere((i) => i == index);
      }
    }

    if (tos != null) {
      for (var idx in tos) {
        this.nodes[idx].from!.removeWhere((i) => i == index);
      }
    }
  }
}

void main() {
  var graph = UUG();

  graph.addNode(20);
  graph.addNode(45, from: 0);
  graph.addNode(69, from: 0, to: 1);
  print(graph);

  graph.removeNode(2);
  print(graph);
}
