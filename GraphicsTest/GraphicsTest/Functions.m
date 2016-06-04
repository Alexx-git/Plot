//
//  Functions.m
//  GraphicsTest
//
//  Created by Vlad on 28/05/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

#include "Functions.h"

CGRect rectForPointAndSize (CGPoint point, CGSize size)
{
    return CGRectMake(point.x, point.y, size.width, size.height);
}

CGRect zoomRectForScale (CGRect rect, CGFloat zoomScale)
{
    CGSize newSize = CGSizeMake(rect.size.width * zoomScale, rect.size.height * zoomScale);
    CGPoint center = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2);
    CGPoint newOrigin = CGPointMake(center.x - newSize.width/2, center.y - newSize.height/2);
    return rectForPointAndSize(newOrigin, newSize);
}