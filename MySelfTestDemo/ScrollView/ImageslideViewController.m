//
//  ImageslideViewController.m
//  MySelfTestDemo
//
//  Created by 郭云峰 on 16/5/17.
//  Copyright © 2016年 By. All rights reserved.
//

#import "ImageslideViewController.h"

#define HEIGHTVIEW 200

@interface ImageslideViewController ()<UIScrollViewDelegate>{

    UIPageControl * _pagecontrol;
    UIScrollView *_scroll;
    NSTimer *_timer;
    int _currentPage;//当前页
    NSArray * _array;
    
    UIImageView * _leftImageView;  //左视图
    UIImageView * _centerImageView;//中间视图
    UIImageView * _rightImageView; //右视图
}

@end

static ImageslideViewController * imageslide;

@implementation ImageslideViewController

+ (ImageslideViewController *) sharedImageslide{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        imageslide = [[self alloc] init];
    });
    
    return imageslide;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self makeView];
}

- (void)makeView{
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollImage) userInfo:nil repeats:YES];
    
    _array = [NSArray arrayWithObjects:@"11",@"12",@"13",nil];

    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HEIGHTVIEW)];
    [_scroll setPagingEnabled:YES];
    _scroll.showsHorizontalScrollIndicator = NO;
    [_scroll setBackgroundColor:[UIColor grayColor]];
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
//    for (int i=0; i<_array.count ; i++) {
//        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*w, 0, w, 200)];
//        [imageView setContentMode:UIViewContentModeScaleToFill];
//        [imageView setImage:[UIImage imageNamed:[_array objectAtIndex:i]]];
//        [_scroll addSubview:imageView];
//    }

    _pagecontrol = [[UIPageControl alloc] init];
    _pagecontrol.frame = CGRectMake(_scroll.frame.size.width/2, _scroll.frame.size.height+_scroll.frame.origin.y-20,
                                    100, 20);
    _pagecontrol.numberOfPages = _array.count;
    _pagecontrol.pageIndicatorTintColor = [UIColor redColor];
    _pagecontrol.currentPageIndicatorTintColor = [UIColor greenColor];
    _pagecontrol.enabled = YES;
    //    _pagecontrol.currentPage = 0; 默认当前指定第一页  0
    [self.view addSubview:_pagecontrol];
    
    _scroll.contentSize = CGSizeMake(_array.count*ScreenWidth, 0);
    _currentPage = 0;

    [self initImageView];
}

- (void)initImageView {
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, HEIGHTVIEW)];
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth, 0,ScreenWidth, HEIGHTVIEW)];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 2, 0,ScreenWidth, HEIGHTVIEW)];
    
    [_scroll addSubview:_leftImageView];
    [_scroll addSubview:_centerImageView];
    [_scroll addSubview:_rightImageView];
    
    [self changeImageLeft:_array.count-1 center:0 right:1];

}

- (void)changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex
{
    [_leftImageView setImage:[UIImage imageNamed:[_array objectAtIndex:LeftIndex]]];
    [_centerImageView setImage:[UIImage imageNamed:[_array objectAtIndex:centerIndex]]];
    [_rightImageView setImage:[UIImage imageNamed:[_array objectAtIndex:rightIndex]]];

    [_scroll setContentOffset:CGPointMake(ScreenWidth, 0)];
}

#pragma mark - 给复用的imageView赋值

- (void)autoScrollImage
{
    [_scroll setContentOffset:CGPointMake(_scroll.contentOffset.x +ScreenWidth, 0) animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_timer) {
        [_timer invalidate];//销毁定时器
        _timer = nil;
    }
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)changeImageWithOffset:(CGFloat)offsetX
{
    if (offsetX >= ScreenWidth * 2)
    {
        _currentPage++;
        
        if (_currentPage == _array.count-1)
        {
            [self changeImageLeft:_currentPage-1 center:_currentPage right:0];
            
        }else if (_currentPage == _array.count)
        {
            
            _currentPage = 0;
            
            [self changeImageLeft:_array.count-1 center:0 right:1];
            
        }else
        {
            [self changeImageLeft:_currentPage-1 center:_currentPage right:_currentPage+1];
        }
        _pagecontrol.currentPage = _currentPage;
        
    }
    
    if (offsetX <= 0)
    {
        _currentPage--;
        
        if (_currentPage == 0) {
            
            [self changeImageLeft:_array.count-1 center:0 right:1];
            
        }else if (_currentPage == -1) {
            
            _currentPage = (int)_array.count-1;
            [self changeImageLeft:_currentPage-1 center:_currentPage right:0];
            
        }else {
            [self changeImageLeft:_currentPage-1 center:_currentPage right:_currentPage+1];
        }
        
        _pagecontrol.currentPage = _currentPage;
    }
}

#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //开始滚动，判断位置，然后替换复用的三张图
    [self changeImageWithOffset:scrollView.contentOffset.x];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];//
        _timer = nil;
        NSLog(@"开始了");

    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollImage) userInfo:nil repeats:YES];
        NSLog(@"结束了");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
