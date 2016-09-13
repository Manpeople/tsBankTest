//
//  PresentViewViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 15/12/10.
//  Copyright © 2015年 By. All rights reserved.
//

#import "PresentViewViewController.h"
#import "SpaceViewController.h"
#import "AnamotionViewController.h"
#import "PhotoViewController.h"
#import "CameraViewController.h"
#import "AddressViewController.h"
#import "TestblockViewController.h"
#import "ApplePayViewController.h"
#import "ImageslideViewController.h"
#import "SQLiteViewController.h"
#import "myanimation.h"
#import "testFrameMasonryViewController.h"
#import "MyUIPickerViewController.h"


@interface PresentViewViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PresentViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView * table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
}

#pragma mark - UITableViewData

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        [cell.textLabel setText:@"1、点击空白收回键盘"];
    }
    else if(indexPath.section == 1){
        [cell.textLabel setText:@"2、UIView的各种动画效果"];
    }
    else if (indexPath.section == 2){
    
        [cell.textLabel setText:@"3、照像机的调用及相册功能"];
    }
    else if (indexPath.section == 3){
    
        [cell.textLabel setText:@"4、人脸识别技术"];
    }
    else if(indexPath.section == 4){
    
        [cell.textLabel setText:@"5、获取系统通讯录"];
    }
    else if(indexPath.section == 5){
    
        [cell.textLabel setText:@"6、block和delegate的运用"];
    }
    else if(indexPath.section == 6){
        
        [cell.textLabel setText:@"7、Apple Pay"];
    }
    else if(indexPath.section == 7){
        
        [cell.textLabel setText:@"8、AES加解密"];
    }
    else if(indexPath.section == 8){
        
        [cell.textLabel setText:@"9、图片滑动的优化效果及单例规范写法"];
    }
    else if(indexPath.section == 9){
        
        [cell.textLabel setText:@"10、数据的存储和读取"];
    }
    else if(indexPath.section == 10){
        
        [cell.textLabel setText:@"11、uiview自定义动画效果"];
    }
    else if(indexPath.section == 11){
        
        [cell.textLabel setText:@"12、代替frame的masory"];
    }
    else if(indexPath.section == 12){
        
        [cell.textLabel setText:@"13、UIPickerView使用方法"];
    }

    return cell;
}

#pragma mark UITableDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        //跳转到点击空白区域取消弹出的view
        SpaceViewController * space = [[SpaceViewController alloc] init];
        [self.navigationController pushViewController:space animated:YES];
    }
    else if(indexPath.section == 1){
    
        AnamotionViewController * anamotion = [[AnamotionViewController alloc] init];
        [self.navigationController pushViewController:anamotion animated:YES];
    }
    else if(indexPath.section == 2){
    
        PhotoViewController * photo = [[PhotoViewController alloc] init];
        [self.navigationController pushViewController:photo animated:YES];
    }
    else if(indexPath.section == 3){
    
        CameraViewController * camera = [[CameraViewController alloc] init];
        [self.navigationController pushViewController:camera animated:YES];
    }
    else if (indexPath.section == 4){
    
        AddressViewController * address = [[AddressViewController alloc] init];
        [self.navigationController pushViewController:address animated:YES];
    }
    else if (indexPath.section == 5){
        
        TestblockViewController * block = [[TestblockViewController alloc] init];
        [self.navigationController pushViewController:block animated:YES];
    }
    else if (indexPath.section == 6){
        
        ApplePayViewController * apay = [[ApplePayViewController alloc] init];
        [self.navigationController pushViewController:apay animated:YES];
    }
    else if (indexPath.section == 7){
        

    }
    else if (indexPath.section == 8){
        
        [self.navigationController pushViewController:[ImageslideViewController sharedImageslide] animated:YES];
    }
    else if (indexPath.section == 9){
        
        SQLiteViewController * sqlite = [[SQLiteViewController alloc] init];
        [self.navigationController pushViewController:sqlite animated:YES];
    }
    else if (indexPath.section == 10){
        myanimation * myanimationview = [[myanimation alloc] init];
        [self.navigationController pushViewController:myanimationview animated:YES];
    }
    else if (indexPath.section == 11){
        testFrameMasonryViewController * masonry = [[testFrameMasonryViewController alloc] init];
        [self.navigationController pushViewController:masonry animated:YES];
    }
    else if (indexPath.section == 12){
        MyUIPickerViewController * masonry = [[MyUIPickerViewController alloc] init];
        [self.navigationController pushViewController:masonry animated:YES];
    }

}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
