//
//  ViewController.swift
//  SwiftCode
//
//  Created by Vlad on 31/07/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    @IBOutlet weak var baseView: BaseView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        self.addPoints()
        self.baseView.displayView.setNeedsDisplay()
        self.baseView.displayView.setShowRect(CGRectMake(0, 0, 40, 40))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPoints()
    {
        
        let series = PointSeries()
        var i:CGFloat = 0
        for i in 1...50
        {
            let x = 500 + 10 * i * cos(i)
            let y = 500 + 10 * i * sin(i)
            series.addPoint(CGPointMake(x, y))
        }
        series.pointColor = UIColor.redColor()
        series.lineColor = UIColor.greenColor()
        series.lineWidth = 1.0
        series.style = PointSeries.GPDrawStyle.Round
        series.size = 4
        self.baseView.displayView.plot.addPointSeries(series)
        self.baseView.displayView.setShowRect(CGRectMake(0, 0, 999, 999))
        self.baseView.displayView.plot.addPointSeries(series)
    }
}

