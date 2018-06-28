//
//  ScaleRect.m
//  GraphicsTest
//
//  Created by Vlad on 16/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "ScaleRect.h"

@interface ScaleRect ()

@property (assign, nonatomic) CGRect realRect;
@property (assign, nonatomic) CGRect virtualRect;

@end

@implementation ScaleRect

-(instancetype)init
{
    self = [super init];
    self.realRect = CGRectNull;
    self.virtualRect = CGRectNull;
    self.xScale = [ScaleLine new];
    self.yScale = [ScaleLine new];
    return self;
}

-(void)realRectSetValue:(CGRect)rect
{
    self.realRect = rect;
    if (!CGRectIsEmpty(self.virtualRect))
    {
        [self updateScale];
    }
}

-(void)virtualRectSetValue:(CGRect)rect
{
    self.virtualRect = rect;
    if (!CGRectIsEmpty(self.realRect))
    {
        [self updateScale];
    }
}

-(void)updateScale
{
    CGFloat virtualMin = self.virtualRect.origin.x;
    CGFloat virtualMax = self.virtualRect.origin.x + self.virtualRect.size.width;
    CGFloat realMin = self.realRect.origin.x;
    CGFloat realMax = self.realRect.origin.x + self.realRect.size.width;
    [self.xScale scaleFromVirtualMin:virtualMin andMax:virtualMax toRealMin:realMin andMax:realMax];
    virtualMin = self.virtualRect.origin.y;
    virtualMax = self.virtualRect.origin.y + self.virtualRect.size.height;
    realMin = self.realRect.origin.y;
    realMax = self.realRect.origin.y + self.realRect.size.height;
    [self.yScale scaleFromVirtualMin:virtualMin andMax:virtualMax toRealMin:realMin andMax:realMax];
}

-(CGPoint)realPointForVirtualPoint:(CGPoint)point
{
    CGPoint real;
    real.x = [self.xScale realPositionForVirtualPosition:point.x];
    real.y = [self.yScale realPositionForVirtualPosition:point.y];
    return real;
}

-(CGSize)realSizeForVirtualSize:(CGSize)size
{
    CGSize real;
    real.width = [self.xScale realLengthForVirtualLength:size.width];
    real.height = [self.yScale realLengthForVirtualLength:size.height];
    return real;
}

-(CGRect)realRectForVirtualRect:(CGRect)rect
{
    CGRect real;
    real.origin = [self realPointForVirtualPoint:rect.origin];
    real.size = [self realSizeForVirtualSize:rect.size];
    return real;
}

-(CGRect)showRect
{
    return self.virtualRect;
}


@end
