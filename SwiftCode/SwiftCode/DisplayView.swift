//
//  DisplayView.swift
//  SwiftCode
//
//  Created by Vlad on 04/08/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class DisplayView: UIView
{
    let plot = Plot()
    var offset: CGFloat = 4
    var graphicRect = CGRectNull
    var tickLength: CGFloat = 4
    
//    -(void)commonInitialization
//    {
//        [self updateSizes];
//    }

    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        CGContextSetFillColorWithColor(context, self.backgroundColor!.CGColor)
        CGContextFillRect(context, rect)
        CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
        CGContextFillRect(context, self.graphicRect)
        self.drawAxisInContext(context)
        self.drawLinesInContext(context)
        self.drawPointsInContext(context)
    }

    func drawLinesInContext(context: CGContextRef)
    {
        CGContextAddRect(context, self.graphicRect);
        CGContextClip(context);
        var firstPoint: CGPoint!
        var secondPoint: CGPoint!
        for series in self.plot.seriesArray
        {
            firstPoint = self.plot.scale.realPointForVirtualPoint(series.points[1])
            CGContextSetLineWidth(context, series.lineWidth);
            CGContextSetStrokeColorWithColor(context, series.lineColor.CGColor);
            for point in series.points
            {
                secondPoint = self.plot.scale.realPointForVirtualPoint(point)
                CGPoint points[2] = {firstPoint, secondPoint}
                CGContextStrokeLineSegments(context, points, 2);
                firstPoint = secondPoint
            }
        }
    }

    func drawPointsInContext(context: CGContextRef)
    {
        CGContextAddRect(context, self.graphicRect);
        CGContextClip(context);
        var color: CGColorRef
        var pointRect: CGRect
        UIImage * image;
        float radius;
        for (PointSeries * series in self.graphic.seriesArray)
        {
            color = series.pointColor.CGColor;
            radius = series.size;
            for (GraphicPoint * point in series.points)
            {
                CGPoint virtualPoint = [point getPoint];
                CGRect showRect = [self.graphic.scale showRect];
                image = series.image;
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
                        [image drawInRect:CGRectMake(realPoint.x - radius, realPoint.y - radius, 2 * radius, 2 * radius)];
                    }
                }
            }
        }
    }

    func drawAxisInContext(context: CGContextRef)
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

    func drawTicksInContext(context: CGContextRef)
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

    func updateSizes()
    {
        self.offset = self.bounds.size.width / 10;
        let temp = CGRectInset(self.bounds, self.offset, self.offset);
        //self.graphicRect = CGRectMake(temp.origin.x, temp.origin.y + temp.size.height, temp.size.width, - temp.size.height);
        self.graphicRect = temp;
        self.plot.scale.realRectSetValue(self.graphicRect)
        self.setNeedsDisplay()
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.updateSizes()
    }

    func setShowRect(rect: CGRect)
    {
        self.plot.scale.virtualRectSetValue(rect)
    }

    func returnGraphicRect() -> CGRect
    {
        return self.graphicRect;
    }

}
