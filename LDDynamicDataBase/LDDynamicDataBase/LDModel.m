//
//  LDModel.m
//  LDDynamicDataBase
//
//  Created by 李洞洞 on 17/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDModel.h"

@implementation LDModel
+ (NSString *)primaryKey
{
    return @"bookName";
}
+ (NSDictionary *)newNameToOldNameDic   //最好不要修改主键
{
    return @{
             @"bookNewPrice":@"bookPrice"
             };
}
@end
