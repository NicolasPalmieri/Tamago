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
#import "Pet.h"
#import "Meal.h"

@interface ViewControllerEnergia ()

#pragma mark - Propiedades
@property (strong, nonatomic) IBOutlet UIImageView *ImageViewProfileEnergia;
@property (strong, nonatomic) IBOutlet UIProgressView *progressEnergia;
@property (strong, nonatomic) IBOutlet UILabel *labelNameENergy;
@property (strong, nonatomic) IBOutlet UIButton *btnFeed;
@property (strong, nonatomic) IBOutlet UIImageView *imgBringFood;
@property (strong, nonatomic) IBOutlet UIView *ViewRango;
@property (strong, nonatomic) ArrayConst *gif;
@property (strong, nonatomic) ArrayConst *train;
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation ViewControllerEnergia

#pragma mark - Instancias
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPetNombre:(NSString *)PetName andPetPicture:(NSString *) imagen andVarArray:(int)var;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [[Pet sharedInstance] setName: PetName]; //almaceno nombre
        [[Pet sharedInstance] setImagen: imagen]; //almaceno imagen
        [[Pet sharedInstance] setType: var]; //almaceno tipo
    }
    return self;
}

-(void)DidSelectedMeal:(Meal *)imag
{
    [Meal sharedInstance].imagen = imag.imagen;
}

#pragma mark - Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //Titulo UIViewEnergia
    [self setTitle:@"Energy"];
    
    //pos original del view, para editar jirafa luego
    self.posViewJirafa = [self.ViewRango frame];
    
    /*if([self.ImageViewProfileEnergia //:@"%jirafa%"])
    {
            //reposiciono rango/boca jirafa
        [self.ViewRango setFrame:CGRectMake(154.50, 250.50, self.posViewJirafa.size.width, self.posViewJirafa.size.height)];
        [self.ViewRango setAlpha:1];
    }*/
    
    //asigno nombre e imagen de mascota
    [self.labelNameENergy setText: [Pet sharedInstance].name];
    self.ImageViewProfileEnergia.image = [UIImage imageNamed: [Pet sharedInstance].imagen];
    
    //hidden magico del rango/boca
    [self.ViewRango setAlpha:0];
    
    //posicion orig que responde al change_comida
    self.posOriginalImagen = CGPointMake(self.imgBringFood.frame.origin.x, self.imgBringFood.frame.origin.y);
    
    //fill gifEat-Train
    self.gif = [[ArrayConst alloc] init];
    [self.gif FILLarray:[Pet sharedInstance]];
    
    //fill2
    self.train = [[ArrayConst alloc] init];
    [self.train FILLarray:[Pet sharedInstance]];
    

}

- (void) viewWillAppear:(BOOL)animated
{
    self.imgBringFood.image = [UIImage imageNamed:[Meal sharedInstance].imagen];
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
    
   if(self.timer && [self.timer isValid])
   {
       [self.timer invalidate];
        self.timer = nil;
   }
}

#pragma mark - Botones
- (IBAction)btnFeed:(id)sender
{
    ComidaViewController *myView = [[ComidaViewController alloc] initWithNibName:@"ComidaViewController" bundle:[NSBundle mainBundle]];
    [myView setDelegate:self];
    [self.navigationController pushViewController:myView animated:YES];
}

- (IBAction)btnTrain:(id)sender
{
    [self trainGif];
    //[self entrenarPet];
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
                                                [self eatGift]; //itero_gif
                                                [self progressLive]; //creceProgressHP
                                            }
                                        else
                                            {
                                                NSLog(@"Hungry!");
                                                return;
                                            }
                                    }];
    }
}

-(void) eatGift
{
    NSArray *imagenesArray = @[[UIImage imageNamed:self.gif.arrayEat[0]],
                             [UIImage imageNamed:self.gif.arrayEat[1]],
                             [UIImage imageNamed:self.gif.arrayEat[2]],
                             [UIImage imageNamed:self.gif.arrayEat[3]]];
    
    [self.ImageViewProfileEnergia setAnimationImages:imagenesArray];
    [self.ImageViewProfileEnergia setAnimationDuration:0.7f];
    [self.ImageViewProfileEnergia setAnimationRepeatCount:2.0f];
    [self.ImageViewProfileEnergia startAnimating];
}

-(void) trainGif
{
    NSArray *imagenesArrayAux = @[[UIImage imageNamed:self.train.arrayTrain[0]],
                               [UIImage imageNamed:self.train.arrayTrain[1]],
                               [UIImage imageNamed:self.train.arrayTrain[2]],
                               [UIImage imageNamed:self.train.arrayTrain[3]]];
    
    [self.ImageViewProfileEnergia setAnimationImages:imagenesArrayAux];
    [self.ImageViewProfileEnergia setAnimationDuration:0.5f];
    [self.ImageViewProfileEnergia setAnimationRepeatCount:4.0f];
    [self.ImageViewProfileEnergia startAnimating];
}

-(void) progressLive
{
    [UIView animateWithDuration:1.4f animations:^(void)
                                                  {
                                                      [self.progressEnergia setProgress:1 animated:YES];
                                                  }];
}

-(void) entrenarPet
{
     self.timer = [NSTimer scheduledTimerWithTimeInterval: 4.0f
                                                   target: self
                                                 selector: @selector(entrenarPet)
                                                 userInfo: nil
                                                  repeats: YES];
    
     [UIView animateWithDuration:1.4f animations:^(void)
     {
         [self.progressEnergia setProgress:0 animated:YES];
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
