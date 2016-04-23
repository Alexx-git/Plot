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
@property (assign, nonatomic) CGRect startRect;
@property (assign, nonatomic) float startZoomScale;

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
    self.scrollView.maximumZoomScale = 20;
    [self.scrollView addSubview:self.zoomView];
    [self bringSubviewToFront:self.graphicView];
    self.graphicView.userInteractionEnabled = NO;
    return self;
}

-(void)updateSizes
{
    self.graphicView.frame = self.bounds;
    [self.graphicView updateSizes];
    self.scrollView.frame = [self.graphicView returnGraphicRect];
    CGRect showRect = [self.graphicView.graphic.scale showRect];
    self.startRect = CGRectMake(0, 0, showRect.size.width, showRect.size.height);
    self.startZoomScale = self.scrollView.zoomScale;
    CGRect fullVirtualRect = [self.graphicView.graphic rectForPointSeries];
    float width = self.scrollView.frame.size.width + fullVirtualRect.size.width - self.startRect.size.width;
    float height = self.scrollView.frame.size.height + fullVirtualRect.size.height - self.startRect.size.height;
    self.scrollView.contentSize = CGSizeMake(width, height);
    self.zoomView.frame = CGRectMake(0, 0, width, height);
    [self.scrollView setContentOffset:showRect.origin animated:NO];
}

-(void)layoutSubviews
{
    [self updateSizes];
    [super layoutSubviews];
}

#pragma mark - UIScrollViewDelegate methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint scrollOffset = self.scrollView.contentOffset;
    //NSLog(@"soff:%@", NSStringFromCGPoint(scrollOffset));
    //NSLog(@"size:%@", NSStringFromCGSize(self.scrollView.contentSize));
    //CGRect rect = CGRectOffset(self.startRect, scrollOffset.x, - scrollOffset.y);
    CGRect rect = CGRectOffset(self.startRect, scrollOffset.x, scrollOffset.y);
    rect = [self transformRect:rect withZoom:self.scrollView.zoomScale];
    [self.graphicView setShowRect:rect];
    [self.graphicView setNeedsDisplay];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.zoomView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    float zoom = self.scrollView.zoomScale / self.startZoomScale;
    CGRect rect = [self.graphicView.graphic.scale showRect];
    rect = [self transformRect:rect withZoom:zoom];
    [self.graphicView setShowRect:rect];
    [self.graphicView setNeedsDisplay];
    NSLog(@"newShowRect:%@", NSStringFromCGRect(rect));
    NSLog(@"Zoom:%f", zoom);
}

-(CGRect)transformRect:(CGRect)rect withZoom:(float)zoom
{
    CGRect zoomRect;
    CGSize size = CGSizeMake(rect.size.width * zoom, rect.size.height * zoom);
    zoomRect.size = size;
    zoomRect.origin = CGPointMake(rect.origin.x + rect.size.width - size.width, rect.origin.y + rect.size.height - size.height);
    return zoomRect;
}

@end
