//
//  LDModel.h
//  LDDynamicDataBase
//
//  Created by 李洞洞 on 17/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGSqliteModelTool.h"
@interface LDModel : NSObject<XMGModelProtocol>
@property(nonatomic,copy)NSString * bookName;
//@property(nonatomic,assign)NSInteger  bookPrice;
@property(nonatomic,strong)NSArray * bookDirectory;
#pragma mark --- app 2.0 新加属性
@property(nonatomic,copy)NSString * bookNewAuthor;
#pragma mark --- app 3.0 修改属性
@property(nonatomic,copy)NSString * bookNewPrice;
@end
