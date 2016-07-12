//
//  ViewController.m
//  NJBannerViewDemo
//
//  Created by JLee Chen on 16/6/30.
//  Copyright © 2016年 NanJin Chen. All rights reserved.
//

#import "ViewController.h"
#import "NJBannerView.h"
#import "BannerDetailVC.h"

@interface ViewController ()<NJBannerViewDataSource>

@property (weak , nonatomic) NJBannerView *bannerV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NJBannerView *bannerV = [[NJBannerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    
    bannerV.datas = [NSMutableArray arrayWithObjects:
                     @{@"img":@"homepage_defaultbanner1.jpg",@"link":@"banner1"},
                     @{@"img":@"http://p700.oschina.io/b/01.png",@"link":@"banner2"},
                     @{@"img":@"homepage_defaultbanner3.jpg",@"link":@"banner3"},
                     @{@"img":@"homepage_defaultbanner2.jpg",@"link":@"banner4"},
                     nil];
    
    __unsafe_unretained ViewController *vc = self;
    bannerV.linkAction = ^(NSString *link)
    {
        [vc bannerLink:link];
    };
    [self.view addSubview:bannerV];
    
}

- (void) bannerLink:(NSString *) link
{
    BannerDetailVC *bannerDetailvc = [[BannerDetailVC alloc] init];
    bannerDetailvc.bannerLink = link;
    [self.navigationController pushViewController:bannerDetailvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
