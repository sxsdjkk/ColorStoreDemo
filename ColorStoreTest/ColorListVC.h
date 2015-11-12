//
//  ColorListVC.h
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  ColorStoreTypeEncode = 1,
  ColorStoreTypePlist,
  ColorStoreTypeSqlite,
} ColorStoreType;


@interface ColorListVC : UIViewController

@property (nonatomic, assign) ColorStoreType colorStoreType;


- (instancetype)initWithColorStoreType:(ColorStoreType)type;


- (BOOL)colorArrayIsEmpty;

@end
