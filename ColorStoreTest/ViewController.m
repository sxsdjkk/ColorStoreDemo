//
//  ViewController.m
//  ColorStoreTest
//
//  Created by user on 15/11/12.
//  Copyright © 2015年 gamechat. All rights reserved.
//

#import "ViewController.h"
#import "ColorListVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = YES;
}

- (IBAction)gotoColorListVC:(id)sender {
  
  UIButton *button = (UIButton *)sender;
  ColorListVC *listVC = [[ColorListVC alloc] init];
  listVC.colorStoreType = button.tag;
  [self.navigationController pushViewController:listVC animated:![listVC colorArrayIsEmpty]];
}




- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
