//
//  binTree.m
//  算法
//
//  Created by 李响 on 2018/5/5.
//  Copyright © 2018年 LiXiang. All rights reserved.
//

#import "binTree.h"

@interface binTree ()

@end

@implementation binTree

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    /*
     1
     7        2
     6   8    3   4
     9 10        5
     11  12
     
     */
    
    
    BinTree *head = createTreeNode(1);
    
    BinTree *j = createTreeNode(11);
    BinTree *k = createTreeNode(12);
    
    BinTree *i = createTreeNode(10);
    i->left = j;
    i->right = k;
    
    BinTree *h = createTreeNode(9);
    BinTree *g = createTreeNode(8);
    g->left = h;
    g->right = i;
    
    BinTree *e = createTreeNode(6);
    BinTree *f = createTreeNode(7);
    f->left = e;
    f->right = g;
    
    head->left = f;
    
    BinTree *b = createTreeNode(3);
    BinTree *c = createTreeNode(4);
    BinTree *a = createTreeNode(2);
    a->left = b;
    a->right = c;
    
    c->right = createTreeNode(5);
    
    head->right = a;
    
    //preOrderTraverse(head);
    //    midOrderTraverse(head);
    lastOrderTraverse(head);
}

#pragma mark - 二叉树-遍历

//二叉链表
typedef struct BinTree{
    int val;
    struct BinTree *left;
    struct BinTree *right;
}BinTree;

//先序遍历
void preOrderTraverse(BinTree *T){
    if (T == NULL) {
        return;
    }
    printf("%d-",T->val);
    preOrderTraverse(T->left);
    preOrderTraverse(T->right);
}

//中序遍历
void midOrderTraverse(BinTree *T){
    if (T == NULL) {
        return;
    }
    midOrderTraverse(T->left);
    printf("%d-",T->val);
    midOrderTraverse(T->right);
}

//后序遍历
void lastOrderTraverse(BinTree *T){
    if (T == NULL) {
        return;
    }
    lastOrderTraverse(T->left);
    lastOrderTraverse(T->right);
    printf("%d-",T->val);
}

#pragma mark - 二叉查找树/二叉搜索树

//三叉链表
typedef struct threeNode{
    int val;
    struct threeNode *left;
    struct threeNode *right;
    struct threeNode *parent;
    
}ThreeNode;

BinTree* createTreeNode(int val){
    BinTree *newNode = (BinTree *)malloc(sizeof(BinTree));
    if (newNode == NULL) {
        printf("out of memory");
        return NULL;
    }
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}


//：对于节点T,所有左子树的节点的值均小于T的值，所有右子树的值都大于T的值。

//查找指定值
BinTree* search(BinTree *root, int val){
    if (root == NULL) {
        return NULL;
    }
    
    if (root->val > val) {
        return search(root->left, val);
    } else if (root->val == val) {
        return root;
    } else {
        return search(root->right, val);
    }
}

//查找最小值
BinTree* findMin(BinTree* root){
    if (root == NULL) {
        return NULL;
    }
    if (root->left == NULL) {
        return root;
    } else {
        return findMin(root->left);
    }
}

//查找最大值
BinTree* findMax(BinTree* root){
    if (root == NULL) {
        return NULL;
    }
    if (root->right == NULL) {
        return root;
    } else {
        return findMax(root->right);
    }
}

//插入
BinTree* insert(BinTree* root, int val){
    if (root == NULL) {
        root = createTreeNode(val);
        if (root == NULL) {
            printf("out of memery");
        }
    } else if (val < root->val) {
        root->left = insert(root->left, val);
    } else if (val > root->val){
        root->right = insert(root->right, val);
    }
    
    return root;
}

//删除
BinTree* removeNode(BinTree* root, int val){
    if (root == NULL) {
        printf("not found");
    } else {
        if (val < root->val) {
            root->left = removeNode(root->left, val);
        } else if (val > root->val) {
            root->right = removeNode(root->right, val);
        } else {
            if (root->left && root->right) {//有2个字节点:用右子树的最小节点替换右子树的值，并删除右子树的最小节点
                BinTree *deleNode = findMin(root->right);
                root->val = deleNode->val;
                root->right = removeNode(root->right, root->val);
            } else {//有1个或0个子节点:
                
                BinTree *tempNode = root;
                if (root->left == NULL) {
                    root = root->right;
                } else if (root->right == NULL){
                    root = root->left;
                }
                free(tempNode);
            }
        }
    }
    return root;
}
//时间复杂度：O(log2(n))

@end
