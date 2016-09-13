//
//  AddressViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/1/21.
//  Copyright © 2016年 By. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressBook/AddressBook.h"
#import "AddressBookUI/AddressBookUI.h"
#import "Contacts/Contacts.h"
#import "ContactsUI/ContactsUI.h"
#import "pinyin.h"

@interface AddressViewController ()<CNContactPickerDelegate,CNContactViewControllerDelegate>{

    NSMutableArray *addressBookTemp;//用于存放通讯录信息的数组
    NSMutableArray * myphoneArr;      //用于存放通讯录电话号码
    
}

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self requestAddress];
}

- (void)requestAddress{
    
    //在工程中添加AddressBook.framework和AddressBookUI.framework
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 160, 40)];
    [btn setTitle:@"获取通讯录" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    
//    [btn addTarget:self action:@selector(clickold:) forControlEvents:UIControlEventTouchUpInside];//老的方法
    [btn addTarget:self action:@selector(clickNew:) forControlEvents:UIControlEventTouchUpInside];//新的方法

    [self.view addSubview:btn];
}

//新方法
- (void)clickNew:(UIButton *)btn{

    // CNContactStore * stroe = [[CNContactStore alloc] init];//需要的时候，查一下怎么用
    
    //取到系统通讯录，界面也取到了
    CNContactPickerViewController * con = [[CNContactPickerViewController alloc]init];
    con.delegate = self;   //如果想直接拨打电话，把代理注了就可以了******************************************************
    [self presentViewController:con animated:YES completion:nil];
    
//    CNContact * _Nonnull contact;
//    CNContactViewController * con = [CNContactViewController viewControllerForContact:contact];
//    [self presentViewController:con animated:YES completion:nil];
    
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{

    NSLog(@"通讯录代理走了");
}

#pragma mark CNContactViewController Delegate

//前边没有圆圈，只能选一个，点击后就返回，取值到界面
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    NSDictionary * daic = [[NSDictionary alloc] init];
    [daic objectForKey:@""];
    NSLog(@"contact == %@",contact.familyName);
    NSLog(@"phoneNumbers == %@",contact.phoneticFamilyName);
    NSLog(@"phoneNumbers == %@",contact.phoneticGivenName);
    NSLog(@"phoneNumbers == %@",contact.phoneticMiddleName);
    NSLog(@"phoneNumbers == %@",contact.phoneNumbers);
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{

    NSLog(@"contactProperty == %@",contactProperty);
}
//前边有圆圈选项，重重之中***************************************************************************************************
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{

    NSLog(@"contacts ===%lu",(unsigned long)contacts.count);
    NSLog(@"contacts ===%@",contacts);
    
    for (int i=0; i<contacts.count; i++){
        
        NSLog(@"familyName ==%@",[contacts objectAtIndex:i].familyName);
        NSLog(@"phoneNumbers==%@",[contacts objectAtIndex:i].phoneNumbers);
        NSLog(@"label==%@",[[contacts objectAtIndex:i].phoneNumbers objectAtIndex:0].label);
        NSLog(@"value==%@",[[contacts objectAtIndex:i].phoneNumbers objectAtIndex:0].value.stringValue); //取电话号码的地方
    }
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{

    NSLog(@"picker == %@",picker);
    NSLog(@"contactProperties ==%@",contactProperties);
}

//旧的方法获取通讯录
- (void)clickold:(UIButton *)btn{

    int __block tip = 0;
    ABAddressBookRef addBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] > 6.0) {
        addBook=ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
            if (!greanted) {
                tip=1;
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

    }
    else{
        //IOS6之前
        addBook =ABAddressBookCreate();
    }
    if (tip) {
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }

    NSMutableDictionary * dicton = nil;
    NSMutableArray * array = [[NSMutableArray alloc] init];
    myphoneArr = [[NSMutableArray alloc] init];
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    NSLog(@"number == %ld",number);
    for (NSInteger i=0; i<number; i++) {
        //获取姓名
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
//        NSLog(@"addressBook ==%@",firstName);
        NSString*lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        if (lastName !=nil) {
            [array addObject:lastName];
        }
        NSString * sequenceStr = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([lastName characterAtIndex:0])] uppercaseString];
//        NSLog(@"addressBook ==%@",sequenceStr);

        //获取电话号码
        NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
            [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
        }
        if (lastName != nil) {
            [myphoneArr addObject:phoneArr];

        }

    }
    
    //给获取到的电话号码排序
    for (int i=0; i<array.count-1; i++) {
        for (int j=i; j<array.count-1; j++) {
            
            NSString * sequenceStr = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([[array objectAtIndex:i] characterAtIndex:0])] uppercaseString];
            NSString * sequenceStrTwo = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([[array objectAtIndex:j+1] characterAtIndex:0])] uppercaseString];
            
            if (sequenceStr > sequenceStrTwo) {
                
                [array exchangeObjectAtIndex:i withObjectAtIndex:j+1];
                [myphoneArr exchangeObjectAtIndex:i withObjectAtIndex:j+1];
            }
        }
    }
    
    for (int i=0; i<array.count; i++) {
        NSLog(@"array === %@",[array objectAtIndex:i]);
        NSLog(@"arrayphone === %@",[myphoneArr objectAtIndex:i]);

    }
    CFRelease(addBook);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
