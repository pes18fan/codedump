// Rayleigh's power method to calculate the largest eigenvalue
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#define E 0.01

int main() {
    int n;

    printf("What's the order of the matrix? ");
    scanf("%d", &n);

    double mat[n][n], x[n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("Enter mat[%d][%d]: ", i, j);
            scanf("%lf", &mat[i][j]);
        }
    }

    // Initialize x
    for (int i = 0; i < n; i++) {
        x[i] = 1;
    }

    double lambda = 99999999999999;
    while (true) {
        /* Multiply the matrices */
        double result[n];
        for (int i = 0; i < n; i++) {
            result[i] = 0.0;
            for (int j = 0; j < n; j++) {
                result[i] += mat[i][j] * x[j];
            }
        }

        for (int i = 0; i < n; i++) {
            x[i] = result[i];
        }

        double lambda_new = x[0];
        for (int i = 0; i < n; i++) {
            if (x[i] > lambda_new) {
                lambda_new = x[i];
            }
        }

        for (int i = 0; i < n; i++) {
            x[i] /= lambda_new;
        }

        if (fabs(lambda_new - lambda) < E) {
            lambda = lambda_new;
            break;
        }

        lambda = lambda_new;
    }

    printf("Eigenvalue is %lf\n", lambda);

    printf("Eigenvector is: \n");
    for (int i = 0; i < n; i++) {
        printf("%lf\t", x[i]);
    }
    printf("\n");

    return 0;
}
