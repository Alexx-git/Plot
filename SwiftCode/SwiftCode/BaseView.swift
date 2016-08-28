//
//  BaseView.swift
//  SwiftCode
//
//  Created by Vlad on 24/08/2016.
//  Copyright © 2016 Vlad. All rights reserved.
//

import UIKit

class BaseView: UIView, UIScrollViewDelegate
{
    var displayView = DisplayView()
    var scrollView = UIScrollView()
    var zoomView = UIImageView()
    var scale = ScaleRect()
    var startRect = CGRectMake(0, 0, 0, 0)
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.addSubview(self.displayView)
        self.addSubview(self.scrollView)
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.setContentOffset(CGPointZero, animated: false)
        self.scrollView.minimumZoomScale = 0.2;
        self.scrollView.zoomScale = 1.0;
        self.scrollView.maximumZoomScale = 200;
        self.scrollView.addSubview(self.zoomView)
        self.bringSubviewToFront(self.displayView)
        self.displayView.userInteractionEnabled = false
    }
    
    func setPlotBackgroundImage(image: UIImage)
    {
        self.zoomView.image = image
    }
    
    func updateSizes()
    {
        self.displayView.frame = self.bounds
        self.displayView.updateSizes()
        let scale = ScaleRect()
        self.scrollView.frame = self.displayView.returnGraphicRect()
        NSLog("realrect:%@", NSStringFromCGRect(self.scrollView.frame))
        scale.realRectSetValue(self.scrollView.frame)
        var showRect = self.displayView.plot.scale.showRect()
        scale.virtualRectSetValue(showRect)
        NSLog("virtualrect:%@", NSStringFromCGRect(showRect));
        
        var fullVirtualRect = self.displayView.plot.rectForPointSeries()
        self.scrollView.contentSize = scale.realSizeForVirtualSize(fullVirtualRect.size)
        NSLog("size:%@", NSStringFromCGSize(self.scrollView.contentSize));
        self.zoomView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
        self.scrollView.setZoomScale(1, animated: false)
        self.startRect = showRect
        self.scrollView.setContentOffset(showRect.origin, animated:false)
        self.scale.realRectSetValue(fullVirtualRect)
        self.scale.virtualRectSetValue(CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height))
        self.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
    }

    override func layoutSubviews()
    {
        self.updateSizes()
        super.layoutSubviews()
    }

    // MARK: - UIScrollViewDelegate methods

    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        var rect = Functions.rectForPointAndSize(self.scrollView.contentOffset, size:self.scrollView.frame.size)
        rect = self.scale.realRectForVirtualRect(rect)
        self.displayView.setShowRect(rect)
        self.displayView.setNeedsDisplay()
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return self.zoomView
    }

    func scrollViewDidZoom(scrollView: UIScrollView)
    {
        self.scale.virtualRectSetValue(CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height))
        var rect = Functions.rectForPointAndSize(self.scrollView.contentOffset, size: self.scrollView.frame.size)
        rect = self.scale.realRectForVirtualRect(rect)
        self.displayView.setShowRect(rect)
        self.displayView.setNeedsDisplay()
    }


}
