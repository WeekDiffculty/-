//
//  UIViewController+PlaceHoder.m
//  FitNess
//
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
