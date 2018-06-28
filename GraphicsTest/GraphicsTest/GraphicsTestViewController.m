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
@property (strong, nonatomic) NSArray * demoPointSeries;
@property (strong, nonatomic) NSTimer * timer;

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
//    [self setRandomPointSeries];
    [self addAnotherSeries];
    self.plotView.graphicView.backgroundColor = [UIColor colorWithRed:0.3 green:0.2 blue:0.3 alpha:1];
    [self.plotView setNeedsDisplay];
    [self.plotView.graphicView setNeedsDisplay];
}


- (void) addAnotherSeries{
    NSMutableArray * mPoints = [NSMutableArray new];
    for (int i = 0; i < 50; i++) {
        double x = 500 + 10 * i * cosf(i);
        double y = 500 + 10 * i * sinf(i);
        [mPoints addObject: [GraphicPoint pointWithX:x Y:y]];
    }
    PointSeries * series = [PointSeries new];
    series.pointColor = [UIColor redColor];
    series.lineColor = [UIColor greenColor];
    series.lineWidth = 1.0;
    series.style = GPDrawStyleRound;
    series.drawElements = PSDrawElementsAll;
    series.size = 4;
    [series setPoints:[NSArray arrayWithArray:mPoints]];
    [self.plotView.graphicView.graphic addPointSeries:series];
    [self.plotView.graphicView setShowRect:CGRectMake(0, 0, 999, 999)];
}

-(void)setRandomPointSeries
{
    PointSeries * series = [PointSeries new];
    series.pointColor = [UIColor redColor];
    series.lineColor = [UIColor greenColor];
    series.lineWidth = 1.0;
    series.style = GPDrawStyleRound;
    series.drawElements = PSDrawElementsAll;
    series.size = 4;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(addRandomPoint) userInfo:series repeats:YES];
    
}

-(void)addRandomPoint
{
    static CGFloat y;
    CGFloat x = arc4random_uniform(1001);
    NSMutableArray * tempArray = [NSMutableArray arrayWithArray:self.demoPointSeries];
    [tempArray addObject: [GraphicPoint pointWithX:x Y:y]];
    y += 10;
    PointSeries * series = self.timer.userInfo;
    self.demoPointSeries = [NSArray arrayWithArray:tempArray];
    [series setPoints:[NSArray arrayWithArray:self.demoPointSeries]];
    [self.plotView.graphicView.graphic clearPointSeries];
    [self.plotView.graphicView.graphic addPointSeries:series];
    [self.plotView.graphicView setShowRect:CGRectMake(0, 0, 999, 999)];
    if (y > 1000)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
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
