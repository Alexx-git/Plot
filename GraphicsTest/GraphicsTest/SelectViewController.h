//
//  SelectViewController.h
//  GraphicsTest
//
//  Created by VLADIMIR on 1/8/18.
//  Copyright © 2018 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray * cellsData;

@end
