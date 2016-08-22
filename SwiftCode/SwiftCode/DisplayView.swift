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
    var offset: CGFloat = 1
    var graphicRect = CGRectNull
    var tickLength: CGFloat = 4
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.updateSizes()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.updateSizes()
    }
    
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
                        points.dealloc(8)
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
        axis.dealloc(4)
        var titleSize = self.plot.xAxis.title.sizeWithAttributes([NSFontAttributeName: self.plot.xAxis.tickFont])
        var axisTitleRect = CGRectMake(xAxisEnd.x + self.offset / 2, xAxisEnd.y - titleSize.height, titleSize.width, titleSize.height)
        self.plot.xAxis.title.drawInRect(axisTitleRect, withAttributes: ([NSFontAttributeName: self.plot.xAxis.titleFont]))
        titleSize = self.plot.yAxis.title.sizeWithAttributes([NSFontAttributeName: self.plot.yAxis.tickFont])
        axisTitleRect = CGRectMake(yAxisEnd.x - titleSize.width, yAxisEnd.y + self.offset / 2, titleSize.width, titleSize.height)
        self.plot.yAxis.title.drawInRect(axisTitleRect, withAttributes: ([NSFontAttributeName: self.plot.xAxis.titleFont]))
        self.drawTicksInContext(context)
    }

    func drawTicksInContext(context: CGContextRef)
    {
        let round = ScaleRound()
        let showRect = self.plot.scale.showRect()
        var tickTitle: String!
        var length = round.decimalPlacesForFloat(showRect.size.width)
        let xTicks = round.ticksWithinRangeFromMin(showRect.origin.x, max:showRect.origin.x + showRect.size.width)
        for element in xTicks
        {
            let tick = element as! CGFloat
            tickTitle = String(format: "%.*f", length, tick)
            let realTick = self.plot.scale.xScale.realPositionFromVirtualPosition(tick)
            let tickDraw = UnsafeMutablePointer<CGPoint>.alloc(4)
            tickDraw[0] = CGPointMake(realTick, self.graphicRect.origin.y)
            tickDraw[1] = CGPointMake(realTick, self.graphicRect.origin.y - tickLength)
            CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
            CGContextStrokeLineSegments(context, tickDraw, 2)
            tickDraw.dealloc(2)
            let tickTitleSize = (tickTitle as NSString).sizeWithAttributes([NSFontAttributeName: self.plot.xAxis.tickFont])
            let tickTitleRect = CGRectMake(realTick - tickTitleSize.width / 2, self.graphicRect.origin.y - tickTitleSize.height - tickLength, tickTitleSize.width, tickTitleSize.height)
            tickTitle.drawInRect(tickTitleRect, withAttributes:([NSFontAttributeName: self.plot.xAxis.tickFont]))
        }
        length = round.decimalPlacesForFloat(showRect.size.height)
        let yTicks = round.ticksWithinRangeFromMin(showRect.origin.y, max:showRect.origin.y + showRect.size.height)
        for element in yTicks
        {
            let tick = element as! CGFloat
            tickTitle = String(format: "%.*f", length, tick)
            let realTick = self.plot.scale.yScale.realPositionFromVirtualPosition(tick)
            let tickDraw = UnsafeMutablePointer<CGPoint>.alloc(4)
            tickDraw[0] = CGPointMake(self.graphicRect.origin.x, realTick)
            tickDraw[1] = CGPointMake(self.graphicRect.origin.x - tickLength, realTick)
            CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
            CGContextStrokeLineSegments(context, tickDraw, 2)
            tickDraw.dealloc(2)
            let tickTitleSize = (tickTitle as NSString).sizeWithAttributes([NSFontAttributeName: self.plot.xAxis.tickFont])
            let tickTitleRect = CGRectMake(self.graphicRect.origin.x - tickLength - tickTitleSize.width, realTick - tickTitleSize.height / 2, tickTitleSize.width, tickTitleSize.height)
            tickTitle.drawInRect(tickTitleRect, withAttributes:([NSFontAttributeName: self.plot.xAxis.tickFont]))
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
