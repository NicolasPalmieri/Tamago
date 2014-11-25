//
//  Pet.m
//  Tamago
//
//  Created by Nicolas on 11/24/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Pet.h"

@interface Pet ()

@property (nonatomic) int energy;

@end


@implementation Pet

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^
                {
                _sharedObject = [[self alloc] init]; });
    return _sharedObject;
}

-(void) timeToEat
{
    self.energy = 100;
    [self.delegate moreProgress:self.energy];
}

-(void) timeToExercise
{
    if(self.energy > 0)
    {
        self.energy -= 10;
    }
    [self.delegate lessProgress:self.energy];
}

@end
