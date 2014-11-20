//
//  ViewControllerEnergia.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ViewControllerEnergia.h"
#import "ComidaViewController.h"

@interface ViewControllerEnergia ()

#pragma mark - Propiedades

@property (strong, nonatomic) IBOutlet UIImageView *ImageViewProfileEnergia;
@property (strong, nonatomic) IBOutlet UIProgressView *progressEnergia;
@property (strong, nonatomic) IBOutlet UILabel *labelNameENergy;
@property (strong, nonatomic) IBOutlet UIButton *btnFeed;
@property (strong, nonatomic) IBOutlet UIImageView *imgBringFood;

@end

@implementation ViewControllerEnergia

#pragma mark - Instancias

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre:(NSString *)PetName andPetPicture:(NSString *) imagen;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.variableName = PetName; //almaceno nombre en variable
        self.variablePic = imagen; //almaceno imagen en variable
    }
    return self;
}

#pragma mark - Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:@"Energy"];
    
    self.labelNameENergy.text = self.variableName; //asigno string de la variable=label
    self.ImageViewProfileEnergia.image = [UIImage imageNamed: self.variablePic]; //parametro
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Will
- (void) viewWillAppear:(BOOL)animated
{
    self DidSelectedMeal:<#(Meal *)#>
}

#pragma mark - Botones
- (IBAction)btnFeed:(id)sender
{
    ComidaViewController *myView = [[ComidaViewController alloc] initWithNibName:@"ComidaViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:myView animated:YES];
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
