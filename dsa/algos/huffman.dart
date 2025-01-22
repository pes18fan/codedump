/* An implementation of Huffman coding.
 * Probably the most inefficient implementation of that algorithm in the entire
 * universe, I have done this because I'm just learning about it. I'll probably
 * optimize it properly later on. */
class HuffmanNode {
  String? character;
  int frequency;
  HuffmanNode? left;
  HuffmanNode? right;

  HuffmanNode(this.character, this.frequency);
}

/* A map of each character to its code */
var characterMap = <String, String>{};

String? _findCharacterCode(HuffmanNode? node, String needle, String path) {
  // character doesn't exist in the tree
  if (node == null) {
    return null;
  }

  // found the character! Now, return the associated code
  if (node.character != null && node.character == needle) {
    characterMap[needle] = path;
    return path;
  }

  var left = _findCharacterCode(node.left, needle, path + "0");
  if (left != null) {
    return left; // the left path
  }

  var right = _findCharacterCode(node.right, needle, path + "1");
  return right; // either the right path or null
}

String? findCharacterCode(HuffmanNode root, String needle) {
  var path = "";

  return _findCharacterCode(root, needle, path);
}

(String?, String) _findCharacter(HuffmanNode? node, String code) {
  if (node == null) {
    return (null, code);
  }

  /* Found the character. Why? Because we reached a leaf node. */
  if (node.left == null && node.right == null) {
    return (node.character, code);
  }

  /* See where the code's telling us to go */
  if (code[0] == "0") {
    return _findCharacter(node.left, code.substring(1));
  } else if (code[0] == "1") {
    return _findCharacter(node.right, code.substring(1));
  } else {
    /* Invalid Huffman code as it has something other than a zero or one */
    return (null, code);
  }
}

/* Return the character we're looking for (first string) and the remaining code
 * that we sent (second string). */
(String?, String) findCharacter(HuffmanNode root, String code) {
  if (code.isEmpty) {
    throw ArgumentError("Code can't be empty!");
  }

  return _findCharacter(root, code);
}

HuffmanNode getHuffmanTree(String text) {
  // calculate character frequency
  var charFrequency = <String, int>{};

  for (int i = 0; i < text.length; i++) {
    var character = text[i];

    charFrequency.putIfAbsent(character, () => 0);
    charFrequency[character] = charFrequency[character]! + 1;
  }

  // put in a queue
  var queue = <HuffmanNode>[];
  charFrequency.forEach((k, v) {
    queue.add(HuffmanNode(k, v));
  });
  queue.sort((a, b) => a.frequency.compareTo(b.frequency));

  HuffmanNode root;

  // create the huffman tree
  while (true) {
    var b = queue.removeAt(0);
    var a = queue.removeAt(0);
    var newNode = HuffmanNode(null, a.frequency + b.frequency);
    newNode.right = b;
    newNode.left = a;

    if (queue.isEmpty) {
      root = newNode;
      break;
    }

    queue.add(newNode);
    queue.sort((a, b) => a.frequency.compareTo(b.frequency));
  }

  return root;
}

String encode(String text, [HuffmanNode? treeRoot]) {
  treeRoot ??= getHuffmanTree(text);

  // traverse the tree to form the code
  var sb = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    var character = text[i];

    if (characterMap[i] != null) {
      sb.write(characterMap[i]);
      continue;
    }

    var charCode = findCharacterCode(treeRoot, character);
    if (charCode == null) {
      throw ArgumentError("Invalid Huffman tree provided.");
    }

    sb.write(charCode);
  }

  return sb.toString();
}

String decode(String code, HuffmanNode treeRoot) {
  var sb = StringBuffer();

  while (true) {
    var (character, updatedCode) = findCharacter(treeRoot, code);
    code = updatedCode;

    if (character == null) {
      throw ArgumentError("Invalid Huffman code or Huffman tree provided.");
    }

    sb.write(character);

    if (code.isEmpty) {
      break;
    }
  }

  return sb.toString();
}

void main() {
  var str = "aaabbbbcccccdd";

  var root = getHuffmanTree(str);
  String code = encode(str, root);

  print("Number of bits in original string: ${str.length * 8}");
  print("Number of bits in compressed string: ${code.length}");

  String original = decode(code, root);
  print("Decoded as: $original");
}
