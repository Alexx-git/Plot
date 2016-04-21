//
//  GraphicPoint.m
//  GraphicsTest
//
//  Created by Vlad on 24/03/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "GraphicPoint.h"

@implementation GraphicPoint

+(GraphicPoint *)pointWithX:(float)x Y:(float)y
{
    GraphicPoint * point = [GraphicPoint new];
    point.x = x;
    point.y = y;
    return point;
}

-(CGPoint)getPoint
{
    return CGPointMake(self.x, self.y);
}


@end
