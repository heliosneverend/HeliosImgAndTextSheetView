//
//  ViewController.m
//  HeliosImgAndTextSheetView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "ViewController.h"
#import "ItemModel.h"
#import "ImgAndTextSheet.h"
@interface ViewController ()<HeliosSheetDelegate>
{
    NSArray *_listDataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self makeUI];
}
- (void)makeUI {
    
    CGRect bounds = self.view.bounds;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(bounds)/2-100, 200, 200, 40)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"图文混排ActionSheet" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick {
    [self setDataSource];
    ImgAndTextSheet *sheetView = [[ImgAndTextSheet alloc] initWithSheetList:_listDataArray title:@"拨打电话"];
    sheetView.delegate = self;
    [sheetView showSheetInController:self];
}

- (void)setDataSource {
    
    ItemModel *item1 = [[ItemModel alloc] init];
    item1.icon = @"phone";
    item1.title = @"13111111111";
    
    ItemModel *item2 = [[ItemModel alloc] init];
    item2.icon = @"phone";
    item2.title = @"15555555555";
    
    ItemModel *item3 = [[ItemModel alloc] init];
    item3.icon = @"phone";
    item3.title = @"13666666666";
    _listDataArray = [NSArray arrayWithObjects:item1,item2,item3, nil];
}
#pragma Mark HeliosSheetDelegate
- (void)didSelectIndex:(NSInteger )index{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您当前点击的是第%zi个按钮",index] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
