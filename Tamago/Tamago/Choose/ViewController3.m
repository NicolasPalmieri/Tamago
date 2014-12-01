//
//  ViewController3.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ViewController3.h"
#import "ViewControllerEnergia.h"
#import "Pet.h"

@interface ViewController3 ()

#pragma mark - Propiedades
@property (strong, nonatomic) IBOutlet UILabel *labelPetName;
@property (strong, nonatomic) IBOutlet UIImageView *ImageViewPerfilPicture;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollGroupbox1;
@property (assign, nonatomic) mascotaTypes petType;


@end

@implementation ViewController3

#pragma mark - Instancia
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre:(NSString *)PetName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [[Pet sharedInstance] setName:PetName]; //almaceno parametro en variable
    }
    return self;
}

#pragma mark - Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:@"Selection"];
    
    //scrolleo
    [self.ScrollGroupbox1 setContentSize:CGSizeMake(self.ScrollGroupbox1.frame.size.width
                                                    + 70, self.ScrollGroupbox1.frame.size.height)];
    
    //asigno string de la variable
    self.labelPetName.text = [Pet sharedInstance].name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Botones
//switchPics

- (IBAction)choosePetType:(UIButton* )sender
{
    self.petType = sender.tag;
    switch (self.petType)
    {
        case TYPE_CIERVO:
            self.ImageViewPerfilPicture.image = [UIImage imageNamed:@"ciervo_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"ciervo_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_CIERVO];
            break;
        case TYPE_GATO:
            self.ImageViewPerfilPicture.image = [UIImage imageNamed: @"gato_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"gato_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_GATO];
            break;
        case TYPE_LEON:
            self.ImageViewPerfilPicture.image = [UIImage imageNamed: @"leon_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"leon_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_LEON];
            break;
        case TYPE_JIRAFA:
            self.ImageViewPerfilPicture.image = [UIImage imageNamed: @"jirafa_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"jirafa_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_JIRAFA];
            break;
    }
}


- (IBAction)buttonVIEW3:(id)sender
{
    if([Pet sharedInstance].imagen) //validar selection
    {
        ViewControllerEnergia *myView = [[ViewControllerEnergia alloc] initWithNibName:@"ViewControllerEnergia" bundle:[NSBundle mainBundle] andPetNombre:self.labelPetName.text andPetPicture:[Pet sharedInstance].imagen andVarArray:[Pet sharedInstance].type];
    [self.navigationController pushViewController:myView animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selection"
                                                        message:@"Choose!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Go"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
