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

-(NSInteger)decimalPlacesForFloat:(float)number
{
    float f = number;
    NSInteger decimal = 0;
    while(f < 1)
    {
        decimal+=1;
        f*=10;
    }
    
    return decimal;
}

-(float)decimalMultiplierForFloat:(float)number
{
    float f = number;
    float decimal = 1;
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

-(floatSegment)roundedRangeForFloatSegment:(floatSegment)range
{
    float length = range.max - range.min;
    float multiplier = [self decimalMultiplierForFloat:length];
    floatSegment newRange;
    newRange.min = range.min - length/20;
    newRange.min = floorf(newRange.min * multiplier) / multiplier;
    newRange.max = range.max + length/20;
    newRange.max = ceilf(newRange.max * multiplier) / multiplier;
    return newRange;
}

-(NSArray *)ticksWithinRangeFromMin:(float)min toMax:(float)max
{
    NSMutableArray * ticks = [NSMutableArray array];
    float length = max - min;
    float multiplier = [self decimalMultiplierForFloat:length];
    if (length > 5 * multiplier)
    {
        multiplier *=2;
    }
    else if (length < 2 * multiplier)
    {
        multiplier /=2;
    }
    float tick = ceilf(min / multiplier) * multiplier;
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
