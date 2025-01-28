extension on List<int> {
  /// Check if two lists are equal.
  bool equals(List<int> list) {
    if (this.length != list.length) return false;

    for (int i = 0; i < list.length; i++) {
      if (this[i] != list[i]) return false;
    }

    return true;
  }

  /// Return a sorted version of a list using selection sort.
  List<int> selectionSorted() {
    // A singular element or an empty list is inherently sorted.
    if (this.length <= 1) {
      return this;
    }

    var list = List<int>.from(this);

    for (int i = 0; i < list.length - 1; i++) {
      var minIdx = i;
      for (int j = i + 1; j < list.length; j++) {
        if (list[j] < list[minIdx]) minIdx = j;
      }

      var tmp = list[i];
      list[i] = list[minIdx];
      list[minIdx] = tmp;
    }

    return list;
  }
}

void main() {
  print("sorted: ${[3, 1, 0, -1, 92, 81, 19].selectionSorted()}");
  assert([3, 1, 0, -1, 92, 81, 19]
      .selectionSorted()
      .equals([-1, 0, 1, 3, 19, 81, 92]));
  print("ok");
}
