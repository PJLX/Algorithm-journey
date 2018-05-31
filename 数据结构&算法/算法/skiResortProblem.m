//
//  skiResortProblem.m
//  算法
//
//  Created by 李响 on 2018/5/7.
//  Copyright © 2018年 LiXiang. All rights reserved.
//

#import "skiResortProblem.h"

@interface skiResortProblem ()

@end

@implementation skiResortProblem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSArray *graph = @[@[@14, @15, @16, @17, @18],
                       @[@13, @26, @27, @28, @19],
                       @[@12, @25, @30, @29, @20],
                       @[@11, @24, @23, @22, @21],
                       @[@10,  @9,  @8,  @7,  @6]];
    
    
    
    
    
    
}

int dp[105][105], board[105][105];


int dx[4] = { -1, 0, 1, 0 };
int dy[4] = { 0, -1, 0, 1 };
int dfs( int i, int j )
{
    if( dp[i][j] >= 0 )
        return dp[i][j];
    
    int temp = 1;
    for( int k = 0; k < 4; k++ )
    {
        if( board[i + dx[k]] [j + dy[k]] < board[i][j] )
            temp = MAX( temp, dfs( i + dx[k], j + dy[k] ) + 1 );
    }
    
    return (dp[i][j] = temp);
}



- (void)skiResortProblem{
    
}

@end
