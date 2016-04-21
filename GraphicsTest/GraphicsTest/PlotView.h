//
//  PlotView.h
//  GraphicsTest
//
//  Created by Vlad on 09/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicsView.h"

@interface PlotView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) GraphicsView * graphicView;

@end
