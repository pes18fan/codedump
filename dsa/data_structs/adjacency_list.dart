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

class AdjacencyList {
  late List<GraphNode> data;

  AdjacencyList() {
    this.data = [];
  }

  void addNode(int data, {int? from, int? to}) {
    var currentListLength = this.data.length;

    if (from != null) {
      if (from > this.data.length || from < 0) {
        throw ArgumentError("Value for from is invalid.");
      }

      // Update the references to the existing graphs.
      for (var entry in this.data.asMap().entries) {
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
      if (to > this.data.length || to < 0) {
        throw ArgumentError("Value for to is invalid.");
      }

      // Update the references to the existing graphs.
      for (var entry in this.data.asMap().entries) {
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
    this.data.add(GraphNode(data, from: fromList, to: toList));
  }

  @override
  String toString() {
    var buf = StringBuffer();

    buf.writeln("[");
    for (int i = 0; i < this.data.length; i++) {
      var nodeAsString = this.data[i].toString();
      buf.write("\t$i: $nodeAsString");

      if (i != this.data.length - 1) {
        buf.writeln(",");
      } else {
        buf.writeln();
      }
    }
    buf.writeln("]");

    return buf.toString();
  }
}

void main() {
  var graph = AdjacencyList();

  graph.addNode(20);
  graph.addNode(45, from: 0);
  graph.addNode(69, from: 0, to: 1);

  print(graph.toString());
}
