//
//  PointSeries.swift
//  SwiftCode
//
//  Created by Vlad on 04/08/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class PointSeries: NSObject
{
    enum GPDrawStyle: Int
    {
        case Round
        case Square
        case Star
        case Image
    }
    
    var style = GPDrawStyle.Round
    var image: UIImage!
    var size: CGFloat = 5
    var pointColor = UIColor.blackColor()
    var lineColor = UIColor.clearColor()
    var lineWidth: CGFloat = 1
    var points = [CGPoint]()
    
    func rectForPoints() -> CGRect
    {
        var rect = CGRectNull
        let point = self.points[1]
        var minX: CGFloat = point.x
        var minY: CGFloat = point.y
        var maxX: CGFloat = point.x
        var maxY: CGFloat = point.y
        for point in self.points
        {
            if point.x < minX
            {
                minX = point.x
            }
            if point.y < minY
            {
                minY = point.y
            }
            if point.x > maxX
            {
                maxX = point.x
            }
            if point.y > maxY
            {
                maxY = point.y
            }

        }
        rect = CGRectMake(minX, minY, maxX - minX, maxY - minY)
        return rect
    }
    
    func addPoint (point: CGPoint)
    {
        self.points.append(point)
    }
}
