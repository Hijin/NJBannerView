//
//  NJBannerView.m
//  BannerViewDemo
//
//  Created by JLee Chen on 16/6/27.
//  Copyright © 2016年 JLee Chen. All rights reserved.
//

#import "NJBannerView.h"
#import "NJBannerImageView.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@interface NJBannerView () <UIScrollViewDelegate>

@property (weak , nonatomic) UIScrollView *scrollerView;
@property (weak , nonatomic) UIPageControl *pageControl;

@property (weak , nonatomic) NSTimer *timer;

@property (assign , nonatomic) CGFloat lastContentX;

/**
 *  存放用于展示广告页的View
 */
@property (copy , nonatomic) NSMutableArray *arrBannerImageViews;

- (void) startAnimation;
- (void) stopAnimation;

@end

@implementation NJBannerView

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageIndicatorTintColor = [UIColor grayColor];
        _intervalTime = 2.0f;
    }
    return self;
}

- (NSMutableArray *) arrBannerImageViews
{
    if (_arrBannerImageViews == nil) {
        _arrBannerImageViews = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            CGRect frame = CGRectMake(WIDTH * i, 0, WIDTH,HEIGHT);
            NJBannerImageView *imageV = [[NJBannerImageView alloc] initWithFrame:frame];
            imageV.linkAction = ^(NSString *link)
            {
                [self bannerAction:link];
            };
            [_arrBannerImageViews addObject:imageV];
        }
    }
    return _arrBannerImageViews;
}

- (void) setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    if (datas.count <= 0) return;
    if (datas.count == 1) {
        NJBannerImageView *imageV = [[NJBannerImageView alloc] initWithFrame:self.bounds];
        imageV.linkAction = ^(NSString *link)
        {
            [self bannerAction:link];
        };
        imageV.dicProperty = datas[0];
        [self addSubview:imageV];
        
        return;
    }
    
    [self setScrollerView];
    [self setPageControl];
    [self startAnimation];
    
}

- (void) setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void) setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}


- (void) bannerAction:(NSString *)link
{
    if (self.linkAction) {
        self.linkAction(link);
    }
}

- (void) setScrollerView
{
    self.lastContentX = WIDTH;
    
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:self.bounds];
    scroller.delegate = self;
    scroller.pagingEnabled = YES;
    scroller.bounces = NO;
    scroller.showsHorizontalScrollIndicator = NO;
    CGSize size = CGSizeMake(WIDTH * 3, HEIGHT);
    scroller.contentSize = size;
    
    for (int i = 0; i < self.arrBannerImageViews.count; i++) {
        NJBannerImageView *imageV = self.arrBannerImageViews[i];
        imageV.dicProperty = _datas[i%_datas.count];
        [scroller addSubview:imageV];
    }
    
    [scroller setContentOffset:CGPointMake(WIDTH, 0)];
    
    [self addSubview:scroller];
    self.scrollerView = scroller;
}

- (void) setPageControl
{
    if (_datas.count <= 0)
        return;
    
    CGRect frame = CGRectMake(0, HEIGHT * 0.95, WIDTH, HEIGHT * 0.05);
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = self.datas.count;
    pageControl.currentPage = 1;
    pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
}

/**
 *  开始拖动，停止自动滚动
 *
 */
- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self stopAnimation];
}

/**
 *  自动滚动停止
 *
 */
- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewEndScroll:scrollView];
}

/**
 *  拖动滚动停止
 *
 */
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewEndScroll:scrollView];
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0];
}

/**
 *  滚动停止
 *
 */
- (void)scrollViewEndScroll:(UIScrollView *)scrollView
{
    CGFloat contentX = scrollView.contentOffset.x;

    BOOL isRight = (contentX - self.lastContentX > 0);
    
    [self adjustPage:isRight];
    
    [self adjustBannerImage:isRight];
    [self adjustBanner];
}

- (void) adjustPage:(BOOL) isRight
{
    if (isRight) {
        if (self.pageControl.currentPage == self.datas.count - 1) {
            self.pageControl.currentPage = 0;
            return;
        }
        self.pageControl.currentPage += 1;
        
        return;
    }
    
    if (self.pageControl.currentPage == 0) {
        self.pageControl.currentPage = self.datas.count - 1;
        return;
    }
    self.pageControl.currentPage -= 1;
}

- (void) adjustBannerImage:(BOOL) isRight
{
    int lastIndex =(int) self.datas.count -1;
    if (isRight) {
        NSDictionary *firstDatas = self.datas[0];
        for (int i = 0; i< lastIndex + 1 ; i++) {
            
            self.datas[i] = i== lastIndex ? firstDatas: self.datas[i+1];
        }
    }
    else
    {
        NSDictionary *lastDatas = self.datas[lastIndex];
        for (int i = lastIndex; i >= 0; i--) {
            
            self.datas[i] = i== 0? lastDatas: self.datas[i-1];
        }
    }
    for (int i = 0; i < self.arrBannerImageViews.count; i++) {
        NJBannerImageView *imageV = self.arrBannerImageViews[i];
        imageV.dicProperty = self.datas[i%_datas.count];
        [self.scrollerView addSubview:imageV];
    }
}

- (void) adjustBanner
{
    [self.scrollerView setContentOffset:CGPointMake(WIDTH, 0)];
}

- (void) autoAnimation
{
    [self.scrollerView setContentOffset:CGPointMake(WIDTH * 2, 0) animated:YES];
}

/**
 *  开始滚动
 */

- (void) startAnimation
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime target:self selector:@selector(autoAnimation) userInfo:nil repeats:YES];
}

/**
 *  停止滚动
 */
- (void) stopAnimation
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
