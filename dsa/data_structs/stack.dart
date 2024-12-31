/* Stack.
 * A stack is more or less the opposite of a queue. It is
 * a last-in, first-out (LIFO) data structure. Stacks provide
 * a "push" method to push a value to the top, a "pop" method
 * to remove a value from the top and a "peek" method to see
 * what value is at the top.
 * If this is a queue:
 *
 * hd -> A -> B -> C -> D <- tl
 *
 * This is a stack:
 *
 * tl -> A <- B <- C <- D <- hd
 *
 * The last element is the head.
 */

// a stack node.
class Node<T> {
  final T value;
  Node<T>? prev;

  Node(this.value, this.prev);
}

class Stack<T> {
  Node<T>? _head;
  int len = 0;

  Stack() {
    _head = null;
  }

  bool isEmpty() {
    return _head == null;
  }

  void push(T item) {
    final node = Node<T>(item, null);

    len++;
    if (isEmpty()) {
      _head = node;
      return;
    }

    final hed = _head;
    _head = node;
    _head?.prev = hed;
  }

  T? pop() {
    if (isEmpty()) return null;

    final hed_value = _head?.value;
    _head = _head?.prev;
    // prevent len from being less than zero
    len = len < 0 ? 0 : len - 1;

    return hed_value;
  }

  T? peek() {
    if (_head == null)
      return null;
    else
      return _head?.value;
  }
}

void main() {
  final stuff = Stack<int>();
  stuff.push(69);
  stuff.push(420);

  assert(stuff.peek() == 420);
  assert(stuff.len == 2);

  assert(stuff.pop() == 420);
  assert(stuff.pop() == 69);
  assert(stuff.pop() == null);
}
