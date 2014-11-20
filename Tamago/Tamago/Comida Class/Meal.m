//
//  Meal.m
//  Tamago
//
//  Created by Nicolas on 11/20/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Meal.h"

@implementation Meal

#pragma mark - Metodos

-(instancetype) initWithDESC:(NSString *)desc andImagen:(NSString *)imagen
{
    self = [super init];
    if(self)
    {
        self.desc = desc;
        self.imagen = imagen;
    }
    return self;
}

@end
