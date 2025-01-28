/* Quicksort.
 * A type of simple divide and conquer sorting algorithm. Divide and 
 * conquer is based on splitting the input into a bunch of chunks and 
 * doing that again and again until you get to a chunk with only 1 
 * element or no element, which is considered sorted.
 *
 * Pick some element in the array, call it the p for pivot. We then
 * start walking the array with two loop variables i and j, where j
 * is the one that actually walks the entire array. Every time j is
 * an element lower than p, we move it to the index of i, then increment
 * i. So, we put all the elements smaller or equal to p on one side, and
 * the rest on the other side, with p in the middle.
 * After that, we pick a pivot on both sides and start doing the same
 * operation there, essentially dividing the problem in two. We keep 
 * doing this until we reach an array which has one or no element, as
 * such arrays are already sorted.
 *
 * Let's say we have an array of size 32, i.e. index 0 to 31. Consider
 * the middle element to be the pivot, i.e. index 16. Do it again, we
 * now have array 0-15 and 17-31 (inclusive on both). We're not including
 * 16 since that's a singular element that's already sorted. Then, split those
 * in two, picking a pivot in the middle. We now have 0-7, 9-15, 17-23, 
 * 25-31. Keep doing this until you get to a point where all of your split 
 * arrays have only one element. Since that's the base case, due to a singular
 * element being already "sorted", all the recursive functions start returning,
 * and the whole array is sorted.
 *
 * The time complexity of quicksort is 0(n log n).
 * In the worst case: O(n^2). In this program's case, the last element of each
 * array is taken as the pivot, thus making the worst case a reverse sorted 
 * array. Generally, a random pivot is chosen, which makes the chances of a
 * worst case scenario very low. I didn't do that here since I'm too stoopid
 * and have no idea how to recreate Math.random() in C++.
 */
#include <iostream>
#include <chrono> // for benchmarking
#include <vector>

using namespace std::chrono;
using
    std::ios_base,
    std::cout,
    std::vector;

static int partition(vector<int>* arr, int lo, int hi) {
    int pivot = arr->at(hi);
    int idx = lo - 1;

    for (int i = lo; i < hi; i++) {
        if (arr->at(i) <= pivot) {
            idx++;
            int tmp = arr->at(i);
            arr->at(i) = arr->at(idx);
            arr->at(idx) = tmp;
        }
    }

    idx++;
    arr->at(hi) = arr->at(idx);
    arr->at(idx) = pivot;

    return idx;
}

static void sort(vector<int>* arr, int lo, int hi) {
    if (lo >= hi) return;

    int pivot_idx = partition(arr, lo, hi);

    sort(arr, lo, pivot_idx - 1);
    sort(arr, pivot_idx + 1, hi);
}

void quick_sort(vector<int>* arr) {
    sort(arr, 0, arr->size() - 1);
}

int main() {
    vector<int> large_reverse_sorted_array =
        { 100, 99, 98, 97, 96, 95, 94, 93, 92, 91,
          90, 89, 88, 87, 86, 85, 84, 83, 82, 81,
          80, 79, 78, 77, 76, 75, 74, 73, 72, 71,
          70, 69, 68, 67, 66, 65, 64, 63, 62, 61,
          60, 59, 58, 57, 56, 55, 54, 53, 52, 51,
          50, 49, 48, 47, 46, 45, 44, 43, 42, 41,
          40, 39, 38, 37, 36, 35, 34, 33, 32, 31,
          30, 29, 28, 27, 26, 25, 24, 23, 22, 21,
          20, 19, 18, 17, 16, 15, 14, 13, 12, 11,
          10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };

    // benchmark stuff, ignore
    auto start = high_resolution_clock::now();
    ios_base::sync_with_stdio(false);

    quick_sort(&large_reverse_sorted_array);

    // more benchmark stuff, ignore
    auto end = high_resolution_clock::now();
    double time_taken =
        duration_cast<nanoseconds>(end - start).count();
    time_taken *= 1e-9;

    cout << "[";
    for (auto i: large_reverse_sorted_array) {
        cout << i << ", ";
    }
    cout << "]\n";
    std::printf("Took %.9lf seconds.\n", time_taken);

    return 0;
}
