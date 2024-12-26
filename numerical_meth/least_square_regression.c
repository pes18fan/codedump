#include <stdio.h>

int main() {
    int n;

    printf("How many points? ");
    scanf("%d", &n);

    double x[n], y[n];
    double sum_xx = 0, sum_xy = 0, sum_x = 0, sum_y = 0;
    double a, b; // For y = a + bx

    for (int i = 0; i < n; i++) {
        printf("Provide x and y for (x%d, y%d): ", i, i);
        scanf("%lf %lf", &x[i], &y[i]);
    }

    // Summing up
    for (int i = 0; i < n; i++) {
        sum_x += x[i];
        sum_y += y[i];
        sum_xx += x[i] * x[i];
        sum_xy += x[i] * y[i];
    }

    b = (n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x * sum_x);
    a = (sum_y - b * sum_x) / n;

    if (b >= 0) {
        printf("The best-fitting equation is y = %.3lf + %.3lfx.", a, b);
    } else {
        printf("The best-fitting equation is y = %.3lf - %.3lfx.", a, -b);
    }
}
