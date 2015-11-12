//
//  ColorEditView.h
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKColor.h"

@interface ColorEditView : UIView
{
  UISlider *_redSlider;
  UISlider *_greenSlider;
  UISlider *_blueSlider;
  
  UILabel *_rValueLbel;
  UILabel *_gValueLbel;
  UILabel *_bValueLbel;
}

@property (nonatomic, weak) id taget;
@property (nonatomic, assign, nonnull) SEL valueChangeSelector;
@property (nonatomic, strong, nullable) JKColor *color;

- (void)addTarget:(_Nullable id)taget action:(nonnull SEL)action;

- (void)setColor:(nonnull JKColor *)color;

@end
