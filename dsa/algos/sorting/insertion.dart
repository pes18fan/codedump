extension on List<int> {
  /// Check if two lists are equal.
  bool equals(List<int> list) {
    if (this.length != list.length) return false;

    for (int i = 0; i < list.length; i++) {
      if (this[i] != list[i]) return false;
    }

    return true;
  }

  /// Return a sorted version of a list using insertion sort.
  List<int> insertionSorted() {
    // A singular element or an empty list is inherently sorted.
    if (this.length <= 1) {
      return this;
    }

    var list = List<int>.from(this);

    // Walk the unsorted part of the array.
    for (int i = 1; i < list.length; i++) {
      /* Walk the sorted part of the array backwards, swapping elements
       * along the way. As we walk back, once we get to an element that is
       * smaller than the one just after it, we stop swapping. */
      // NOTE: A possible optimization here is to shift instead of swapping
      for (int j = i - 1; j >= 0; j--) {
        if (list[j] < list[j + 1]) {
          break;
        }

        var tmp = list[j + 1];
        list[j + 1] = list[j];
        list[j] = tmp;
      }
    }

    return list;
  }
}

void main() {
  print("sorted: ${[3, 1, 0, -1, 92, 81, 19].insertionSorted()}");
  assert([3, 1, 0, -1, 92, 81, 19]
      .insertionSorted()
      .equals([-1, 0, 1, 3, 19, 81, 92]));
  print("ok");
}
