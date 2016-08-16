//
//  ViewController.swift
//  SwiftCode
//
//  Created by Vlad on 31/07/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayView: DisplayView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        self.addPoints()
        self.displayView.setNeedsDisplay()
        NSLog("bla-bla-bal")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPoints()
    {
        let series = PointSeries()
        series.addPoint(CGPointMake(-5, -10))
        series.addPoint(CGPointMake(15, 25))
        series.addPoint(CGPointMake(300, 5))
        self.displayView.plot.addPointSeries(series)
    }
}

