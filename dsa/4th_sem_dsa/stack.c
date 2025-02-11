#include <stdbool.h>
#include <stdio.h>

#define MAX 100

typedef struct {
    int arr[MAX]; // Array holding stack elements
    int top;      // Array index of the top of the stack
} Stack;

void initStack(Stack* s) { s->top = -1; }

bool isEmpty(Stack* s) {
    if (s->top < 0)
        return true;
    else
        return false;
}

bool isFull(Stack* s) {
    if (s->top >= MAX - 1)
        return true;
    else
        return false;
}

void push(Stack* s, int val) {
    if (isFull(s)) {
        fprintf(stderr, "Too many stack elements!\n");
        return;
    }

    s->top++;
    s->arr[s->top] = val;
}

int pop(Stack* s) {
    if (isEmpty(s)) {
        fprintf(stderr, "Can't pop an empty stack!\n");
        return -1;
    }

    s->top--;
    return s->arr[s->top + 1];
}

int peek(Stack* s) {
    if (isEmpty(s)) {
        fprintf(stderr, "Can't peek into an empty stack!\n");
        return -1;
    }

    return s->arr[s->top];
}

void printStack(Stack* s) {
    if (isEmpty(s)) {
        printf("empty\n");
        return;
    }

    printf("top: ");
    for (int i = 0; i < s->top + 1; i++) {
        printf("%d  ", s->arr[i]);
    }

    printf("\n");
}

int main() {
    Stack s;
    initStack(&s);

    push(&s, 12);
    push(&s, 68);
    push(&s, 419);

    printStack(&s);

    pop(&s);
    pop(&s);
    push(&s, 79);

    printStack(&s);

    return 0;
}
