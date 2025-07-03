#include <stdio.h>

int binary_addition(int a, int b) {
    int carry = 0, result = 0, bit = 1;
    while (a != 0 || b != 0) {
        int bit_a = a % 10;
        int bit_b = b % 10;

        int sum = bit_a + bit_b + carry;

        result += (sum % 2) * bit;

        carry = sum / 2;

        a /= 10;
        b /= 10;
        bit *= 10;
    }

    result += carry * bit;
    return result;
}

int logical_shift_left(int num) { return num * 10; }

int logical_shift_right(int num) { return num / 10; }

int booth_multiply(int multiplicand, int multiplier) {
    int accumulator = 0;
    int bitMask = 1;

    while (multiplier != 0) {
        if (multiplier % 10 == 1) {
            accumulator = binary_addition(accumulator, multiplicand);
        }

        multiplicand = logical_shift_left(multiplicand);
        multiplier = logical_shift_right(multiplier);

        bitMask *= 10;
    }

    return accumulator;
}

int binary_to_decimal(int binary) {
    int decimal = 0, base = 1;
    while (binary != 0) {
        int lastDigit = binary % 10;
        decimal += lastDigit * base;
        binary /= 10;
        base *= 2;
    }
    return decimal;
}

int main() {
    int multiplicand, multiplier;
    printf("Enter the multiplicand (binary): ");
    scanf("%d", &multiplicand);
    printf("Enter the multiplier (binary): ");
    scanf("%d", &multiplier);

    int product = booth_multiply(multiplicand, multiplier);

    printf("Product of the two binary numbers: %d (binary)\n", product);
    printf("Product in decimal: %d\n", binary_to_decimal(product));

    return 0;
}
