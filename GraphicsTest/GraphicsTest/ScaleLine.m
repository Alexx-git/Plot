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

-(void)scaleFromVirtualMin:(float)virtMin andMax:(float)virtMax toRealMin:(float)realMin andMax:(float)realMax
{
    self.multiplier = (realMax - realMin) / (virtMax - virtMin);
    self.deflection = realMin - virtMin * self.multiplier;
}

-(float)realPositionFromVirtualPosition:(float)position
{
    float basePosition = position * self.multiplier + self.deflection;
    return basePosition;
}

@end
