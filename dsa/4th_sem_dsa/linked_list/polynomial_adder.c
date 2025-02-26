#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct Term {
    double coefficient;
    int exponent;
    struct Term* next;
} Term;

Term* phead1 = NULL;
Term* phead2 = NULL;
Term* phead3 = NULL; // sum

void cleanup() {
    Term* ptr;

    // cleanup p1
    ptr = phead1;

    while (ptr != NULL) {
        Term* p = ptr;
        ptr = ptr->next;
        free(p);
        p = NULL;
    }

    // cleanup p2
    ptr = phead2;

    while (ptr != NULL) {
        Term* p = ptr;
        ptr = ptr->next;
        free(p);
        p = NULL;
    }

    // cleanup p3
    ptr = phead3;

    while (ptr != NULL) {
        Term* p = ptr;
        ptr = ptr->next;
        free(p);
        p = NULL;
    }
}

void push(Term** head, double coeff, int expo) {
    Term* new = malloc(sizeof(Term));
    if (!new) {
        fprintf(stderr, "Ran out of memory");
        exit(1);
    }
    new->coefficient = coeff;
    new->exponent = expo;

    if (*head == NULL) {
        *head = new;
        return;
    }

    Term* ptr = *head;
    while (ptr->next != NULL) {
        ptr = ptr->next;
    }

    ptr->next = new;
}

/* For the example, initialize these values:
 * p1 = x^3 + 2x^2 - x  + 9
 * p2 = x^4 + 4x^2 + 9x + 2
 */
void init() {
    // create p1
    push(&phead1, 1, 3);
    push(&phead1, 2, 2);
    push(&phead1, -1, 1);
    push(&phead1, 9, 0);

    // create p2
    push(&phead2, 1, 4);
    push(&phead2, 4, 2);
    push(&phead2, 9, 1);
    push(&phead2, 2, 0);
}

void add_polynomials() {
    // both polynomials are NULL
    if (phead1 == NULL && phead2 == NULL) {
        fprintf(stderr, "Both polynomials are NULL!");
        return;
    }

    // one of the polynomials is NULL
    if (phead1 == NULL || phead2 == NULL) {
        Term* ptr = !phead1 ? phead2 : phead1;
        Term* sum = phead3;

        while (ptr != NULL) {
            double coeff = ptr->coefficient;
            int expo = ptr->exponent;
            push(&phead3, coeff, expo);

            ptr = ptr->next;
        }

        return;
    }

    // neither polynomial is NULL
    Term* p1 = phead1;
    Term* p2 = phead2;

    // because phead3 is empty to begin with, we initialize it to a sentinel
    // value
    push(&phead3, -1, -1);
    Term* p3 = phead3;

    while (true) {
        if (p1->exponent > p2->exponent) {
            p3->coefficient = p1->coefficient;
            p3->exponent = p1->exponent;
            p1 = p1->next;
        } else if (p2->exponent > p1->exponent) {
            p3->coefficient = p2->coefficient;
            p3->exponent = p2->exponent;
            p2 = p2->next;
        } else {
            p3->exponent = p2->exponent; // this can be p1->exponent
                                         // too, since they're the same
            p3->coefficient = p1->coefficient + p2->coefficient;
            p1 = p1->next;
            p2 = p2->next;
        }

        if (p1 == NULL && p2 == NULL) {
            break;
        } else {
            if (!p3->next) {
                push(&phead3, -1, -1);
            }
            p3 = p3->next;
        }
    }
}

void print_polynomial(Term* head) {
    Term* ptr = head;

    while (ptr != NULL) {
        if (ptr->coefficient >= 0) {
            printf("+ ");
        } else {
            printf("- ");
        }

        printf("%.2f",
               ptr->coefficient >= 0 ? ptr->coefficient : -ptr->coefficient);

        if (ptr->exponent == 0) {
            // don't print x
        } else if (ptr->exponent == 1) {
            printf("x");
        } else {
            printf("x^%d", ptr->exponent);
        }

        printf(" ");
        ptr = ptr->next;
    }
}

int main() {
    init();
    add_polynomials();
    print_polynomial(phead3);
    cleanup();
}
