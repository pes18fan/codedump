class Node<T> {
  T value;
  Node<T>? next = null;
  Node<T>? prev = null;

  Node(this.value);
}

/* Least Recently Used cache */
class LRU<K, V> {
  int _length = 0;
  int _capacity; // Max capacity of cache, defaults to 10
  Node<V>? _head = null;
  Node<V>? _tail = null;

  Map<K, Node<V>> _lookup = Map();
  Map<Node<V>, K> _reverseLookup = Map();

  LRU([this._capacity = 10]);

  /* Quick note: `update` can also insert a value that doesn't exist, not just
   * update an existing one */
  void update(K key, V value) {
    /* does it exist?
     * if it doesn't, insert it
     *    - check capacity and evict if over capacity
     * if value exists, update to front of the list and update value
     */
    var node = _lookup[key];
    if (node == null) {
      node = Node(value);
      _length++;
      _prepend(node);
      _trimCache();

      _lookup[key] = node;
      _reverseLookup[node] = key;
    } else {
      _detach(node);
      _prepend(node);
      node.value = value;
    }
  }

  V? get(K key) {
    // check the cache if the value exists
    final node = _lookup[key];
    if (node == null) {
      return null;
    }

    // update the value we found and move it to the front
    _detach(node);
    _prepend(node);

    // return the value found or null if doesn't exist
    return node.value;
  }

  // Detach a node from the linked list.
  void _detach(Node<V> node) {
    if (node.prev != null) {
      node.prev!.next = node.next;
    }

    if (node.next != null) {
      node.next!.prev = node.prev;
    }

    if (_head == node) {
      _head = _head!.next;
    }

    if (_tail == node) {
      _tail = _tail!.prev;
    }

    node.next = node.prev = null;
  }

  // Prepend a node to the linked list.
  void _prepend(Node<V> node) {
    if (_head == null) {
      _head = _tail = node;
      return;
    }

    node.next = _head;
    _head!.prev = node;
    _head = node;
  }

  // Remove the least recently used item in the cache.
  void _trimCache() {
    if (_length <= _capacity) {
      return;
    }

    // remove the tail
    final tail = _tail;
    _detach(_tail!);

    final key = _reverseLookup[tail];
    _lookup.remove(key);
    _reverseLookup.remove(tail);
    _length--;
  }
}

void main() {
  var lru = LRU<String, int>(3);

  assert(lru.get("foo") == null);
  lru.update("foo", 69);
  assert(lru.get("foo") == 69);

  lru.update("bar", 420);
  assert(lru.get("bar") == 420);

  lru.update("baz", 1337);
  assert(lru.get("baz") == 1337);

  lru.update("ball", 69420);
  assert(lru.get("ball") == 69420);
  assert(lru.get("foo") == null);
  assert(lru.get("bar") == 420);

  lru.update("foo", 69);
  assert(lru.get("bar") == 420);

  print("ok");
}
