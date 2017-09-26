//
//  ViewController.h
//  Tracker
//
//  Created by Joce on 26.09.17.
//  Copyright © 2017 joce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *daysTableView;
- (IBAction)setGoalTap:(UIBarButtonItem *)sender;
- (IBAction)addDayTap:(UIBarButtonItem *)sender;


@end

