//
//  Functions.swift
//  SwiftCode
//
//  Created by Vlad on 25/08/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class Functions: NSObject
{
    class func rectForPointAndSize(point:CGPoint, size:CGSize) -> CGRect
    {
        return CGRectMake(point.x, point.y, size.width, size.height)
    }
}
