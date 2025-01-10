/* Convert an infix expression into a postfix expression. Note that this only
 * works for infix expressions that have single-digit numbers. */
import "../data_structs/stack.dart";

enum Associativity { LR, RL }

int precedenceOf(String c) {
  switch (c) {
    case "(":
    case ")":
      return 3;
    case "^":
      return 2;
    case "/":
    case "*":
      return 1;
    case "+":
    case "-":
      return 0;
    default:
      throw ArgumentError("Invalid operator $c\n");
  }
}

Associativity associativityOf(String c) {
  switch (c) {
    case "/":
    case "*":
    case "+":
    case "-":
      return Associativity.LR;
    case "^":
      return Associativity.RL;
    default:
      throw ArgumentError("Invalid operator $c\n");
  }
}

String toPostfix(String infix) {
  var opStack = Stack<String>();
  var postfix = StringBuffer();

  for (int i = 0; i < infix.length; i++) {
    var scanned = infix[i];

    switch (scanned) {
      case "^":
      case "+":
      case "-":
      case "*":
      case "/":
        {
          if (opStack.isEmpty()) {
            opStack.push(scanned);
            continue;
          }

          var topOp = opStack.peek()!;

          if (topOp == "(") {
            opStack.push(scanned);
            continue;
          }

          if (precedenceOf(topOp) > precedenceOf(scanned)) {
            postfix.write(opStack.pop()! + " ");
            opStack.push(scanned);
          } else if (precedenceOf(topOp) < precedenceOf(scanned)) {
            opStack.push(scanned);
          } else {
            if (associativityOf(scanned) == Associativity.LR) {
              postfix.write(opStack.pop()! + " ");
              opStack.push(scanned);
            } else {
              opStack.push(scanned);
            }
          }
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

          // To allow multi-digit numbers
          if (i + 1 < infix.length && num.tryParse(infix[i + 1]) != null) {
            postfix.write(scanned);
          } else {
            postfix.write(scanned + " ");
          }
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
  assert(toPostfix("1 - 37 * (6 + 4) / 41") == "1 37 6 4 + * 41 / -");
  print("ok");
}
