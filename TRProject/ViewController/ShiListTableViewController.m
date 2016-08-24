//
//  ShiListTableViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ShiListTableViewController.h"
#import "ShiListViewModel.h"
@interface ShiListTableViewController ()
@property (nonatomic) ShiListViewModel *shiListVM;
@end

@implementation ShiListTableViewController

#pragma mark - 方法 Methods
- (void)refreshUI{
    [self.shiListVM getShiListCompletionHandler:^{
        [self.tableView reloadData];
    }];
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUI];
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.tableView.backgroundView = bgView;
    [Factory addBackItemToVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.shiListVM.rowNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.shiListVM titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self.shiListVM authorForRow:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [UIAlertView bk_showAlertViewWithTitle:@"删除诗词" message:@"删除后无法恢复，确定删除吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self.shiListVM removeShi:[self.shiListVM shiForRow:indexPath.row] completionHandler:^{
                    [self refreshUI];
                }];
            }
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    ShiModel *model = [self.shiListVM shiForRow:indexPath.row];
    //采用KVC传值，可以不用导头文件
    [segue.destinationViewController setValue:model forKey:@"shiModel"];
}
- (ShiListViewModel *)shiListVM {
	if(_shiListVM == nil) {
        NSAssert(_kindModel, @"%s kindModel不能为空",__FUNCTION__);
		_shiListVM = [[ShiListViewModel alloc] initWithKindModel:self.kindModel];
	}
	return _shiListVM;
}

@end
