void toh(int n, String a, String b, String c) {
  if (n > 0) {
    toh(n - 1, a, c, b);
    print("$a to $c");
    toh(n - 1, b, a, c);
  }
}

void main() {
  toh(3, "a", "b", "c");
}
