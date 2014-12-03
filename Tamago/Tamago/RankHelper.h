//
//  RankHelper.h
//  Tamago
//
//  Created by Nicolas on 12/3/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataHelper.h"

@class Pet;

@interface RankHelper : NSObject

-(NSArray*) selectRanking;
-(void) insertRanking:(NSArray*)object;
-(void) deleteRanking;
-(Pet*) allocPet;
+(instancetype) sharedInstance;

@end
