#include <stdio.h>

/* Used to calculate y(xp) using Newton's interpolation formula, not necessary
 * if only the table is needed. */
double factorial(double x) {
    if (x <= 1)
        return 1;
    else
        return x * factorial(x - 1);
}

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

    /* Calculation of y(xp) using Newton's interpolation formula, not necessary
     * if only the table is needed. */
    double xp;
    printf("Enter the value of xp to find f(xp) at: ");
    scanf("%lf", &xp);

    double p = (xp - x[0]) / (x[1] - x[0]);

    double res = y[0][0];
    for (int i = 1; i < n; i++) {
        double p_roduct = p;
        int k = 1;
        for (int j = 1; j < i; j++, k++) {
            p_roduct *= (p - k);
        }
        res += y[0][i] * (p_roduct / factorial(i));
    }

    printf("Result is %lf", res);

    return 0;
}
