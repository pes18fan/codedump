#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int* _merge(int* left, int* right, int left_len, int right_len) {
    int* merged = malloc((left_len + right_len) * sizeof(int));

    int i = 0, j = 0, k = 0;
    while (i < left_len && j < right_len) {
        if (left[i] < right[j]) {
            merged[k] = left[i];
            i++;
        } else {
            merged[k] = right[j];
            j++;
        }

        k++;
    }

    while (i < left_len) {
        merged[k] = left[i];
        k++;
        i++;
    }

    while (j < right_len) {
        merged[k] = right[j];
        k++;
        j++;
    }

    return merged;
}

int* _sort(int* arr, int len) {
    if (len <= 1) {
        int* new = malloc(sizeof(int));
        *new = arr[0];
        return new;
    }

    int mid = len / 2;

    int* left = malloc(sizeof(int) * mid);
    for (int i = 0; i < mid; i++) {
        left[i] = arr[i];
    }

    int* right = malloc(sizeof(int) * (len - mid));
    int j = 0;
    for (int i = 0; i < len - mid; i++) {
        right[j] = arr[mid + i];
        j++;
    }

    int* sorted_left = _sort(left, mid);
    int* sorted_right = _sort(right, len - mid);

    free(left);
    free(right);

    int* merged = _merge(sorted_left, sorted_right, mid, len - mid);

    free(sorted_left);
    free(sorted_right);

    return merged;
}

int* merge_sort(int* arr, int len) {
    if (len == 0)
        return arr;

    return _sort(arr, len);
}

int main() {
    int arr[8] = {8, 7, 6, 5, 4, 3, 2, 1};
    int* new = merge_sort(arr, 8);

    printf("sorted: ");
    for (int i = 0; i < 8; i++) {
        printf("%d\t", new[i]);
    }

    free(new);
}
