//
//  ColorEditVC.m
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import "ColorEditVC.h"
#import "ColorEditView.h"
#import "JKDataManager.h"
#import "JKColor.h"

@interface ColorEditVC ()
{
  ColorEditView *_editView;
  NSInteger _colorID;
}

@property (weak, nonatomic) IBOutlet UIView *colorField;

@end

@implementation ColorEditVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"编辑颜色";
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveColor)];
  
  [self addColorEditView];
    
  if (self.editType == ColorEditTypeAdd) {
    
    _colorField.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    _editView.color = [[JKColor alloc] initWithUIColor:_colorField.backgroundColor ];
  }
  else {
    
    _color = [_colorArray objectAtIndex:_colorIndex];
    _editView.color = _color;
    _colorID = _color.colorID;
    _colorField.backgroundColor = [UIColor colorWithRed:_color.rValue green:_color.gValue blue:_color.bValue alpha:1.0];
    _nameTextField.text = _color.name;
  }
}

- (void)saveColor {
  
  if (_colorStoreType == ColorStoreTypePlist) {
    
    if (_editType == ColorEditTypeAdd) {
      
      JKColor *color = [[JKColor alloc] initWithUIColor:_colorField.backgroundColor];
      color.name = _nameTextField.text;
      [_colorArray addObject:color];
    }
    else {
      JKColor *color = [[JKColor alloc] initWithUIColor:_colorField.backgroundColor];
      color.name = _nameTextField.text;
      [_colorArray replaceObjectAtIndex:_colorIndex withObject:color];
    }
    [JKDataManager saveArrayToPlist:_colorArray];
  }
  else if (_colorStoreType == ColorStoreTypeEncode) {
    
    if (_editType == ColorEditTypeAdd) {
      
      JKColor *color = [[JKColor alloc] initWithUIColor:_colorField.backgroundColor];
      color.name = _nameTextField.text;
      [_colorArray addObject:color];
    }
    else {
      JKColor *color = [[JKColor alloc] initWithUIColor:_colorField.backgroundColor];
      color.name = _nameTextField.text;
      [_colorArray replaceObjectAtIndex:_colorIndex withObject:color];
    }
    [JKDataManager saveArrayToArchive:_colorArray];
  }
  else if (_colorStoreType == ColorStoreTypeSqlite) {
    
    if (_editType == ColorEditTypeAdd) {
      
      JKColor *color = [[JKColor alloc] initWithUIColor:_colorField.backgroundColor];
      color.name = _nameTextField.text;
      color = [JKDataManager insertToDB:color];
      if (color) {
        
        [_colorArray addObject:color];
      }
    }
    else {
      
      JKColor *color = [[JKColor alloc] initWithUIColor:_colorField.backgroundColor];
      color.name = _nameTextField.text;
      color.colorID = _color.colorID;
      [JKDataManager updateToDB:color];
      [_colorArray replaceObjectAtIndex:_colorIndex withObject:color];
    }
  }
  [self.navigationController popViewControllerAnimated:YES];
}


- (void)addColorEditView {
  
  _editView = [[ColorEditView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-150, SCREEN_WIDTH, 150)];
  [_editView addTarget:self action:@selector(editViewChanged:)];
  [self.view addSubview:_editView];
}

- (void)editViewChanged:(id)sender {
  
  ColorEditView *editView = (ColorEditView *)sender;
  JKColor *color = editView.color;
  _colorField.backgroundColor = [UIColor colorWithRed:color.rValue green:color.gValue blue:color.bValue alpha:1.0];
}

- (IBAction)colorFieldTapped:(id)sender {
  
  [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
