//
//  LDDCell.h
//  LDDynamicDataBase
//
//  Created by 李洞洞 on 17/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDModel.h"
@interface LDDCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *directoryL;

@property(nonatomic,strong)LDModel * model;
@end
