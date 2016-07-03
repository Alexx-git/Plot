//
//  GraphicPoint.m
//  GraphicsTest
//
//  Created by Vlad on 24/03/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "GraphicPoint.h"



@implementation GraphicPoint

@dynamic x, y;

//+(GraphicPoint *)pointWithX:(float)x Y:(float)y
//{
//    GraphicPoint * point = [GraphicPoint new];
//    point.x = x;
//    point.y = y;
//    return point;
//}
//
//-(CGPoint)getPoint
//{
//    return CGPointMake(self.x, self.y);
//}

+(GraphicPoint *)pointWithX:(float)x Y:(float)y
{
    GraphicPoint * gPoint = [GraphicPoint new];
    gPoint.point = CGPointMake(x, y);
    return gPoint;
}

+(GraphicPoint *)pointWithCGPoint:(CGPoint)point
{
    GraphicPoint * gPoint = [GraphicPoint new];
    gPoint.point = point;
    return gPoint;
}

-(float)x
{
    return self.point.x;
}

-(float)y
{
    return self.point.y;
}

-(CGPoint)getPoint
{
    return self.point;
}

@end
