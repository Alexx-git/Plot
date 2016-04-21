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

float const static radius = 4;

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
    for (PointSeries * series in self.graphic.seriesArray)
    {
        color = series.color.CGColor;
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
                else
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
            }
        }
    }
}

-(void)drawAxisInContext:(CGContextRef)context
{
    CGPoint O = self.graphicRect.origin;
    CGPoint xAxis = CGPointMake(self.graphicRect.origin.x + self.graphicRect.size.width, self.graphicRect.origin.y);
    CGPoint yAxis = CGPointMake(self.graphicRect.origin.x, self.graphicRect.origin.y + self.graphicRect.size.height);
    CGPoint axis[4] = {O, xAxis, O, yAxis};
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextStrokeLineSegments(context, axis, 4);
    CGRect rect = [self.graphic.scale showRect];
    NSLog(@"rect:%@", NSStringFromCGRect(rect));
    NSString * string = [NSString stringWithFormat:@"%f", rect.origin.x];
    [string drawInRect:CGRectMake(self.graphicRect.origin.x, self.graphicRect.origin.y - self.offset, self.offset, self.offset) withAttributes:nil];
    string = [NSString stringWithFormat:@"%f", rect.origin.x + rect.size.width];
    [string drawInRect:CGRectMake(self.graphicRect.origin.x + self.graphicRect.size.width, self.graphicRect.origin.y - self.offset, self.offset, self.offset) withAttributes:nil];
    string = [NSString stringWithFormat:@"%f", rect.origin.y];
    [string drawInRect:CGRectMake(self.graphicRect.origin.x - self.offset, self.graphicRect.origin.y, self.offset, self.offset) withAttributes:nil];
    string = [NSString stringWithFormat:@"%f", rect.origin.y + rect.size.height];
    [string drawInRect:CGRectMake(self.graphicRect.origin.x - self.offset, self.graphicRect.origin.y + self.graphicRect.size.height, self.offset, self.offset) withAttributes:nil];
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
