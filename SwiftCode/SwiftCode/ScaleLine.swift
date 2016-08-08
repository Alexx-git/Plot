//
//  ScaleLine.swift
//  SwiftCode
//
//  Created by Vlad on 31/07/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class ScaleLine: NSObject
{

    var multiplier: CGFloat!
    var deflection: CGFloat!

    func setScale(virtMin: CGFloat, virtMax: CGFloat, realMin: CGFloat, realMax: CGFloat)
    {
        self.multiplier = (realMax - realMin) / (virtMax - virtMin)
        self.deflection = realMin - virtMin * self.multiplier
    }

    func realPositionFromVirtualPosition (position: CGFloat) -> CGFloat
    {
        let basePosition = position * self.multiplier + self.deflection
        return basePosition
    }

    func realLengthForVirtualLength(length:CGFloat) -> CGFloat
    {
        return length * self.multiplier;
    }
}
