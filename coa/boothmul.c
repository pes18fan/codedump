#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int32_t binary_to_decimal(const char* s) {
    int len = strlen(s);
    if (len == 0 || len > 32) {
        fprintf(stderr, "Invalid binary input length\n");
        exit(1);
    }
    uint value = 0;
    for (int i = 0; i < len; ++i) {
        if (s[i] != '0' && s[i] != '1') {
            fprintf(stderr, "Invalid character in binary input\n");
            exit(1);
        }
        value = (value << 1) | (s[i] - '0');
    }

    if (len == 32 && (value & (1u << 31))) {
        return (int)value;
    }

    return (int)value;
}

long long booth_multiply(int M, int Q) {
    const int n = sizeof(int) * CHAR_BIT;
    int A = 0;
    int Q_minus1 = 0;

    for (int i = 0; i < n; i++) {
        int Q0 = Q & 1;
        if (Q0 == 1 && Q_minus1 == 0) {
            A -= M;
        } else if (Q0 == 0 && Q_minus1 == 1) {
            A += M;
        }
        Q_minus1 = Q0;

        int signA = A & (1u << (n - 1));
        int newQ = (uint)Q >> 1;
        if (A & 1)
            newQ |= 1u << (n - 1);
        Q = newQ;
        A = (A >> 1) | signA;
    }

    return (((long long)A << n) | (uint)Q);
}

int main() {
    printf("Sadbhav Adhikari | ACE079BCT054\n");

    char bufferM[35], bufferQ[35];
    printf("Enter multiplicand in binary (upto 32 bits): ");
    if (!fgets(bufferM, sizeof(bufferM), stdin))
        return 1;
    bufferM[strcspn(bufferM, "\r\n")] = 0;

    printf("Enter multiplier in binary (upto 32 bits): ");
    if (!fgets(bufferQ, sizeof(bufferQ), stdin))
        return 1;
    bufferQ[strcspn(bufferQ, "\r\n")] = 0;

    int M = binary_to_decimal(bufferM);
    int Q = binary_to_decimal(bufferQ);

    long long result = booth_multiply(M, Q);
    printf("\nBinary product: ");
    for (int i = 63; i >= 0; --i) {
        putchar((result >> i) & 1 ? '1' : '0');
        if (i % 8 == 0 && i != 0)
            putchar(' ');
    }

    printf("\nDecimal product: %lld\n", result);
    return 0;
}
