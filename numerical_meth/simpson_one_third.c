#include <stdio.h>
#include <stdlib.h>

double f(double x) { return 1 + x * x * x; }

double integrator(double (*f)(double), double a, double b) {
    /* When n = 1, the result is simple Simpson's
     * For anything higher, it's compound Simpson's */
    int n;

    double h;

    printf("Enter the number of iterations: ");
    scanf("%d", &n);

    if (n % 2 != 0) {
        printf("n must be even!");
        exit(1);
    }

    h = (b - a) / n;

    double oddoffset = 0;
    for (int i = 1; i < n; i += 2) {
        oddoffset += f(a + h * i);
    }
    oddoffset *= 4;

    double evenoffset = 0;
    for (int i = 2; i < n; i += 2) {
        evenoffset += f(a + h * i);
    }
    evenoffset *= 2;

    double integral = (h / 3) * (f(a) + f(b) + oddoffset + evenoffset);

    return integral;
}

int main() {
    printf("The integral approximation for 1 + x^3 from 1 to 2 is %lf.",
           integrator(f, 1, 2));
}
