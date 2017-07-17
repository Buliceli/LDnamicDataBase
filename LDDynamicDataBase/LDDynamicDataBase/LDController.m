//
//  LDController.m
//  LDDynamicDataBase
//
//  Created by 李洞洞 on 17/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDController.h"
#import "LDModel.h"
#import "LDDCell.h"
#import <UIKit/UIKit.h>
#import "XMGSqliteModelTool.h"
#define LDD(objecet,assignment) (object = object?assignment)
@interface LDController ()
@property(nonatomic,strong)NSMutableArray * dataSource;
@end

@implementation LDController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LDDCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    [self requestNetWorkData];
}
- (void)requestNetWorkData
{

    [self zeng];
    [self gai];
}
#pragma mark --- 增
- (void)zeng
{
    [XMGSqliteModelTool createTable:[LDModel class] uid:@"1"];
    for (int i = 0; i < 3; i++) {
        LDModel * model = [[LDModel alloc]init];
        model.bookName = [NSString stringWithFormat:@"书籍%d",i];
        model.bookNewPrice = [NSString stringWithFormat:@"%d",i];
        model.bookDirectory = [self iToBookDirctory][@(i)];
        model.bookNewAuthor = [NSString stringWithFormat:@"作者:%d",i];
        [self.dataSource addObject:model];
        [XMGSqliteModelTool saveOrUpdateModel:model uid:@"1"];
    }
  
}
#pragma mark --- 删
- (void)shan
{
#if 0  //根据model删  (全自动)
    LDModel * model = [[LDModel alloc]init];
    model.bookName = @"书籍0";
    model.bookPrice = 0;
    model.bookDirectory = @[@"第一章",@"第二章"];
    
    [XMGSqliteModelTool deleteModel:model uid:@"1"];
#endif
  
#if 0  //根据外界的条件 在数据库里删除符合条件的数据 (半自动)
    
    BOOL isSuccess = [XMGSqliteModelTool deleteModel:[LDModel class] columnName:@"bookPrice" relation:ColumnNameToValueRelationTypeLessEqual value:@1 uid:@"1"];
    if (isSuccess) {
        NSLog(@"删除成功");
    }
#endif
#if 0  //根据外界的条件 在数据库里删除符合条件的数据 (半自动)
    NSString * sql = @"bookPrice = 2";
    BOOL isSuccess = [XMGSqliteModelTool deleteModel:[LDModel class] whereStr:sql uid:@"1"];
    if (isSuccess) {
        NSLog(@"删除成功");
    }
#endif
    
}
#pragma mark --- 查
- (void)cha
{
#if 1 //如果没网,在数据库里取所有数据 (全自动)
    BOOL isNewWork = NO;
    if (!isNewWork) {
        NSArray * allModels = [XMGSqliteModelTool queryAllModels:[LDModel class] uid:@"1"];
        self.dataSource = [NSMutableArray arrayWithArray:allModels];
        return;
    }
#endif
    
#if 0 //按照外界的条件 在数据库里筛选符合条件的数据 (半自动方式)
    
    NSArray * allModels = [XMGSqliteModelTool queryModels:[LDModel class] columnName:@"bookPrice" relation:ColumnNameToValueRelationTypeMoreEqual value:@2 uid:@"1"];
    self.dataSource = [NSMutableArray arrayWithArray:allModels];
    return;
    
#endif
#if 0 //按照外界的条件 在数据库里筛选符合条件的数据 (手动方式)
    NSString *sql = @"select * from LDModel where  bookPrice >= 1";
    NSArray * allModels = [XMGSqliteModelTool queryModels:[LDModel class] WithSql:sql uid:@"1"];
    self.dataSource = [NSMutableArray arrayWithArray:allModels];
    return;
    
#endif
}
#pragma mark --- 改 ---- >(数据的迁移 和 数据库的动态更新,全都基于模型)
/*
 App的2.0版本 相对于 App的1.0版本 ---->(一个模型对应一张表结构)
 if(表结构发生变化-->也就是模型的字段发生了变化){
                       1.app的2.0版本 相对于app的1.0版本 (同一个模型新添加了字段)
                       2.app的2.0版本 (修改了模型的属性名称)
                       以上两种情况:需要更新数据库的表结构
 }
 */
/*
 动态更新数据库表结构的流程是:
                       1.通过Runtime创建一个最新模型对应的表结构(称为临时表)
                       2.根据主键把数据迁移到新表中(临时表中)
                       3.删除掉老表
                       4.把临时表 更名为 老表
 */
- (void)gai
{
#if 0      //模型增加属性--->也就是数据库表结构需要动态增加字段
    LDModel * newModel = [[LDModel alloc]init];
    newModel.bookDirectory = @[@"第七章",@"第八章"];
    newModel.bookPrice = 3;
    newModel.bookName = @"新加属性";
    newModel.bookNewAuthor = @"李明杰";
    [XMGSqliteModelTool saveOrUpdateModel:newModel uid:@"1"];
#endif
    
#if 1      //模型修改属性名--->也就是数据库表结构需要动态更新字段
    LDModel * newModel = [[LDModel alloc]init];
    newModel.bookDirectory = @[@"第九章",@"第十章"];
    newModel.bookNewPrice = [NSString stringWithFormat:@"%d",4];
    newModel.bookName = @"修改属性";
    newModel.bookNewAuthor = @"李南江";
    
    [XMGSqliteModelTool saveOrUpdateModel:newModel uid:@"1"];
#endif
}
//私有方法 映射思想
- (NSDictionary *)iToBookDirctory
{
    return @{
             @(0) :@[@"第一章",@"第二章"],
             @(1) :@[@"第三章",@"第四章"],
             @(2) :@[@"第五章",@"第六章"]
             };
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDDCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        UIViewController * vc = [[UIViewController alloc]init];
//        vc.view.backgroundColor = [UIColor whiteColor];
//        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        [self presentViewController:vc animated:YES completion:nil];
//    }
//}
@end
