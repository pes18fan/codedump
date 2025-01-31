#include <stdio.h>

int _nth_digit(int num, int n) {
    while (--n > 0) {
        num /= 10;
    }
    return num % 10;
}

void radix_sort(int* arr, int len) {
    int buckets[10][len];
    int bucket_tops[10];

    for (int i = 0; i < 10; i++) {
        bucket_tops[i] = -1;
    }

    int radix = 1;
    int largest_radix = 1;
    int radix_measurer = 10;

    for (int i = 0; i < len; i++) {
        if (arr[i] >= radix_measurer) {
            largest_radix += 1;
            radix_measurer *= 10;
        }
    }

    do {
        for (int i = 0; i < 10; i++) {
            bucket_tops[i] = -1;
        }

        for (int i = 0; i < len; i++) {
            int digit = _nth_digit(arr[i], radix);
            bucket_tops[digit]++;
            buckets[digit][bucket_tops[digit]] = arr[i];
        }

        int k = 0;
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < bucket_tops[i] + 1; j++) {
                arr[k] = buckets[i][j];
                k++;
            }
        }

        radix += 1;
    } while (radix <= largest_radix);
}

int main() {
    int arr[6] = {679, 854, 941, 329, 291, 1011};
    radix_sort(arr, 6);

    printf("sorted: ");
    for (int i = 0; i < 6; i++) {
        printf("%d\t", arr[i]);
    }
}
