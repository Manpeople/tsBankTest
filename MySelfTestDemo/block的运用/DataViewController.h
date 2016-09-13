//
//  DataViewController.h
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/1/28.
//  Copyright © 2016年 By. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ablock)(NSString *str);

@interface DataViewController : UIViewController

@property (nonatomic,copy) ablock myBlock;

@end
