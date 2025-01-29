#include <stdio.h>

void toh(int n, char a, char b, char c) {
    if (n > 0) {
        toh(n - 1, a, c, b);
        printf("%c to %c\n", a, c);
        toh(n - 1, b, a, c);
    }
}

int main() {
    int n;

    printf("How many disks? ");
    scanf("%d", &n);

    toh(n, 'a', 'b', 'c');
}
