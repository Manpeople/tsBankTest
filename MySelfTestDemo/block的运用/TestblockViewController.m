//
//  TestblockViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/1/28.
//  Copyright © 2016年 By. All rights reserved.
//

#import "TestblockViewController.h"
#import "DataViewController.h"
#import "MyDelegateViewController.h"

@interface TestblockViewController ()<MyDelegateViewControllerdelegate>

@property (nonatomic,strong) UILabel * lable;
@end

@implementation TestblockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    int num1 =4;
    int(^ablock)(int) = ^(int num2){
        
        return num1 +num2;
    };
    NSLog(@"%d",ablock(3));
    
    char * myCharacter[3] = {"Tom","Jimo","Apple"};
    qsort_b(myCharacter, 3, sizeof(char *), ^int(const void *l, const void *r) {
        char * left = *(char **)l;
        char * right = *(char **)r;
        return  strncasecmp(left, right, 1);
    });
    
    //前边加上__block之后里边东西才可以改
    __block int multiplier = 7 ;
    int(^myBlcik)(int) = ^(int num){
    
        if(num > 5){
        
            multiplier = 17;
        }
        else{
        
            multiplier = 7;
        }
        return multiplier + num;
    };
    NSLog(@"%d",myBlcik(6));
    
    self.lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
    [self.lable setBackgroundColor:[UIColor grayColor]];
    [self.lable setTextColor:[UIColor redColor]];
    [self.view addSubview:self.lable];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 100, 50)];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.tag = 0;
    [btn setTitle:@"Nextblock" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btndelegate = [[UIButton alloc] initWithFrame:CGRectMake(50,400, 100, 50)];
    [btndelegate setBackgroundColor:[UIColor grayColor]];
    btndelegate.tag = 1;
    [btndelegate setTitle:@"Nextdelegate" forState:UIControlStateNormal];
    [btndelegate addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btndelegate];
}

- (void)click:(UIButton *)btn{

    if (btn.tag == 0) {
        DataViewController * dataView = [[DataViewController alloc] init];
        [self.navigationController pushViewController:dataView animated:YES];
        dataView.myBlock = ^(NSString * str){
            
            self.lable.text = str;
        };

    }
    else{
    
        MyDelegateViewController * mydelegate = [[MyDelegateViewController alloc] init];
        mydelegate.delegate = self;
        [self.navigationController pushViewController:mydelegate animated:YES];
    }
}

- (void)receiveDataWithString:(NSString *)status {
    
    [self.lable setText:status];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
