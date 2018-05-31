//
//  Dijkstras.m
//  算法
//  属于贪婪算法
//  Created by 李响 on 2018/5/6.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(N*N)

/*
 1.找出最便宜的节点，即可在最短时间到达的节点
 2.对于该节点的邻居，检查是否有前往他们的更短路径，如果有，就更新其开销
 3.重复1.2步骤，知道对图中的每个节点都这样做了
 4.回溯出最短路径
 */

#import "Dijkstras.h"

@interface Dijkstras ()

@property (nonatomic, copy) NSDictionary<NSString*, NSDictionary*> *graph;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSNumber*> *costs;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSString*> *parents;
@property (nonatomic, strong) NSMutableArray<NSString *> *precessedNodes;

@end

@implementation Dijkstras

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    //1.
    NSMutableDictionary<NSString*, NSDictionary*> *graph = [NSMutableDictionary dictionary];
    graph[@"start"] = @{@"a": @6,
                        @"b": @2
                        };
    graph[@"a"] = @{@"end": @1
                    };
    graph[@"b"] = @{@"a": @3,
                    @"end": @5
                    };
    graph[@"end"] = @{};
    self.graph = graph;
    
    //2.
    NSDictionary *costs = @{@"a": @6,
                            @"b": @2,
                            @"end": @NSIntegerMax
                            };
    self.costs = costs.mutableCopy;
    
    //3.
    NSDictionary *parents = @{@"start": [NSNull null],
                              @"a": @"start",
                              @"b": @"start",
                              @"end": [NSNull null]
                              };
    self.parents = parents.mutableCopy;
    
    //4.
    self.precessedNodes = [NSMutableArray new];
    
    
    
    [self findShortestPathUsingDijkstras];
    
    
}

/**
 找出最便宜的节点

 @return 节点
 */
- (nullable NSString *)findLowestNode{
    __block NSInteger lowest = NSIntegerMax;
    __block NSString *lowestNode = NULL;
    [self.costs enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![self.precessedNodes containsObject:key] && obj.integerValue < lowest) {
            lowestNode = key;
            lowest = obj.integerValue;
        }
    }];
    return lowestNode;
}

- (NSArray *)findShortestPathUsingDijkstras{
    
    NSString *node = [self findLowestNode];
    while (node) {
        NSInteger cost = [self.costs valueForKey:node].integerValue;
        NSDictionary<NSString*, NSNumber*> *neighbors = [self.graph valueForKey:node];
        [neighbors enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger new_cost = cost + obj.integerValue;
            if (new_cost < [self.costs valueForKey:key].integerValue) {
                [self.costs setValue:@(new_cost) forKey:key];
                [self.parents setValue:node forKey:key];
            }
        }];
        [self.precessedNodes addObject:node];
        node = [self findLowestNode];
    }
    
    NSMutableArray *path = [NSMutableArray new];
    [path insertObject:@"end" atIndex:0];
    NSString *parent = [self.parents valueForKey:@"end"];
    while ([parent isNotEqualTo:[NSNull null]]) {
        [path insertObject:parent atIndex:0];
        parent = [self.parents valueForKey:parent];
    }
    
    NSLog(@"%@",path);
    return path;
}





@end
