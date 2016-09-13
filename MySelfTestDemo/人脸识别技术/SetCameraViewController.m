//
//  SetCameraViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/1/7.
//  Copyright © 2016年 By. All rights reserved.
//

#import "SetCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+FixOrientation.h"
#import <QuartzCore/QuartzCore.h>

//讯飞引入的头文件
#import "SBJsonParser.h"
#import "UIImage+fixOrientation.h"
#import "UIImage+compress.h"
#import "PermissionDetector.h"
#import "IFlyFace/IFlyFaceSDK.h"


#import <MobileCoreServices/UTCoreTypes.h>

@interface SetCameraViewController ()
<

AVCaptureAudioDataOutputSampleBufferDelegate,
IFlySpeechFaceRequestDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate,
UIPopoverControllerDelegate,
UIAlertViewDelegate

>{

    AVCaptureSession * _session;
    AVCaptureDeviceInput * _captureInput;
    AVCaptureStillImageOutput * _captureOutput;
    AVCaptureVideoPreviewLayer * _preview;
    AVCaptureDevice * _device;

    UIView* m_highlitView[100];
    CGAffineTransform m_transform[100];
    
    UIImage * _testImage;
    
    NSString * _stopString; //控制多线程停止的字符串标志
    UIImage *image;
    CVImageBufferRef imageBuffer;
    AVCaptureVideoDataOutput * captureOutput;
}

@property (nonatomic, retain) CALayer *customLayer;
@property (nonatomic,retain) UIView *cameraView;

@property (nonatomic,retain) IFlySpeechFaceRequest * iFlySpFaceRequest;

@end

@implementation SetCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _stopString = [NSString stringWithFormat:@"start"];
    [self makeCamera];
}

- (void)makeCamera{

    self.iFlySpFaceRequest=[IFlySpeechFaceRequest sharedInstance];
    [self.iFlySpFaceRequest setDelegate:self];

    self.cameraView = [[UIView alloc] initWithFrame:self.view.bounds]; //摄像机区域
    [self.view addSubview:self.cameraView];
    self.navigationController.navigationBarHidden = YES;
    
    [self makeButton];
    
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPreset640x480];

    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        //设置默认摄像头是后置摄像头还是前置摄像头AVCaptureDevicePositionFront 前置 AVCaptureDevicePositionBack后置
        if (device.position == AVCaptureDevicePositionFront)
        {
            _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        }
    }
    NSError * error;
    if (!_captureInput)
    {
        NSLog(@"Error: %@",error);
        return;
    }
    [_session addInput:_captureInput];
    
    ///out put
    captureOutput = [[AVCaptureVideoDataOutput alloc]
                                               init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    //captureOutput.minFrameDuration = CMTimeMake(1, 10);
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("cameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber
                       numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary
                                   dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    [_session addOutput:captureOutput];
    
    ///custom Layer
    self.customLayer = [CALayer layer];
    self.customLayer.frame = self.view.bounds;
    self.customLayer.transform = CATransform3DRotate(
                                                     CATransform3DIdentity, M_PI/2.0f, 0, 0, 1);
    self.customLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.view.layer addSublayer:self.customLayer];
    
    //3.创建、配置输出
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_captureOutput setOutputSettings:outputSettings];
    [_session addOutput:_captureOutput];
    
    ////////////
    _preview = [AVCaptureVideoPreviewLayer layerWithSession: _session];
    _preview.frame = CGRectMake(0, 0, self.cameraView.frame.size.width, self.cameraView.frame.size.height);
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.cameraView.layer addSublayer:_preview];
    [_session startRunning];
}

