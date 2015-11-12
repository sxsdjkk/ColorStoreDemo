//
//  ColorEditView.m
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import "ColorEditView.h"

@implementation ColorEditView

- (instancetype)initWithFrame:(CGRect)frame {
  
  self = [super initWithFrame:frame];
  
  if (self) {
    
    self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    _redSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, width-80, 30)];
    _redSlider.tag = 1;
    [_redSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _redSlider.minimumValue = 0;
    _redSlider.maximumValue = 255;
    
    _greenSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, width-80, 30)];
    _greenSlider.tag = 2;
    [_greenSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _greenSlider.minimumValue = 0;
    _greenSlider.maximumValue = 255;
    
    _blueSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, width-80, 30)];
    
    _blueSlider.minimumValue = 0;
    _blueSlider.maximumValue = 255;
    _blueSlider.tag = 3;
    [_blueSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _redSlider.center = CGPointMake(width/2, height/6);
    _greenSlider.center = CGPointMake(width/2, height/6*3);
    _blueSlider.center = CGPointMake(width/2, height/6*5);
    
    
    [self addSubview:_redSlider];
    [self addSubview:_greenSlider];
    [self addSubview:_blueSlider];
    
    
    UILabel *rLabel = [[UILabel alloc] init];
    rLabel.text = @"R";
    rLabel.bounds = CGRectMake(0, 0, 30, 30);
    rLabel.center = CGPointMake(35, _redSlider.center.y);
    [self addSubview:rLabel];
    
    UILabel *gLabel = [[UILabel alloc] init];
    gLabel.text = @"G";
    gLabel.bounds = CGRectMake(0, 0, 30, 30);
    gLabel.center = CGPointMake(35, _greenSlider.center.y);
    [self addSubview:gLabel];
    
    UILabel *bLabel = [[UILabel alloc] init];
    bLabel.text = @"B";
    bLabel.bounds = CGRectMake(0, 0, 30, 30);
    bLabel.center = CGPointMake(35, _blueSlider.center.y);
    [self addSubview:bLabel];
    
    
    _rValueLbel = [[UILabel alloc] init];
    _rValueLbel.bounds = CGRectMake(0, 0, 40, 30);
    _rValueLbel.center = CGPointMake(SCREEN_WIDTH-20, _redSlider.center.y);
    [self addSubview:_rValueLbel];
    
    _gValueLbel = [[UILabel alloc] init];
    _gValueLbel.bounds = CGRectMake(0, 0, 40, 30);
    _gValueLbel.center = CGPointMake(SCREEN_WIDTH-20, _greenSlider.center.y);
    [self addSubview:_gValueLbel];
    
    _bValueLbel = [[UILabel alloc] init];
    _bValueLbel.bounds = CGRectMake(0, 0, 40, 30);
    _bValueLbel.center = CGPointMake(SCREEN_WIDTH-20, _blueSlider.center.y);
    [self addSubview:_bValueLbel];
    
    _color = [[JKColor alloc] initWithUIColor:[UIColor colorWithRed:_redSlider.value/255.0 green:_greenSlider.value/255.0 blue:_blueSlider.value/255.0 alpha:0]];
    
  }
  return self;
}

- (void)setColor:(JKColor *)color {
  
  _color = color;
  
  _redSlider.value = color.rValue*255;
  _greenSlider.value = color.gValue*255;
  _blueSlider.value = color.bValue*255;
  
  _rValueLbel.text = [NSString stringWithFormat:@"%d",(int)(color.rValue*255)];
  _gValueLbel.text = [NSString stringWithFormat:@"%d",(int)(color.gValue*255)];
  _bValueLbel.text = [NSString stringWithFormat:@"%d",(int)(color.bValue*255)];
}

- (void)addTarget:(_Nullable id)taget action:(nonnull SEL)action {
  
  _taget = taget;
  _valueChangeSelector = action;
}

- (void)sliderValueChanged:(id)sender {
  
  _color = [[JKColor alloc] initWithUIColor:[UIColor colorWithRed:_redSlider.value/255.0 green:_greenSlider.value/255.0 blue:_blueSlider.value/255.0 alpha:0]];
  
  _rValueLbel.text = [NSString stringWithFormat:@"%d",(int)(_color.rValue*255)];
  _gValueLbel.text = [NSString stringWithFormat:@"%d",(int)(_color.gValue*255)];
  _bValueLbel.text = [NSString stringWithFormat:@"%d",(int)(_color.bValue*255)];
  
  if (_taget && [_taget respondsToSelector:_valueChangeSelector]) {
    
    [_taget performSelector:_valueChangeSelector withObject:self];
  }
}

@end
