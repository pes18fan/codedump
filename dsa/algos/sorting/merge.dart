extension on List<int> {
  /// Check if two lists are equal.
  bool equals(List<int> list) {
    if (this.length != list.length) return false;

    for (int i = 0; i < list.length; i++) {
      if (this[i] != list[i]) return false;
    }

    return true;
  }

  List<int> _merge(List<int> left, List<int> right) {
    /* If any one of the lists is empty, the merged result is just the non-empty
     * one. */
    if (left.isEmpty) return right;
    if (right.isEmpty) return left;

    var merged = <int>[];

    int i = 0; // Index for left
    int j = 0; // Index for right
    while (true) {
      /* Add left's value to `merged` if its smaller, then increment its 
       * index, similarly increment right's index if its value is smaller
       */
      if (left[i] < right[j]) {
        merged.add(left[i]);
        i++;
      } else {
        merged.add(right[j]);
        j++;
      }

      /* When one of the lists runs out of elements, add the rest of the elements
       * of the other to `merged` and end the loop. */
      if (i >= left.length) {
        merged.addAll(right.sublist(j));
        break;
      } else if (j >= right.length) {
        merged.addAll(left.sublist(i));
        break;
      }
    }

    return merged;
  }

  List<int> _sort(List<int> list) {
    /* A list with one or zero elements is inherently sorted. */
    if (list.length <= 1) return list;

    /* Split the list into two. */
    int middle = list.length ~/ 2; // In Dart, ~/ means integer division
    var left = list.sublist(0, middle);
    var right = list.sublist(middle, list.length);

    left = _sort(left);
    right = _sort(right);

    /* Merge the two lists back together. */
    return _merge(left, right);
  }

  /// Return a sorted version of a list using merge sort.
  List<int> mergeSorted() {
    var list = List<int>.from(this);
    return _sort(list);
  }
}

void main() {
  print("sorted: ${[9, 2, 0, 1, 92, 81, 19].mergeSorted()}");
  assert(
      [9, 2, 0, 1, 92, 81, 19].mergeSorted().equals([0, 1, 2, 9, 19, 81, 92]));
  print("ok");
}
