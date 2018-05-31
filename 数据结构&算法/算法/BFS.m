//
//  BFS.m
//  算法
//  属于贪婪算法
//  Created by 李响 on 2018/5/5.
//  Copyright © 2018年 LiXiang. All rights reserved.
//  O(V+E)   vertice+edge

#import "BFS.h"

@interface BFS ()
@property (nonatomic, strong) NSDictionary<NSString*, NSArray*> *graph;
@property (nonatomic, strong) NSMutableArray<NSString *> *searchedNode;
@property (nonatomic, strong) NSMutableArray<NSString *> *paths;

@end

@implementation BFS

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSMutableDictionary<NSString*, NSArray*> *graph = [NSMutableDictionary dictionary];
    graph[@"a"] = @[@"b", @"c", @"d"];
    graph[@"b"] = @[@"e", @"f"];
    graph[@"c"] = @[@"g"];
    graph[@"d"] = @[@"h"];
    graph[@"e"] = @[@"z"];
    graph[@"f"] = @[@"i"];
    graph[@"g"] = @[@"h"];
    graph[@"h"] = @[@"j"];
    graph[@"i"] = @[@"z", @"j"];
    graph[@"j"] = @[@"z"];
    graph[@"z"] = @[];
    self.graph = graph.copy;
    
    [self bfsWithGraph:graph start:@"a" end:@"z"];
    
    self.paths = [NSMutableArray new];
    [self findPathsWithKey:self.searchedNode.lastObject];
}

/**
 广度优先搜索寻找最短路径是否存在

 @param graph 数据存储方式
 @param start 起点
 @param end 终点
 @return 是否存在路径
 */

- (BOOL)bfsWithGraph:(NSDictionary *)graph start:(NSString *)start end:(NSString *)end{
    //队列
    NSMutableArray *queue = [[graph valueForKey:start] mutableCopy];
    //已搜索的节点
    self.searchedNode = [NSMutableArray new];
    [self.searchedNode addObject:start];
    while (queue.count > 0) {
        NSString *guessNode = queue.firstObject;
        [queue removeObject:guessNode];
        if (![self.searchedNode containsObject:guessNode]) {
            [self.searchedNode addObject:guessNode];
            if ([guessNode isEqualToString:end]) {
                NSLog(@"%@",self.searchedNode);
                NSLog(@"find");
                return YES;
            } else {
                [queue addObjectsFromArray: [graph valueForKey:guessNode]];
            }
        }
    }
    NSLog(@"unfind");
    return NO;
}


/**
 回溯路径:遍历已搜索的点，在对象图中找到第一个包含key的点，把这个点继续当做key递归调用。
 */
- (void)findPathsWithKey:(NSString *)key{
    [self.paths insertObject:key atIndex:0];
    for (NSString *node in self.searchedNode) {
        NSArray *values = [self.graph valueForKey:node];
        if ([values containsObject:key]) {
            [self findPathsWithKey:node];
            return;
        }
    }
    NSLog(@"%@",self.paths);
}



@end
