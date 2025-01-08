/* Solving differential eqns with the Runge-Kutta method of fourth order */
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
        double k1 = f(x, y);
        double k2 = f(x + (h / 2), y + k1 * (h / 2));
        double k3 = f(x + (h / 2), y + k2 * (h / 2));
        double k4 = f(x + h, y + h * k3);
        double k = (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

        y += k;
        x += h;
        i++;
    }

    printf("Looped %d times.\n", i);
    return y;
}

int main() { printf("Approximation is %lf", approximator(y_deriv)); }
