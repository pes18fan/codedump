/* Hashmap / Hash table / Dictionary / Associative array.
 * A collection of key value pairs. The main advantage of a hashmap is
 * that it has O(1) lookup time, which is much faster than a list or
 * tree.
 * This hashmap is implemented using linear probing, which means that
 * collisions are handled by looking for the next empty bucket. This
 * means that the hashmap will never be full, since it will always have
 * at least one empty bucket.
 * Note that this is not the hashmap implementation from ThePrimeagen's
 * algos course, rather its based on the hash table implementation
 * from Crafting Interpreters. */
#include <cstdint>
#include <iostream>
#include <optional>
#include <string>
#include <type_traits>

/* The maximum allowed load factor for the map.
 * The load factor equals the number of entries divided by the capacity.
 * If the load factor is too high, the map will be resized to lower the chance
 * of collisions. */
#define MAX_LOAD 0.6

using std::make_optional, std::nullopt, std::optional, std::string, std::cout;

/* This enumerable is used to determine what type of entry is in the hashmap.
 * An empty entry is one that has never been used, a tombstone is one that
 * has been used but has been deleted, and an occupied entry is one that
 * is currently in use. */
enum EntryType { ENTRY_EMPTY, ENTRY_TOMBSTONE, ENTRY_OCCUPIED };

/* An entry in the hashmap. The key is the string used to find the value, and
 * the value is the value associated with the key. Both of these are optionals,
 * to allow for empty slots within the map. */
template <typename T> struct Entry {
    optional<string> key;
    optional<T> value;
    EntryType type;
};

/* A collection of key value pairs, where the values are of type T, and
 * the keys are strings. */
template <typename T> class HashMap {
  private:
    /* The number of keys in the hashmap. */
    int count;

    /* The number of buckets in the hashmap. */
    int capacity;

    /* An array of entries of the provided type. */
    Entry<T>* entries;

    /* Find an entry in the table. If the entry is not found, the next
     * empty entry is returned. */
    Entry<T>* find_entry(string key) {
        /* Modulo the hash to map it within the entry array's bounds. */
        uint32_t idx = hash(key) % this->capacity;

        for (;;) {
            /* Get a pointer to the entry. */
            auto entry = &entries[idx];

            /* If the key at that array index is nullopt, the bucket is
             * empty. If it does equal the requested key, it already
             * exists.
             * If neither are true, we have a collision at that index. A
             * collision is handled by linearly probing, looking for the
             * next empty or equal bucket, hence the infinite for loop.
             * However, the loop will break no matter what since an
             * empty bucket will always exist, due to resizing being done
             * as soon as the load factor is too high. */
            if (entry->key == make_optional(key) || entry->key == nullopt) {
                return entry;
            }

            idx = (idx + 1) % this->capacity;
        }
    }

    /* Grow the table's capacity. The already existing entries are
     * re-added into the new empty array, to prevent entries from ending
     * up in different buckets. */
    void grow() {
        int new_capac = this->capacity * 2;
        auto entries = new Entry<T>[this->capacity];

        for (int i = 0; i < this->capacity; i++) {
            entries[i].key = nullopt;
            entries[i].value = nullopt;
            entries[i].type = ENTRY_EMPTY;
        }

        this->count = 0;
        for (int i = 0; i < this->capacity; i++) {
            auto entry = &this->entries[i];
            if (entry->type != ENTRY_OCCUPIED)
                continue;

            auto dest = find_entry(entry->key.value());
            dest->key = entry->key;
            dest->value = entry->key;
            dest->type = ENTRY_OCCUPIED;
            this->count++;
        }

        delete[] this->entries;
        this->entries = entries;
        this->capacity = new_capac;
    }

    /* Convert a value to a string. Uses compile-time if statements to
     * determine what the type to convert is. */
    string as_string(T value) {
        if constexpr (std::is_same_v<T, string>) {
            return '"' + value + '"';
        } else if constexpr (std::is_same_v<T, bool>) {
            return value ? "true" : "false";
        } else {
            return std::to_string(value);
        }
    }

    /* Hash a string into a 32-bit unsigned integer. This hash is
     * used as the index. The hash must be consistent, that is, for a
     * certain input it should always provide the same output.
     *
     * This particular hashing algorithm is the FNV-1a hash function. */
    uint32_t hash(string key) {
        uint32_t hash = 2166136261u;

        for (int i = 0; i < key.length(); i++) {
            hash ^= (uint8_t)key[i];
            hash *= 16777619;
        }

        return hash;
    }

  public:
    HashMap() {
        this->count = 0;
        this->capacity = 8;
        this->entries = new Entry<T>[0];
    }

    ~HashMap() { delete[] this->entries; }

    /* Get a value from the map. Returns nullopt if the key is not found. */
    optional<T> get(T key) {
        if (this->count == 0)
            return nullopt;

        auto entry = find_entry(key);
        if (entry->type != ENTRY_OCCUPIED)
            return nullopt;

        return entry->value;
    }

    /* Set a value in the map. If the key already exists, the value will be
     * overwritten. */
    void set(string key, T value) {
        /* Grow the table if the load factor is too high. */
        if (this->count + 1 > this->capacity * MAX_LOAD) {
            grow();
        }

        auto entry = find_entry(key);
        bool is_new_key = entry->type != ENTRY_OCCUPIED;
        if (is_new_key)
            this->count++;

        entry->key = make_optional(key);
        entry->value = make_optional(value);
        entry->type = ENTRY_OCCUPIED;
    }

    /* Remove a key from the map. Returns false if no key was found
     * to delete. */
    bool remove(string key) {
        if (this->count == 0)
            return false;

        // Find the entry.
        auto entry = find_entry(key);
        if (entry->key == nullopt)
            return false;

        // Place a tombstone in the entry.
        entry->key = nullopt;
        entry->value = nullopt;
        entry->type = ENTRY_TOMBSTONE;
        return true;
    }

    /* Return true if the key exists. */
    bool has_key(string key) {
        if (this->count == 0)
            return false;

        auto entry = find_entry(key);
        if (entry->type != ENTRY_OCCUPIED)
            return false;

        return true;
    }

    /* Get the key associated with `value`. Returns nullopt if there is
     * no key associated with `value`. */
    optional<T> get_key_of(T value) {
        for (int i = 0; i < this->capacity; i++) {
            auto entry = &this->entries[i];
            if (entry->type != ENTRY_OCCUPIED)
                continue;

            if (entry->value == make_optional(value)) {
                return entry->key.value();
            }
        }

        return nullopt;
    }

    /* Return a nicely formatted string representation of the hashmap. */
    string stringify() {
        string result = "{";

        for (int i = 0; i < this->capacity; i++) {
            auto entry = &this->entries[i];
            if (entry->key == nullopt)
                continue;

            result += "\n    ";

            result += entry->key.value();
            result += ": ";
            result += as_string(entry->value.value());
            if (i + 1 != this->count)
                result += ",\n";
        }

        result += "}";
        return result;
    }
};

int main() {
    HashMap<string> map;
    map.set("foo", "bar");
    map.set("baz", "bop");

    cout << map.get("foo").value() << "\n"; // "bar"

    map.remove("foo");

    cout << map.get("foo").value_or("ain't no foos out here")
         << "\n"; // "ain't no foos out here"

    cout << map.get_key_of("bop").value() << "\n"; // "baz"

    cout << map.stringify() << "\n";

    return 0;
}
