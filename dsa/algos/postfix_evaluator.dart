/* Evaluate a postfix expression. Note that it only works when the postfix
 * expression has just single-digit numbers. */
import "dart:math";
import "../data_structs/stack.dart";
import "infix_to_postfix.dart";

extension on double {
  /* Check for double near-equality within a certain tolerance. Checking two
   * floats for equality is nearly impossible in computers, so the next best
   * thing to do is to use this with a very low tolerance. */
  bool within(double b, {required double tol}) {
    var d = (this - b).abs();
    if (d == 0) {
      return true;
    }

    return d / (this.abs() + b.abs()) < tol;
  }
}

double evaluate(String postfix) {
  var stk = Stack<double>();
  var scanned_num = "";

  for (int i = 0; i < postfix.length; i++) {
    var scanned = postfix[i];

    switch (scanned) {
      case "^":
      case "+":
      case "-":
      case "/":
      case "*":
        {
          if (stk.isEmpty()) throw ArgumentError("Invalid postfix expression.");
          var b = stk.pop()!;

          if (stk.isEmpty()) throw ArgumentError("Invalid postfix expression.");
          var a = stk.pop()!;

          double result;
          if (scanned == "^") {
            result = pow(a, b).toDouble();
          } else if (scanned == "+") {
            result = a + b;
          } else if (scanned == "-") {
            result = a - b;
          } else if (scanned == "/") {
            result = a / b;
          } else {
            result = a * b;
          }

          stk.push(result);
        }
      case " ":
        continue;
      case _:
        if (num.tryParse(scanned) == null) {
          throw ArgumentError("Operands must be numbers.");
        }

        scanned_num += postfix[i];
        if (i + 1 < postfix.length && num.tryParse(postfix[i + 1]) != null) {
          continue;
        } else {
          stk.push(num.parse(scanned_num).toDouble());
          scanned_num = "";
        }
    }
  }

  if (stk.isEmpty()) throw ArgumentError("Invalid postfix expression.");
  return stk.pop()!;
}

void main() {
  var postfix = toPostfix("92 + 3 - (4 + 12) / 2 ^ 10");
  var infixResult = 92 + 3 - (4 + 12) / (pow(2, 10).toDouble());
  assert(evaluate(postfix).within(infixResult, tol: 0.0000000001));
  print("ok");
}
