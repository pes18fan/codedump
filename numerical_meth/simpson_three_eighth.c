#include <stdio.h>
#include <stdlib.h>

double f(double x) { return 1 + x * x * x; }

double integrator(double (*f)(double), double a, double b) {
    int n;
    double h;

    printf("Enter the number of iterations: ");
    scanf("%d", &n);

    if (n % 3 != 0) {
        printf("n must be a multiple of 3!");
        exit(1);
    }

    h = (b - a) / n;

    double offset1 = 0;
    for (int i = 1; i < n; i += 1) {
        if (i % 3 == 0)
            continue;
        offset1 += f(a + i * h);
    }
    offset1 *= 3;

    double offset2 = 0;
    for (int i = 3; i < n; i += 3) {
        offset2 += f(a + i * h);
    }
    offset2 *= 2;

    double integral = ((3 * h) / 8) * (f(a) + f(b) + offset1 + offset2);
    return integral;
}

int main() {
    printf("Approximate integral for 1 + x^3 from 1 to 2 is %lf.",
           integrator(f, 1, 2));
}
