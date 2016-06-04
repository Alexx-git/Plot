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

-(void)scaleFromVirtualMin:(float)virtMin andMax:(float)virtMax toRealMin:(float)realMin andMax:(float)realMax;
-(float)realPositionFromVirtualPosition:(float)position;
-(float)realLengthForVirtualLength:(float)length;

@end
