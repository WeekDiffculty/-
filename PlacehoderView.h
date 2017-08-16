//
//  PlacehoderView.h
//  FitNess
//
//  Created by bf on 2017/8/15.
//  Copyright © 2017年 xuqq. All rights reserved.
//
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
