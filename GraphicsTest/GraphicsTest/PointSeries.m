//
//  PointSeries.m
//  GraphicsTest
//
//  Created by Vlad on 02/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "PointSeries.h"


@implementation PointSeries

-(CGRect)rectForPoints
{
    if (self.points.count == 0)
    {
        return CGRectMake(0, 0, 1, 1);
    }
    else if(self.points.count == 1)
    {
        CGPoint point = [self.points.firstObject getPoint];
        NSLog(@"point:%@", NSStringFromCGPoint(point));
        return CGRectMake(point.x, point.y, 1, 1);
    }
    CGPoint firstPoint = [self.points.firstObject getPoint];
    CGFloat minX = firstPoint.x, minY = firstPoint.y, maxX = firstPoint.x, maxY = firstPoint.y;
    for (GraphicPoint * point in self.points)
    {
        if (point.x < minX)
        {
            minX = point.x;
        }
        if (point.y < minY)
        {
            minY = point.y;
        }
        if (point.x > maxX)
        {
            maxX = point.x;
        }
        if (point.y > maxY)
        {
            maxY = point.y;
        }
    }
    CGRect rect = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    return rect;
}

-(void)setSeries:(NSArray *)series
{
    self.points = [NSArray arrayWithArray:series];
}

@end
