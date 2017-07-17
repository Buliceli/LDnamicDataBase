//
//  XMGTableTool.h
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGTableTool : NSObject


/**
 获取表格中所有的排序后字段

 @param cls 类名
 @param uid 用户唯一标识
 @return 字段数组
 */
+ (NSArray *)tableSortedColumnNames:(Class)cls uid:(NSString *)uid;



+ (BOOL)isTableExists:(Class)cls uid:(NSString *)uid;

@end
