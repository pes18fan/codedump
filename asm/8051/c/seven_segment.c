// display zero to nine in a seven segment display
// display is interfaced at port 1
#include <reg51.h>

void delay() {
    for (int i = 0; i < 100; i++)
        for (int j = 0; j < 1000; j++)
            ;
}

int main() {
    // input codes to show digits from 0 to 9 in a standard 7-segment display
    unsigned char code digits = {0x3f, 0x06, 0x5b, 0x4f, 0x66,
                                 0x6d, 0x7d, 0x07, 0x7f, 0x6f};
    int count = 10;

    for (int i = 0; i < count; i++) {
        P1 = digits[i];
        delay();
    }
}
