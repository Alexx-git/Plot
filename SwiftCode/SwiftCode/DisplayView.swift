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
        self.drawAxisInContext(context!)
        self.drawLinesInContext(context!)
        self.drawPointsInContext(context!)
    }

    func drawLinesInContext(context: CGContextRef)
    {
        CGContextAddRect(context, self.graphicRect)
        CGContextClip(context)
        var firstPoint: CGPoint!
        var secondPoint: CGPoint!
        for series in self.plot.seriesArray
        {
            firstPoint = self.plot.scale.realPointForVirtualPoint(series.points[1])
            CGContextSetLineWidth(context, series.lineWidth)
            CGContextSetStrokeColorWithColor(context, series.lineColor.CGColor)
            for point in series.points
            {
                secondPoint = self.plot.scale.realPointForVirtualPoint(point)
                let points = UnsafeMutablePointer<CGPoint>.alloc(2)
                points[0] = firstPoint
                points[1] = secondPoint
                CGContextStrokeLineSegments(context, points, 2)
                points.dealloc(2)
                firstPoint = secondPoint
            }
        }
    }

    func drawPointsInContext(context: CGContextRef)
    {
        CGContextAddRect(context, self.graphicRect)
        CGContextClip(context)
        var color: CGColorRef
        var pointRect: CGRect
        var image: UIImage!
        var radius: CGFloat
        for series in self.plot.seriesArray
        {
            color = series.pointColor.CGColor
            radius = series.size
            for point in series.points
            {
                let showRect = self.plot.scale.showRect()
                image = series.image
                if CGRectContainsPoint(showRect, point)
                {
                    let realPoint = self.plot.scale.realPointForVirtualPoint(point)
                    if series.style == PointSeries.GPDrawStyle.Round
                    {
                        pointRect = CGRectMake(realPoint.x - radius, realPoint.y - radius, 2 * radius, 2 * radius)
                        CGContextSetFillColorWithColor(context, color)
                        CGContextFillEllipseInRect(context, pointRect)
                    }
                    else if series.style == PointSeries.GPDrawStyle.Square
                    {
                        pointRect = CGRectMake(realPoint.x - radius, realPoint.y - radius, 2 * radius, 2 * radius)
                        CGContextSetFillColorWithColor(context, color)
                        CGContextFillRect(context, pointRect)
                    }
                    else if series.style == PointSeries.GPDrawStyle.Star
                    {
                        let points = UnsafeMutablePointer<CGPoint>.alloc(8)
                        points[0] = CGPointMake(realPoint.x, realPoint.y - radius)
                        points[1] = CGPointMake(realPoint.x + radius * 0.3, realPoint.y - radius * 0.3)
                        points[2] = CGPointMake(realPoint.x + radius, realPoint.y)
                        points[3] = CGPointMake(realPoint.x + radius * 0.3, realPoint.y + radius * 0.3)
                        points[4] = CGPointMake(realPoint.x, realPoint.y + radius)
                        points[5] = CGPointMake(realPoint.x - radius * 0.3, realPoint.y + radius * 0.3)
                        points[6] = CGPointMake(realPoint.x - radius, realPoint.y)
                        points[7] = CGPointMake(realPoint.x - radius * 0.3, realPoint.y - radius * 0.3)
                        
                        let path = CGPathCreateMutable()
                        CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
                        CGPathAddLines(path, nil, points, 8)
                        CGContextAddPath(context, path)
                        CGContextSetFillColorWithColor(context, color)
                        CGContextFillPath(context)
                    }
                    else
                    {
                        image.drawInRect(CGRectMake(realPoint.x - radius, realPoint.y - radius, 2 * radius, 2 * radius))
                    }
                }
            }
        }
    }

    func drawAxisInContext(context: CGContextRef)
    {
        let OPoint = self.graphicRect.origin
        let xAxisEnd = CGPointMake(self.graphicRect.origin.x + self.graphicRect.size.width, self.graphicRect.origin.y)
        let yAxisEnd = CGPointMake(self.graphicRect.origin.x, self.graphicRect.origin.y + self.graphicRect.size.height)
        let axis = UnsafeMutablePointer<CGPoint>.alloc(4)
        axis[0] = OPoint
        axis[1] = xAxisEnd
        axis[2] = OPoint
        axis[3] = yAxisEnd
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        CGContextStrokeLineSegments(context, axis, 4)
        self.plot.xAxis.title.drawInRect(CGRectMake(xAxisEnd.x, xAxisEnd.y - self.offset / 2, self.offset / 2, self.offset / 2), withAttributes: nil)
        self.plot.yAxis.title.drawInRect(CGRectMake(yAxisEnd.x - self.offset / 2, yAxisEnd.y, self.offset / 2, self.offset / 2), withAttributes: nil)
        self.drawTicksInContext(context)
    }

    func drawTicksInContext(context: CGContextRef)
    {
        let round = ScaleRound()
        let showRect = self.plot.scale.showRect()
        var tickPoint: CGPoint!
        var endPoint: CGPoint!
        var tickTitle: String!
        let length = round.decimalPlacesForFloat(showRect.size.width)
        let xTicks = round.ticksWithinRangeFromMin(showRect.origin.x, max:showRect.origin.x + showRect.size.width)
        for tick in xTicks
        {
            tickTitle = NSString(format: "%.*f", length, tick, nil)
            let realTick = self.plot.scale.xScale.realPositionFromVirtualPosition(tick)
            tickPoint = CGPointMake(realTick, self.graphicRect.origin.y)
            endPoint = CGPointMake(realTick, self.graphicRect.origin.y - tickLength);
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
