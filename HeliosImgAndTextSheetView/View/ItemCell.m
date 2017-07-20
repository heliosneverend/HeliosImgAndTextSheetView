//
//  ItemCell.m
//  HeliosImgAndTextSheetView
//
//  Created by beyo-zhaoyf on 2017/7/20.
//  Copyright © 2017年 beyo-zhaoyf. All rights reserved.
//

#import "ItemCell.h"

@interface ItemCell ()
@property (nonatomic , strong) UIImageView *leftView;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) ItemModel  *item;
@end
@implementation ItemCell

- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self makeUI];
    }
    return self;
}
- (void)makeUI {
    _leftView = [[UIImageView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_leftView];
    [self.contentView addSubview:_titleLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/*
 ** 重新绘制frame 在makeUI直接绘制也可以
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    _leftView.frame = CGRectMake(20, (CGRectGetHeight(self.frame)-30)/2, 30, 30);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_leftView.frame)+5, (CGRectGetHeight(self.frame)-20)/2, 150, 20);
    _titleLabel.textColor = [UIColor blueColor];
}

- (void)setValueWithItemModel:(ItemModel *)item {
    _item = item;
    _leftView.image = [UIImage imageNamed:item.icon];
    _titleLabel.text = item.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/*
 ** 设置点击事件
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if(selected){
        self.backgroundColor = RGBCOLOR(12, 102, 188);
    }else{
         self.backgroundColor = [UIColor whiteColor];
    }
    // Configure the view for the selected state
}

@end
