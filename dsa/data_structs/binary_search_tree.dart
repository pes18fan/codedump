/* 
A binary search tree is a binary tree, where at any node, everything in its
left subtree must be less than or equal to its own value, and everything in its
right subtree must be greater than (or equal to) its own value. In that sense,
it kind of has some of the characteristics of the quicksort algorithm.

If we want to find an element in the tree, we can do something resembling a 
binary search on an arraylist. We'd use depth first search here. 
*/
import "binary_tree.dart";

// integer binary tree
class BST {
  BinaryNode<int>? root;

  BST();

  void _toString(StringBuffer buf, BinaryNode<int>? curr) {
    if (curr == null) return;

    // push the root as character
    buf.write(curr.toString());

    // if a leaf, return
    if (curr.left == null && curr.right == null) return;

    // for left subtree
    buf.write('(');
    _toString(buf, curr.left);
    buf.write(')');

    // for right subtree
    if (curr.right != null) {
      buf.write('(');
      _toString(buf, curr.right);
      buf.write(')');
    }
  }

  /// Returns a parenthesized representation of the binary search tree.
  @override
  String toString() {
    var buf = StringBuffer();
    _toString(buf, root);
    return buf.toString();
  }

  void _insert(BinaryNode<int>? node, int value) {
    // if the current node is null, we're at the beginning of the tree
    // so we assign the value to the root
    if (node == null) {
      root = BinaryNode(value);
      return;
    }

    if (node.value < value) {
      if (node.right == null) {
        node.right = BinaryNode(value);
        return;
      }

      _insert(node.right, value);
    } else {
      if (node.left == null) {
        node.left = BinaryNode(value);
        return;
      }

      _insert(node.left, value);
    }
  }

  // use a depth first traversal
  bool _has(BinaryNode<int>? node, int value) {
    // if the current node is null, we've reached the end of the tree and failed
    // to find the value
    if (node == null) return false;

    // we found it!
    if (node.value == value) return true;

    // current value is less, so we move to the right subtree
    if (node.value < value) {
      return _has(node.right, value);
    }

    // current value is greater, so we move to the left subtree
    return _has(node.left, value);
  }

  BinaryNode<int>? _delete(BinaryNode<int>? node, int value) {
    /* If the node is null, we're at the beginning of a tree and can't delete
     * from there. */
    if (node == null) {
      throw ArgumentError("Es gibt keinen Wert $value.");
    }

    if (value < node.value) {
      // Delete from the left subtree
      node.left = _delete(node.left, value);
    } else if (value > node.value) {
      // Delete from the right subtree
      node.right = _delete(node.right, value);
    } else {
      // If neither of the above if's are satisfied, we found the node to delete.
      // Now we have three possible situations.
      // Base case 1: node is a leaf, then just delete it
      if (node.left == null && node.right == null) {
        return null;
      }

      // Base case 2: one child, set parent to point to child
      else if (node.left == null || node.right == null) {
        if (node.left == null)
          return node.right;
        else
          return node.left;
      }

      /* Base case 3: two children, take the left hand side (smaller one), find 
       * the largest element in it, put it where the node is. Or, you could do 
       * the inverse by finding the smallest on the large side.
       *
       * In this case, we'll find the smallest in the right side or the in-order
       * successor.
       */
      else {
        // Start with the right node
        BinaryNode<int> successor = node.right!;

        // Find the smallest value in the right subtree
        while (successor.left != null) {
          successor = successor.left!;
        }

        // We now have the smallest value in the right subtree. Replace the current
        // node's value with this.
        node.value = successor.value;
        node.right = _delete(node.right, successor.value);
      }
    }

    return node;
  }

  bool has(int value) {
    return _has(root, value);
  }

  void insert(int value) {
    _insert(root, value);
  }

  void delete(int value) {
    _delete(root, value);
  }
}

void testBST() {
  final tree = BST();

  tree.insert(1);
  tree.insert(69);
  tree.insert(420);
  tree.insert(-1);
  tree.insert(0);

  assert(tree.toString() == "1(-1()(0))(69()(420))");

  assert(tree.has(420));

  tree.delete(420);
  tree.delete(-1);

  assert(tree.toString() == "1(0)(69)");

  final tree2 = BST();

  tree2.insert(1);
  tree2.insert(69);
  tree2.insert(420);
  tree2.insert(-1);
  tree2.insert(0);
  tree2.delete(420);
  tree2.delete(-1);

  assert(binaryTreesEqual(tree.root, tree2.root));

  print("ok");
}

void main() {
  testBST();
}
