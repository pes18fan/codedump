/* Convert an infix expression into a postfix expression. Note that this only
 * works for infix expressions that have single-digit numbers. */
import "../data_structs/stack.dart";

const precedence = {"(": 2, "/": 1, "*": 1, "+": 0, "-": 0};

String toPostfix(String infix) {
  var opStack = Stack<String>();
  var postfix = StringBuffer();

  for (int i = 0; i < infix.length; i++) {
    var scanned = infix[i];

    switch (scanned) {
      case "+":
      case "-":
      case "*":
      case "/":
        {
          if (opStack.isEmpty()) {
            opStack.push(scanned);
            continue;
          }

          var topOp = opStack.peek();

          if (topOp == "(") {
            opStack.push(scanned);
            continue;
          }

          if (precedence[topOp]! >= precedence[scanned]!) {
            postfix.write(opStack.pop()! + " ");
          }

          opStack.push(scanned);
        }
      case "(":
        opStack.push(scanned);
      case ")":
        {
          while (true) {
            var popped = opStack.pop();

            if (popped == null) {
              throw ArgumentError(
                  "Invalid postfix string; bracket not closed.");
            } else if (popped == "(") {
              break;
            }

            postfix.write(popped + " ");
          }
        }
      case " ":
        continue;
      case _:
        {
          if (num.tryParse(scanned) == null) {
            throw ArgumentError("Invalid value $scanned in infix string.");
          }

          postfix.write(scanned + " ");
        }
    }
  }

  while (!opStack.isEmpty()) {
    var value = opStack.pop()!;
    if (value == "(") {
      throw ArgumentError("Invalid postfix string; bracket not closed.");
    }

    postfix.write(value + " ");
  }

  return postfix.toString().trim();
}

void main() {
  assert(toPostfix("1 - 3 * (6 + 4) / 4") == "1 3 6 4 + * 4 / -");
  print("ok");
}
