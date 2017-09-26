//
//  ViewController.m
//  Tracker
//
//  Created by Joce on 26.09.17.
//  Copyright © 2017 joce. All rights reserved.
//

#import "TrackerViewController.h"
#import "DaySteps.h"
#import "DayStepsTableViewCell.h"

@interface TrackerViewController ()
@property (nonatomic, strong)  NSMutableArray *days;//days with step statistics
@property (nonatomic, strong) NSNumber *goal;
@end

@implementation TrackerViewController

- (NSMutableArray *)days
{
    if (!_days) _days =[[NSMutableArray alloc] init];
    return _days;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDaysArray];
    self.daysTableView.delegate = self;
    self.daysTableView.dataSource = self;
    [self.daysTableView reloadData];
    self.daysTableView.tableFooterView = [[UIView alloc] init];
    [self.daysTableView registerNib: [UINib nibWithNibName: DayStepsTableViewCell.getNibName bundle:nil]   forCellReuseIdentifier: DayStepsTableViewCell.getCellIdentifier];
}

-(void) createDaysArray{
    for (int i = 0; i<4; i += 1) {
        DaySteps *daySteps = [[DaySteps alloc] init];
        daySteps.date = [NSString stringWithFormat:@"2%d.09.2017", i];
//        NSDate *currentDate =
        self.days[i] = daySteps;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)setGoalTap:(UIBarButtonItem *)sender {
}

- (IBAction)addDayTap:(UIBarButtonItem *)sender {
}

// NOTE:  Table View configuration

//number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  16;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.days.count;
}

//configuring cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DayStepsTableViewCell *cell =  [self.daysTableView dequeueReusableCellWithIdentifier: DayStepsTableViewCell.getCellIdentifier];
    return cell;
}

@end
