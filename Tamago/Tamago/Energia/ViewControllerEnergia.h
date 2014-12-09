//
//  ViewControllerEnergia.h
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodProtocol.h"
#import <AddressBook/AddressBook.h>
#import "ComidaViewController.h"
#import "ArrayConst.h"
#import "Meal.h"
#import "Pet.h"
#import "NetworkManage.h"
#import "PushManager.h"
#import "RankViewController.h"
#import "LocationManager.h"
#import "MapViewController.h"
#import "ContactosViewController.h"
#import "Storage.h"


typedef void (^Success)(NSURLSessionDataTask*,id);
typedef void (^Failure)(NSURLSessionDataTask*, NSError*);

@interface ViewControllerEnergia : UIViewController <FoodProtocol, Petdelegate>

#pragma mark - Intancias
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre: (NSString *)PetName andPetPicture: (NSString *)imagen andVarArray: (int) var;

#pragma mark - Propiedades
@property (strong, nonatomic) NSString *varPicturePop;
@property (assign, nonatomic) CGPoint posOriginalImagen;
@property (assign, nonatomic) CGRect posViewJirafa;

#pragma mark - Recognizer
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *recognizer;

@end
