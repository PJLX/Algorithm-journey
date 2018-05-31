//
//  linkedList.m
//  算法
//
//  Created by 李响 on 2018/5/5.
//  Copyright © 2018年 LiXiang. All rights reserved.
//

#import "linkedList.h"

@interface linkedList ()

@end

@implementation linkedList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark- 链表-单向链表

typedef struct LNode{
    int val;
    struct LNode *next;
}LNode;

//创建节点
LNode* createNode(int value){
    LNode *newNode = (LNode *)malloc(sizeof(LNode));
    if (newNode == NULL) {
        printf("out of memory");
        return NULL;
    }
    
    newNode->val = value;
    newNode->next = NULL;
    
    return newNode;
}

//尾节点
LNode* Tail(LNode *head){
    if (head->next == NULL) {
        printf("list is null");
        return NULL;
    }
    
    while (head->next != NULL) {
        head = head->next;
    }
    return head;
}

//后插法
// head - a - b - tail
// head - a - b - tail - newnode
void insertInTail(int val, LNode *head){
    LNode *tail = Tail(head);
    LNode *newNode = createNode(val);
    tail->next = newNode;
    tail = newNode;
    head->val++;
}

//前插法
// head - a - b - tail
// head - newnode - a -b - tail
void insertInHead(int val, LNode *head){
    LNode *newNode = createNode(val);
    newNode->next = head->next;
    head->next = newNode;
    head->val++;
}

//删除
// head - a - b - tail
// head - b - tail
void delete(int val, LNode *head){
    if (head->next == NULL){
        printf("empty list!\n");
        return;
    }
    
    LNode *pre = head;
    LNode *cur = head->next;
    while (cur != NULL) {
        if (cur->val == val) {
            break;
        } else {
            pre = cur;
            cur = cur->next;
        }
    }
    pre->next = cur->next;
    head->val--;
    free(cur);
    
}

///链表反转
LNode* reverse(LNode *head){
    if (head == NULL || head->next == NULL) {
        printf("empty");
        return head;
    }
    
    LNode *pre = NULL;
    LNode *cur = head->next;
    LNode *next = NULL;
    
    while (cur != NULL) {
        next = cur->next;
        cur->next = pre;
        pre = cur;
        cur = cur->next;
    }
    
    head->next = pre;
    
    return head;
    
}

// head -> a -> b -> c     null <- a <- b -> c     a <- b <- c    a <- b <- c <- head

#pragma mark- 链表-双向链表
typedef struct DuLNode{
    int val;
    struct DuLNode *pre;
    struct DuLNode *next;
}DuLNode;

#pragma mark- 链表-循环链表

@end
