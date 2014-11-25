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
#import "Meal.h"

@interface ViewControllerEnergia ()

#pragma mark - localDef
#define MAIL_BODY_MSG @"Buenas! Soy %@, qué tal? Quería comentarte que estuve usando la App Tamago para comerme todo y está genial. Bajatela YA!! Saludos!"

#pragma mark - Propiedades
@property (strong, nonatomic) IBOutlet UIImageView *ImageViewProfileEnergia;
@property (strong, nonatomic) IBOutlet UIProgressView *progressEnergia;
@property (strong, nonatomic) IBOutlet UILabel *labelNameENergy;
@property (strong, nonatomic) IBOutlet UIButton *btnFeed;
@property (strong, nonatomic) IBOutlet UIImageView *imgBringFood;
@property (strong, nonatomic) IBOutlet UIView *ViewRango;
@property (strong, nonatomic) ArrayConst *gif;
@property (strong, nonatomic) MFMailComposeViewController *correo;
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
    
    //customBackBtn _color _< button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside]; //metodo
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton; // <
    
    //mailBtn
    UIButton *buttonREF = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* mail_image = [UIImage imageNamed:@"correo"];
    [buttonREF setBackgroundImage:mail_image forState:UIControlStateNormal];
    [buttonREF addTarget:self action:@selector(showMail) forControlEvents:UIControlEventTouchUpInside]; //metodo
    [buttonREF setShowsTouchWhenHighlighted:YES]; // brilla al touch?
    buttonREF.frame = CGRectMake(0, 0, mail_image.size.width-20, mail_image.size.height-20); //orig_size excede navbar
    UIBarButtonItem *mail =[[UIBarButtonItem alloc] initWithCustomView:buttonREF];
    self.navigationItem.rightBarButtonItem = mail; // >

    //fill gifEat-Train
    self.gif = [[ArrayConst alloc] init];
    [self.gif FILLarray:[Pet sharedInstance]];
    
    //fill2
    self.train = [[ArrayConst alloc] init];
    [self.train FILLarray:[Pet sharedInstance]];
    
    //delegate
    [Pet sharedInstance].delegate = self;
    
    //progressCustom?
    [self.progressEnergia setTransform:CGAffineTransformMakeScale(1.0, 7.0)];
    
    UIImage *track = [[UIImage imageNamed:@"trackImage"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
    [self.progressEnergia setTrackImage:track]; //nofunca :C
    
    UIImage *prog = [[UIImage imageNamed:@"progressImage"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
    [self.progressEnergia setTrackImage:prog]; //nofunca :C
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

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
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
                                                [[Pet sharedInstance] timeToEat]; //creceProgressHP
                                            }
                                        else
                                            {
                                                NSLog(@"Hungry!");
                                                return;
                                            }
                                    }];
    }
}

-(void) callMeth
{
    [[Pet sharedInstance] timeToExercise];
}

- (IBAction)btnTrain:(id)sender
{
    //[self trainGif];
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector: @selector(callMeth)
                                                userInfo: nil
                                                 repeats: YES];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector: @selector(trainGif)
                                                userInfo: nil
                                                 repeats: YES];
    
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


-(void) moreProgress:(int) value
{
    float valor = value;
    valor = valor/100;
    [UIView animateWithDuration:1.4f animations:^(void)
     {
         [self.progressEnergia setProgress:valor animated:YES];
         if (self.progressEnergia.progress ==1)
         {
             NSLog(@"Full!");
             [self.timer invalidate];
             //self.trainbutton enabled??
             //self.feedbutton disabled??
         }
     }];
}

-(void) lessProgress:(int) value
{
    [UIView animateWithDuration:1.4f animations:^(void)
    {
        self.progressEnergia.progress -=0.1;
        if (self.progressEnergia.progress ==0)
        {
            NSLog(@"Empty!");
            [self.timer invalidate];
            //self.trainbutton disabled?
            //self.feedbutton enabled??
        }

    }];
}

#pragma mark - Mail
-(void)showMail
{
    MFMailComposeViewController *correo = [[MFMailComposeViewController alloc] init];
    correo.mailComposeDelegate = self;
    
    //Subject
    NSString *mailSubj = [[NSString alloc] initWithFormat:@"Que app flipante"];
    [correo setSubject:mailSubj];
    
    //BodyText
    NSString *mailBody = [[NSString alloc] initWithFormat:MAIL_BODY_MSG, self.labelNameENergy.text];
    [correo setMessageBody:mailBody isHTML:NO];

    //Interface
    [self presentViewController:correo animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *message;
    switch (result)
    {
        case MFMailComposeResultSent:
            
            NSLog(@"SEND!:D");
            message = [[UIAlertView alloc] initWithTitle:@"STATUS!"
                                                              message:@"Message sended!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OKey"
                                                    otherButtonTitles:nil];
            [message show];
            break;
            
        case MFMailComposeResultSaved:
            
            NSLog(@"BORRADOR!");
            message = [[UIAlertView alloc] initWithTitle:@"STATUS!"
                                                              message:@"Message stored!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OKey"
                                                    otherButtonTitles:nil];
            [message show];
            break;
            
        case MFMailComposeResultCancelled:
            
            NSLog(@"CANCELED!:C");
            message = [[UIAlertView alloc] initWithTitle:@"STATUS!"
                                                              message:@"Message canceled!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OKey"
                                                    otherButtonTitles:nil];
            [message show];
            break;
            
        case MFMailComposeResultFailed:
            
            NSLog(@"COMP FAILED!");
            message = [[UIAlertView alloc] initWithTitle:@"STATUS!"
                                                              message:@"Compose ERROR!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OKey"
                                                    otherButtonTitles:nil];
            [message show];
            break;
            
        default:
            
            NSLog(@"ERROR DEF!");
            message = [[UIAlertView alloc] initWithTitle:@"STATUS!"
                                                              message:@"ERROR DEF!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OKey"
                                                    otherButtonTitles:nil];
            [message show];
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
