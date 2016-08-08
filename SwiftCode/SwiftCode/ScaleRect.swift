//
//  ScaleRect.swift
//  SwiftCode
//
//  Created by Vlad on 31/07/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class ScaleRect: NSObject
{

    let xScale = ScaleLine()
    let yScale = ScaleLine()
    var virtualRect = CGRectNull
    var realRect = CGRectNull

    func realRectSetValue(rect: CGRect)
    {
        self.realRect = rect
        if (!CGRectIsNull(self.virtualRect))
        {
            self.updateScale()
        }
    }

    func virtualRectSetValue(rect: CGRect)
    {
        self.virtualRect = rect
        if (!CGRectIsNull(self.realRect))
        {
            self.updateScale()
        }
    }

    func updateScale()
    {
        var virtualMin = self.virtualRect.origin.x
        var virtualMax = self.virtualRect.origin.x + self.virtualRect.size.width
        var realMin = self.realRect.origin.x
        var realMax = self.realRect.origin.x + self.realRect.size.width
        self.xScale.setScale(virtualMin, virtMax: virtualMax, realMin: realMin, realMax: realMax)
        virtualMin = self.virtualRect.origin.y
        virtualMax = self.virtualRect.origin.y + self.virtualRect.size.height
        realMin = self.realRect.origin.y
        realMax = self.realRect.origin.y + self.realRect.size.height
        self.yScale.setScale(virtualMin, virtMax: virtualMax, realMin: realMin, realMax: realMax)
    }
        
    func realPointForVirtualPoint(point: CGPoint) -> CGPoint
    {
        var real = CGPointMake(0, 0)
        real.x = self.xScale.realPositionFromVirtualPosition(point.x)
        real.y = self.yScale.realPositionFromVirtualPosition(point.y)
        return real;
    }
    

    func realSizeForVirtualSize(size: CGSize) -> CGSize
    {
        var real = CGSizeMake(0, 0)
        real.width = self.xScale.realLengthForVirtualLength(size.width)
        real.height = self.yScale.realLengthForVirtualLength(size.height)
        return real;
    }

    func realRectForVirtualRect(rect: CGRect) -> CGRect
    {
        var real = CGRectNull
        real.origin = self.realPointForVirtualPoint(rect.origin)
        real.size = self.realSizeForVirtualSize(rect.size)
        return real;
    }

    func showRect() -> CGRect
    {
        return self.virtualRect;
    }
}
