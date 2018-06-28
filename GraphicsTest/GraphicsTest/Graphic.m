//
//  GraphicModel.m
//  GraphicsTest
//
//  Created by Vlad on 02/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "Graphic.h"

@implementation Graphic

-(instancetype)init
{
    self = [super init];
    self.scale = [ScaleRect new];
    self.xAxis = [GraphicAxis new];
    self.xAxis.title = @"X";
    self.yAxis = [GraphicAxis new];
    self.yAxis.title = @"Y";
    return self;
}

-(CGRect)rectForPointSeries;
{
    CGRect rect = CGRectNull;
    for (PointSeries * series in self.seriesArray)
    {
        rect = CGRectUnion(rect, [series rectForPoints]);
    }
    if (CGRectEqualToRect(rect, CGRectNull))
    {
        rect = CGRectMake(0, 0, 100, 100);
    }
    NSLog(@"rect:%@", NSStringFromCGRect(rect));
    return rect;
}

-(void)addPointSeries:(PointSeries *)series
{
    NSMutableArray * mutable = [NSMutableArray arrayWithArray:self.seriesArray];
    [mutable addObject:series];
    self.seriesArray = [NSArray arrayWithArray:mutable];
    CGRect rect = [self rectForPointSeries];
    [self.scale virtualRectSetValue:rect];
}

-(void)clearPointSeries
{
    self.seriesArray = [NSArray new];
}


@end
