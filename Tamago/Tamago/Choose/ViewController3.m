//
//  ViewController3.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ViewController3.h"
#import "ViewControllerEnergia.h"

@interface ViewController3 ()

#pragma mark - Propiedades
@property (strong, nonatomic) IBOutlet UILabel *labelPetName;
@property (strong, nonatomic) IBOutlet UIImageView *ImageViewPerfilPicture;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollGroupbox1;
@property (strong, nonatomic) IBOutlet UIButton *scrollbut1;
@property (strong, nonatomic) IBOutlet UIButton *scrollbut2;
@property (strong, nonatomic) IBOutlet UIButton *scrollbut3;
@property (strong, nonatomic) IBOutlet UIButton *scrollbut4;
@property (strong, nonatomic) NSString *image;

@end

@implementation ViewController3

#pragma mark - Instancia
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre:(NSString *)PetName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.variableName = PetName; //almaceno parametro en variable
    }
    return self;
}

#pragma mark - Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:@"Selection"];
    
    [self.ScrollGroupbox1 setContentSize:CGSizeMake(580, 150)]; //scrolleo
    
    self.labelPetName.text = self.variableName; //asigno string de la variable
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Botones
//switchPics
- (IBAction)chooseCiervo:(id)sender
{
    self.ImageViewPerfilPicture.image = [UIImage imageNamed:@"ciervo_comiendo_1"];
    self.image =@"ciervo_comiendo_1";
}

- (IBAction)chooseGato:(id)sender
{
    self.ImageViewPerfilPicture.image = [UIImage imageNamed: @"gato_comiendo_1"];
    self.image =@"gato_comiendo_1";
}

- (IBAction)chooseJirafa:(id)sender
{
    self.ImageViewPerfilPicture.image = [UIImage imageNamed: @"jirafa_comiendo_1"];
    self.image =@"jirafa_comiendo_1";
}

- (IBAction)chooseLeon:(id)sender
{
    self.ImageViewPerfilPicture.image = [UIImage imageNamed: @"leon_comiendo_1"];
    self.image =@"leon_comiendo_1";
}

- (IBAction)buttonVIEW3:(id)sender
{
    if(self.image) //validar selection
    {
    ViewControllerEnergia *myView = [[ViewControllerEnergia alloc] initWithNibName:@"ViewControllerEnergia" bundle:[NSBundle mainBundle] andPetNombre:self.labelPetName.text andPetPicture:self.image];
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







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end
