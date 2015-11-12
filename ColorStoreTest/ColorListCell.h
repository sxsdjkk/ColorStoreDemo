//
//  ColorListCell.h
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKColor;

@interface ColorListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *rLabel;

@property (weak, nonatomic) IBOutlet UILabel *gLabel;

@property (weak, nonatomic) IBOutlet UILabel *bLabel;



- (void)setCellWithColor:(JKColor *)color;


@end
