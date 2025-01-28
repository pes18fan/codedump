/* Bubble sort starts at the first position and ends at the last.
 * If the element after any item in the array is larger than that
 * item, then the two are swapped. This keeps going for the entire
 * length of the array. */
#include <iostream>
#include <vector>

using std::cout, std::vector;

/* Return a sorted vector<int>. */
vector<int> bubble_sort(vector<int> vek) {
    // main loop over the entire vector
    for (int i = 0; i < vek.size(); i++) {
        // loop that does most of the grunt work, looping
        // over each element checking if its sorted
        for (int j = 0; j < vek.size() - 1 - i; j++) {
            // if the previous element is higher than the
            // next one, swap them
            if (vek[j] > vek[j + 1]) {
                int tmp = vek[j];
                vek[j] = vek[j + 1];
                vek[j + 1] = tmp;
            }
        }
    }

    return vek;
}

int main() {
    vector<int> vek = {1, 6, 9, -1, 69, 4};

    vek = bubble_sort(vek);

    cout << "["
         << "\n";

    for (auto item : vek) {
        cout << "\t" << item << "\n";
    }

    cout << "]"
         << "\n";
}