- (void)makeButton{

    UIButton * buttonclear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonclear.frame = CGRectMake((ScreenWidth-80)/2, ScreenHeigth-65-30, 80,80);
    [buttonclear setTitle:@"返回" forState:UIControlStateNormal];
    buttonclear.tag = 101;
    [buttonclear.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [buttonclear setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    buttonclear.layer.cornerRadius = buttonclear.frame.size.width/2.0f;
    buttonclear.layer.borderColor = [UIColor whiteColor].CGColor;
    buttonclear.layer.borderWidth = 2.0f;
    buttonclear.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    buttonclear.layer.rasterizationScale = [UIScreen mainScreen].scale;
    buttonclear.layer.shouldRasterize = YES;
    [buttonclear addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonclear];

    UIButton * FlipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FlipBtn.frame = CGRectMake(ScreenWidth-49-10,20, 29.0f + 20.0f, 22.0f + 20.0f);
    FlipBtn.tag = 102;
    [FlipBtn setImage:[UIImage imageNamed:@"camera-switch.png"] forState:UIControlStateNormal];
    FlipBtn.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [FlipBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FlipBtn];

}
- (void)click:(UIButton *)btn{

    if (btn.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(btn.tag == 102){
        //摄像头翻转
        NSArray *inputs = _session.inputs;
        for ( AVCaptureDeviceInput *input in inputs )
        {
            AVCaptureDevice *device = input.device;
            if ([device hasMediaType:AVMediaTypeVideo])
            {
                AVCaptureDevicePosition position = device.position;
                AVCaptureDevice *newCamera = nil;
                AVCaptureDeviceInput *newInput = nil;
                
                if (position == AVCaptureDevicePositionFront)
                {
                    newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
                }
                else
                {
                    newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
                }
                _device = newCamera;
                newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
                
                // beginConfiguration ensures that pending changes are not applied immediately
                [_session beginConfiguration];
                
                [_session removeInput:input];
                [_session addInput:newInput];
                
                // Changes take effect once the outermost commitConfiguration is invoked.
                [_session commitConfiguration];
                break;
            }
        }
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

//从摄像头缓冲区获取图像
#pragma mark -
#pragma mark AVCaptureSession delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    sleep(3);//必须停止一秒，否则由于运行太快，试的讯飞的人脸检测回调方法不走，无法进行注册及验证（这个其实和网络有关系，网络慢的话，一秒都不行）
    
        self.iFlySpFaceRequest.delegate = self;
        
        imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        CVPixelBufferLockBaseAddress(imageBuffer,0);
        uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef newContext = CGBitmapContextCreate(baseAddress,
                                                        width, height, 8, bytesPerRow, colorSpace,
                                                        kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        CGImageRef newImage = CGBitmapContextCreateImage(newContext);
        
        CGContextRelease(newContext);
        CGColorSpaceRelease(colorSpace);

    if ([self.iFlySpFaceRequest.delegate respondsToSelector:@selector(onData:)]) {
        NSLog(@"代理响应了‘’‘");
    }
    else{
    
        NSLog(@"代理没响应‘’‘");
    }
    
        image= [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationLeftMirrored];
        
        CGImageRelease(newImage);
        CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    

    image = [image fixOrientation];//图像反转
    if ([_stopString isEqualToString:@"stop"]) {
        NSLog(@"停止了");
    }
    else {
        //注册人脸
//        [self performSelectorOnMainThread:@selector(detectForFacesInUIImage:)
//                                withObject: (id)image waitUntilDone:NO];
        //验证人脸
        [self performSelectorOnMainThread:@selector(verifyForFacesInUIImage:)
                               withObject: (id)image waitUntilDone:NO];
    }
}

//人脸验证
- (void)verifyForFacesInUIImage:(UIImage *)faceImage{

    self.iFlySpFaceRequest = [IFlySpeechFaceRequest sharedInstance];
    self.iFlySpFaceRequest.delegate = self;
    [self.iFlySpFaceRequest setParameter:[IFlyFaceConstant VERIFY] forKey:[IFlyFaceConstant SST]];
    [self.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlyFaceConstant APPID]];
    
    //auth_id 用于第三方跟用户关联，由第三方传入和管理
    [self.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlyFaceConstant AUTH_ID]];
    
    //若第三方未传入auth_id 则需要传入gid 来验证
    
    //    NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
    //    NSString* gid=[userDefaults objectForKey:@"gid"];
    //    [self.iFlySpFaceRequest setParameter:gid forKey:[IFlyFaceConstant GID]];
    
    [self.iFlySpFaceRequest setParameter:@"2000" forKey:@"wait_time"];
    NSData * imgData=UIImageJPEGRepresentation(faceImage,0.0001 );
    NSLog(@"verify image data length: %lu",(unsigned long)[imgData length]);
    [self.iFlySpFaceRequest sendRequest:imgData];

}

- (void)viewWillDisappear:(BOOL)animated{

//    [self performSelector:@selector(detectForFacesInUIImage:) withObject:nil afterDelay:0.2];
}
/////人脸识别注册
-(void)detectForFacesInUIImage:(UIImage *)faceImage
{
//    NSData * data = [NSData data]
    self.iFlySpFaceRequest = [IFlySpeechFaceRequest sharedInstance];
    self.iFlySpFaceRequest.delegate = self;
    [self.iFlySpFaceRequest setParameter:[IFlyFaceConstant REG] forKey:[IFlyFaceConstant SST]];

    [self.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlyFaceConstant APPID]];
    
    //auth_id 用于第三方跟用户关联，由第三方传入
    //第三方管理 auth_id 和 用户的关联关系
    //这里传入appid 只作为示例
    [self.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlyFaceConstant AUTH_ID]];
    //设置属性为del可以删除已注册的模型重新注册
    [self.iFlySpFaceRequest setParameter:[IFlyFaceConstant DEL] forKey:[IFlyFaceConstant PROPERTY]];
    
    NSData* imgData=UIImageJPEGRepresentation(faceImage,0.0001 );
    NSLog(@"reg image data length: %lu",(unsigned long)[imgData length]);
    [self.iFlySpFaceRequest sendRequest:imgData];
}

/**
 * 消息回调
 * @param eventType 消息类型
 * @param params 消息数据对象
 */
- (void) onEvent:(int) eventType WithBundle:(NSString*) params{
    NSLog(@"onEvent | params:%@",params);
}

/**
 * 数据回调，可能调用多次，也可能一次不调用
 * @param buffer 服务端返回的二进制数据
 */

- (void) onData:(NSData* )data{

    NSLog(@"讯飞人脸识别回调走了");
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"result:%@",result);

    SBJsonParser * jsonParser=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonParser objectWithString:result];
    
    if(dic){
        
        int ret=[[dic objectForKey:@"ret"] intValue];
        if(ret){
            NSString *resultInfo = @"";
            resultInfo=[resultInfo stringByAppendingFormat:@"发生错误\n错误码：%d",ret];
            _stopString = [NSString stringWithFormat:@"stop"];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:resultInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 202;
            [alert show];
            return;
        }
        
        NSString* strSessionType=[dic objectForKey:@"sst"];
        
        //注册
        if([strSessionType isEqualToString:@"reg"]){
            [self praseRegResult:result];
        }
        
        //验证
        if([strSessionType isEqualToString:@"verify"]){
            [self praseVerifyResult:result];
        }
//
//        //检测
//        if([strSessionType isEqualToString:@"detect"]){
//            [self praseDetectResult:result];
//        }
//        
//        //关键点
//        if([strSessionType isEqualToString:@"align"]){
//            [self praseAlignResult:result];
//        }
        
    }

}
//注册
-(void)praseRegResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    SBJsonParser * jsonParser=[[SBJsonParser alloc] init];
    
    @try {
        NSDictionary* dic=[jsonParser objectWithString:result];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:@"sst"];
            
            //注册
            if([strSessionType isEqualToString:@"reg"]){
                NSString* rst=[dic objectForKey:@"rst"];
                NSString* ret=[dic objectForKey:@"ret"];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"注册错误\n错误码：%@",ret];
                }else{
                    if(rst && [rst isEqualToString:@"success"]){
                        NSString* gid=[dic objectForKey:@"gid"];
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n注册成功！"];
                        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                        [defaults setObject:gid forKey:@"gid"];
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"gid:%@",gid];
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n注册失败！"];
                    }
                }
            }
            _stopString = [NSString stringWithFormat:@"stop"];
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:resultInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 201;
            [alert show];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
}

