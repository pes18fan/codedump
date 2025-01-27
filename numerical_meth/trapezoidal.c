#include <stdio.h>

double f(double x) { return 1 + x * x * x; }

double integrator(double (*f)(double), double a, double b) {
    double h;

    /* When n = 1, the result is simple trapezoidal
     * For anything higher, it's compound trapezoidal */
    int n = 1;

    printf("Enter the number of iterations: ");
    scanf("%d", &n);

    h = (b - a) / n;
    double integral = f(a) + f(b);
    double offset = 0;
    for (int i = 1; i <= n - 1; i++) {
        offset += f(a + i * h);
    }
    offset *= 2;
    integral += offset;
    integral *= h / 2;

    return integral;
}

int main() {
    printf("The integral approximation of 1 + x^3 from 1 to 2 is %lf.",
           integrator(f, 1, 2));
}
