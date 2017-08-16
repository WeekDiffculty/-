//
//  UIViewController+PlaceHoder.h
//  FitNess
//
//  Created by bf on 2017/8/15.
//  Copyright © 2017年 xuqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacehoderView.h"
@interface UIViewController (PlaceHoder)
@property (nonatomic, strong)PlacehoderView *placehoderView;
- (void)showPlaceHoderandType:(PlaceHoderImageViewtype)type withFrame:(CGRect )frame;
@end
