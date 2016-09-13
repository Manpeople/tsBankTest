//
//  AnamotionViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 15/12/10.
//  Copyright © 2015年 By. All rights reserved.
//

#import "AnamotionViewController.h"
#import "LewPopupViewController.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"

@interface AnamotionViewController (){

    UIView * _outView;
}

@end

@implementation AnamotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self makeAnamotion];
}

- (void)makeAnamotion{

    NSArray * array = [NSArray arrayWithObjects:@"淡出",@"上来下出",@"炫酷",@"下来下出", nil];
    NSArray * arrayView = [NSArray arrayWithObjects:@"淡出",@"下出",@"炫酷",@"下出",@"下出", nil];
    
    for (int i=0; i<4; i++) {
        
        UIButton * btn = [[UIButton alloc] init];

        [btn setFrame:CGRectMake(40, 100+i*60, ScreenWidth-40*2, 40)];
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        btn.tag = 100+i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    _outView = [[UIView alloc] initWithFrame:CGRectMake(40, 100, ScreenWidth-40*2, ScreenHeigth-2*100)];
    [_outView setBackgroundColor:[UIColor redColor]];
    
    for (int i=0; i<arrayView.count; i++) {
        
        UIButton * btn = [[UIButton alloc] init];
        
        [btn setFrame:CGRectMake(40, 100+i*60, _outView.frame.size.width-40*2, 40)];
        [btn setTitle:[arrayView objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        btn.tag = 200+i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
        [_outView addSubview:btn];
    }
}

- (void)click:(UIButton *)btn{
    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
    animation.type = LewPopupViewAnimationSlideTypeBottomBottom;

    switch (btn.tag) {
        case 100:
            
            [self lew_presentPopupView:_outView animation:[LewPopupViewAnimationFade new] dismissed:^{
                NSLog(@"动画开始");
            }];
            break;
        case 101:
            [self lew_presentPopupView:_outView animation:animation dismissed:^{
                NSLog(@"动画结束");
            }];
            break;
        case 102:
            [self lew_presentPopupView:_outView animation:[LewPopupViewAnimationSpring new] dismissed:^{
                NSLog(@"动画结束");
            }];
            break;
        case 103:
            [self lew_presentPopupView:_outView animation:[LewPopupViewAnimationDrop new] dismissed:^{
                NSLog(@"动画结束");
            }];
            break;
        default:
            break;
    }
}

- (void)clickView:(UIButton *)btn{
    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
    animation.type = LewPopupViewAnimationSlideTypeTopBottom;

    switch (btn.tag) {
        case 200:
            
            [self lew_dismissPopupView];
            break;
        case 201:
            [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationFade new]];
            break;
        case 202:
            [self lew_dismissPopupViewWithanimation:animation];
            break;
        case 203:
            [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
            break;
        case 204:
            [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
