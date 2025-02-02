#include <stdio.h>

// Make sure that `arr` is sorted
int binary_search(int* arr, int needle, int len) {
    int lo = 0;
    int hi = len - 1;

    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;
        int value = arr[mid];

        if (value == needle) {
            return mid;
        } else if (value > needle) {
            hi = mid - 1;
        } else {
            lo = mid + 1;
        }
    }

    return -1;
}

int main() {
    int arr[9] = {12, 24, 67, 91, 184, 453, 976, 1098};

    printf("Found value 91 at: %d\n", binary_search(arr, 91, 9));
    printf("Found value 69 at: %d", binary_search(arr, 69, 9));
}
