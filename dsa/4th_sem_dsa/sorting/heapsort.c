#include <stdio.h>

int _parent(int i) { return (i - 1) / 2; }
int _left_child(int i) { return 2 * i + 1; }
int _right_child(int i) { return 2 * i + 2; }

void _heapify_down(int* arr, int i, int len) {
    int lIdx = _left_child(i);
    int rIdx = _right_child(i);

    if (i >= len || lIdx >= len)
        return;

    int lV = arr[lIdx];
    int rV = (rIdx < len) ? arr[rIdx] : -1;
    int v = arr[i];

    if (rIdx < len && lV < rV && v < rV) {
        arr[i] = rV;
        arr[rIdx] = v;
        _heapify_down(arr, rIdx, len);
    } else if (rV < lV && v < lV) {
        arr[i] = lV;
        arr[lIdx] = v;
        _heapify_down(arr, lIdx, len);
    }
}

void heapsort(int* arr, int len) {
    // Turn the array into a max heap
    // Start from the last non-leaf node then heapify down from there
    for (int i = len / 2 - 1; i >= 0; i--) {
        _heapify_down(arr, i, len);
    }

    int l = len;
    for (int i = 0; i < len; i++) {
        int tmp = arr[l - 1];
        arr[l - 1] = arr[0];
        arr[0] = tmp;
        l--;

        _heapify_down(arr, 0, l);
    }
}

int main() {
    int arr[9] = {8, 9, 1, 7, 6, 2, 3, 5, 4};

    heapsort(arr, 9);

    printf("sorted:\t");
    for (int i = 0; i < 9; i++) {
        printf("%d\t", arr[i]);
    }
}
