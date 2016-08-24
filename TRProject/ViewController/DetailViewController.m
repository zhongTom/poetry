//
//  DetailViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DetailViewController.h"

@import AVFoundation;
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) AVSpeechSynthesizer *speechSyn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    label.text = @[_shiModel.shi,_shiModel.introShi][indexPath.section];
    
    return cell;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @[@"诗词赏析",@"注解"][section];
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
//自定义头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    UILabel *view = [UILabel new];
    view.text =@[@"诗词赏析",@"注解"][section];
    view.font = [UIFont systemFontOfSize:20];
//    view.backgroundView = [UIView new];
    
    return view;
}
//cell的高度自适应
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
#pragma mark - 方法 Methods

- (IBAction)read:(UIBarButtonItem *)sender {
   static BOOL isReading = NO;
    if (!_speechSyn) {
        AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:_shiModel.shi];
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
        utt.voice = voice;
        _speechSyn = [AVSpeechSynthesizer new];
        [_speechSyn speakUtterance:utt];
        isReading = YES;
    }else{
        if (isReading) {
            [_speechSyn pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            isReading = NO;
            NSLog(@"YES");
        }else{
            [_speechSyn continueSpeaking];
            isReading = YES;
        }
    }
    sender.title = isReading?@"暂停":@"朗读";
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    //注册自定义分区头
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"Header"];
    
    self.title = self.shiModel.title;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [Factory addBackItemToVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