//验证

-(void)praseVerifyResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    SBJsonParser * jsonParser=[[SBJsonParser alloc] init];
    
    @try {
        NSDictionary* dic=[jsonParser objectWithString:result];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:@"sst"];
            
            if([strSessionType isEqualToString:@"verify"]){
                NSString* rst=[dic objectForKey:@"rst"];
                NSString* sid=[dic objectForKey:@"sid"];
                NSString* ret=[dic objectForKey:@"ret"];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"验证错误\n错误码：%@",ret];
                }else{
                    
                    if([rst isEqualToString:@"success"]){
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n"];
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n"];
                    }
                    NSString* verf=[dic objectForKey:@"verf"];
                    NSString* score=[dic objectForKey:@"score"];
                    if([verf boolValue]){
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"score:%@\n",score];
                        resultInfo=[resultInfo stringByAppendingString:@"验证结果:验证成功!"];
                    }else{
                        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
                        NSString* gid=[defaults objectForKey:@"gid"];
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"last reg gid:%@\n \n sid:%@",gid,sid];
                        resultInfo=[resultInfo stringByAppendingString:@"验证结果:验证失败!"];
                    }
                }
                
            }
            
            if([resultInfo length]<1){
                resultInfo=@"结果异常";
            }
            _stopString = [NSString stringWithFormat:@"stop"];

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:resultInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 203;
            [alert show];
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 201) {
        //注册成功
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(alertView.tag == 202){
    //发生了错误
        _stopString = [NSString stringWithFormat:@"start"];
    }
    else if(alertView.tag == 203){
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
