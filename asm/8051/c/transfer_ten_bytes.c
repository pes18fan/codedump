// transfer 10 bytes starting at 45h, to 70h
#include <reg51.h>

int main() {
    unsigned char data initial = 0x45;
    unsigned char data final = 0x70;
    int count = 10;

    for (int i = 0; i < count; i++) {
        *final = *initial;
        initial++;
        final++;
    }
}
