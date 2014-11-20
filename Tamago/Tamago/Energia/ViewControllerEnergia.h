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
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetPicture: (NSString *)imagen;

#pragma mark - Propiedades
@property (strong, nonatomic) NSString *variableName;
@property (strong, nonatomic) NSString *variablePic;

#pragma mark - Delegate/Prot
@property (nonatomic, weak) id <FoodProtocol> delegate;

@end
