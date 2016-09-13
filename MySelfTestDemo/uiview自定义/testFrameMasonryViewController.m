//
//  testFrameMasonryViewController.m
//  MySelfTestDemo
//
//  Created by H H M on 16/6/23.
//  Copyright © 2016年 By. All rights reserved.
//

#import "testFrameMasonryViewController.h"

@interface testFrameMasonryViewController ()

@end

@implementation testFrameMasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self makeUI];
}

- (void)makeUI{
    
    // 初始化一个View
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    // 使用mas_makeConstraints添加约束
    
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(200, 200)); //固定view的宽和高
//    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.edges.mas_offset(UIEdgeInsetsMake(100, 10, 100, 10));//上、左、下、右
    }];
    
    NSLog(@"bgView ==w= %f  h=%f",bgView.frame.size.width,bgView.frame.size.height);
    
//    文／赵璞（简书作者）
//    原文链接：http://www.jianshu.com/p/f0b17ecfd04e
//    著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
