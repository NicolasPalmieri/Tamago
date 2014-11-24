//
//  Pet.h
//  Tamago
//
//  Created by Nicolas on 11/24/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

typedef enum
{
    TYPE_CIERVO =0,
    TYPE_GATO,
    TYPE_JIRAFA,
    TYPE_LEON
    
} mascotaTypes;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imagen;
@property (nonatomic) mascotaTypes type;

+(instancetype) sharedInstance;

@end
