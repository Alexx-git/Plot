//
//  Plot.swift
//  SwiftCode
//
//  Created by Vlad on 04/08/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class Plot: NSObject
{
    let seriesArray = [PointSeries]()
    var scale = ScaleRect()
    var xAxis = PlotAxis()
    var yAxis = PlotAxis()
    var offset: CGFloat = 4
    
    override init()
    {
        self.xAxis.title = "X"
        self.yAxis.title = "Y"
        super.init()
    }
    
    func rectForPointSeries() -> CGRect
    {
        var rect = CGRectNull
        for series in self.seriesArray
        {
            rect = CGRectUnion(rect, series.rectForPoints());
        }
        return rect;
    }

    func addPointSeries(series: PointSeries)
    {
        self.seriesArray
    }
}
