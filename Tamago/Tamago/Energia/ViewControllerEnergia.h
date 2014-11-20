//
//  ViewControllerEnergia.h
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodProtocol.h"

@interface ViewControllerEnergia : UIViewController <FoodProtocol>

#pragma mark - Intancias
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre: (NSString *)PetName andPetPicture: (NSString *)imagen;

#pragma mark - Propiedades
@property (strong, nonatomic) NSString *variableName;
@property (strong, nonatomic) NSString *variablePic;
@property (strong, nonatomic) NSString *varPicturePop;

@end
