//
//  DaySteps.m
//  Tracker
//
//  Created by Joce on 26.09.17.
//  Copyright © 2017 joce. All rights reserved.
//

#import "DaySteps.h"
@interface DaySteps()
@property (nonatomic, readwrite) NSUInteger allSteps;
@end

@implementation DaySteps
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.walkSteps = [self getRandomSteps];
        self.aerobicSteps = [self getRandomSteps];
        self.runSteps = [self getRandomSteps];
//        NSLog(@"ALL STEPS are %d", self.allSteps);
    }
    return self;
}

- (unsigned) getRandomSteps
{
    return arc4random() % 3000;// I prefered to point top limit as 3000 steps per every steps type
}

- (NSUInteger)allSteps
{
    return self.walkSteps + self.aerobicSteps + self.runSteps;
}

- (unsigned long )getPercentageFromSteps : (NSUInteger) steps
{
    unsigned long percentage = steps * 100 /self.allSteps;
    return percentage;
}


@end
