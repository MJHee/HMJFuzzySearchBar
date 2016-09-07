//
//  UIView+Extension.h
//
//
//  Created by MJHee on 16/9/5.
//  Copyright © 2016年 MJHee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, readonly) CGFloat maxX;
@property (nonatomic, readonly) CGFloat maxY;

@end
