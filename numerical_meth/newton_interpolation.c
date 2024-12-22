#include <stdio.h>

int main() {
    int n;

    printf("How many points? ");
    scanf("%d", &n);

    double xp;

    printf("Provide the input (xp): ");
    scanf("%lf", &xp);

    double x[n], a[n][n];
    for (int i = 0; i < n; i++) {
        printf("Provide x[%d] and a[0][%d]: ", i, i);
        scanf("%lf %lf", &x[i], &a[0][i]);
    }

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < n - i; j++) {
            a[i][j] = (a[i - 1][j + 1] - a[i - 1][j]) / (x[i + j] - x[j]);
        }
    }

    double p = a[0][0];
    double product;

    for (int i = 1; i < n; i++) {
        product = 1;
        for (int j = 0; j < i; j++) {
            product *= xp - x[j];
        }
        p += a[i][0] * product;
    }

    printf("Result is %.3lf", p);
    return 0;
}
