//
//  PlotView.m
//  GraphicsTest
//
//  Created by Vlad on 09/04/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "PlotView.h"

@interface PlotView ()

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIImageView * zoomView;
@property (strong, nonatomic) ScaleRect * scale;
@property (assign, nonatomic) CGRect startRect;

@end

@implementation PlotView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.graphicView = [GraphicsView new];
    [self addSubview:self.graphicView];
    self.scrollView = [UIScrollView new];
    [self addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.scrollView setContentOffset:CGPointZero animated:NO];
    self.zoomView = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"Sandro.jpg"];
    [self.zoomView setImage:image];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.zoomScale = 1.0;
    self.scrollView.maximumZoomScale = 200;
    [self.scrollView addSubview:self.zoomView];
    [self bringSubviewToFront:self.graphicView];
    self.graphicView.userInteractionEnabled = NO;
    return self;
}

-(void)updateSizes
{
    self.graphicView.frame = self.bounds;
    [self.graphicView updateSizes];
    ScaleRect * scale = [ScaleRect new];
    self.scrollView.frame = [self.graphicView returnGraphicRect];
    [scale realRectSetValue:self.scrollView.frame];
    CGRect showRect = [self.graphicView.graphic.scale showRect];
    [scale virtualRectSetValue:showRect];
    
    CGRect fullVirtualRect = [self.graphicView.graphic rectForPointSeries];
    self.scrollView.contentSize = [scale realSizeForVirtualSize:fullVirtualRect.size];
    self.zoomView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    [self.scrollView setZoomScale:1];
    self.startRect = showRect;
    [self.scrollView setContentOffset:showRect.origin animated:NO];
    self.scale = [ScaleRect new];
    [self.scale realRectSetValue:fullVirtualRect];
    [self.scale virtualRectSetValue:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}

-(void)layoutSubviews
{
    [self updateSizes];
    [super layoutSubviews];
}

#pragma mark - UIScrollViewDelegate methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect rect = rectForPointAndSize(self.scrollView.contentOffset, self.scrollView.frame.size);
    rect = [self.scale realRectForVirtualRect:rect];
    [self.graphicView setShowRect:rect];
    [self.graphicView setNeedsDisplay];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.zoomView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self.scale virtualRectSetValue:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    CGRect rect = rectForPointAndSize(self.scrollView.contentOffset, self.scrollView.frame.size);
    rect = [self.scale realRectForVirtualRect:rect];
    [self.graphicView setShowRect:rect];
    [self.graphicView setNeedsDisplay];
}

@end
