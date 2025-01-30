#include <stdio.h>

void selection_sort(int* arr, int len) {
    for (int i = 0; i < len; i++) {
        int min_idx = i;
        for (int j = i; j < len; j++) {
            if (arr[j] < arr[min_idx])
                min_idx = j;
        }

        int tmp = arr[i];
        arr[i] = arr[min_idx];
        arr[min_idx] = tmp;
    }
}

int main() {
    int arr[6] = {6, 5, 4, 3, 2, 1};
    selection_sort(arr, 6);

    printf("sorted: ");
    for (int i = 0; i < 6; i++) {
        printf("%d\t", arr[i]);
    }
}
