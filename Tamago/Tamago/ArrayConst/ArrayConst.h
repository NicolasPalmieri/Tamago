//
//  ArrayConst.h
//  Tamago
//
//  Created by Nicolas on 11/21/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"

@interface ArrayConst : NSObject

@property (strong, nonatomic) NSArray *arrayEat;
@property (strong, nonatomic) NSArray *arrayTrain;

-(void)FILLarray:(Pet*) mascota;

@end
