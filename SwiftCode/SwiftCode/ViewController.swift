//
//  ViewController.swift
//  SwiftCode
//
//  Created by Vlad on 31/07/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let series = PointSeries()
        series.addPoint(CGPointMake(-5, -10))
        series.addPoint(CGPointMake(15, 25))
        series.addPoint(CGPointMake(300, 5))
        let rect = series.rectForPoints()
        NSLog("rect:%@", NSStringFromCGRect(rect));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

