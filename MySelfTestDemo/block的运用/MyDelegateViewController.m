//
//  MyDelegateViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/5/17.
//  Copyright © 2016年 By. All rights reserved.
//

#import "MyDelegateViewController.h"

@interface MyDelegateViewController (){

    UITextField * _textField;
}

@end

@implementation MyDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    [_textField setBackgroundColor:[UIColor grayColor]];

    [self.view addSubview:_textField];
    
    UIButton * btndelegate = [[UIButton alloc] initWithFrame:CGRectMake(50,400, 100, 50)];
    [btndelegate setBackgroundColor:[UIColor grayColor]];
    btndelegate.tag = 1;
    [btndelegate setTitle:@"返回" forState:UIControlStateNormal];
    [btndelegate addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btndelegate];

}

- (void)click:(UIButton *)btn{

    [self.delegate receiveDataWithString:_textField.text];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
