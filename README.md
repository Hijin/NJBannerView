# NJBannerViewDemo
`NJBannerView`是一个轻量级的简单易用的用于展示广告循环滚动的开源库，效率高，占用内存小，支持本地图片和网络图片，两者可混合，广告页数量任意，实现图片点击事件，可自定义当前页显示颜色。

####一张图片的使用效果
![one picture](http://g.recordit.co/9VZwyJpEk5.gif)

####两张图片的使用效果
![two pictures](http://g.recordit.co/O765Lj8Ch3.gif)  

####三张以上图片效果
![three pictures](http://recordit.co/wXeKQse901.gif)

###使用
####datas
datas:字典数组，key:img,value:本地图片名或网络图片地址

bannerView需要显示的图片字典数组
```
NJBannerView *bannerV = [[NJBannerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    
 bannerV.datas = [NSMutableArray arrayWithObjects:
                @{@"img":@"homepage_defaultbanner1.jpg",@"link":@"banner1"},
                @{@"img":@"http://p700.oschina.io/b/01.png",@"link":@"banner2"},
//              @{@"img":@"homepage_defaultbanner3.jpg",@"link":@"banner3"},
//              @{@"img":@"homepage_defaultbanner2.jpg",@"link":@"banner4"},
                nil];
```

####linkAction
点击广告页事件，不需要时可无需设置
```
__unsafe_unretained ViewController *vc = self;
bannerV.linkAction = ^(NSString *link)
    {
        [vc bannerLink:link];
    };
```

自己写的第一个开源库，有问题欢迎指出，以后会更新添加其他功能。QQ：1553877174    微信：cnj901212 邮箱：1553877174@qq.com
