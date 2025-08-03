#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned int parse_binary(const char* s) {
    unsigned int value = 0;
    for (size_t i = 0; i < strlen(s); ++i) {
        if (s[i] != '0' && s[i] != '1') {
            fprintf(stderr, "Invalid binary digit: %c\n", s[i]);
            exit(1);
        }
        value = (value << 1) | (s[i] - '0');
    }
    return value;
}

void restoring_division(unsigned int dividend, unsigned int divisor,
                        unsigned int* quotient, unsigned int* remainder) {
    if (divisor == 0) {
        fprintf(stderr, "Can't divide by zero\n");
        exit(1);
    }

    int n = sizeof(unsigned int) * CHAR_BIT; // total bits in register
    unsigned int A = 0;                      // Accumulator, initially 0
    unsigned int Q = dividend;
    unsigned int M = divisor;
    unsigned int q = 0;

    for (int i = n - 1; i >= 0; i--) {
        A = (A << 1) | ((Q >> i) & 1); // left shift the combined AQ register
        int temp = (int)A - (int)M;

        if (temp < 0) {
            q <<= 1;
        } else {
            A = (unsigned int)temp;
            q = (q << 1) | 1;
        }
    }
    *quotient = q;
    *remainder = A;
}

int main() {
    char bin_dividend[65], bin_divisor[65];
    printf("Enter dividend in binary: ");
    if (scanf("%64s", bin_dividend) != 1) {
        fprintf(stderr, "Invalid input.\n");
        return 1;
    }
    printf("Enter divisor in binary: ");
    if (scanf("%64s", bin_divisor) != 1) {
        fprintf(stderr, "Invalid input.\n");
        return 1;
    }

    unsigned int dividend = parse_binary(bin_dividend);
    unsigned int divisor = parse_binary(bin_divisor);

    unsigned int quo, rem;
    restoring_division(dividend, divisor, &quo, &rem);

    // Print results in binary
    char out_q[65] = {0}, out_r[65] = {0};
    for (int i = sizeof(unsigned int) * CHAR_BIT - 1; i >= 0; i--) {
        out_q[sizeof(unsigned int) * CHAR_BIT - 1 - i] = ((quo >> i) & 1) + '0';
        out_r[sizeof(unsigned int) * CHAR_BIT - 1 - i] = ((rem >> i) & 1) + '0';
    }
    char* q_str = strchr(out_q, '1');
    char* r_str = strchr(out_r, '1');
    printf("Quotient: %s\n", q_str ? q_str : "0");
    printf("Remainder: %s\n", r_str ? r_str : "0");
    return 0;
}
