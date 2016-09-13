//
//  ImageViewController.m
//  LLSimpleCameraExample
//
//  Created by Ömer Faruk Gül on 15/11/14.
//  Copyright (c) 2014 Ömer Faruk Gül. All rights reserved.
//

#import "ImageViewController.h"
#import "ViewUtils.h"
#import "UIImage+Crop.h"

#import "PhotoViewController.h"

@interface ImageViewController ()
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation ImageViewController

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        self.image = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.backgroundColor = [UIColor yellowColor];
    
    //self.image = [self.image crop:CGRectMake(0, 0, self.image.size.width, self.image.size.width)];
    
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.imageView];
    
    NSString *info = [NSString stringWithFormat:@"Size: %@, orientation: %d", NSStringFromCGSize(self.image.size), self.image.imageOrientation];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.infoLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    self.infoLabel.textColor = [UIColor whiteColor];
    self.infoLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:13];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    self.infoLabel.text = info;
    [self.view addSubview:self.infoLabel];
    
    UIButton * selectIgeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectIgeBtn.tag = 120;
    selectIgeBtn.frame = CGRectMake(ScreenWidth-100, ScreenHeigth-60, 80, 40);
    [selectIgeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [selectIgeBtn setTitle:@"选择" forState:UIControlStateNormal];
    [selectIgeBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    selectIgeBtn.layer.borderWidth = 2.0f;
    selectIgeBtn.layer.cornerRadius = 10.0f;
    selectIgeBtn.layer.borderColor = [UIColor yellowColor].CGColor;
    [selectIgeBtn setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
    [selectIgeBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearBtn.tag = 121;
    clearBtn.frame = CGRectMake(20, ScreenHeigth-60, 80, 40);
    [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clearBtn setTitle:@"重拍" forState:UIControlStateNormal];
    [clearBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    clearBtn.layer.borderWidth = 2.0f;
    clearBtn.layer.cornerRadius = 10.0f;
    clearBtn.layer.borderColor = [UIColor yellowColor].CGColor;
    [clearBtn setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
    [clearBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:clearBtn];
    [self.view addSubview:selectIgeBtn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)click:(UIButton *)btn{

    if (btn.tag == 120) {
        
        PhotoViewController * photo = [[PhotoViewController alloc] initWithImage:self.image];
        
        [self.imageView removeFromSuperview];
        UIImageView * image = [[UIImageView alloc] initWithImage:self.image];
        image.frame = CGRectMake(20, 200, 300, 300);
        [image setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:image];

//        [self.navigationController popToViewController:photo animated:YES];
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[PhotoViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }

    }
    else if(btn.tag == 121){
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewTapped:(UIGestureRecognizer *)gesture {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.imageView.frame = self.view.contentBounds;
    
    [self.infoLabel sizeToFit];
    self.infoLabel.width = self.view.contentBounds.size.width;
    self.infoLabel.top = 0;
    self.infoLabel.left = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
