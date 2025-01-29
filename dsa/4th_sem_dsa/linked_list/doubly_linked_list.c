#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node* next;
    struct Node* prev;
} Node;

Node* head = NULL;

void cleanup() {
    Node* ptr = head;
    while (ptr != NULL) {
        Node* p = ptr;
        ptr = ptr->next;
        free(p);
        p = NULL;
    }
}

/* Insert at the beginning */
void unshift(int value) {
    Node* new = malloc(sizeof(Node));
    new->data = value;
    new->next = NULL;
    new->prev = NULL;

    if (head == NULL) {
        head = new;
        return;
    }

    new->next = head;
    head->prev = new;
    head = new;
}

/* Insert at the end */
void push(int value) {
    Node* new = malloc(sizeof(Node));
    new->data = value;
    new->next = NULL;
    new->prev = NULL;

    if (head == NULL) {
        head = new;
        return;
    }

    Node* ptr = head;
    while (ptr->next != NULL) {
        ptr = ptr->next;
    }

    ptr->next = new;
    new->prev = ptr;
}

/* Insert at specified position */
void insert_at(int pos, int value) {
    if (pos <= 0) {
        fprintf(stderr, "Position can't be less than one.\n");
        return;
    }

    Node* new = malloc(sizeof(Node));
    new->data = value;
    new->next = NULL;
    new->prev = NULL;

    if (head == NULL) {
        head = new;
        return;
    }

    if (pos == 1) {
        new->next = head;
        head->prev = new;
        head = new;
        return;
    }

    Node* ptr = head;
    for (int i = 0; i < pos - 1; i++) {
        ptr = ptr->next;
        if (ptr == NULL) {
            fprintf(stderr, "Position %d is too deep into the list.\n", pos);
            free(new);
            return;
        }
    }

    new->prev = ptr->prev;
    new->next = ptr;
    ptr->prev->next = new;
    ptr->prev = new;
}

/* Delete from beginning */
int shift() {
    if (head == NULL) {
        fprintf(stderr, "Can't shift from an empty list!\n");
        return -1;
    }

    Node* ptr = head;
    int data = ptr->data;
    head = head->next;
    head->prev = NULL;
    free(ptr);
    return data;
}

/* Delete from end */
int pop() {
    if (head == NULL) {
        fprintf(stderr, "Can't pop from an empty list!\n");
        return -1;
    }

    if (head->next == NULL) {
        return shift();
    }

    Node* ptr = head;
    while (ptr->next != NULL) {
        ptr = ptr->next;
    }

    int data = ptr->data;
    ptr->prev->next = NULL;
    free(ptr);
    return data;
}

/* Delete from specified position */
int delete_at(int pos) {
    if (pos < 1) {
        fprintf(stderr, "Position can't be less than one.\n");
        return -1;
    }

    if (head == NULL) {
        fprintf(stderr, "Can't delete from an empty list!\n");
        return -1;
    }

    if (pos == 1) {
        return shift();
    }

    Node* ptr = head;
    for (int i = 0; i < pos - 1; i++) {
        ptr = ptr->next;
        if (ptr == NULL) {
            fprintf(stderr, "Position %d is too far into the list.\n", pos);
            return -1;
        }
    }

    ptr->prev->next = ptr->next;
    if (ptr->next != NULL)
        ptr->next->prev = ptr->prev;
    int data = ptr->data;
    free(ptr);
    return data;
}

void update(int pos, int value) {
    if (pos < 1) {
        fprintf(stderr, "Position can't be less than one.\n");
        return;
    }

    Node* ptr = head;
    for (int i = 0; i < pos - 1; i++) {
        ptr = ptr->next;
        if (ptr == NULL) {
            fprintf(stderr, "Position %d is too far into the list.", i);
            return;
        }
    }

    ptr->data = value;
}

/* Print the list */
void print_list() {
    Node* ptr = head;
    printf("start: ");
    while (ptr != NULL) {
        printf("%d\t", ptr->data);
        ptr = ptr->next;
    }
    printf("\n");
}

int main() {
    push(1);
    unshift(2);
    push(8);
    insert_at(2, 9);
    print_list();

    update(4, 69);
    print_list();

    shift();
    pop();
    print_list();

    delete_at(2);
    print_list();

    cleanup();
}
