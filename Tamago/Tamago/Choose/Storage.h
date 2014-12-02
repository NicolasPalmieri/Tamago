//
//  Storage.h
//  Tamago
//
//  Created by Nicolas on 12/2/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"

@interface Storage : NSObject

+(void) savePet:(Pet*) pet;
+(Pet*) loadPet;
+(NSString*) getLocalFilePathForCompletedPet;

@end
