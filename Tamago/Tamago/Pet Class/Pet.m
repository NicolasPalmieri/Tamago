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
@property (nonatomic) int exprequired;

@end


NSString *const MSG_LVLUP =@"Alocaverna";
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
    [self calcularExpLvl];
    if(self.energy > 0)
    {
        self.energy -= 10;
        self.exp += 15;
        NSLog(@"-10+15//%d,%d",self.energy,self.exp);
        
        if(self.exp >= self.exprequired)
        {
            self.level +=1;
            [[NSNotificationCenter defaultCenter] postNotificationName:MSG_LVLUP object:nil];
            NSLog(@"%d", self.level);
        }
        
        if(self.energy <=0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:MSG_EXHAUST object:nil];
            NSLog(@"observerSend");
        }
        [self.delegate lessProgress:self.energy];
    }
}

-(BOOL) valEjercitar
{
    return self.energy > 0;
}

-(void) calcularExpLvl
{
    self.exprequired = 100*(int)pow(self.level,2);
    NSLog(@"req: %d",self.exprequired);
}

-(void) getLvl1
{
    self.level =1;
}

-(int) showLvl
{
    return self.level;
}



@end
