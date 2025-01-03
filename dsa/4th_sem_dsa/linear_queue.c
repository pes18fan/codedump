#include <stdbool.h>
#include <stdio.h>

#define MAX 100

/* An array-based queue. */
typedef struct {
    int front;
    int rear;
    int arr[MAX];
} Queue;

void initQueue(Queue* q) {
    q->front = 0;
    q->rear = -1;
}

bool isEmpty(Queue* q) { return q->front > q->rear; }

bool isFull(Queue* q) { return q->rear == MAX - 1; }

/* One disadvantage of a fixed array-based linear queue is that the queue will
 * waste space. This happens when you deque something, incrementing the `front`
 * index and leaving behind unused space at the front of the array. The more
 * elements you deque, the worse this problem gets. It can even cause the queue
 * to be pseudo-filled, since the only condition for the queue to be full is
 * `rear` equalling MAX - 1 and this does not take into account the number of
 * elements that have been dequed so far. Hence, theoretically you could enqueue
 * 100 elements, deque 99 of them and the queue would still call itself full
 * despite 99 spaces being present, just because the `rear` pointer is MAX - 1.
 *
 * The fix to this is to shift everything in the queue back to the beginning of
 * the array again once the `rear` pointer reaches MAX - 1 and the `front`
 * pointer is over 0 which indicates elements were dequed. */
void shiftLeft(Queue* q) {
    int j = 0;

    // Shift all the queue values back.
    for (int i = q->front; i < q->rear + 1; i++, j++) {
        q->arr[j] = q->arr[i];
        q->arr[i] = 0;
    }

    q->front = 0;
    q->rear = -1;
}

void printQueue(Queue* q) {
    if (isEmpty(q)) {
        printf("Queue is empty!\n");
        return;
    }

    printf("front: ");
    for (int i = q->front; i < q->rear + 1; i++) {
        printf("%d\t", q->arr[i]);
    }
    printf("\n");
}

void enqueue(Queue* q, int v) {
    if (isFull(q) && q->front > 0) {
        shiftLeft(q);
    }

    if (isFull(q)) {
        printf("Queue is full!\n");
        return;
    }

    q->rear++;
    q->arr[q->rear] = v;
}

int deque(Queue* q) {
    if (isEmpty(q)) {
        printf("Can't deque an empty queue!\n");
        return -1;
    }

    int v = q->arr[q->front];
    q->front++;
    return v;
}

int peek(Queue* q) {
    if (isEmpty(q)) {
        printf("Can't peek into an empty queue!\n");
        return -1;
    }

    return q->arr[q->front];
}

int main() {
    Queue q;
    initQueue(&q);

    enqueue(&q, 12);
    enqueue(&q, 68);
    enqueue(&q, 419);

    printQueue(&q);

    deque(&q);
    deque(&q);
    enqueue(&q, 79);

    printQueue(&q);

    return 0;
}
