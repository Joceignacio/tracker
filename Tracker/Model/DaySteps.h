//
//  DaySteps.h
//  Tracker
//
//  Created by Joce on 26.09.17.
//  Copyright © 2017 joce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaySteps : NSObject
@property (nonatomic) NSUInteger walkSteps;
@property (nonatomic) NSUInteger aerobicSteps;
@property (nonatomic) NSUInteger runSteps;
@property (nonatomic, strong) NSString* date;
@property (nonatomic, readonly) NSUInteger allSteps;

-(unsigned long) getPercentageFromSteps: (NSUInteger) steps;
@end
