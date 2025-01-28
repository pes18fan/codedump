#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;

    printf("How many equations? ");
    scanf("%d", &n);
    printf("\n");

    double mat[n][n + 1];    // Since a separate column exists for coeffs

    // Input the augmented matrix
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n + 1; j++) {
            printf("Enter mat[%d][%d]: ", i, j);
            scanf("%lf", &mat[i][j]);
        }
    }

    // First step
    // Note: i and j being "swapped" is intentional
    // Iterate over columns
    for (int j = 0; j < n - 1; j++) {
        if (mat[j][j] == 0) {
            fprintf(stderr, "Invalid matrix.");
            exit(1);
        }

        // Iterate over rows
        for (int i = j + 1; i < n; i++) {
            double ratio = mat[i][j] / mat[j][j];

            // Over columns
            for (int k = 0; k < n + 1; k++) {
                mat[i][k] -= mat[j][k] * ratio; 
            }
        }
    }

    double x[n];

    for (int i = n - 1; i >= 0; i--) {
        x[i] = mat[i][n];
        
        for (int j = i + 1; j < n; j++) {
            x[i] = x[i] - mat[i][j] * x[j];
        }

        x[i] /= mat[i][i];
    }

    for (int i = 0; i < n; i++) {
        printf("%lf\n", x[i]);
    }
}