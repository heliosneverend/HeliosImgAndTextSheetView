//
//  ItemCell.h
//  HeliosImgAndTextSheetView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
/*
 ** 懒的复制了 别的类可以访问到
 */
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ItemCell : UITableViewCell

- (void)setValueWithItemModel:(ItemModel *)item;
@end
