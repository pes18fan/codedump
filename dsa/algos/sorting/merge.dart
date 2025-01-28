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
    if (left.isEmpty) return right;
    if (right.isEmpty) return left;

    var merged = <int>[];

    int i = 0; // For left
    int j = 0; // For right
    while (true) {
      if (left[i] < right[j]) {
        merged.add(left[i]);
        i++;
      } else {
        merged.add(right[j]);
        j++;
      }

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
    if (list.length <= 1) return list;

    int middle = list.length ~/ 2;
    var left = list.sublist(0, middle);
    var right = list.sublist(middle, list.length);

    left = _sort(left);
    right = _sort(right);

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
