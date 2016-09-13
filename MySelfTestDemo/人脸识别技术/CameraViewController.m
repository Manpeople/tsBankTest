//
//  CameraViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/1/7.
//  Copyright © 2016年 By. All rights reserved.
//

#import "CameraViewController.h"
#import <ImageIO/CGImageProperties.h>
#import <AVFoundation/AVFoundation.h>
#import "SetCameraViewController.h"

@interface CameraViewController (){
 
    
    UIImageView * _imageView;
}


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self makeCamera];
}

- (void)makeCamera{

    UIButton * btnCamera = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 200, 50)];
    [btnCamera setTitle:@"人脸识别" forState:UIControlStateNormal];
    [btnCamera setBackgroundColor:[UIColor grayColor]];
    [btnCamera addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btnCamera setTag:101];
    [self.view addSubview:btnCamera];
    
    UIButton * btnVerfily = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 200, 50)];
    [btnVerfily setTitle:@"人脸登录" forState:UIControlStateNormal];
    [btnVerfily setBackgroundColor:[UIColor grayColor]];
    [btnVerfily addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btnVerfily setTag:101];
    [self.view addSubview:btnVerfily];

//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, ScreenHeigth-180)];
//    [_imageView setBackgroundColor:[UIColor grayColor]];
//    [self.view addSubview:_imageView];
}

- (void)click:(UIButton *)btn{

    SetCameraViewController * setcamera = [[SetCameraViewController alloc] init];
    [self.navigationController pushViewController:setcamera animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
