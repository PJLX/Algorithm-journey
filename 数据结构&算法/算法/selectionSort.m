//
//  selectionSort.m
//  算法
//
//  Created by 李响 on 2018/5/4.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(n*n)

#import "selectionSort.h"

@interface selectionSort ()

@end

@implementation selectionSort

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSArray *a = @[@(11),@(13),@(15),@(17),@(9),@(1),@(3),@(5),@(7),@(19),@(21)];
    NSArray *arr = [self selectionSort:a];
    NSLog(@"%@",arr);
}


/**
 寻找数组中的最小值

 @param arr 无序数组
 @return 最小值
 */
- (NSInteger)findSmallest:(NSArray<NSNumber*>*)arr{
    __block NSInteger min = arr.firstObject.integerValue;
    [arr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.integerValue < min) {
            min = obj.integerValue;
        }
    }];
    return min;
}


/**
 选择排序

 @param arr 无序数组
 @return 输出
 */
- (NSArray *)selectionSort:(NSArray<NSNumber*>*)arr{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:arr.count];
    NSMutableArray *arrMutableCopy = [arr mutableCopy];
    while (arrMutableCopy.count > 0) {
        NSInteger min = [self findSmallest:arrMutableCopy];
        [arrMutableCopy removeObject:@(min)];
        [ma addObject:@(min)];
    }
    return ma.copy;
}

@end
