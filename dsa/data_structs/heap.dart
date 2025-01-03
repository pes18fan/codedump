/* # Heap / Priority queue.

   A heap is a binary tree, where every child and grandchild of a node is
   smaller (a max heap) or larger (a min heap) than itself. Whenever a node
   is added or deleted, we must adjust it. We don't "traverse" a heap.

   Every level of a heap must be filled. There are no empty spaces when going
   from left to right on each level.

   This is a min heap:

   ```
                50
            /       \
          71        100
         /  \      /   \
       101  80   200   101
   ```

   Heaps are weakly ordered.

   ## Insert a node

   First, go straight to the bottom of the heap. Then bubble up as required.
   For example, if we inserted 3 to the above min heap, it would go down to the
   bottom, then start bubbling back up, swapping with its parents, until it 
   reached the top, where it should be.

   ## Deleting

   We always delete the root node. Then we take the last node and put it at
   the top. Then we bubble down as required.

   But, HOW do we "get" or "take" the last node? That would be hard with
   a node-based data-structure. Instead, we use something else.

   Assign an index to each element, like an array, breadth-first. So, in
   the above poorly drawn heap, 50 would be index 0, 71 would be 1, 100
   would be 2, 101 would be 3 etc etc. So we'd get:

   [50, 71, 100, 101, 80, 200, 101]
    0   1    2    3   4    5    6

   To find the index of a node's children in this array, you use two
   formulae:

   2i + 1 for the left child, and
   2i + 2 for the right child.

   Where, `i` is the index of the node whose children you're trying to get.
   
   Try applying this formula to index 2 (100). You'll get:

   2 * 2 + 1 = 5 (200)
   2 * 2 + 2 = 6 (101)

   Which are indeed the correct children!

   Well, that's cool and all, but how do we go back? Use this formula
   to reverse the thing we did just before:

   (i - 2) / 2

   This will get the parent of a node. Applying it to node 5 gives:

   (5 - 2) / 2 => 3 / 2 => 1

   Which indeed is its parent!

   And, to get the last item, just keep track of the length of the array.

   Both insertion and deletion from a heap are O(log n).
*/
class MinHeap {
  late int len;
  late List<int> _data;

  MinHeap() {
    _data = [];
    len = 0;
  }

  bool get isEmpty => len == 0;

  void insert(int value) {
    _data.add(value);
    _heapifyUp(this.len);
    len++;
  }

  int delete() {
    if (len == 0) {
      return -1;
    }

    final out = _data[0];
    len--;

    if (this.len == 0) {
      _data = [];
      return out;
    }

    _data[0] = _data[this.len];
    _heapifyDown(0);
    return out;
  }

  void _heapifyDown(int idx) {
    final lIdx = _leftChild(idx);
    final rIdx = _rightChild(idx);

    if (idx >= len || lIdx >= len) {
      return;
    }

    final lV = _data[lIdx];
    final rV = _data[rIdx];
    final v = _data[idx];

    if (lV > rV && v > rV) {
      _data[idx] = rV;
      _data[rIdx] = v;
      _heapifyDown(rIdx);
    } else if (rV > lV && v > lV) {
      _data[idx] = lV;
      _data[lIdx] = v;
      _heapifyDown(lIdx);
    }
  }

  void _heapifyUp(int idx) {
    if (idx == 0) return;

    final p = _parent(idx);
    final parentV = _data[p];
    final v = _data[idx];

    if (parentV > v) {
      _data[idx] = parentV;
      _data[p] = v;
      _heapifyUp(p);
    }
  }

  int _leftChild(int idx) => idx * 2 + 1;
  int _rightChild(int idx) => idx * 2 + 2;
  int _parent(int idx) => (idx - 1) ~/ 2;
}

void main() {
  final heap = MinHeap();

  heap.insert(5);
  heap.insert(3);
  heap.insert(69);
  heap.insert(420);
  heap.insert(4);
  heap.insert(1);
  heap.insert(8);
  heap.insert(7);

  assert(heap.len == 8);
  assert(heap.delete() == 1);
  assert(heap.delete() == 3);
  assert(heap.delete() == 4);
  assert(heap.delete() == 5);
  assert(heap.len == 4);
  assert(heap.delete() == 7);
  assert(heap.delete() == 8);
  assert(heap.delete() == 69);
  assert(heap.delete() == 420);
  assert(heap.len == 0);
}
