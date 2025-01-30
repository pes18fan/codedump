#include <stdio.h>

void insertion_sort(int* arr, int len) {
    for (int i = 1; i < len; i++) {
        int key = arr[i];
        int j = i - 1;

        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }

        arr[j + 1] = key;
    }
}

int main() {
    int arr[6] = {6, 5, 4, 3, 2, 1};
    insertion_sort(arr, 6);

    printf("sorted: ");
    for (int i = 0; i < 6; i++) {
        printf("%d\t", arr[i]);
    }
}
