//
//  ScaleRound.m
//  GraphicsTest
//
//  Created by Vlad on 28/05/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

#import "ScaleRound.h"

@interface ScaleRound ()

@end

@implementation ScaleRound

-(NSInteger)decimalPlacesForFloat:(CGFloat)number
{
    CGFloat f = number;
    NSInteger decimal = 0;
    if (f == 0)
    {
        return 0;
    }
    while(f < 1)
    {
        decimal+=1;
        f*=10;
    }
    return decimal;
}

-(CGFloat)decimalMultiplierForFloat:(CGFloat)number
{
    if (number == 0)
    {
        return 0;
    }
    CGFloat f = number;
    CGFloat decimal = 1;
    while(f < 1)
    {
        decimal/=10;
        f*=10;
    }
    while(f > 10)
    {
        decimal*=10;
        f/=10;
    }
    return decimal;
}

-(CGFloatSegment)roundedRangeForFloatSegment:(CGFloatSegment)range
{
    CGFloat length = range.max - range.min;
    CGFloat multiplier = [self decimalMultiplierForFloat:length];
    CGFloatSegment newRange;
    newRange.min = range.min - length/20;
    newRange.min = floor(newRange.min * multiplier) / multiplier;
    newRange.max = range.max + length/20;
    newRange.max = ceil(newRange.max * multiplier) / multiplier;
    return newRange;
}

-(NSArray *)ticksWithinRangeFromMin:(CGFloat)min toMax:(CGFloat)max
{
    NSMutableArray * ticks = [NSMutableArray array];
    CGFloat length = max - min;
    CGFloat multiplier = [self decimalMultiplierForFloat:length];
    if (length > 5 * multiplier)
    {
        multiplier *=2;
    }
    else if (length < 2 * multiplier)
    {
        multiplier /=2;
    }
    CGFloat tick = ceilf(min / multiplier) * multiplier;
    NSNumber * objTick;
    while (tick <= max)
    {
        objTick = [NSNumber numberWithFloat:tick];
        [ticks addObject:objTick];
        tick += multiplier;
    }
    return [NSArray arrayWithArray:ticks];
}

@end
