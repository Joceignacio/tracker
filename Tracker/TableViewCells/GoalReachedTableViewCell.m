//
//  GoalReachedTableViewCell.m
//  Tracker
//
//  Created by Joce on 26.09.17.
//  Copyright © 2017 joce. All rights reserved.
//

#import "GoalReachedTableViewCell.h"

@implementation GoalReachedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)getCellIdentifier
{
    return @"goalReached";
}

@end
