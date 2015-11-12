//
//  ColorEditVC.h
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorListVC.h"

typedef enum {
  ColorEditTypeModify,
  ColorEditTypeAdd,
} ColorEditType;

@class JKColor;

@interface ColorEditVC : UIViewController

@property (nonatomic, assign) ColorStoreType colorStoreType;

@property (nonatomic, assign) ColorEditType editType;

@property (nonatomic, strong) JKColor *color;

@property (nonatomic, weak) NSMutableArray *colorArray;

@property (nonatomic, assign) NSInteger colorIndex;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;


@end
