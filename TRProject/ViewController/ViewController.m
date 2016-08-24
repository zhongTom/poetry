//
//  ViewController.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "KindViewModel.h"
#import "KindCell.h"
#import "DetailViewController.h"
#import "ShiListTableViewController.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,KindCellDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) KindViewModel *kindVM;
//保存当前的编辑状态
@property (nonatomic,getter=isEdit) BOOL edit;
@end

@implementation ViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        _edit = NO;
    }
    return self;
    
}
#pragma mark - 方法 Methods
- (IBAction)editKind:(UIBarButtonItem *)sender {
    _edit = !_edit;
    sender.title = _edit?@"完成":@"编辑";
    [_collectionView reloadData];
}
#pragma mark - UISearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.kindVM searchWithWords:searchText completionHandler:^{
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
    
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.kindVM.shiNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSInteger row = indexPath.row;
    cell.textLabel.text = [self.kindVM shiTitleForRow:row];
    cell.detailTextLabel.text = [self.kindVM authorForRow:row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.shiModel = [self.kindVM shiForRow:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - KindCell Delegate
- (void)removeKindInCell:(KindCell *)kindCell{
    [UIAlertView bk_showAlertViewWithTitle:@"删除诗集" message:@"一旦删除则无法恢复，确定要删除吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex == 1){
            NSIndexPath *indexPath = [_collectionView indexPathForCell:kindCell];
            KindModel *kindModel = [self.kindVM kindForRow:indexPath.row];
            [self.kindVM removeKind:kindModel completionHandler:^{
                [self refreshUI];
            }];
            
        }
    }];
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.kindVM.rowNumber;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kindCell" forIndexPath:indexPath];
    NSString *title = [self.kindVM titleForRow:indexPath.row];
    cell.iconIV.image = [UIImage imageNamed:title];
    cell.removeBtn.hidden = !self.isEdit;
    cell.delegate = self;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //340*162
    CGFloat width = (kScreenW - 35)/2;
    CGFloat height = width*162/340;
    return CGSizeMake(width, height);
}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    ShiListTableViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShiListTableViewController"];
//    vc.kindModel = [self.kindVM kindForRow:indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//}
#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUI];
    [self configSearchBar];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.searchDisplayController.searchResultsTableView.backgroundView = view;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ShiListTableViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = [_collectionView indexPathForCell:sender];
    vc.kindModel = [self.kindVM kindForRow:indexPath.row];
}
- (void)configSearchBar{
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    //输入框是私有的属性，正常点语法拿不到
    NSArray *subViews = searchBar.subviews.firstObject.subviews;
    //删除背景图
    [subViews.firstObject removeFromSuperview];
    UITextField *tf = subViews.lastObject;
    tf.borderStyle = UITextBorderStyleNone;
    tf.background = [UIImage imageNamed:@"圆角矩形-1"];
    NSLog(@"");
    
}
- (void)refreshUI{
    [self.kindVM getKindListCompletionHandler:^{
        [_collectionView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (KindViewModel *)kindVM {
    if(_kindVM == nil) {
        _kindVM = [[KindViewModel alloc] init];
    }
    return _kindVM;
}

@end
