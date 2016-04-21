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

@interface Graphic : NSObject

@property (strong, nonatomic) NSArray * seriesArray;
@property (strong, nonatomic) ScaleRect * scale;
@property (assign, nonatomic) float offset;

-(void)addPointSeries:(PointSeries *)series;
-(CGRect)rectForPointSeries;

@end
