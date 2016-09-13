//
//  SpaceViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 15/12/10.
//  Copyright © 2015年 By. All rights reserved.
//

#import "SpaceViewController.h"
#import "UIView+MLInputDodger.h"

@interface SpaceViewController ()<UITextFieldDelegate>{

    UITextField * textView;
    UITextField * textField2;
    UIView * outView;
}

@end

@implementation SpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 100, 40)];
    [btn setTitle:@"outView" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    textView = [[UITextField alloc] initWithFrame:CGRectMake(40, 150, 200, 40)];
    textView.delegate = self;
    textView.tag = 1;
    textView.layer.cornerRadius = 8.0f;   //控制uitextfield四角的弧度
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = [[UIColor redColor] CGColor];  //边框的颜色
    textView.layer.borderWidth = 1.0f;    //边框的宽度
    [textView setKeyboardType:UIKeyboardTypeNumberPad];
    textView.returnKeyType = UIReturnKeyDefault;   //右下角按钮
    [self.view addSubview:textView];
    
    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(40, 200, 100, 40)];
    textField2.tag = 2;
    textField2.layer.cornerRadius = 8.0f;
    textField2.layer.masksToBounds = YES;
    textField2.layer.borderWidth = 1.0f;
    textField2.layer.borderColor = [[UIColor greenColor] CGColor];
    [textField2 setKeyboardType:UIKeyboardTypeASCIICapable];
    textField2.delegate = self;
    [self.view addSubview:textField2];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (textField.tag == 1) {
        
        self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;  //键盘的地方
        [self.view registerAsDodgeViewForMLInputDodger];           //
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    return YES;
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [textView resignFirstResponder];
    [textField2 resignFirstResponder];
    [outView removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
//弹出View

- (void)click:(UIButton *)btn{
    
    outView = [[UIView alloc] initWithFrame:CGRectMake(40, 40, ScreenWidth-2*40, ScreenHeigth-2*40)];
    [outView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:outView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
