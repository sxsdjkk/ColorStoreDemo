//
//  ColorListCell.m
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import "ColorListCell.h"
#import "JKColor.h"

@implementation ColorListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithColor:(JKColor *)color {
  
  _nameLabel.text = (!color.name||color.name.length==0||[color.name isEqualToString:@"(null)"])?@"未命名":color.name;
  _rLabel.text = [NSString stringWithFormat:@"%d",(int)(color.rValue*255)];
  _gLabel.text = [NSString stringWithFormat:@"%d",(int)(color.gValue*255)];
  _bLabel.text = [NSString stringWithFormat:@"%d",(int)(color.bValue*255)];
  _colorView.backgroundColor = [UIColor colorWithRed:color.rValue green:color.gValue blue:color.bValue alpha:1.0];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
