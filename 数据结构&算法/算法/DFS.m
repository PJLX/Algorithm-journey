//
//  DFS.m
//  算法
//
//  Created by 李响 on 2018/5/7.
//  Copyright © 2018年 LiXiang. All rights reserved.
//

#import "DFS.h"

@interface DFS ()

@property (nonatomic, strong) NSDictionary<NSString*, NSArray*> *graph;
@property (nonatomic, strong) NSMutableArray<NSString *> *searchedNode;
@property (nonatomic, strong) NSMutableArray<NSString *> *path;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSString *>*> *paths;
@property (nonatomic, assign) BOOL isFinded;

@end

@implementation DFS

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSMutableDictionary<NSString*, NSArray*> *graph = [NSMutableDictionary dictionary];
    graph[@"a"] = @[@"b", @"c", @"d", @"e", @"k"];
    graph[@"b"] = @[@"e", @"f"];
    graph[@"c"] = @[@"g"];
    graph[@"d"] = @[@"h"];
    graph[@"e"] = @[@"z"];
    graph[@"f"] = @[@"i"];
    graph[@"g"] = @[@"h"];
    graph[@"h"] = @[@"j"];
    graph[@"i"] = @[@"z", @"j"];
    graph[@"j"] = @[@"z"];
    graph[@"k"] = @[];
    graph[@"z"] = @[];
    self.graph = graph.copy;
    
    self.searchedNode = [NSMutableArray new];
    self.path = [NSMutableArray new];
    self.paths = [NSMutableArray new];
    [self dfsWithStart:@"a" end:@"z"];
    NSLog(@"%@",self.paths);
}

/**
 深度优先搜索寻找最短路径是否存在
 --递归
 
 @param start 起点
 @param end 终点
 */

- (void)dfsWithStart:(NSString *)start end:(NSString *)end{
    
    //搜索走过的路径，包含回溯重复的点
    [self.searchedNode addObject:start];
    //单次首次发现的路径,
    if (![self.path containsObject:start]) {
        [self.path addObject:start];
    }
    printf("%s-",start.UTF8String);

    if ([start isEqualToString:end]) {
        printf("find-");
        [self.searchedNode removeObject:end];
        //对于不包含起点的子路径，要把起点到子路径起点的路径补上
        while (![self.path containsObject:@"a"]) {
            [self.path insertObject:[self findFirstParentWithChild:self.path.firstObject] atIndex:0];
        }
        [self.paths addObject:[self.path copy]];
        [self.path removeAllObjects];
        //如果已搜索过的节点A，A的父节点中包含未被搜索过的点，那么将A从已搜索过的点中移除
        [self deleteSearchedNodeWithUnsearchedParent];
        
        
    } else {
        NSArray *neighbors = [self.graph valueForKey:start];
        if (neighbors.count == 0) {
            NSString *parent = [self findFirstParentWithChild:start];
            [self.path removeObject:start];
            [self dfsWithStart:parent end:end];
        } else {
            for (NSString *neighbor in neighbors) {
                if (![self.searchedNode containsObject:neighbor]) {
                    [self dfsWithStart:neighbor end:end];
                }
            }
        }
    }
}


/**
 寻找子节点上次路过的父节点

 @param child 子节点
 @return 父节点
 */
- (NSString *)findFirstParentWithChild:(NSString *)child{
    __block NSString *parent;
    [self.searchedNode enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *values = [self.graph valueForKey:obj];
        if ([values containsObject:child]) {
            parent = obj;
            *stop = YES;
        }
    }];
    return parent;
}

/**
 寻找子节点的所有父节点

 @param child 子节点
 @return 父节点
 */
- (NSArray *)findParentsWithChild:(NSString *)child{
    NSMutableArray *parents = [NSMutableArray new];
    NSArray *keys = self.graph.allKeys;
    for (NSString *key in keys) {
        NSArray *childen = [self.graph valueForKey:key];
        if ([childen containsObject:child]) {
            [parents addObject:key];
        }
    }
    return parents;
}

/**
 删除已搜索的节点中包含未被搜索的父节点的点
 */
- (void)deleteSearchedNodeWithUnsearchedParent{
    for (NSString *node in self.searchedNode) {
        NSArray *parents = [self findParentsWithChild:node];
        NSMutableSet *seta = [NSSet setWithArray:self.searchedNode].mutableCopy;
        NSSet *setb = [NSSet setWithArray:parents];
        [seta intersectSet:setb];
        ///node的父节点都被访问过
        if (![seta isEqualToSet:setb]) {
            [self.searchedNode removeObject:node];
            [self deleteSearchedNodeWithUnsearchedParent];
            break;
        }
    }
}





@end
