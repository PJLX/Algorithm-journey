//
//  binary_search.m
//  算法
//
//  Created by 李响 on 2018/5/4.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(logN)

#import "binary_search.h"

@interface binary_search ()

@end

@implementation binary_search

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSArray *a = @[@(1),@(3),@(5),@(7),@(9),@(11),@(13),@(15),@(17),@(19),@(21)];
    NSInteger index = [self binary_search:a item:10];
    NSLog(@"%ld",index);
    
}


/**
 二分查找

 @param sortedArray 有序数组
 @param item 要查找的值
 @return 值所在的索引
 */
- (NSInteger)binary_search:(NSArray<NSNumber*>*)sortedArray item:(NSInteger)item{
    NSInteger low = 0;
    NSInteger high = sortedArray.count - 1;
    while (low <= high) {
        NSInteger mid = (low + high) / 2;
        NSInteger guess = sortedArray[mid].integerValue;
        if (guess > item) {
            high = mid - 1;
        } else if (guess < item) {
            low = low + 1;
        } else {
            return mid;
        }
    }
    return -1;
}

@end
