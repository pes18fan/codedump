/* Solving differential eqns with Euler's method */
#include <stdio.h>

double y_deriv(double x, double y) { return 1 + 3 * x * x; }

double approximator(double (*f)(double, double)) {
    double x, y, h, xp;

    printf("Provide the initial values of x and y: ");
    scanf("%lf %lf", &x, &y);
    printf("Provide the step size h: ");
    scanf("%lf", &h);
    printf("Provide the value of x to calculate y for: ");
    scanf("%lf", &xp);

    int i = 0;
    while (x < xp) {
        y += h * f(x, y);
        x += h;
        i++;
    }

    printf("Looped %d times.\n", i);
    return y;
}

int main() { printf("Approximation is %lf", approximator(y_deriv)); }
