//
//  MyPickerView.m
//  MySelfTestDemo
//
//  Created by H H M on 16/7/7.
//  Copyright © 2016年 By. All rights reserved.
//

#import "MyPickerView.h"

@interface MyPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>{

    UIPickerView * myPickerView;
    UITextField *areaField;
}

@end

@implementation MyPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    CGFloat w = 150;
    self = [super initWithFrame:CGRectMake(0, ScreenHeigth-w, ScreenWidth, w)];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self makeUI];
    }
    return self;
}

- (void)makeUI{

    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height-10)];
    myPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    myPickerView.backgroundColor = [UIColor clearColor];
    myPickerView.alpha = 0.5;
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    [self addSubview:myPickerView];
    
    areaField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    areaField.inputView = myPickerView;
    areaField.tag = 0;
    areaField.backgroundColor = [UIColor clearColor];
    areaField.textAlignment = NSTextAlignmentLeft;
    areaField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    areaField.delegate = self;
    areaField.borderStyle = UITextBorderStyleNone;
//    [self addSubview:areaField];

}

#pragma mark -UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return @"";
        //        return [provinceNameArr objectAtIndex:row];
    }
    else if(component ==1){
        return @"分钟";
    }
    else if(component ==2){
        return @"3";
    }
    else
        return @"";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 12.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

@end
