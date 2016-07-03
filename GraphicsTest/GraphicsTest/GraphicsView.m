//
//  GraphicsView.m
//  GraphicsTest
//
//  Created by Vlad on 24/03/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "GraphicsView.h"
#import <CoreText/CoreText.h>

@interface GraphicsView ()

@property (assign, nonatomic) float offset;
@property (assign, nonatomic) CGRect graphicRect;

@end

static const float tickLength = 4;
static const float letterWidth = 8;
static const float letterHeight = 12;

@implementation GraphicsView

-(instancetype)init
{
    self = [super init];
    [self commonInitialization];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self commonInitialization];
    return self;
}

-(void)commonInitialization
{
    self.graphic = [Graphic new];
    [self updateSizes];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, self.graphicRect);
    [self drawAxisInContext:context];
    [self drawPointsInContext:context];
}

-(void)drawPointsInContext:(CGContextRef)context
{
    CGColorRef color;
    CGRect pointRect;
    float radius;
    for (PointSeries * series in self.graphic.seriesArray)
    {
        color = series.color.CGColor;
        radius = series.size;
        for (GraphicPoint * point in series.points)
        {
            CGPoint virtualPoint = [point getPoint];
            CGRect showRect = [self.graphic.scale showRect];
            if (CGRectContainsPoint(showRect, virtualPoint))
            {
                CGPoint realPoint = [self.graphic.scale realPointForVirtualPoint:virtualPoint];
                if (series.style == GPDrawStyleRound)
                {
                    pointRect = CGRectMake(realPoint.x - radius, realPoint.y - radius, 2 * radius, 2 * radius);
                    CGContextSetFillColorWithColor(context, color);
                    CGContextFillEllipseInRect(context, pointRect);
                }
                else if (series.style == GPDrawStyleSquare)
                {
                    pointRect = CGRectMake(realPoint.x - radius, realPoint.y - radius, 2 * radius, 2 * radius);
                    CGContextSetFillColorWithColor(context, color);
                    CGContextFillRect(context, pointRect);
                }
                else if (series.style == GPDrawStyleStar)
                {
                    CGPoint first = CGPointMake(realPoint.x, realPoint.y - radius);
                    CGPoint second = CGPointMake(realPoint.x + radius * 0.3, realPoint.y - radius * 0.3);
                    CGPoint third = CGPointMake(realPoint.x + radius, realPoint.y);
                    CGPoint fourth = CGPointMake(realPoint.x + radius * 0.3, realPoint.y + radius * 0.3);
                    CGPoint fifth = CGPointMake(realPoint.x, realPoint.y + radius);
                    CGPoint sixth = CGPointMake(realPoint.x - radius * 0.3, realPoint.y + radius * 0.3);
                    CGPoint seventh = CGPointMake(realPoint.x - radius, realPoint.y);
                    CGPoint eighth = CGPointMake(realPoint.x - radius * 0.3, realPoint.y - radius * 0.3);
                    CGMutablePathRef path = CGPathCreateMutable();
                    CGPathMoveToPoint(path, NULL, first.x, first.y);
                    CGPoint points[8] = {second, third, fourth, fifth, sixth, seventh, eighth, first};
                    CGPathAddLines(path, NULL, points, 8);
                    CGContextAddPath(context, path);
                    CGContextSetFillColorWithColor(context, color);
                    CGContextFillPath(context);
                    CGPathRelease(path);
                }
                else
                {
                    [series.image drawInRect:CGRectMake(realPoint.x - radius, realPoint.y - radius, 2 * radius, 2 * radius)];
                }
            }
        }
    }
}

