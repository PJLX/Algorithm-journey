//
//  knapsackProblem.m
//  算法
//
//  Created by 李响 on 2018/5/6.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(n*n)

#import "knapsackProblem.h"

@interface knapsackProblem ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber*>*> *gridding;
@property (nonatomic, strong) NSMutableArray *selectedGoods;
@property (nonatomic, strong) NSDictionary<NSString*, NSNumber*> *graphValue;
@property (nonatomic, strong) NSDictionary<NSString*, NSNumber*> *graphWeight;
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
    NSInteger size = 7;
    NSInteger maxValue = [self findMaxminumValueWithKnapsackSize:size graphValue:self.graphValue graphWeight:self.graphWeight];
    self.selectedGoods = [NSMutableArray new];
    [self findGoodsWithRow:self.graphValue.allKeys.count-1 list:size - 1 maxValue:maxValue];
    NSLog(@"%@",self.selectedGoods);
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

@end
