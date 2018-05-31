//
//  quickSort.m
//  算法
//
//  Created by 李响 on 2018/5/5.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(N*logN)

#import "quickSort.h"

@interface quickSort ()

@end

@implementation quickSort

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
//    NSArray *a = @[@(11),@(13),@(15),@(17),@(9),@(1),@(3),@(5),@(7),@(19),@(21)];
//    NSArray *arr = [self quickSort:a];
//    NSInteger sum = [self sumUseRecursion:a];
//    NSLog(@"%@",arr);
//    NSLog(@"%ld",sum);
    
    [self findBiggestSubPartOfRectangleWithWidth:1680 height:640];

}


/**
 快速排序：
 
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




@end
