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
    GPDrawStyleStar,
    GPDrawStyleImage
};

@interface PointSeries : NSObject

@property (assign, nonatomic) GPDrawStyle style;
@property (assign, nonatomic) float size;
@property (strong, nonatomic) UIColor * color;
@property (strong, nonatomic) UIImage * image;
@property (strong, nonatomic) NSArray * points;



-(CGRect)rectForPoints;
-(void)setPoints:(NSArray *)points;

@end
