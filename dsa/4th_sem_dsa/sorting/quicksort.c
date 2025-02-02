#include <stdio.h>

int _partition(int* arr, int lo, int hi) {
    int pivot = arr[hi];
    int idx = lo - 1;

    for (int i = lo; i < hi; i++) {
        if (arr[i] < pivot) {
            idx++;
            int tmp = arr[i];
            arr[i] = arr[idx];
            arr[idx] = tmp;
        }
    }

    idx++;
    arr[hi] = arr[idx];
    arr[idx] = pivot;

    return idx;
}

void _sort(int* arr, int lo, int hi) {
    if (lo >= hi) {
        return;
    }

    int pivotIdx = _partition(arr, lo, hi);

    _sort(arr, lo, pivotIdx - 1);
    _sort(arr, pivotIdx + 1, hi);
}

void quick_sort(int* arr, int len) { _sort(arr, 0, len - 1); }

int main() {
    int arr[6] = {679, 854, 941, 329, 291, 1011};
    quick_sort(arr, 6);

    printf("sorted: ");
    for (int i = 0; i < 6; i++) {
        printf("%d\t", arr[i]);
    }
}
