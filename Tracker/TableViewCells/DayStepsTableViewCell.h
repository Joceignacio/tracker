//
//  DayStepsTableViewCell.h
//  Tracker
//
//  Created by Joce on 26.09.17.
//  Copyright © 2017 joce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayStepsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *walkViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aerobicViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *runViewWidth;
@property (weak, nonatomic) IBOutlet UIView *infographicView;
@property (weak, nonatomic) IBOutlet UILabel *walkSteps;
@property (weak, nonatomic) IBOutlet UILabel *aerobicSteps;
@property (weak, nonatomic) IBOutlet UILabel *runSteps;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inforraphicViewWidth;

+ (NSString *) getNibName;
+ (NSString *) getCellIdentifier;

@end
