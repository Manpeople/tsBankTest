//
//  DataViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/1/28.
//  Copyright © 2016年 By. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@property (nonatomic,strong) UITextField * textfield;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, ScreenWidth-40, 50)];
    [self.textfield setBackgroundColor:[UIColor grayColor]];
    self.textfield.layer.borderColor = [UIColor redColor].CGColor;
    self.textfield.layer.borderWidth = 2.0f;
    self.textfield.layer.cornerRadius = 15.0f;
    [self.textfield setTextColor:[UIColor blackColor]];
    [self.textfield setPlaceholder:@"请输入要传递的值"];
    [self.view addSubview:self.textfield];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    ablock safeblock = self.myBlock;
    
    //下面的是为了原子安全，防止self.myBlock被另一个线程修改为空造成crash
    if (safeblock) {
        safeblock(self.textfield.text);
    }
    //下边的是确定其他线程不会把block修改为空
//    self.myBlock(self.textfield.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
