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
@property (nonatomic) int level;
@property (nonatomic) int exp;

@end


NSString *const MSG_EMPTY =@"No_food";
NSString *const MSG_EXHAUST =@"Alobestia";


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
    self.energy +=50;
    [self.delegate moreProgress:self.energy];
}

-(void) timeToExercise
{
    if(self.energy > 0)
    {
        self.energy -= 10;
        self.exp += 15;
        NSLog(@"-10 +15exp");
        if(self.energy <=0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:MSG_EXHAUST object:nil];
            NSLog(@"observer");
        }
    }
    [self.delegate lessProgress:self.energy];
}

-(BOOL) valEjercitar
{
    return self.energy > 0;
}



@end
