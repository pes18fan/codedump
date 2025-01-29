#include <stdio.h>

long fibonacci(int n) {
    if (n <= 1)
        return 0;
    if (n == 2)
        return 1;
    else
        return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int n;

    printf("What-th Fibonacci number? ");
    scanf("%d", &n);

    printf("The %dth Fibonacci number is %ld.", n, fibonacci(n));
}
