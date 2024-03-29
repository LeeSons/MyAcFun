//
//  AdScrollView.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdScrollView.h"

#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标

static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1

@interface AdScrollView ()

{
    //广告的label
    UILabel * _adLabel;
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语(可选)
    UILabel * _leftAdLabel;
    UILabel * _centerAdLabel;
    UILabel * _rightAdLabel;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation AdScrollView

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_rightImageView];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
    }
    return self;
}

#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageNameArray:(NSArray *)imageNameArray
{
    _imageNameArray = imageNameArray;
    // 网络加载图片
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[0]]];
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[1]]];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[2]]];
}

#pragma mark - 设置每个对应广告对应的广告语
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle
{
    _adTitleArray = adTitleArray;
    
    if(adTitleStyle == AdTitleShowStyleNone)
    {
        return;
    }
    
    // 清空子视图，避免因复用导致lable重复的问题
    if ([[_leftImageView subviews] count] > 0) {
        NSArray *array = [_leftImageView subviews];
        NSUInteger n = array.count;
        for (int i = 0; i < n; i++) {
            [array[i] removeFromSuperview];
        }
    }
    if ([[_centerImageView subviews] count] > 0) {
        NSArray *array = [_centerImageView subviews];
        NSUInteger n = array.count;
        for (int i = 0; i < n; i++) {
            [array[i] removeFromSuperview];
        }
    }
    if ([[_rightImageView subviews] count] > 0) {
        NSArray *array = [_rightImageView subviews];
        NSUInteger n = array.count;
        for (int i = 0; i < n; i++) {
            [array[i] removeFromSuperview];
        }
    }
    
    _leftAdLabel = [[UILabel alloc]init];
    _centerAdLabel = [[UILabel alloc]init];
    _rightAdLabel = [[UILabel alloc]init];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, UISCREENHEIGHT - 40, UISCREENWIDTH, 30)];
    leftView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UIView *center = [[UIView alloc] initWithFrame:CGRectMake(0, UISCREENHEIGHT - 40, UISCREENWIDTH, 30)];
    center.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UIView *right = [[UIView alloc] initWithFrame:CGRectMake(0, UISCREENHEIGHT - 40, UISCREENWIDTH, 30)];
    right.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _leftAdLabel.frame = CGRectMake(10, 5, UISCREENWIDTH, 20);
    _leftAdLabel.textColor = [UIColor whiteColor];
    [leftView addSubview:_leftAdLabel];
    [_leftImageView addSubview:leftView];
    _centerAdLabel.frame = CGRectMake(10, 5, UISCREENWIDTH, 20);
    _centerAdLabel.textColor = [UIColor whiteColor];
    [center addSubview:_centerAdLabel];
    [_centerImageView addSubview:center];
    _rightAdLabel.frame = CGRectMake(10, 5, UISCREENWIDTH, 20);
    _rightAdLabel.textColor = [UIColor whiteColor];
    [right addSubview:_rightAdLabel];
    [_rightImageView addSubview:right];
    
    if (adTitleStyle == AdTitleShowStyleLeft) {
        _leftAdLabel.textAlignment = NSTextAlignmentLeft;
        _centerAdLabel.textAlignment = NSTextAlignmentLeft;
        _rightAdLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (adTitleStyle == AdTitleShowStyleCenter)
    {
        _leftAdLabel.textAlignment = NSTextAlignmentCenter;
        _centerAdLabel.textAlignment = NSTextAlignmentCenter;
        _rightAdLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        _leftAdLabel.textAlignment = NSTextAlignmentRight;
        _centerAdLabel.textAlignment = NSTextAlignmentRight;
        _rightAdLabel.textAlignment = NSTextAlignmentRight;
    }
    
    
    _leftAdLabel.text = _adTitleArray[0];
    _centerAdLabel.text = _adTitleArray[1];
    _rightAdLabel.text = _adTitleArray[2];
    
}


#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageNameArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    else if (PageControlShowStyle == UIPageControlShowStyleCenter)
    {
        _pageControl.frame = CGRectMake(0, [self superview].frame.size.height, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH/2.0, HIGHT+UISCREENHEIGHT - 10);
    }
    else
    {
        _pageControl.frame = CGRectMake( UISCREENWIDTH - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}
//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [[self superview] addSubview:_pageControl];
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if(_imageNameArray.count == 0){
        return;
    }
    
    if (self.contentOffset.x == 0)
    {
        currentImage = (currentImage-1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
    }
    else if(self.contentOffset.x == UISCREENWIDTH * 2)
    {
       currentImage = (currentImage+1)%_imageNameArray.count;
        NSLog(@"%lu",(unsigned long)currentImage);
       _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
    }
    else
    {
        return;
    }
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[(currentImage-1)%_imageNameArray.count]]];
    _leftAdLabel.text = _adTitleArray[(currentImage-1)%_imageNameArray.count];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[currentImage%_imageNameArray.count]]];
    
    _centerAdLabel.text = _adTitleArray[currentImage%_imageNameArray.count];
    
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[(currentImage+1)%_imageNameArray.count]]];
    
    _rightAdLabel.text = _adTitleArray[(currentImage+1)%_imageNameArray.count];
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
