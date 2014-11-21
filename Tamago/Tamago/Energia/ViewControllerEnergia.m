//
//  ViewControllerEnergia.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ViewControllerEnergia.h"
#import "ComidaViewController.h"
#import "ArrayConst.h"

@interface ViewControllerEnergia ()

#pragma mark - Propiedades

@property (strong, nonatomic) IBOutlet UIImageView *ImageViewProfileEnergia;
@property (strong, nonatomic) IBOutlet UIProgressView *progressEnergia;
@property (strong, nonatomic) IBOutlet UILabel *labelNameENergy;
@property (strong, nonatomic) IBOutlet UIButton *btnFeed;
@property (strong, nonatomic) IBOutlet UIImageView *imgBringFood;
@property (strong, nonatomic) IBOutlet UIView *ViewRango;
@property (strong, nonatomic) ArrayConst *gif;

@end

@implementation ViewControllerEnergia

#pragma mark - Instancias
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre:(NSString *)PetName andPetPicture:(NSString *) imagen andVarArray:(int)var;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.variableName = PetName; //almaceno nombre en variable
        self.variablePic = imagen; //almaceno imagen en variable
        self.varArray = var;
    }
    return self;
}

-(void)DidSelectedMeal:(Meal *)imag
{
    self.varPicturePop = imag.imagen;
}

#pragma mark - Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:@"Energy"];
    
    self.posViewJirafa = [self.ViewRango frame]; //asigno posicion original del view, para editar jirafa luego
    
    /*if([self.ImageViewProfileEnergia //:@"%jirafa%"])
    {
            //reposiciono rango/boca jirafa
        [self.ViewRango setFrame:CGRectMake(154.50, 250.50, self.posViewJirafa.size.width, self.posViewJirafa.size.height)];
        [self.ViewRango setAlpha:1];
    }*/
    
    self.labelNameENergy.text = self.variableName; //asigno string de la variable=label
    self.ImageViewProfileEnergia.image = [UIImage imageNamed: self.variablePic]; //parametro
    
    [self.ViewRango setAlpha:0]; //hidden magico del rango/boca
    
    self.posOriginalImagen = CGPointMake(self.imgBringFood.frame.origin.x, self.imgBringFood.frame.origin.y); //posicion orig
                                                                                                            //responde al change_comida
    
    self.gif = [[ArrayConst alloc] init];
    [self.gif FILLarray:self.varArray];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.imgBringFood.image = [UIImage imageNamed:self.varPicturePop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Disapear
- (void) viewWillDisappear:(BOOL)animated
{
    [self.imgBringFood setCenter:self.posOriginalImagen]; //asigno pos original
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.imgBringFood setHidden:NO]; //en caso de REalimentar
}

#pragma mark - Botones
- (IBAction)btnFeed:(id)sender
{
    ComidaViewController *myView = [[ComidaViewController alloc] initWithNibName:@"ComidaViewController" bundle:[NSBundle mainBundle]];
    [myView setDelegate:self];
    [self.navigationController pushViewController:myView animated:YES];
}

#pragma mark - Animaciones
- (IBAction)viewTouchScreen:(id)sender
{
    if(self.imgBringFood.image)
    {
        CGPoint touchLocation = [sender locationInView:self.view]; //declaro posición del clic

        [UIView animateWithDuration:0.7f
                              delay:0.2f
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^
                                    {
                                        [self.imgBringFood setCenter:touchLocation];
                                    }
                         completion:^(BOOL finished)
                                    {
                                        CGRect petEATtime = [self.ViewRango frame]; //declaro rango a comparar [rect]
                                        
                                        if (CGRectContainsPoint(petEATtime, touchLocation))
                                            {
                                                NSLog(@"Fed!");
                                                [self.imgBringFood setHidden:YES];
                                                [self EatGift]; //itero_gif
                                                [self ProgressLIVE]; //creceProgressHP
                                            }
                                        else
                                            {
                                                NSLog(@"Hungry!");
                                                return;
                                            }
                                    }];
    }
}

-(void) EatGift
{
    NSArray *imagenesArray = @[[UIImage imageNamed:self.gif.array[0]],
                             [UIImage imageNamed:self.gif.array[1]],
                             [UIImage imageNamed:self.gif.array[2]],
                             [UIImage imageNamed:self.gif.array[3]]];
    
    [self.ImageViewProfileEnergia setAnimationImages:imagenesArray];
    [self.ImageViewProfileEnergia setAnimationDuration:0.7f];
    [self.ImageViewProfileEnergia setAnimationRepeatCount:2.0f];
    [self.ImageViewProfileEnergia startAnimating];
}

-(void) ProgressLIVE
{
    [UIView animateWithDuration:1.4f animations:^(void)
                                                  {
                                                      [self.progressEnergia setProgress:1 animated:YES];
                                                  }];
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
