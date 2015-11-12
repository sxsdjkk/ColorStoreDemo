//
//  JKColor.h
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKColor : NSObject<NSCoding>


@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat rValue;
@property (nonatomic, assign) CGFloat gValue;
@property (nonatomic, assign) CGFloat bValue;

@property (nonatomic, retain) NSDate *lastModifyDate;

@property (nonatomic, assign) NSInteger colorID;

- (instancetype)initWithUIColor:(UIColor *)color;
- (void)setWithUIColor:(UIColor *)color;

- (NSDictionary *)dictionaryFromColor;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
