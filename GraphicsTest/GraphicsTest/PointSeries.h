//
//  PointSeries.h
//  GraphicsTest
//
//  Created by Vlad on 02/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GraphicPoint.h"

typedef NS_ENUM(NSInteger, GPDrawStyle) {
    GPDrawStyleRound,
    GPDrawStyleSquare,
    GPDrawStyleStar
};

@interface PointSeries : NSObject

@property (assign, nonatomic) UIColor * color;
@property (assign, nonatomic) GPDrawStyle style;
@property (strong, nonatomic) NSArray * points;



-(CGRect)rectForPoints;
-(void)setPoints:(NSArray *)points;

@end
