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

+(GraphicPoint *)pointWithX:(float)x Y:(float)y;
-(CGPoint)getPoint;

@end
