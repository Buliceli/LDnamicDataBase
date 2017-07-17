//
//  LDDCell.m
//  LDDynamicDataBase
//
//  Created by 李洞洞 on 17/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDDCell.h"

@interface LDDCell ()

@end

@implementation LDDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(LDModel *)model
{
    _model = model;
    self.nameL.text = model.bookName;
    self.priceL.text = [NSString stringWithFormat:@"%@",model.bookNewPrice];
    NSMutableString * str = [NSMutableString string];
    NSArray * arr = model.bookDirectory;
    for (int i = 0; i < arr.count; i++) {
        [str appendString:arr[i]];
     }
    self.directoryL.text = str;
}

@end
