//
//  NJBannerImageView.m
//  BannerViewDemo
//
//  Created by JLee Chen on 16/6/27.
//  Copyright © 2016年 JLee Chen. All rights reserved.
//

#import "NJBannerImageView.h"
#import <UIImageView+WebCache.h>

@interface NJBannerImageView ()

@property (weak , nonatomic) UIImageView *imgV;

@end

@implementation NJBannerImageView

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imgV];
        _imgV = imgV;
        
        [self addTarget:self action:@selector(bannerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void) setDicProperty:(NSDictionary *)dicProperty
{
    _dicProperty = dicProperty;
    
    NSString *imgURL = _dicProperty[@"img"];
    if ([imgURL hasPrefix:@"http"]) {  //网络图片
        [_imgV sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:self.placeholderImg options:SDWebImageRetryFailed];
    }
    else
    {
        _imgV.image = [UIImage imageNamed:imgURL];
        
    }
}

- (void) bannerAction
{
    if (!_dicProperty || !_dicProperty[@"link"]) {
        return;
    }
    if (_linkAction) {
        NSString *link = _dicProperty[@"link"];
        self.linkAction(link);
    }
}

@end

