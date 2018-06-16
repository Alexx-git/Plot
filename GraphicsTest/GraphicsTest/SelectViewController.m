//
//  SelectViewController.m
//  GraphicsTest
//
//  Created by VLADIMIR on 1/8/18.
//  Copyright © 2018 Vlad. All rights reserved.
//

#import "SelectViewController.h"


@interface SelectViewController ()

@property (weak, nonatomic) IBOutlet UITableView * selectTableView;

@property (strong, nonatomic) NSString * reuseIdentifier;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reuseIdentifier = @"selectCellReuseIdentifier";
    self.selectTableView.dataSource = self;
    self.selectTableView.delegate = self;
    [self.selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.reuseIdentifier];
    self.cellsData = [NSArray arrayWithObjects:
                      @{@"name":@"Lines",@"details":@""},
                      @{@"name":@"Dots",@"details":@""},
                      nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowsNumber = self.cellsData.count;
    return rowsNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    tableViewCell.textLabel.text = [[self.cellsData objectAtIndex:indexPath.row] objectForKey:@"name"];
    tableViewCell.detailTextLabel.text = [[self.cellsData objectAtIndex:indexPath.row] objectForKey:@"details"];
    tableViewCell.backgroundColor = tableView.backgroundColor;
    return tableViewCell;
}

#pragma mark - UITableViewDataDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * newStoryboard = [UIStoryboard storyboardWithName:@"GraphicsTest" bundle:nil];
    UIViewController * newViewController = [newStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:newViewController animated:NO];
}

@end
