//
//  GraphicAxis.m
//  GraphicsTest
//
//  Created by Vlad on 02/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "GraphicAxis.h"
#import "ScaleLine.h"

@implementation GraphicAxis

-(instancetype)init
{
    self = [super init];
    self.color = [UIColor blackColor];
    self.title = @"";
    self.titleFont = [UIFont systemFontOfSize:10];
    self.tickFont = [UIFont systemFontOfSize:10];
    return self;
}

@end
