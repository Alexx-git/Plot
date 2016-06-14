//
//  GraphicsView.h
//  GraphicsTest
//
//  Created by Vlad on 24/03/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graphic.h"

@interface GraphicsView : UIView

@property (strong, nonatomic) Graphic * graphic;
@property (strong, nonatomic) UIColor * backgroundColor;

-(void)setShowRect:(CGRect)rect;
-(CGRect)returnGraphicRect;
-(void)updateSizes;

@end
