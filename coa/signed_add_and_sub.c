#include <math.h>
#include <stdio.h>
#include <stdlib.h>

void dec_to_binary(int nbit, int num, int arry[]) {
    for (int i = nbit - 1; i >= 0; i--) {
        arry[i] = num % 2;
        num = num / 2;
    }
}

void two_complement(int arry[], int nbit) {
    int bitsum, i, carry = 1;
    for (i = 0; i < nbit; i++) {
        arry[i] = !arry[i];
    }
    for (i = nbit - 1; i >= 0; i--) {
        bitsum = arry[i] + carry;
        arry[i] = bitsum % 2;
        carry = bitsum / 2;
    }
}

void show_binary(int* p, int size) {
    int i;
    for (i = 0; i < size; i++) {
        printf("%d ", *(p + i));
    }
    printf("\n");
}

int add_binary(int arry1[], int arry2[], int nbit, int sum[]) {
    int i, bitsum, carry = 0;
    for (i = nbit - 1; i >= 0; i--) {
        bitsum = arry1[i] + arry2[i] + carry;
        sum[i] = bitsum % 2;
        carry = bitsum / 2;
    }
    return carry;
}

void binary_to_dec(int arry[], int nbit) {
    int add = 0, i;
    if (arry[0] == 1) {
        add = add - arry[0] * pow(2, nbit - 1);
    } else {
        add = add + arry[0] * pow(2, nbit - 1);
    }
    for (i = 1; i <= nbit - 1; i++) {
        add = add + arry[i] * pow(2, (nbit - 1) - i);
    }
    printf("The decimal equivalent is %d", add);
}

int main() {
    int num1, num2, arry1[10], arry2[10], sum[10], nbit;
    printf("Enter number of bits: ");
    scanf("%d", &nbit);
    printf("Enter the two number: ");
    scanf("%d%d", &num1, &num2);

    if (num1 < 0) {
        dec_to_binary(nbit, abs(num1), arry1);
        two_complement(arry1, nbit);
        show_binary(arry1, nbit);
    } else {
        dec_to_binary(nbit, num1, arry1);
        show_binary(arry1, nbit);
    }

    if (num2 < 0) {
        dec_to_binary(nbit, abs(num2), arry2);
        two_complement(arry2, nbit);
        show_binary(arry2, nbit);
    } else {
        dec_to_binary(nbit, num2, arry2);
        show_binary(arry2, nbit);
    }

    printf("The sum of binary is: \n");
    add_binary(arry1, arry2, nbit, sum);
    show_binary(sum, nbit);
    binary_to_dec(sum, nbit);
    if ((arry1[0] == arry2[0]) && (arry1[0] != sum[0])) {
        printf("\nOverflow detected.");
    }

    return 0;
}
