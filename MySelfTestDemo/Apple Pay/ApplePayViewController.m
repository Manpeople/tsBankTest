//
//  ApplePayViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/2/22. PKPaymentAuthorizationViewController
//  Copyright © 2016年 By. All rights reserved.
//

#import "ApplePayViewController.h"
#import <PassKit/PassKit.h>


@interface ApplePayViewController ()<PKPaymentAuthorizationViewControllerDelegate>

@end

@implementation ApplePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(60, 200, 200, 50);
    btn.center = self.view.center;
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setBackgroundImage:[UIImage imageNamed:@"ApplePayBTN_64pt__whiteLine_textLogo_"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(ApplePay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

#pragma mark ----开始支付
- (void)ApplePay{
    if([PKPaymentAuthorizationViewController canMakePayments]) {
        
        NSLog(@"支持支付");
        
        PKPaymentRequest *request = [[PKPaymentRequest alloc] init];
        
        PKPaymentSummaryItem *widget1 = [PKPaymentSummaryItem summaryItemWithLabel:@"鸡蛋"
                                                                            amount:[NSDecimalNumber decimalNumberWithString:@"0.99"]];
        
        PKPaymentSummaryItem *widget2 = [PKPaymentSummaryItem summaryItemWithLabel:@"苹果"
                                                                            amount:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
        
        PKPaymentSummaryItem *widget3 = [PKPaymentSummaryItem summaryItemWithLabel:@"2个苹果"
                                                                            amount:[NSDecimalNumber decimalNumberWithString:@"2.00"]];
        
        PKPaymentSummaryItem *widget4 = [PKPaymentSummaryItem summaryItemWithLabel:@"总金额" amount:[NSDecimalNumber decimalNumberWithString:@"3.99"] type:PKPaymentSummaryItemTypeFinal];
        
        request.paymentSummaryItems = @[widget1, widget2, widget3, widget4];
        
        request.countryCode = @"CN";
        request.currencyCode = @"CHW";
        //此属性限制支付卡，可以支付。PKPaymentNetworkChinaUnionPay支持中国的卡 9.2增加的
        request.supportedNetworks = @[PKPaymentNetworkChinaUnionPay, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
        request.merchantIdentifier = @"merchant.testoneone";
        /*
         PKMerchantCapabilityCredit NS_ENUM_AVAILABLE_IOS(9_0)   = 1UL << 2,   // 支持信用卡
         PKMerchantCapabilityDebit  NS_ENUM_AVAILABLE_IOS(9_0)   = 1UL << 3    // 支持借记卡
         */
        request.merchantCapabilities = PKMerchantCapabilityCredit;
        //增加邮箱及地址信息
        request.requiredBillingAddressFields = PKAddressFieldEmail | PKAddressFieldPostalAddress;
        PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        paymentPane.delegate = self;
        
        
        if (!paymentPane) {
            
            NSLog(@"出问题了");
        }
        
        [self presentViewController:paymentPane animated:YES completion:nil];
        
        
    } else {
        NSLog(@"该设备不支持支付");
    }
    
}

#pragma mark ----支付状态
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    NSLog(@"Payment was authorized: %@", payment);
    
    BOOL asyncSuccessful = FALSE;
    if(asyncSuccessful) {
        completion(PKPaymentAuthorizationStatusSuccess);
        
        // do something to let the user know the status
        
        NSLog(@"支付成功");
        
    } else {
        completion(PKPaymentAuthorizationStatusFailure);
        
        // do something to let the user know the status
        NSLog(@"支付失败");
        
    }
    
}

#pragma mark ----支付完成
- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    
    [controller dismissViewControllerAnimated:TRUE completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
