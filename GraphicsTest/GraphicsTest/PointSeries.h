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

typedef NS_ENUM(NSInteger, PSDrawElements)
{
    PSDrawElementsLines,
    PSDrawElementsDots,
    PSDrawElementsAll
};

@interface PointSeries : NSObject

@property (assign, nonatomic) GPDrawStyle style;
@property (assign, nonatomic) PSDrawElements drawElements;
@property (assign, nonatomic) CGFloat size;
@property (strong, nonatomic) UIColor * pointColor;
@property (strong, nonatomic) UIColor * lineColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIImage * image;
@property (strong, nonatomic) NSArray * points;



-(CGRect)rectForPoints;
-(void)setPoints:(NSArray *)points;

@end
