//
//  ScaleRound.h
//  GraphicsTest
//
//  Created by Vlad on 28/05/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

typedef struct
{
    CGFloat min;
    CGFloat max;
} CGFloatSegment;

@interface ScaleRound : NSObject

-(NSInteger)decimalPlacesForFloat:(CGFloat)number;
-(CGFloatSegment)roundedRangeForFloatSegment:(CGFloatSegment)range;
-(NSArray *)ticksWithinRangeFromMin:(CGFloat)min toMax:(CGFloat)max;

@end
