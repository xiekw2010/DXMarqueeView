//
//  AppDelegate.m
//  DXMarqueeViewDemo
//
//  Created by xiekw on 8/14/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//


#import "DXMarqueeView.h"

@interface DXMarqueeView ()
{
    BOOL _left;
}

@property (nonatomic) UIView *snapshot1;
@property (nonatomic) UIView *snapshot2;

@end

@implementation DXMarqueeView
{
    CADisplayLink *displayLink;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        _spaceBetweenRepeats = 5;
        _speed = 0.7;
    }
    return self;
}

- (void)setViewToScroll:(UIView *)viewToScroll
{
    [self.snapshot1 removeFromSuperview];
    [self.snapshot2 removeFromSuperview];
    
    _viewToScroll = viewToScroll;
    
    viewToScroll.hidden = NO;
    [self addSubview:viewToScroll];
    
    
    self.snapshot1 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:viewToScroll]];
    self.snapshot2 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:viewToScroll]];
    
    [self addSubview:self.snapshot1];
    [self addSubview:self.snapshot2];
    
    CGRect trailingRect = self.snapshot2.frame;
    trailingRect.origin.x = CGRectGetMaxX(self.snapshot1.frame) + self.spaceBetweenRepeats;
    self.snapshot2.frame = trailingRect;
    
    self.viewToScroll.hidden = YES;
}

- (BOOL)shouldScroll
{
    if(CGRectGetWidth(self.viewToScroll.frame) > CGRectGetWidth(self.frame)) {
        return YES;
    }
    
    return NO;
}

- (void)beginScrollingToLeft:(BOOL)left;
{
    _left = left;
    if(displayLink) {
        return;
    }
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerDidFire:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopScrolling
{
    [displayLink invalidate];
    displayLink = nil;
}

- (void)timerDidFire:(NSTimer *)timer
{
    [self offsetViews];
}

- (UIView *)leadingSnapshot
{
    if (_left) {
        if(CGRectGetMinX(self.snapshot1.frame) < CGRectGetMinX(self.snapshot2.frame)) {
            return self.snapshot1;
        } else {
            return self.snapshot2;
        }
    }else {
        if(CGRectGetMaxX(self.snapshot1.frame) < CGRectGetMaxX(self.snapshot2.frame)) {
            return self.snapshot2;
        } else {
            return self.snapshot1;
        }
    }
}

- (UIView *)trailingSnapshot
{
    
    if (_left) {
        if(CGRectGetMinX(self.snapshot1.frame) > CGRectGetMinX(self.snapshot2.frame)) {
            return self.snapshot1;
        } else {
            return self.snapshot2;
        }
    }else {
        if(CGRectGetMaxX(self.snapshot1.frame) < CGRectGetMaxX(self.snapshot2.frame)) {
            return self.snapshot1;
        } else {
            return self.snapshot2;
        }

    }
}

- (void)offsetViews
{
    CGFloat const offsetAmount = MAX(self.speed, 0.0);
    
    UIView *leadingSnapshot = [self leadingSnapshot];
    UIView *trailingSnapshot = [self trailingSnapshot];
    CGRect leadingRect = leadingSnapshot.frame;
    CGRect trailingRect = trailingSnapshot.frame;

    if (_left) {
        
        CGFloat leadingMaxX = CGRectGetMaxX(leadingRect);
        if(leadingMaxX < 0) {
            // send to end
            leadingRect.origin.x = CGRectGetMaxX(trailingRect) + self.spaceBetweenRepeats;
        } else {
            leadingRect.origin.x -= offsetAmount;
        }
        
        trailingRect.origin.x -= offsetAmount;

    }else {
        CGFloat leadingMaxX = CGRectGetMinX(leadingRect);
        if(leadingMaxX > CGRectGetWidth(self.bounds)) {
            // send to end
            leadingRect.origin.x = CGRectGetMinX(trailingRect) - self.spaceBetweenRepeats - CGRectGetWidth(trailingRect);
        } else {
            leadingRect.origin.x += offsetAmount;
        }
        
        trailingRect.origin.x += offsetAmount;

    }
    leadingSnapshot.frame = trailingRect;
    trailingSnapshot.frame = leadingRect;

}

@end
