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

String? _findCharacter(HuffmanNode? node, String needle, String path) {
  // character not found
  if (node == null) {
    return null;
  }

  // found the character!
  if (node.character != null && node.character == needle) {
    return path;
  }

  var left = _findCharacter(node.left, needle, path + "0");
  if (left != null) {
    return left; // either the left path or null
  }

  var right = _findCharacter(node.right, needle, path + "1");
  return right; // either the right path or null
}

String? findCharacter(HuffmanNode? root, String needle) {
  var path = "";

  return _findCharacter(root, needle, path);
}

String huffman(String text) {
  // calculate character frequency
  var charFrequency = Map<String, int>();

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
  }

  // now traverse it to form the code
  var sb = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    var character = text[i];
    String charCode = findCharacter(root, character)!;
    sb.write(charCode);
  }

  return sb.toString();
}

void main() {
  var str = "huffman coding exampleeeee";
  String code = huffman(str);
  print("Number of bits in original string: ${str.length * 8}");
  print("Number of bits in compressed string: ${code.length}");
}
