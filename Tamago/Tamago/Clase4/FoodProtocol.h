//
//  FoodProtocol.h
//  Tamago
//
//  Created by Nicolas on 11/20/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#ifndef Tamago_FoodProtocol_h
#define Tamago_FoodProtocol_h
#import "Meal.h"

@protocol FoodProtocol <NSObject>

@required

- (void)DidSelectedMeal: (Meal *) food;

@end

#endif
