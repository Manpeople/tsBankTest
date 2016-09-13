//
//  MyUIPickerViewController.m
//  MySelfTestDemo
//
//  Created by H H M on 16/7/7.
//  Copyright © 2016年 By. All rights reserved.
//

#import "MyUIPickerViewController.h"
#import "MyPickerView.h"

@interface MyUIPickerViewController ()

@end

@implementation MyUIPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    MyPickerView * myPicker = [[MyPickerView alloc] init];
    [self.view addSubview:myPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
