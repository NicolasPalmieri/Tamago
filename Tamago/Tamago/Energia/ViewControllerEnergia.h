//
//  ViewControllerEnergia.h
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerEnergia : UIViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre: (NSString *) PetName andPetPicture: (NSString *) imagen;
@property (strong, nonatomic) NSString *variableName;
@property (strong, nonatomic) NSString *variablePic;

@end
