#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

Node* head = NULL;

/* Insert at start of list. */
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

/* Insert at push of list. */
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

/* Insert at specified position. */
void insert_at(int pos, int value) {
    Node* new = malloc(sizeof(Node));
    new->data = value;
    new->next = NULL;

    /* Case if the list is empty. */
    if (head == NULL) {
        head = new;
        return;
    }

    /* Case if we need to insert at beginning. */
    if (pos == 1) {
        new->next = head;
        head = new;
        return;
    }

    Node* temp = head;
    Node* ptr = head;
    for (int i = 0; i < pos - 1; i++) {
        if (ptr == NULL) {
            fprintf(stderr, "The position %d doesn't exist on the list.\n",
                    pos);
            return;
        }

        temp = ptr;
        ptr = ptr->next;
    }

    new->next = temp->next;
    temp->next = new;
}

void printList() {
    if (head == NULL) {
        printf("empty list\n");
        return;
    }

    printf("start: ");

    Node* ptr = head;
    while (ptr != NULL) {
        printf("%d\t", ptr->data);
        ptr = ptr->next;
    }

    printf("\n");
}

void cleanup() {
    Node* ptr = head;
    while (ptr != NULL) {
        Node* p = ptr;
        ptr = ptr->next;
        free(p);
        p = NULL;
    }
}

void shift() {
    if (head == NULL) {
        fprintf(stderr, "Can't remove element from an empty list!\n");
        return;
    }

    Node* ptr = head;
    head = head->next;
    free(ptr);
}

void pop() {
    if (head == NULL) {
        fprintf(stderr, "Can't remove element from an empty list!\n");
        return;
    }

    Node* temp = head;
    Node* ptr = head;
    if (head->next == NULL) {
        head = head->next;
        free(ptr);
        return;
    }

    while (ptr->next != NULL) {
        temp = ptr;
        ptr = ptr->next;
    }

    temp->next = NULL;
    free(ptr);
}

void delete_at(int pos) {
    if (head == NULL) {
        fprintf(stderr, "Can't remove element from an empty list!\n");
        return;
    }

    Node* temp = head;
    Node* ptr = head;
    if (pos == 1) {
        head = head->next;
        free(ptr);
        return;
    }

    for (int i = 0; i < pos - 1; i++) {
        if (ptr == NULL) {
            fprintf(stderr, "The position %d doesn't exist on the list.\n",
                    pos);
            return;
        }

        temp = ptr;
        ptr = ptr->next;
    }

    temp->next = ptr->next;
    free(ptr);
}

int main() {
    printList();

    push(10);
    insert_at(1, 952);
    push(12);
    printList();

    unshift(99);
    unshift(58);
    printList();

    insert_at(2, 123);
    printList();

    insert_at(4, 15123);
    printList();

    insert_at(12, 751);
    insert_at(8, 14312);
    printList();

    pop();
    shift();
    printList();

    delete_at(1);
    delete_at(3);
    delete_at(12);
    printList();

    cleanup();
    return 0;
}
