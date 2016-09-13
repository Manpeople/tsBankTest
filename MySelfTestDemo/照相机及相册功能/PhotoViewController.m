//
//  PhotoViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 15/12/24.
//  Copyright © 2015年 By. All rights reserved.
//

#import "PhotoViewController.h"
#import "HomeViewController.h"

@interface PhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UIImageView * _image;
    UIImageView * _image22;
}

@property(nonatomic,strong) UIImage * uiimage;
@end

@implementation PhotoViewController

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        self.uiimage = image;
        
        NSLog(@"self.uiimage == %@",self.uiimage);
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makePhoto];
    [self makeCamera];
}

- (void)makeCamera{

    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 160, 200, 40)];
    [btn setTitle:@"相机拍照" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.tag = 102;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)makePhoto{

    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 40)];
    [btn setTitle:@"从相册选图片" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.tag = 101;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 220, ScreenWidth, 400)];
    [_image setImage:self.uiimage];
    NSLog(@"_image == %@",_image);

    [_image setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:_image];
}

- (void)click:(UIButton *)btn{

    if (btn.tag == 101) {
        //手机相册获取照片
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"picture"];
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        
        /*  获取设计摄像头最简单的方法
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
//            picker.mediaTypes = temp_MediaTypes;
            picker.delegate = self;
            picker.allowsImageEditing = YES; 
        }
         */
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentModalViewController:picker animated:YES];
    }
    else if(btn.tag == 102){
        //照相机获取拍摄的图片
        HomeViewController * home = [[HomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
    }
}

#pragma mark UIImagePickerController Delegate
//从手机相册获取图片后的回调方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

//    id<NSFastEnumeration> results = [_image setImage:[[info objectForKey:@"UIImagePickerControllerEditedImage"] CGImage]];
    [_image setImage:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"picture"] != nil) {
        
        self.uiimage = [[UIImage alloc] initWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"picture"]];
        [_image setImage:self.uiimage];
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