-(void)drawAxisInContext:(CGContextRef)context
{
    CGPoint OPoint = self.graphicRect.origin;
    CGPoint xAxisPoint = CGPointMake(self.graphicRect.origin.x + self.graphicRect.size.width, self.graphicRect.origin.y);
    CGPoint yAxisPoint = CGPointMake(self.graphicRect.origin.x, self.graphicRect.origin.y + self.graphicRect.size.height);
    CGPoint axis[4] = {OPoint, xAxisPoint, OPoint, yAxisPoint};
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextStrokeLineSegments(context, axis, 4);
    CGRect rect = [self.graphic.scale showRect];
    NSLog(@"rect:%@", NSStringFromCGRect(rect));
    [self.graphic.xAxis.title drawInRect:CGRectMake(xAxisPoint.x, xAxisPoint.y - self.offset / 2, self.offset / 2, self.offset / 2) withAttributes:nil];
    [self.graphic.yAxis.title drawInRect:CGRectMake(yAxisPoint.x - self.offset / 2, yAxisPoint.y, self.offset / 2, self.offset / 2) withAttributes:nil];
    [self drawTicksInContext:context];
}

-(void)drawTicksInContext:(CGContextRef)context
{
    ScaleRound * round = [ScaleRound new];
    CGRect showRect = [self.graphic.scale showRect];
    CGPoint tickPoint;
    CGPoint endPoint;
    NSString * tickTitle;
    NSInteger length = [round decimalPlacesForFloat:showRect.size.width];
    NSArray * xTicks = [round ticksWithinRangeFromMin:showRect.origin.x toMax:showRect.origin.x + showRect.size.width];
    for (NSNumber * objTick in xTicks)
    {
        float tick = objTick.floatValue;
        tickTitle = [NSString stringWithFormat:@"%.*f", length, tick];
        tick = [self.graphic.scale.xScale realPositionFromVirtualPosition:tick];
        tickPoint = CGPointMake(tick, self.graphicRect.origin.y);
        endPoint = CGPointMake(tick, self.graphicRect.origin.y - tickLength);
        CGPoint tickDraw[2] = {tickPoint, endPoint};
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextStrokeLineSegments(context, tickDraw, 2);
        float titleWidth = tickTitle.length * letterWidth;
        [tickTitle drawInRect:CGRectMake(tickPoint.x - titleWidth / 2, tickPoint.y - letterHeight - tickLength, titleWidth, letterHeight) withAttributes:nil];
    }
    length = [round decimalPlacesForFloat:showRect.size.height];
    NSArray * yTicks = [round ticksWithinRangeFromMin:showRect.origin.y toMax:showRect.origin.y + showRect.size.height];
    for (NSNumber * objTick in yTicks)
    {
        float tick = objTick.floatValue;
        tickTitle = [NSString stringWithFormat:@"%.*f", length, tick];
        tick = [self.graphic.scale.yScale realPositionFromVirtualPosition:tick];
        tickPoint = CGPointMake(self.graphicRect.origin.x, tick);
        endPoint = CGPointMake(self.graphicRect.origin.x - tickLength, tick);
        CGPoint tickDraw[2] = {tickPoint, endPoint};
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextStrokeLineSegments(context, tickDraw, 2);
        float titleWidth = tickTitle.length * letterWidth;
        [tickTitle drawInRect:CGRectMake(tickPoint.x - titleWidth - tickLength, tickPoint.y - letterHeight / 2, titleWidth, letterHeight) withAttributes:nil];
    }
}

-(void)updateSizes
{
    self.offset = self.bounds.size.width / 10;
    CGRect temp = CGRectInset(self.bounds, self.offset, self.offset);
    //self.graphicRect = CGRectMake(temp.origin.x, temp.origin.y + temp.size.height, temp.size.width, - temp.size.height);
    self.graphicRect = temp;
    [self.graphic.scale realRectSetValue:self.graphicRect];
    [self setNeedsDisplay];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self updateSizes];
}

-(void)setShowRect:(CGRect)rect
{
    [self.graphic.scale virtualRectSetValue:rect];
}

-(CGRect)returnGraphicRect
{
    return self.graphicRect;
}

@end
