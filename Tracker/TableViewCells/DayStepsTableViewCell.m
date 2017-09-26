//
//  DayStepsTableViewCell.m
//  Tracker
//
//  Created by Joce on 26.09.17.
//  Copyright © 2017 joce. All rights reserved.
//

#import "DayStepsTableViewCell.h"

@implementation DayStepsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (NSString *)getNibName
{
    return  @"DayStepsTableViewCell";
}

+ (NSString *)getCellIdentifier
{
    return @"dayStepsCell";
}
@end
