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
#import "GoalReachedTableViewCell.h"

@interface TrackerViewController ()
@property (nonatomic, strong)  NSMutableArray *days;//days with step statistics
@property (nonatomic, strong) NSNumber *goal;
@property (nonatomic, strong) NSDate *currentDate;
@end

@implementation TrackerViewController

//days getter
- (NSMutableArray *)days
{
    if (!_days) _days =[[NSMutableArray alloc] init];
    return _days;
}

//goal getter
- (NSNumber *)goal
{
    if (!_goal)
    {
        _goal = @(4000);//initial standart value
    }
    return _goal;
}

//current date getter
-(NSDate *)currentDate
{
    if (!_currentDate) return [NSDate date];
    else return _currentDate;
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

// creating array of days with step statistics
-(void) createDaysArray{
    // defaultly we have 3 days statistics
    for (int i = 0; i<3; i += 1) {
        DaySteps *daySteps = [[DaySteps alloc] init];
        daySteps.date =  [self getDateString:self.currentDate];
        self.currentDate = [self getPreviousDay:self.currentDate];
        self.days[i] = daySteps;
    }
}

// getting next date
- (NSDate *) getNextDay : (NSDate *) date
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate: date options:0];
    return nextDate;
}
// getting previous date
- (NSDate *) getPreviousDay : (NSDate *) date
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate: date options:0];
    return nextDate;
}


// getting date correctly from NSDATE
-(NSString *) getDateString : (NSDate *) date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.YYYY"];
    return [dateFormat stringFromDate:date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)setGoalTap:(UIBarButtonItem *)sender {
    //Alert controller with textfield to set new goal
    
    UIAlertController *allertController = [UIAlertController alertControllerWithTitle:@"Enter your goal" message:@"Goal for steps per day" preferredStyle:UIAlertControllerStyleAlert];
    
    //adding action with complition block
    UIAlertAction *allertAction = [UIAlertAction actionWithTitle:@"ok" style: UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *newGoal = [formatter numberFromString:allertController.textFields[0].text];
        self.goal = newGoal;
        [self.daysTableView reloadData];
    }] ;
    
    //adding textfield
    [allertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Type new goal";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [allertController addAction:allertAction];
    
    //present the allert
    [self presentViewController:allertController animated:YES completion:nil];
}

- (IBAction)addDayTap:(UIBarButtonItem *)sender {
    DaySteps *daySteps = [[DaySteps alloc] init];
    daySteps.date =  [self getDateString:self.currentDate];
    self.currentDate = [self getNextDay:self.currentDate];
    [self.days insertObject:daySteps atIndex:0];
    [self.daysTableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
}

// NOTE:  Table View configuration

//number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if goal is reached we'll have 2
    if ([self.days[section] allSteps ] > self.goal.unsignedIntegerValue)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)// Height for step statistics cell
    {
        return 94;
    }
    else // Height for "goal reached" cell
    {
        return 34;
    }
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
    // first cell type is "step statistics"
    if (indexPath.row == 0)
    {
        DayStepsTableViewCell *cell =  [self.daysTableView dequeueReusableCellWithIdentifier: DayStepsTableViewCell.getCellIdentifier ];
        DaySteps *day = self.days[indexPath.section];

        cell.dateLabel.text = day.date;
        
        //Steps progress
        cell.progressLabel.text = [NSString stringWithFormat:@"%lu / %@ steps", (unsigned long)day.allSteps, self.goal];
        
        
        cell.walkSteps.text = [NSString stringWithFormat:@"%lu",(unsigned long)day.walkSteps];
        cell.aerobicSteps.text = [NSString stringWithFormat:@"%lu",(unsigned long)day.aerobicSteps];
        cell.runSteps.text = [NSString stringWithFormat:@"%lu",(unsigned long)day.runSteps];
        
        //Calculating infographical views
        int margins = 16 * 2; // margins of infographicalView
        CGFloat infographicWidth = self.view.frame.size.width - margins;
        
        cell.inforraphicViewWidth.constant = infographicWidth;
        unsigned long walkWidth = (infographicWidth * [day getPercentageFromSteps: day.walkSteps])/100;
        unsigned long aerobicWidth = (infographicWidth * [day getPercentageFromSteps: day.aerobicSteps])/100;
        unsigned long runWidth = (infographicWidth * [day getPercentageFromSteps: day.runSteps])/100;
        
        [cell.walkViewWidth setConstant: walkWidth];
        [cell.aerobicViewWidth setConstant:aerobicWidth];
        [cell.runViewWidth setConstant:runWidth];
        return cell;
    }
    else
    {
        // second cell type is "Goal reached" message
        // will be shown when step goal is reached
        
        UITableViewCell *cell = [self.daysTableView dequeueReusableCellWithIdentifier: GoalReachedTableViewCell.getCellIdentifier ];
        return cell;
    }
}


// custom separators via header view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    [header setBackgroundColor:[UIColor clearColor]];
    UIView *topBorder = [UIView new];
    UIView *btmBorder = [UIView new];
    topBorder.frame = CGRectMake(0, 15.5, self.view.frame.size.width, 0.5);
    btmBorder.frame = CGRectMake(0, 0, self.view.frame.size.width, 0.5);
    [topBorder setBackgroundColor:[UIColor grayColor]];
    [btmBorder setBackgroundColor:[UIColor grayColor]];
    [header addSubview:topBorder];
    [header addSubview:btmBorder];
    return header;
}

@end
