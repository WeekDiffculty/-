//
//  PlacehoderView.m
//  FitNess
//
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
