/* Solving differential eqns with the Runge-Kutta method of second order */
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
        double k1 = h * f(x, y);
        double k2 = h * f(x + h, y + k1);
        double k = 0.5 * (k1 + k2);

        y += k;
        x += h;
        i++;
    }

    printf("Looped %d times.\n", i);
    return y;
}

int main() { printf("Approximation is %lf", approximator(y_deriv)); }
