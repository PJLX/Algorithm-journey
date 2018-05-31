//
//  queue.m
//  算法
//
//  Created by 李响 on 2018/5/5.
//  Copyright © 2018年 LiXiang. All rights reserved.
//

#import "queue.h"

@interface queue ()

@end

@implementation queue

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - 队列：数组实现,循环

#define Size 20
typedef struct Queue{
    int arr[Size];
    int front;
    int rear;
}Queue;

void Init(Queue* q){
    q->front = 0;
    q->rear = 0;
}

bool isFullQueue(Queue *q){
    return q->front == (q->rear + 1) % Size;
}

void EnQueue(int val, Queue *q){
    if (isFullQueue(q)) {
        return;
    }
    
    q->arr[q->rear] = val;
    q->rear = (q->rear + 1) % Size;
}

bool isEmptyQueue(Queue *q){
    return q->front == q->rear;
}

void DeQueue(Queue *q){
    if (isEmptyQueue(q)) {
        return;
    }
    
    q->front = (q->front + 1) % Size;
}

int Front(Queue *q){
    if (isEmptyQueue(q)) {
        return -1;
    }
    return q->arr[q->front];
}


#pragma mark - 队列：链表实现

typedef struct LNode{
    int val;
    struct LNode *next;
}LNode;

///队列
typedef struct NodeQueue{
    struct LNode *front;
    struct LNode *rear;
}NodeQueue;

///创建节点
static LNode* createNode(int value){
    LNode *newNode = (LNode *)malloc(sizeof(LNode));
    if (newNode == NULL) {
        printf("out of memory");
        return NULL;
    }
    
    newNode->val = value;
    newNode->next = NULL;
    
    return newNode;
}

void EnQueueNode(int val, NodeQueue *q){
    LNode *newNode = createNode(val);
    if (newNode == NULL) {
        return;
    }
    
    q->rear->next = newNode;
    q->rear = q->rear->next;
}

bool isEmptyQueueNode(NodeQueue *q){
    return q->front == q->rear;
}

void DeQueue2(NodeQueue *q){
    if (isEmptyQueueNode(q)) {
        return;
    }
    
    LNode *dNode = q->front->next;
    q->front->next = dNode->next;
    if (q->rear == dNode) {
        q->rear = q->front;
    }
    free(dNode);
}

@end
