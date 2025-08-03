#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* ull_to_binary(unsigned long long num, int bits) {
    char* binary = (char*)malloc(bits + 1);
    binary[bits] = '\0';
    for (int i = bits - 1; i >= 0; i--) {
        binary[i] = (num & 1) + '0';
        num >>= 1;
    }
    return binary;
}

int main() {
    char dividend_str[65], divisor_str[65];

    printf("Enter the binary dividend (up to 64 bits): ");
    scanf("%s", dividend_str);
    printf("Enter the binary divisor (up to 64 bits): ");
    scanf("%s", divisor_str);

    int n = strlen(dividend_str);
    int m = strlen(divisor_str);

    unsigned long long Q = strtoll(dividend_str, NULL, 2); // Dividend
    unsigned long long M = strtoll(divisor_str, NULL, 2);  // Divisor
    unsigned long long A = 0;                              // Accumulator

    if (M == 0) {
        printf("Can't divide by zero\n");
        return 1;
    }

    int restore = 0;

    for (int i = 0; i < n; i++) {
        A = (A << 1) | ((Q >> (n - 1)) & 1);
        Q <<= 1;

        if (restore) {
            A += M;
            restore = 0;
        } else {
            unsigned long long temp = A - M;
            if (A >= M) {
                A = temp;
                Q |= 1;
            } else {
                restore = 1;
            }
        }
    }

    if (restore) {
        A += M;
    }

    char* quotient_binary = ull_to_binary(Q, n);
    char* remainder_binary = ull_to_binary(A, m);

    printf("Quotient: %s\n", quotient_binary);
    printf("Remainder: %s\n", remainder_binary);

    free(quotient_binary);
    free(remainder_binary);

    return 0;
}
