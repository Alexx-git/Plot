//
//  ScaleRound.h
//  GraphicsTest
//
//  Created by Vlad on 28/05/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
    float min;
    float max;
} floatSegment;

@interface ScaleRound : NSObject

-(NSInteger)decimalPlacesForFloat:(float)number;
-(floatSegment)roundedRangeForFloatSegment:(floatSegment)range;
-(NSArray *)ticksWithinRangeFromMin:(float)min toMax:(float)max;

@end
