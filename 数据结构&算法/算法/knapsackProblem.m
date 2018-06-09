//
//  knapsackProblem.m
//  算法-动态规划
//
//  Created by 李响 on 2018/5/6.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(n*n)

#import "knapsackProblem.h"

@interface knapsackProblem ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber*>*> *gridding;
@property (nonatomic, strong) NSMutableArray *selectedGoods;
@property (nonatomic, copy) NSDictionary<NSString*, NSNumber*> *graphValue;
@property (nonatomic, copy) NSDictionary<NSString*, NSNumber*> *graphWeight;
@end

@implementation knapsackProblem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    /*
            1     2     3     4     5
     a 1  1500  1500  1500  1500  1500
     b 3  1500  1500  2000  3500  3500
            |
             -----------------------
                                    |
     c 4  1500  1500  2000  5000 -6500
                                    |
     d 2  1500  2500  4000  5000  6500
     */
    
    self.graphValue = @{@"a": @1500,
                            @"b": @2000,
                            @"c": @5000,
                            @"d": @2500,
                            };
    self.graphWeight = @{@"a": @1,
                                  @"b": @3,
                                  @"c": @4,
                                  @"d": @2,
                                  };
//    NSInteger size = 7;
//    NSInteger maxValue = [self findMaxminumValueWithKnapsackSize:size graphValue:self.graphValue graphWeight:self.graphWeight];
//    self.selectedGoods = [NSMutableArray new];
//    [self findGoodsWithRow:self.graphValue.allKeys.count-1 list:size - 1 maxValue:maxValue];
//    NSLog(@"%@",self.selectedGoods);
    
    
    [self maxsSubSequenceBetweenA:@"foisha" andB:@"fish"];
}

/**
 背包问题

 @param size 背包容量
 @param graphValue 商品价值列表
 @param graphWeight 商品重量列表
 @return 可容纳的最大价值和
 */
- (NSInteger)findMaxminumValueWithKnapsackSize:(NSInteger)size
                                    graphValue:(NSDictionary<NSString*, NSNumber*>*)graphValue
                                   graphWeight:(NSDictionary<NSString*, NSNumber*>*)graphWeight{
    //网格
    self.gridding = [NSMutableArray new];
    //排序的商品列表
    NSArray *goods = [graphValue.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSInteger goodIndex = 0; goodIndex < goods.count; goodIndex++) {
        NSMutableArray *rowArr = [NSMutableArray new];
        NSString *goodName = goods[goodIndex];
        NSInteger goodValue = [graphValue valueForKey:goodName].integerValue;
        NSInteger goodWeight = [graphWeight valueForKey:goodName].integerValue;
        for (NSInteger weight = 0; weight < size; weight++) {
            //首行
            if (goodIndex == 0) {
                if (goodWeight <= weight+1) {
                    [rowArr addObject:@(goodValue)];
                } else {
                    [rowArr addObject:@(0)];
                }
                
            } else {
                //上一行的值
                NSInteger lastRowValue = self.gridding[goodIndex - 1][weight].integerValue;
                if (goodWeight < weight+1) {
                    //当前商品的价值+剩余空间的价值
                    NSInteger mixValue = goodValue + self.gridding[goodIndex - 1][weight - goodWeight].integerValue;
                    [rowArr addObject:@(MAX(lastRowValue, mixValue))];
                } else if (goodWeight == weight+1) {
                    [rowArr addObject:@(MAX(lastRowValue, goodValue))];
                } else {
                    [rowArr addObject:@(lastRowValue)];
                }
            }
        }
        [self.gridding addObject:rowArr];
    }
    
    NSLog(@"%@",self.gridding);
    return self.gridding.lastObject.lastObject.integerValue;
}

