//
//  myanimation.m
//  MySelfTestDemo
//
//  Created by H H M on 16/6/12.
//  Copyright © 2016年 By. All rights reserved.
//

#import "myanimation.h"

@interface myanimation (){

    UIImageView * _imageView;
}

@end

@implementation myanimation

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self maketest66];
}

- (void)maketest66{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 200, 50)];
    [_imageView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_imageView];
    
    [button setTitle:@"改变" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor grayColor]];
    button.frame = CGRectMake(10, 200, 60, 40);
    [button addTarget:self action:@selector(changeUIView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)changeUIView{
    
    //翻页的各种效果
    //    [UIView beginAnimations:@"animation" context:nil];
    //    [UIView setAnimationDuration:1.0f];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    //    [UIView commitAnimations];
    
    //    有震动效果
    [UIView animateWithDuration:4.0 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:1.0 // 类似弹簧振动效果 0~1
          initialSpringVelocity:5.0 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         // code...
                         CGPoint point = _imageView.center;
                         point.y += 150;
                         [_imageView setCenter:point];
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         [_imageView setAlpha:1];
                     }];
    
    //无震动效果
    //    [UIView animateWithDuration:1.5 // 动画时长
    //                          delay:0.0 // 动画延迟
    //                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
    //                     animations:^{
    //                         // code...
    //                         CGPoint point = _imageView.center;
    //                         point.y += 150;
    //                         [_imageView setCenter:point];
    //
    //                     }
    //                     completion:^(BOOL finished) {
    //                         // 动画完成后执行
    //                         // code...
    //                         [_imageView setAlpha:1];
    //
    //                     }];
    
    //这是一个CAKeyframeAnimation
    //    void (^keyFrameBlock)() = ^(){
    //        // 创建颜色数组
    //        NSArray *arrayColors = @[[UIColor orangeColor],
    //                                 [UIColor yellowColor],
    //                                 [UIColor greenColor],
    //                                 [UIColor blueColor],
    //                                 [UIColor purpleColor],
    //                                 [UIColor redColor]];
    //        NSUInteger colorCount = [arrayColors count];
    //        // 循环添加关键帧
    //        for (NSUInteger i = 0; i < colorCount; i++) {
    //            [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
    //                                    relativeDuration:1 / (CGFloat)colorCount
    //                                          animations:^{
    //                                              [_imageView setBackgroundColor:arrayColors[i]];
    //                                          }];
    //        }
    //    };
    //    [UIView animateKeyframesWithDuration:4.0
    //                                   delay:0.0
    //                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveLinear
    //                              animations:keyFrameBlock
    //                              completion:^(BOOL finished) {
    //                                  // 动画完成后执行
    //                                  // code...
    //                                  [self changeUIView];
    //                              }];
    
    //创建一个CABasicAnimation对象
    
    //    CABasicAnimation *animation=[CABasicAnimation animation];
    //    //设置颜色
    //    animation.toValue=(id)[UIColor blueColor].CGColor;
    //    //动画时间
    //    animation.duration=1;
    //    //是否反转变为原来的属性值
    //    animation.autoreverses=YES;
    //    //把animation添加到图层的layer中，便可以播放动画了。forKey指定要应用此动画的属性
    //    [self.view.layer addAnimation:animation forKey:@"backgroundColor"];
    
    
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 20, 20)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
    //初始化路径
    CGMutablePathRef aPath=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(aPath, nil, 100, 100);
    CGPathAddCurveToPoint(aPath, nil,
                          160, 30,//控制点
                          220, 220,//控制点
                          240, 380);//控制点
    
    ani.path=aPath;
    ani.duration=3;
    //设置为渐出
    ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    ani.rotationMode=@"auto";
    
    [redView.layer addAnimation:ani forKey:@"position"];
}

- (void)maketest55{
    
    UIProgressView * progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width-20, 200)];
    [progressView setProgressViewStyle:UIProgressViewStyleBar];
    [progressView setProgress:0.5];
    [progressView setProgressTintColor:[UIColor redColor]];
    [progressView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:progressView];
    
    NSMutableArray * dataArray = [NSMutableArray arrayWithObjects:@"67",@"89",@"87",@"69",@"90",@"100",@"75",@"98", nil];
    
    for (int i=0; i<dataArray.count-1; i++) {
        for (int j=i; j<dataArray.count-1; j++) {
            
            if ([[dataArray objectAtIndex:i] intValue] > [[dataArray objectAtIndex:j+1] intValue]) {
                [dataArray exchangeObjectAtIndex:i withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"array22 == %@",dataArray);
    
    for (int i = 0; i<10; ++i) {
        NSString * str = @"abc";
        str = [str lowercaseString];
        str = [str stringByAppendingString:@"xyz"];
        NSLog(@"%@",str);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
