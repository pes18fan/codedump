// an LED is connected to port 1.0, blink it
#include <reg51.h>

sbit LED = P1 ^ 0;

void delay() {
    int i, j;
    for (i = 0; i < 100; i++)
        for (j = 0; j < 1000; j++)
            ;
}

int main() {
    while (1) {
        LED = 1;
        delay();
        LED = 0;
        delay();
    }
}
