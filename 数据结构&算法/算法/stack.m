//
//  stack.m
//  算法
//
//  Created by 李响 on 2018/5/5.
//  Copyright © 2018年 LiXiang. All rights reserved.
//

#import "stack.h"

@interface stack ()

@end

@implementation stack

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    int n = 5;
    hanoi(n, "x", "y", "z");
    printf("%f\n",pow(2, n)-1);
}

#pragma mark- 栈-数组实现

#define MAX_SIZE 20
typedef int StackEntry;
typedef struct stack{
    StackEntry entry[MAX_SIZE];
    int top;
}Stack;

bool isFull(Stack *s){
    return s->top >= MAX_SIZE;
}

bool isEmpty(Stack *s){
    return s->top <= 0;
}

void push(StackEntry item, Stack *s){
    if (isFull(s)) {
        return;
    }
    s->entry[s->top] = item;
    s->top++;
}

void pop(Stack *s){
    if (isEmpty(s)) {
        return;
    }
    s->top--;
}

StackEntry Top(Stack *s){
    if (isEmpty(s)) {
        return -1;
    }
    return s->entry[s->top-1];
}


#pragma mark- 栈-链表实现

typedef struct LNode{
    int val;
    struct LNode *next;
}LNode;

bool isEmpty2(LNode *head){
    return head->next == NULL;
}

bool isFull2(LNode *head){
    return head->val >= MAX_SIZE;
}

bool push2(int value, LNode *head){
    LNode *addNode = (LNode *)malloc(sizeof(LNode));
    if (addNode == NULL) {
        printf("out of memory");
        return 0;
    }
    addNode->val = value;
    
    addNode->next = head->next;
    head->next = addNode;
    return 1;
}

bool pop2(LNode *head){
    if (isEmpty2(head)) {
        printf("stack is empty");
        return 0;
    }
    
    head->next = head->next->next;
    head->val--;
    free(head->next);
    return 1;
}

#pragma mark- 栈应用/递归-汉诺塔
int c = 0;
void moveOneStep(char *x, int n, char *z){
    printf("%4i. move disk %i from %s to %s \n",++c, n, x, z);
}

/*
 1     1
 2     2
 3     3
 x  y  z
 
 */

void hanoi(int n, char *x, char *y, char *z){
    if (n == 1) {
        moveOneStep(x, n, z);
    } else {
        hanoi(n-1, x, z, y);
        moveOneStep(x, n, z);
        hanoi(n-1, y, x, z);
    }
}

@end