- (void)findGoodsWithRow:(NSInteger)row list:(NSInteger)list maxValue:(NSInteger)maxValue{
    
    if (maxValue == 0) {
        return;
    }
    
    NSArray *goods = [self.graphValue.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSString *goodName = goods[row];
    NSInteger value = [self.graphValue valueForKey:goodName].integerValue;
    NSInteger weight = [self.graphWeight valueForKey:goodName].integerValue;
    NSInteger currentValue = self.gridding[row][list].integerValue;
    
    if (row > 0) {
        //说明没有选第row行的商品
        if (currentValue == self.gridding[row - 1][list].integerValue) {
            [self findGoodsWithRow:row - 1 list:list maxValue:maxValue];
        } else if (list - weight >= 0 &&
                   currentValue == value + self.gridding[row - 1][list - weight].integerValue) {
            //说明选了第row行的商品
            [self.selectedGoods insertObject:goodName atIndex:0];
            [self findGoodsWithRow:row - 1 list:list - weight maxValue:maxValue - value];
        } else {
            //说明选了第row行的商品
            [self.selectedGoods insertObject:goodName atIndex:0];
            [self findGoodsWithRow:row - 1 list:list maxValue:maxValue - value];
        }
    } else if (row == 0) {
        if (maxValue != 0) {
            [self.selectedGoods insertObject:goodName atIndex:0];
        }
    }
}

/**
 最长/大公共子串
       f o s h i
     f
     i
     s
     h
 if a[i] == b[j]
 cell[i][j] = cell[i-1][j-1] + 1;
 else
 cell[i][j] = 0;

 @param a a
 @param b b
 @return 最长/大公共子串
 */
- (NSString *)maxSubStringBetweenA:(NSString *)a andB:(NSString *)b{
    NSUInteger lengthA = a.length;
    NSUInteger lengthB = b.length;
    
    self.gridding = [NSMutableArray new];
    
    //记录最长子串最后一个字符的位置
    NSUInteger max = 0;
    NSUInteger maxI = 0;
    
    for (NSUInteger i = 0; i < lengthA; i++) {
        NSMutableArray<NSNumber*> *rowArr = [NSMutableArray new];

        for (NSUInteger j = 0; j < lengthB; j++) {
            NSString *subA = [a substringWithRange:NSMakeRange(i, 1)];
            NSString *subB = [b substringWithRange:NSMakeRange(j, 1)];
            if ([subA isEqualToString:subB]) {
                [rowArr addObject:@([self itemInI:i-1 j:j-1].integerValue + 1)];
                if (rowArr[j].integerValue > max) {
                    max = rowArr[j].integerValue;
                    maxI = i;
                }
            } else {
                [rowArr addObject:@(0)];
            }
        }
        
        [self.gridding addObject:rowArr];
    }
    
    NSString *maxSubString = [a substringWithRange:NSMakeRange(maxI - max + 1, max)];
    NSLog(@"%@",maxSubString);
    return maxSubString;
}

/**
 求两个字符串的最长公共子序列，子序列表示相同的字符串的总长度，相对于公共子串更能表示字符串间的相似程度
 if a[i] == b[j]
 cell[i][j] = cell[i-1][j-1] + 1;
 else
 cell[i][j] = max(cell[i-1][j], cell[i][j-1]);
 
 @param a a
 @param b b
 */
- (void)maxsSubSequenceBetweenA:(NSString *)a andB:(NSString *)b{
    NSUInteger lengthA = a.length;
    NSUInteger lengthB = b.length;
    
    self.gridding = [[NSMutableArray alloc] initWithCapacity:lengthA*lengthB];
    
    for (NSUInteger i = 0; i < lengthA; i++) {
        NSMutableArray<NSNumber*> *rowArr = [NSMutableArray new];
        
        for (NSUInteger j = 0; j < lengthB; j++) {
            NSString *subA = [a substringWithRange:NSMakeRange(i, 1)];
            NSString *subB = [b substringWithRange:NSMakeRange(j, 1)];
            if ([subA isEqualToString:subB]) {
                [rowArr addObject:@([self itemInI:i-1 j:j-1].integerValue + 1)];
            } else {
                NSUInteger max = MAX([self itemInI:i-1 j:j].integerValue, [self itemInI:i j:j-1].integerValue);
                [rowArr addObject:@(max)];
            }
        }
        
        [self.gridding addObject:rowArr];
    }
    
    NSLog(@"%@",self.gridding);
}

- (NSNumber *)itemInI:(NSInteger)i j:(NSInteger)j{
    if (i < 0 || j < 0) {
        return @(0);
    }
    
    if (!self.gridding.count || self.gridding.count - 1 < i) {
        return @(0);
    }
    
    return self.gridding[i][j];
}

@end
