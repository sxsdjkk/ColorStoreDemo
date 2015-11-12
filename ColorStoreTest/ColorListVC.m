//
//  ColorListVC.m
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import "ColorListVC.h"
#import "ColorEditVC.h"
#import "JKDataManager.h"
#import "ColorListCell.h"
#import "UIKit/UIDevice.h"
#import "JKColor.h"

@interface ColorListVC () <UITableViewDelegate, UITableViewDataSource>
{
  NSMutableArray *_colorListArray;
  
  UITableView *_tableView;
}
@end

@implementation ColorListVC

- (instancetype)initWithColorStoreType:(ColorStoreType)type {
  
  self = [super init];
  if (self) {
    
    self.colorStoreType = type;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"颜色列表";
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(createNewColor)];
  
  if ([self colorArrayIsEmpty]) {
    
    ColorEditVC *editVC = [[ColorEditVC alloc] init];
    editVC.colorStoreType = _colorStoreType;
    editVC.editType = ColorEditTypeAdd;
    editVC.colorArray = _colorListArray;
    [self.navigationController pushViewController:editVC animated:YES];
  }
  
  [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:animated];
  [_colorListArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        JKColor *color1 = (JKColor *)obj1;
        JKColor *color2 = (JKColor *)obj2;
        return [color2.lastModifyDate compare:color1.lastModifyDate];
  }];
  [_tableView reloadData];
}

- (void)initTableView {
  
  _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
  [_tableView registerNib:[UINib nibWithNibName:@"ColorListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.view addSubview:_tableView];
  _tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return _colorListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  JKColor *color = [_colorListArray objectAtIndex:indexPath.row];
  ColorListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  [cell setCellWithColor:color];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [_tableView deselectRowAtIndexPath:indexPath animated:YES];
  ColorEditVC *editVC = [[ColorEditVC alloc] init];
  editVC.colorStoreType = _colorStoreType;
  editVC.editType = ColorEditTypeModify;
  editVC.colorArray = _colorListArray;
  editVC.colorIndex = indexPath.row;
  [self.navigationController pushViewController:editVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    
      if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] == NSOrderedAscending) {
          
          
          if (_colorStoreType != ColorStoreTypeSqlite) {
              
              [self saveArray];
          }
          else {
              
              [JKDataManager deleteFromDB:[_colorListArray objectAtIndex:indexPath.row]];
          }
          [_colorListArray removeObjectAtIndex:indexPath.row];
          [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

      }
      else {
        
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除吗？" preferredStyle:UIAlertControllerStyleAlert];
          
          [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
              
              if (_colorStoreType != ColorStoreTypeSqlite) {
                  
                  [self saveArray];
              }
              else {
                  
                  [JKDataManager deleteFromDB:[_colorListArray objectAtIndex:indexPath.row]];
              }
              [_colorListArray removeObjectAtIndex:indexPath.row];
              [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
              
          }]];
          
          [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
          
        [self presentViewController:alert animated:YES completion:nil];
      }
  }
}

- (void)saveArray {
  
  if (_colorStoreType == ColorStoreTypePlist) {
    
    [JKDataManager saveArrayToPlist:_colorListArray];
  }
  else if (_colorStoreType == ColorStoreTypeEncode) {
    
    [JKDataManager saveArrayToArchive:_colorListArray];
  }
  else if (_colorStoreType == ColorStoreTypeSqlite) {
    
//    [JKDataManager getColorArrayFromSqlite];
  }
}

- (void)setColorStoreType:(ColorStoreType)colorStoreType {
  
  _colorStoreType = colorStoreType;
  
  switch (colorStoreType) {
    case ColorStoreTypeEncode: {
      
      _colorListArray = [NSMutableArray arrayWithArray:[JKDataManager getColorArrayFromArchive]];
    }
      break;
    case ColorStoreTypePlist: {
      
      _colorListArray = [NSMutableArray arrayWithArray:[JKDataManager getColorArrayFromPlist]];
    }
      break;
    case ColorStoreTypeSqlite: {
      
      _colorListArray = [NSMutableArray arrayWithArray:[JKDataManager getColorArrayFromSqlite]];
    }
      break;
    default:
      
      _colorListArray = nil;
      break;
  }
}






- (BOOL)colorArrayIsEmpty {
  
  if (_colorListArray && _colorListArray.count>0) {
    
    return NO;
  }
  else {
    
    return YES;
  }
}

- (void)createNewColor {
  
  ColorEditVC *editVC = [[ColorEditVC alloc] init];
  editVC.colorStoreType = _colorStoreType;
  editVC.editType = ColorEditTypeAdd;
  editVC.colorArray = _colorListArray;
  [self.navigationController pushViewController:editVC animated:YES];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
