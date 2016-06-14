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
} floatRange;

@interface ScaleRound : NSObject

-(NSInteger)decimalPlacesForFloat:(float)number;
-(floatRange)roundedRangeForFloatRange:(floatRange)range;
-(NSArray *)ticksWithinRangeFromMin:(float)min toMax:(float)max;

@end
