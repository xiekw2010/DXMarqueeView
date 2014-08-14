//
//  AppDelegate.m
//  DXMarqueeViewDemo
//
//  Created by xiekw on 8/14/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DXMarqueeView : UIView

@property (nonatomic) UIView *viewToScroll;

- (void)beginScrollingToLeft:(BOOL)left;
- (void)stopScrolling;

@property (nonatomic) CGFloat spaceBetweenRepeats;

/** pixels to offset per frame */
@property (nonatomic) CGFloat speed;

/** determines if the viewToScroll is wider than its parent */
- (BOOL)shouldScroll;

@end
