//
//  ScaleLine.m
//  GraphicsTest
//
//  Created by Vlad on 02/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "ScaleLine.h"

@interface ScaleLine ()

@property (assign, nonatomic) double multiplier;
@property (assign, nonatomic) double deflection;

@end

@implementation ScaleLine

-(void)scaleFromVirtualMin:(CGFloat)virtMin andMax:(CGFloat)virtMax toRealMin:(CGFloat)realMin andMax:(CGFloat)realMax
{
    self.multiplier = (realMax - realMin) / (virtMax - virtMin);
    self.deflection = realMin - virtMin * self.multiplier;
}

-(CGFloat)realPositionForVirtualPosition:(CGFloat)position
{
    CGFloat basePosition = position * self.multiplier + self.deflection;
    return basePosition;
}

-(CGFloat)realLengthForVirtualLength:(CGFloat)length
{
    return length * self.multiplier;
}

@end
