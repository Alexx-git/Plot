//
//  ScaleRound.m
//  GraphicsTest
//
//  Created by Vlad on 28/05/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

#import "ScaleRound.h"

@interface ScaleRound ()

@property (assign, nonatomic) float min;
@property (assign, nonatomic) float max;

@end

@implementation ScaleRound

-(NSInteger)decimalMultiplierForFloat:(float)number
{
    float f = number;
    NSInteger decimalMultiplier = 1;
    while(f < 1)
    {
        decimalMultiplier*=10;
        f*=10;
    }
    return decimalMultiplier;
}

-(floatRange)rangeForFloatRange:(floatRange)range
{
    float length = range.max - range.min;
    NSInteger multiplier = [self decimalMultiplierForFloat:length];
    floatRange newRange;
    newRange.min = range.min - length/20;
    newRange.min = floorf(newRange.min * multiplier) / multiplier;
    newRange.max = range.max + length/20;
    newRange.max = ceilf(newRange.max * multiplier) / multiplier;
    return newRange;
}

@end
