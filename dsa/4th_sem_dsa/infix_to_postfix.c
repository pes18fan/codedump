#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef enum { LR, RL } Associativity;

// Higher number, higher precedence
// 3: () {} [], 2: ^, 1: / *, 0: + -
typedef enum {
    TERM,     // + -
    FACTOR,   // / *
    EXPONENT, // ^
    BRACKETS  // (  )
} Precedence;

Precedence precedence_of(char c) {
    switch (c) {
    case '(':
    case ')':
        return BRACKETS;
    case '^':
        return EXPONENT;
    case '/':
    case '*':
        return FACTOR;
    case '+':
    case '-':
        return TERM;
    default:
        return -1;
    }
}

Associativity associativity_of(char c) {
    switch (c) {
    case '^':
        return RL;
    case '/':
    case '*':
    case '+':
    case '-':
        return LR;
    default:
        return -1;
    }
}

typedef struct {
    char* arr;
    int capacity;
    int top;
} Stack;

void init_stack(Stack* s) {
    s->capacity = 100;
    s->arr = malloc(s->capacity);
    s->top = -1;
}

void destroy_stack(Stack* s) {
    free(s->arr);
    s->arr = NULL;
}

void push(Stack* s, char value) {
    if (s->top >= s->capacity - 1) {
        s->capacity *= 2;
        char* temp = realloc(s->arr, s->capacity);
        if (!temp) {
            fprintf(stderr, "Failed to allocate memory\n");
            free(s->arr);
            exit(EXIT_FAILURE);
        }
        s->arr = temp;
    }

    s->top++;
    s->arr[s->top] = value;
}

bool is_empty(Stack* s) { return s->top < 0; }

char pop(Stack* s) {
    if (is_empty(s)) {
        printf("Stack is empty!\n");
        exit(EXIT_FAILURE);
    }

    char popped = s->arr[s->top];
    s->top--;
    return popped;
}

char peek(Stack* s) {
    if (is_empty(s)) {
        printf("Stack is empty!\n");
        exit(EXIT_FAILURE);
    }

    return s->arr[s->top];
}

bool is_digit(char c) { return c >= 48 && c <= 57; }

void print_postfix(char* infix) {
    Stack stack;
    init_stack(&stack);

    for (int i = 0; infix[i] != '\0'; i++) {
        char c = infix[i];

        if (is_digit(c)) {
            printf("%c ", c);
            continue;
        }

        switch (c) {
        case '^':
        case '/':
        case '*':
        case '+':
        case '-': {
            if (is_empty(&stack) || peek(&stack) == '(') {
                push(&stack, c);
                continue;
            }

            if (precedence_of(c) > precedence_of(peek(&stack))) {
                push(&stack, c);
            } else if (precedence_of(c) < precedence_of(peek(&stack))) {
                printf("%c ", pop(&stack));
                push(&stack, c);
            } else {
                if (associativity_of(c) == LR) {
                    printf("%c ", pop(&stack));
                    push(&stack, c);
                } else {
                    push(&stack, c);
                }
            }

            break;
        }
        case '(':
            push(&stack, c);
            break;
        case ')': {
            if (is_empty(&stack)) {
                fprintf(stderr, "Invalid infix input\n");
                goto end;
            }

            char popped;
            while (true) {
                popped = pop(&stack);
                if (popped == '(') {
                    break;
                }

                printf("%c ", popped);
            }
        }
        case ' ':
        case '\n':
            continue;
        default:
            fprintf(stderr, "\nInvalid character %c\n", c);
            goto end;
        }
    }

    while (!is_empty(&stack)) {
        printf("%c ", pop(&stack));
    }

end:
    destroy_stack(&stack);
    return;
}

int main() {
    char buffer[512];

    printf("Enter an infix expression: ");
    fgets(buffer, sizeof(buffer), stdin);

    print_postfix(buffer);
}
