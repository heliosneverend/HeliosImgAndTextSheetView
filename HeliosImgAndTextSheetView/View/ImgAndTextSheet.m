//
//  ImgAndTextSheet.m
//  HeliosImgAndTextSheetView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "ImgAndTextSheet.h"
#import "ItemCell.h"
@interface ImgAndTextSheet ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *listArr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong)UIView *customerView;
@end
@implementation ImgAndTextSheet
- (instancetype )initWithSheetList:(NSArray *)list title:(NSString *)title {
    if (self = [super init]){
        [self makeUIWith:list title:title];
    }
    return self;
}
- (void)makeUIWith:(NSArray *)list title:(NSString *)title {
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = RGBACOLOR(160, 160, 160, 0);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 0, ScreenWidth-10, 44*list.count+45) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.layer.cornerRadius = 5;
    
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,CGRectGetHeight(_tableView.frame)+10, ScreenWidth-10, 44)];
    cancelLabel.layer.cornerRadius =5;
    cancelLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    cancelLabel.text = @"取消";
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.textColor = [UIColor blueColor];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    cancelLabel.userInteractionEnabled = YES;
    [cancelLabel addGestureRecognizer:tapRecognizer];
    
    _customerView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, CGRectGetHeight(_tableView.frame)+60)];
    _customerView.backgroundColor = [UIColor clearColor];
    [_customerView addSubview:_tableView];
    [_customerView addSubview:cancelLabel];
    
    [self addSubview:_customerView];
    _listArr = list;
    _title = title;
}
/*
 ** 区别单击手势是在tableView中还是View中 是否响应手势(手势代理)
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

- (void)setAnimation {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundColor = RGBACOLOR(160, 160, 160, 0.4);
        CGRect originRect = _customerView.frame;
        originRect.origin.y = ScreenHeight - CGRectGetHeight(_customerView.frame);
        _customerView.frame = originRect;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)tappedCancel{
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
        CGRect originRect = _customerView.frame;
        originRect.origin.y = ScreenHeight;
        _customerView.frame = originRect;
    } completion:^(BOOL finished) {
        if (finished) {
            for (UIView *v in _customerView.subviews) {
                [v removeFromSuperview];
            }
            [_customerView removeFromSuperview];
        }
    }];
}
/*
 ** 判断有没有Controller 有就将视图加载到该Controller上 没有就加载到Window上
 */
- (void)showSheetInController:(UIViewController *)controller {
    if (controller){
        [controller.view addSubview:self];
    }else{
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }
    [self setAnimation];
}
#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArr.count+1;
}
/*
 ** 45伪的tableViewHeader
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 45;
    }
    return 44;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"TitleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = _title;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.userInteractionEnabled = NO;
        return cell;
    }else{
        static NSString *cellIdentifier = @"DownSheetCell";
        ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setValueWithItemModel:_listArr[indexPath.row - 1]];
        return cell;
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tappedCancel];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectIndex:)]) {
        [_delegate didSelectIndex:indexPath.row];
        return;
    }
}
@end
