//
//  ViewControllerEnergia.h
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodProtocol.h"
#import <MessageUI/MessageUI.h>
#import "Pet.h"

typedef void (^Success)(NSURLSessionDataTask*,id);
typedef void (^Failure)(NSURLSessionDataTask*, NSError*);

@interface ViewControllerEnergia : UIViewController <FoodProtocol, MFMailComposeViewControllerDelegate, Petdelegate>

#pragma mark - Intancias
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre: (NSString *)PetName andPetPicture: (NSString *)imagen andVarArray: (int) var;

#pragma mark - Propiedades
@property (strong, nonatomic) NSString *varPicturePop;
@property (assign, nonatomic) CGPoint posOriginalImagen;
@property (assign, nonatomic) CGRect posViewJirafa;

#pragma mark - Recognizer
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *recognizer;

@end
