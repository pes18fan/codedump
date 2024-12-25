/* Basic implementation of a singly linked list.
 * Function names for inserting and removing values are based on equivalent
 * function names from JavaScript. */
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

Node* head = NULL;

/* Add at the start of the list. */
void unshift(int value) {
    Node* new = malloc(sizeof(Node));
    new->data = value;
    new->next = NULL;

    if (head == NULL) {
        head = new;
        return;
    }

    new->next = head;
    head = new;
}

/* Add at the end of the list. */
void push(int value) {
    Node* new = malloc(sizeof(Node));
    new->data = value;
    new->next = NULL;

    if (head == NULL) {
        head = new;
        return;
    }

    Node* ptr = head;
    while (ptr->next != NULL) {
        ptr = ptr->next;
    }

    ptr->next = new;
}

/* Add at a specific position in the list. */
void insert_at(int pos, int value) {
    Node* new = malloc(sizeof(Node));
    new->data = value;
    new->next = NULL;

    if (head == NULL) {
        head = new;
        return;
    }

    Node* ptr = head;
    for (int i = 0; i < pos - 1; i++) {
        ptr = ptr->next;
        if (ptr == NULL) {
            fprintf(stderr, "There exists no position %d in the list.\n", pos);
            return;
        }
    }

    new->next = ptr->next;
    ptr->next = new;
}

/* Delete at the start of the list. */
void shift() {
    if (head == NULL) {
        fprintf(stderr, "Cannot delete from list as it's empty!\n");
        return;
    }

    Node* ptr = head;
    head = head->next;
    free(ptr);
}

/* Delete at the end of the list. */
void pop() {
    if (head == NULL) {
        fprintf(stderr, "Cannot delete from list as it's empty!\n");
        return;
    }

    Node* ptr = head;
    Node* prev = ptr;
    while (ptr->next != NULL) {
        prev = ptr;
        ptr = ptr->next;
    }

    prev->next = NULL;
    free(ptr);
}

/* Delete a specific position in the list. */
void delete_at(int pos) {
    if (head == NULL) {
        fprintf(stderr, "Cannot delete from list as it's empty!\n");
        return;
    }

    Node* ptr = head;
    Node* prev = ptr;
    for (int i = 0; i < pos; i++) {
        prev = ptr;
        ptr = ptr->next;

        if (ptr == NULL) {
            fprintf(stderr, "There exists no position %d in the list.", pos);
            return;
        }
    }

    prev->next = ptr->next;
    free(ptr);
}

/* Print out the linked list. */
void print_list() {
    Node* ptr = head;

    printf("first: ");

    for (;;) {
        printf("%d\t", ptr->data);
        ptr = ptr->next;

        if (ptr == NULL)
            break;
    }

    printf("\n");
}

int main() {
    push(10);
    push(29);
    unshift(91);

    print_list();

    insert_at(2, 69);
    unshift(164);

    print_list();

    pop();
    shift();
    delete_at(1);

    print_list();
}
