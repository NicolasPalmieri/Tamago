//
//  Meal.h
//  Tamago
//
//  Created by Nicolas on 11/20/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject

#pragma mark - Propiedades
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *imagen;

-(instancetype) initWithDESC: (NSString *) desc andImagen: (NSString *) imagen;

@end
