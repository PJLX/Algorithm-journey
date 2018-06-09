//
//  Sort.m
//  算法
//
//  Created by 李响 on 2018/6/9.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  选择排序：O(N*N)
//  快速排序：O(N*logN)
//  冒泡排序：O(N*N)  n-1 + n-2 + n-3 + ... + 1
//  插入排序：O(N*N)  1 + 2 + 3 + ... + n-1
//

#import "Sort.h"

@interface Sort ()

@end

@implementation Sort

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    //1.
//    NSArray *a = @[@(11),@(13),@(15),@(17),@(9),@(1),@(3),@(5),@(7),@(19),@(21)];
//    NSArray *arr = [self selectionSort:a];
//    NSLog(@"%@",arr);
    
    //2.
//    NSArray *a = @[@(11),@(13),@(15),@(17),@(9),@(1),@(3),@(5),@(7),@(19),@(21)];
//    NSArray *arr = [self quickSort:a];
//    NSInteger sum = [self sumUseRecursion:a];
//    NSLog(@"%@",arr);
//    NSLog(@"%ld",sum);
//
//    [self findBiggestSubPartOfRectangleWithWidth:1680 height:640];
    
    
    //3.
    NSMutableArray *a = @[@(11),@(13),@(15),@(17),@(9),@(1),@(3),@(5),@(7),@(19),@(21)].mutableCopy;
    [self bubble_sort:a];
    [self insert_sort:a];

    
}

#pragma mark - 选择排序
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

#pragma mark - 快速排序

/**
 快速排序：使用分而治之的思想。选择数组中的一个元素作为基数，将数组中大于和小于基数的元素分为两部分，递归操作这两个部分
 
 @param arr 输入
 @return 输出
 */
- (NSArray *)quickSort:(NSArray<NSNumber*> *)arr{
    if (arr.count < 2) {
        return arr;
    } else {
        NSInteger base = arr.firstObject.integerValue;
        NSMutableArray *less = [NSMutableArray new];
        NSMutableArray *grater = [NSMutableArray new];
        [arr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.integerValue < base) {
                [less addObject:obj];
            }
            if (obj.integerValue > base) {
                [grater addObject:obj];
            }
        }];
        NSMutableArray *sortedArr = [NSMutableArray new];
        [sortedArr addObjectsFromArray:[self quickSort:less]];
        [sortedArr addObject:@(base)];
        [sortedArr addObjectsFromArray:[self quickSort:grater]];
        return sortedArr.copy;
    }
}


/**
 递归求和
 
 @param arr 输入
 @return 输出
 */
- (NSInteger)sumUseRecursion:(NSArray<NSNumber*> *)arr{
    if (arr.count == 0) {
        return 0;
    } else if (arr.count == 1) {
        return arr.firstObject.integerValue;
    } else {
        return arr.firstObject.integerValue + [self sumUseRecursion:[arr subarrayWithRange:NSMakeRange(1, arr.count - 1)]];
    }
}

/**
 一块矩形的地，将这块地均匀的分成方块，且分成的方块要尽可能的大
 
 @param width 宽
 @param height 高
 @return 方块边长
 */
- (NSInteger)findBiggestSubPartOfRectangleWithWidth:(NSInteger)width height:(NSInteger)height{
    NSInteger max = MAX(width, height);
    NSInteger min = MIN(width, height);
    NSInteger remainder = max % min;
    NSLog(@"max:%ld min:%ld remainder:%ld",max,min,remainder);
    if (remainder == 0) {
        return min;
    } else {
        return [self findBiggestSubPartOfRectangleWithWidth:min height:remainder];
    }
}

#pragma mark - 冒泡排序

/**
 冒泡排序：将大/小的元素放到最后/最前
 示例从小到大排序
 @param ma 无序数组
 */
- (void)bubble_sort:(NSMutableArray<NSNumber *> *)ma{
    NSUInteger count = ma.count;
    for (NSUInteger i = 0; i < count; i++) {
        for (NSUInteger j = 0; j < count - i - 1; j++) {
            if (ma[j].integerValue > ma[j+1].integerValue ) {
                NSNumber *temp = ma[j];
                ma[j] = ma[j+1];
                ma[j+1] = temp;
            }
        }
    }
    NSLog(@"%@",ma);
}


#pragma mark - 插入排序

/**
 插入排序
 从第二个元素开始，依次和它之前的元素做对比，将小/大的放在前面
 示例从小到大排序
 2 1 3 5 4
 1 2 3 5 4
 1 2 3 5 4
 1 2 3 4 5
 @param ma 无序数组
 */
- (void)insert_sort:(NSMutableArray<NSNumber *> *)ma{
    NSUInteger count = ma.count;
    for (NSUInteger i = 1; i < count; i++) {
        for (NSInteger j = i; j > 0; j--) {
            if (ma[j].integerValue < ma[j-1].integerValue) {
                NSNumber *temp = ma[j];
                ma[j] = ma[j-1];
                ma[j-1] = temp;
            }
        }
    }
    NSLog(@"%@",ma);
}


@end
