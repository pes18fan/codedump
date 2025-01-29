#include <stdio.h>

long factorial(int n) {
    if (n <= 1)
        return 1;
    else
        return n * factorial(n - 1);
}

int main() {
    int n;

    printf("What number do you want the factorial of? ");
    scanf("%d", &n);

    printf("The factorial of %d is %ld.", n, factorial(n));
}
