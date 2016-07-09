//
//  GraphicsTestViewController.m
//  GraphicsTest
//
//  Created by Vlad on 24/03/2016.
//  Copyright (c) 2016 Vlad. All rights reserved.
//

#import "GraphicsTestViewController.h"
#import "PlotView.h"

@interface GraphicsTestViewController ()

@property (weak, nonatomic) IBOutlet PlotView *plotView;

@end

@implementation GraphicsTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSArray * array = [NSArray arrayWithObjects:
//    [GraphicPoint pointWithX:10 Y:250],
//    [GraphicPoint pointWithX:264 Y:12],
//    [GraphicPoint pointWithX:222 Y:333],
//    [GraphicPoint pointWithX:67 Y:23], nil];
//    PointSeries * series = [PointSeries new];
//    [series setPoints:array];
//    [self.plotView.graphicView.graphic addPointSeries:series];
    [self addAnotherSeries];
    self.plotView.graphicView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
}


- (void) addAnotherSeries{
    NSMutableArray * mPoints = [NSMutableArray new];
    PointSeries * series = [PointSeries new];
//    for (int i = 0; i < 1000; i++) {
//        double f = i;
//        [mPoints addObject: [GraphicPoint pointWithX:f Y:f]];
//    }
//    series.pointColor = [UIColor greenColor];
//    series.style = GPDrawStyleStar;
//    series.size = 4;
//    [series setPoints:[NSArray arrayWithArray:mPoints]];
//    [self.plotView.graphicView.graphic addPointSeries:series];
    mPoints = [NSMutableArray new];
    for (int i = 0; i < 50; i++) {
        double x = 500 + 10 * i * cosf(i);
        double y = 500 + 10 * i * sinf(i);
        [mPoints addObject: [GraphicPoint pointWithX:x Y:y]];
    }
    series = [PointSeries new];
    series.pointColor = [UIColor redColor];
    series.lineColor = [UIColor greenColor];
    series.lineWidth = 1.0;
    series.style = GPDrawStyleRound;
    series.size = 4;
    [series setPoints:[NSArray arrayWithArray:mPoints]];
    [self.plotView.graphicView.graphic addPointSeries:series];
    [self.plotView.graphicView setShowRect:CGRectMake(0, 0, 999, 999)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
