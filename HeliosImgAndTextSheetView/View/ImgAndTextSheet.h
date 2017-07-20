//
//  ImgAndTextSheet.h
//  HeliosImgAndTextSheetView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeliosSheetDelegate <NSObject>

- (void)didSelectIndex:(NSInteger )index;

@end

@interface ImgAndTextSheet : UIView
@property (nonatomic ,weak) id<HeliosSheetDelegate> delegate;

- (instancetype )initWithSheetList:(NSArray *)list title:(NSString *)title;

- (void)showSheetInController:(UIViewController *)controller;

@end
