
![bb.gif](http://upload-images.jianshu.io/upload_images/2382884-da3e16a4549901de.gif?imageMogr2/auto-orient/strip)

##    项目基本完成，需要加占位图，界面众多，又不可能一个个加......能否利用runtime及oc特性解决问题呢.  实现思路，UIVIewController扩展加属性，加方法，自定义占位图，在需要的时候，一句话加载占位图。

###自定义占位视图

.h 使用枚举列举所有用到占位图的情况包括隐藏
```
typedef enum : NSUInteger {
    NoNetPlacehoder,            //无网路
    NoProductPlacehoder,        // 无产品
    NoCouponPlacehoder,         // 无优惠券
    NoBanckCardPlacehoder,      // 无银行卡
    NoHistoryPlacehoder,        // 无历史
    NoCollectionPllacehoder,    //无收藏
    NoAddressPlacehoder,         // 无地址
    NoOrderPlacehoder,          // 无订单
    NoSearchDataPlacehoder,     // 无搜索结果
    NoFitCardPlacehoder,        // 无健身卡
    NocraftsmanPlaceHoder,     //无手艺人
    NovenuesPlaceHoder,         //无场馆
    Hidden,                     // 隐藏
} PlaceHoderImageViewtype;

#import <UIKit/UIKit.h>

@interface PlacehoderView : UIImageView
+ (instancetype)shareInstance;
- (void)showAndtype:(PlaceHoderImageViewtype )placehoderType;
@end
```

.m 
```
//  Created by bf on 2017/8/15.
//  Copyright © 2017年 xuqq. All rights reserved.
//

#import "PlacehoderView.h"
@interface PlacehoderView ()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *tipArray;
@end
@implementation PlacehoderView

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"placeholder_network_anomaly",
                        @"placeholder_product",
                        @"placeholder_recruitment",
                        @"placeholder_bank_card",
                        @"placeholder_browsing_history",
                        @"placeholder_attention",
                        @"placeholder_address",
                        @"placeholder_order",
                        @"placeholder_product",
                        @"placeholder_fitness_cards",
                        @"placeholder_craftsman",
                        @"placeholder_venues"];
    }
    return _imageArray;
}

- (NSArray *)tipArray{
    if (!_tipArray) {
        _tipArray   = @[@"你的网络好像不太给力\n请查看网络设置或稍后再试",
                        @"还没哟相关产品哦",
                        @"你还没有领取优惠券哦",
                        @"还没有添加银行卡哦",
                        @"你还没有浏览过产品呢",
                        @"你还没有收藏过产品呢",
                        @"你还没有添加常用地址哦",
                        @"还没有相关订单哦",
                        @"暂时没有搜到相关结果\n换个关键词试试吧～",
                        @"你还没有购买过建设卡哦",
                        @"你的附近没有手艺人哦",
                        @"你的附近没有场馆哦"];
    }
    return _tipArray;
}

+ (instancetype)shareInstance{
//   static
    PlacehoderView *placeHoderView = placeHoderView = [[PlacehoderView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
        //    });
    return placeHoderView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    UIView *backView = [MyView uiview:0 bColor:[UIColor clearColor] rect:self.bounds];
    [self addSubview:backView];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH - wight(430))*0.5, (self.xmg_height - wight(430) - wight(120) - wight(30))*0.1, wight(430), wight(430))];
    [self addSubview:self.imageView];
    
    self.tipLabel = [MyView label:@"" tColor:QIANGAR font:[UIFont systemFontOfSize:wight(30)] rect:CGRectMake(wight(30), self.imageView.xmg_bottom , SCREENWIDTH - wight(60), wight(90))];
    self.tipLabel.numberOfLines = 0;
    [self addSubview:self.tipLabel];
    self.tipLabel.textAlignment = NSTextAlignmentCenter ;
    self.userInteractionEnabled = NO;
    self.hidden = YES;
}
//显示特定 活着隐藏占位图
- (void)showAndtype:(PlaceHoderImageViewtype)placehoderType{
    if (placehoderType == Hidden) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
        self.imageView.frame = CGRectMake((SCREENWIDTH - wight(430))*0.5, (self.xmg_height - wight(430) - wight(120) - wight(30))*0.2, wight(430), wight(430));
        self.tipLabel.frame = CGRectMake(wight(30), self.imageView.xmg_bottom , SCREENWIDTH - wight(60), wight(90));
        self.imageView.image = [UIImage imageNamed:self.imageArray[placehoderType]];
        self.tipLabel.text = self.tipArray[placehoderType];
    }

}
@end
```

###UIViewController+PlaceHoder
.h 添加方法 及属性
```
//  Created by bf on 2017/8/15.
//  Copyright © 2017年 xuqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacehoderView.h"
@interface UIViewController (PlaceHoder)
@property (nonatomic, strong)PlacehoderView *placehoderView;
- (void)showPlaceHoderandType:(PlaceHoderImageViewtype)type withFrame:(CGRect )frame;
@end
```

.m  实现自定义属性及接口方法
```
//  Created by bf on 2017/8/15.
//  Copyright © 2017年 xuqq. All rights reserved.
//

#import "UIViewController+PlaceHoder.h"

@implementation UIViewController (PlaceHoder)
static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";
- (void)showPlaceHoderandType:(PlaceHoderImageViewtype)type withFrame:(CGRect)frame{
    if (!self.placehoderView) {
        self.placehoderView = [[PlacehoderView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + wight(240), frame.size.width, frame.size.height -wight(240))];
    }
    [self.view addSubview:self.placehoderView];
//    self.placehoderView.frame = CGRectMake(frame.origin.x, frame.origin.y + wight(120), frame.size.width, frame.size.height -wight(120));
    [self.placehoderView showAndtype:type];
}

- (PlacehoderView *)placehoderView
{
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey);
}
- (void)setPlacehoderView:(PlacehoderView *)placehoderView{
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey, placehoderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
```


#使用 ```  [self showPlaceHoderandType:NocraftsmanPlaceHoder withFrame:self.tableView.frame];```两个参数，一个占位图类型，一个需要加载视图的frame。

```
- (void)loadAndlocation{
        self.page = 1;
        NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:USERID];
        [NetWorkManager getnearbyPersonwithlng:[NSString stringWithFormat:@"%g",self.lng]
                                       withlat:[NSString stringWithFormat:@"%g",self.lat]
                                         withp:[NSString stringWithFormat:@"%ld",self.page]
                                           uid:uid
                                          name:nil
                                       success:^(BaseResponse *response) {
            if ([response.code  isEqualToString:@"1000"]) {
                NSArray *array = response.data;
                NSMutableArray *temp = [NSMutableArray arrayWithCapacity:array.count];
                for (NSInteger index = 0; index < array.count; index ++) {
                    CrafsmanJianjieModel *model = [CrafsmanJianjieModel mj_objectWithKeyValues:array[index]];
                    [temp  addObject:model];
                }
                if (array.count) {
                   
                self.persons = [temp copy];
                    // 结束刷新
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                    [self.tableView reloadData];
                    [self showPlaceHoderandType:Hidden withFrame:self.tableView.frame];
                }else{
                    [self showPlaceHoderandType:NocraftsmanPlaceHoder withFrame:self.tableView.frame];
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        } fail:^(NSError *error) {
            self.persons = @[];
            [self.tableView reloadData];
            [self showPlaceHoderandType:NoNetPlacehoder withFrame:self.tableView.frame];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];

}
```
 [源码](https://github.com/WeekDiffculty/-.git) 
END
