//
//  JKColor.m
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import "JKColor.h"

@implementation JKColor

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super init];
  
  if (self) {
    
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.rValue = [[aDecoder decodeObjectForKey:@"rvalue"] floatValue];
    self.gValue = [[aDecoder decodeObjectForKey:@"gvalue"] floatValue];
    self.bValue = [[aDecoder decodeObjectForKey:@"bvalue"] floatValue];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  
  [aCoder encodeObject:[NSNumber numberWithFloat:self.rValue] forKey:@"rvalue"];
  [aCoder encodeObject:[NSNumber numberWithFloat:self.gValue] forKey:@"gvalue"];
  [aCoder encodeObject:[NSNumber numberWithFloat:self.bValue] forKey:@"bvalue"];
  [aCoder encodeObject:[self safetyString:self.name] forKey:@"name"];
}

- (instancetype)initWithUIColor:(UIColor *)color {
  
  self = [super init];
  
  if (self) {
    
    [self setWithUIColor:color];
  }
  return self;
}

- (void)setWithUIColor:(UIColor *)color {
  
  NSDictionary *dic = [self getRGBDictionaryByColor:color];
  
  _rValue = [[dic objectForKey:@"rvalue"] floatValue];
  _gValue = [[dic objectForKey:@"gvalue"] floatValue];
  _bValue = [[dic objectForKey:@"bvalue"] floatValue];
}


- (instancetype)initWithDictionary:(NSDictionary *)dic {
  
  self = [super init];
  
  if (self) {
    self.name = [dic objectForKey:@"name"];
    self.rValue = [[dic objectForKey:@"rvalue"] floatValue];
    self.gValue = [[dic objectForKey:@"gvalue"] floatValue];
    self.bValue = [[dic objectForKey:@"bvalue"] floatValue];
  }
  return self;
}

- (NSDictionary *)dictionaryFromColor {
  
  return @{@"name":[self safetyString:_name],
           @"rvalue":@(_rValue),
           @"gvalue":@(_gValue),
           @"bvalue":@(_bValue)
           };
}

- (NSString *)safetyString:(NSString *)string {
  
  if (string) {
    return string;
  }
  else {
    return @"";
  }
}





- (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor
{
  CGFloat r=0,g=0,b=0,a=0;
  if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
    [originColor getRed:&r green:&g blue:&b alpha:&a];
  }
  else {
    const CGFloat *components = CGColorGetComponents(originColor.CGColor);
    r = components[0];
    g = components[1];
    b = components[2];
    a = components[3];
  }
  
  return @{@"rvalue":@(r),
           @"gvalue":@(g),
           @"bvalue":@(b),
           @"avalue":@(a)};
}


@end
