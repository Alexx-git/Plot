//
//  GraphicPoint.h
//  GraphicsTest
//
//  Created by Vlad on 24/03/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GraphicPoint : NSObject
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGPoint point;



+(GraphicPoint *)pointWithX:(CGFloat)x Y:(CGFloat)y;
+(GraphicPoint *)pointWithCGPoint:(CGPoint)point;
-(CGPoint)getPoint;


@end

