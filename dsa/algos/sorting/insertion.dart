extension on List<int> {
  bool equals(List<int> list) {
    if (this.length != list.length) return false;

    for (int i = 0; i < list.length; i++) {
      if (this[i] != list[i]) return false;
    }

    return true;
  }

  List<int> insertionSorted() {
    if (this.length <= 1) {
      return this;
    }

    var list = this;

    for (int i = 1; i < list.length; i++) {
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
