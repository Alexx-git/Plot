//
//  ScaleRound.swift
//  SwiftCode
//
//  Created by Vlad on 31/07/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

struct floatSegment
{
    var min: CGFloat
    var max: CGFloat
}

class ScaleRound: NSObject {

    func decimalPlacesForFloat(number: CGFloat) -> NSInteger
    {
        var float = number
        var decimal = 0
        while float < 1
        {
            decimal+=1
            float*=10
        }
        let returnDecimal = decimal
        return returnDecimal
    }

    func decimalMultiplierForFloat(number: CGFloat) -> CGFloat
    {
        var f = number
        var decimal: CGFloat = 1.0
        while f < 1
        {
            decimal/=10
            f*=10
        }
        while f > 10
        {
            decimal*=10
            f/=10
        }
        let returnDecimal = decimal
        return returnDecimal
    }
    
    func roundedRangeForDoubleSegment(segment: floatSegment) -> floatSegment
    {
        let length = segment.max - segment.min
        let multiplier = self.decimalMultiplierForFloat(length)
        var newRange: floatSegment = floatSegment(min: 0.0, max: 0.0)
        newRange.min = segment.min - length/20;
        newRange.min = floor(newRange.min * multiplier) / multiplier;
        newRange.max = segment.max + length/20;
        newRange.max = ceil(newRange.max * multiplier) / multiplier;
        let returnRange = newRange
        return returnRange;
    }

    func ticksWithinRangeFromMin (min: CGFloat, max: CGFloat) -> NSArray
    {
        var ticks = [CGFloat]()
        let length = max - min;
        var multiplier = self.decimalMultiplierForFloat(length)
        if length > 5 * multiplier
        {
            multiplier*=2;
        }
        else if length < 2 * multiplier
        {
            multiplier/=2;
        }
        var tick:CGFloat = ceil(min / multiplier) * multiplier;
        while (tick <= max)
        {
            ticks.append(tick)
            tick += multiplier;
        }
        return ticks
    }

}
