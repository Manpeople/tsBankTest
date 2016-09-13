//
//  MyDelegateViewController.h
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/5/17.
//  Copyright © 2016年 By. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDelegateViewControllerdelegate

- (void)receiveDataWithString:(NSString *)status;

@end

@interface MyDelegateViewController : UIViewController

@property (nonatomic, copy) NSString * status;

@property (nonatomic,assign) id<MyDelegateViewControllerdelegate>delegate;

@end
