/* Simple array-based implementation of a priority queue. Higher priority items
 * will be at the beginning in this implementation. This priority queue stores
 * integers, whose values themselves are the priority. */
class PriorityQueue {
  List<int> arr = [];

  PriorityQueue();

  @override
  String toString() {
    var sb = StringBuffer();

    sb.write("[");
    int i = 0;
    for (var elem in arr) {
      sb.write(elem);
      if (i != arr.length - 1) sb.write(", ");
      i++;
    }
    sb.write("]");

    return sb.toString();
  }

  void _moveUp(int index) {
    var value = arr[index];

    if (index == 0) return;
    if (arr[index - 1] > value) return;

    arr[index] = arr[index - 1];
    arr[index - 1] = value;
    _moveUp(index - 1);
  }

  void enqueue(int value) {
    arr.add(value);
    _moveUp(arr.length - 1);
  }

  int? deque() {
    if (arr.isEmpty) return null;
    return arr.removeAt(0);
  }
}

void main() {
  var q = PriorityQueue();

  q.enqueue(69);
  q.enqueue(12);
  q.enqueue(18);
  q.enqueue(24);
  q.enqueue(29);
  print(q);
}
