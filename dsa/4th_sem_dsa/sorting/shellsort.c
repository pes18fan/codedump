#include <stdbool.h>
#include <stdio.h>

/* Very similar to insertion sort, but you do it with gaps */
void shellsort(int* arr, int len) {
    if (len <= 1)
        return;

    int gap = len;

    do {
        gap /= 2;

        for (int i = gap; i < len; i++) {
            int key = arr[i];
            int j = i - gap;

            while (j >= 0 && arr[j] > key) {
                arr[j + gap] = arr[j];
                j -= gap;
            }

            arr[j + gap] = key;
        }
    } while (gap > 1);
}

int main() {
    int arr[9] = {8, 9, 1, 7, 6, 2, 3, 5, 4};

    shellsort(arr, 9);

    printf("sorted:\t");
    for (int i = 0; i < 9; i++) {
        printf("%d\t", arr[i]);
    }
}
