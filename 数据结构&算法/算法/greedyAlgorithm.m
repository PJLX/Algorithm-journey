//
//  greedyAlgorithm.m
//  算法
//  属于贪婪算法
//  Created by 李响 on 2018/5/6.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(N*N)

#import "greedyAlgorithm.h"

@interface greedyAlgorithm ()

@property (nonatomic, strong) NSMutableSet *neededSet;
@property (nonatomic, strong) NSDictionary<NSString*, NSSet*> *graph;

@end

@implementation greedyAlgorithm

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.neededSet = [NSSet setWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11, nil].mutableCopy;
    self.graph = @{@"a": [NSSet setWithObjects:@1,@3,@5,@7,@9, nil],
                    @"b": [NSSet setWithObjects:@2,@4, nil],
                    @"c": [NSSet setWithObjects:@8,@9,@10, nil],
                    @"d": [NSSet setWithObjects:@5,@6,@7,@8, nil],
                    @"e": [NSSet setWithObjects:@10, nil],
                    @"f": [NSSet setWithObjects:@1,@2,@3,@4, nil],
                    @"g": [NSSet setWithObjects:@1,@2,@10, nil],
                    @"h": [NSSet setWithObjects:@4,@5,@6, nil],
                    @"i": [NSSet setWithObjects:@5,@6,@7,@8, nil],
                    @"j": [NSSet setWithObjects:@1,@10, nil],
                    @"k": [NSSet setWithObjects:@2,@4,@6,@10, nil],
                    };
    
    [self findMinimumSet];
    
    
}

/**
 集合覆盖问题：给定一个有限范围的集合A。假设有多个A的子集，寻找最少的子集数，要求子集的并可以最大限度的接近A

 @return 子集集合
 */
- (NSArray *)findMinimumSet{
    
    NSMutableArray *selectedSet = [NSMutableArray new];
    while (self.neededSet.count > 0) {
        __block NSString *matchedKey = @"";
        __block NSMutableSet *search_covered = [NSMutableSet set];
        [self.graph enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSSet * _Nonnull obj, BOOL * _Nonnull stop) {
            NSMutableSet *neededSetCopy = [self.neededSet mutableCopy];
            [neededSetCopy intersectSet:obj];
            if (neededSetCopy.count > search_covered.count) {
                matchedKey = key;
                search_covered = obj.mutableCopy;
            }
        }];
        
        if (search_covered.count == 0) {
            break;
        }
        [self.neededSet minusSet:search_covered];
        [selectedSet addObject:matchedKey];
    }
    
    NSLog(@"%@",selectedSet);
    return selectedSet;
}


/**
 travelling salesman problem
 从任一起点出发，然后每次选择下一个要去的城市时，都选择未去的最近的城市
 */
- (void)tsp{
    
}

/**
 朋友圈问题：在一堆人中找出互相都认识的人的最大集合
 */
- (void)friendsRelationshipProblem{
    
}



@end
