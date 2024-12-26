#include <stdio.h>

int main() {
    int n;
    printf("Enter the number of readings: ");
    scanf("%d", &n);

    double x[n], y[n][n];

    for (int i = 0; i < n; i++) {
        printf("Enter x and y for (x%d, y%d): ", i, i);
        scanf("%lf %lf", &x[i], &y[i][0]);
    }

    for (int j = 1; j < n; j++) {
        for (int i = 0; i < n; i++) {
            y[i][j] = y[i + 1][j - 1] - y[i][j - 1];
        }
    }

    // Print out the difference table
    printf("\t\t\tForward Difference Table\n");

    printf("x\t");
    for (int i = 0; i < n; i++) {
        if (i == 0) {
            printf("y\t");
        } else {
            printf("d%dy\t", i);
        }
    }
    printf("\n");

    int k = n;
    for (int i = 0; i < n; i++) {
        printf("%.3lf\t", x[i]);

        for (int j = 0; j < k; j++) {
            printf("%.3lf\t", y[i][j]);
        }

        k--;
        printf("\n");
    }

    return 0;
}
