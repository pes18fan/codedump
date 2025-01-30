#include <stdio.h>

void bubble_sort(int* arr, int len) {
    for (int i = 0; i < len - 1; i++) {
        for (int j = 0; j < len - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int tmp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = tmp;
            }
        }
    }
}

int main() {
    int arr[6] = {6, 5, 4, 3, 2, 1};
    bubble_sort(arr, 6);

    printf("sorted: ");
    for (int i = 0; i < 6; i++) {
        printf("%d\t", arr[i]);
    }
}
