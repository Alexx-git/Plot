//
//  GraphicModel.h
//  GraphicsTest
//
//  Created by Vlad on 02/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScaleRect.h"
#import "PointSeries.h"
#import "GraphicAxis.h"

@interface Graphic : NSObject

@property (strong, nonatomic) NSArray * seriesArray;
@property (strong, nonatomic) ScaleRect * scale;
@property (strong, nonatomic) GraphicAxis * xAxis;
@property (strong, nonatomic) GraphicAxis * yAxis;
@property (assign, nonatomic) float offset;

-(void)addPointSeries:(PointSeries *)series;
-(CGRect)rectForPointSeries;

@end
