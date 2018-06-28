//
//  ScaleLine.h
//  GraphicsTest
//
//  Created by Vlad on 02/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScaleLine : NSObject

-(void)scaleFromVirtualMin:(CGFloat)virtMin andMax:(CGFloat)virtMax toRealMin:(CGFloat)realMin andMax:(CGFloat)realMax;
-(CGFloat)realPositionForVirtualPosition:(CGFloat)position;
-(CGFloat)realLengthForVirtualLength:(CGFloat)length;

@end
