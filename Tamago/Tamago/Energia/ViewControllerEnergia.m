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
#import "NetworkManage.h"

@interface ViewControllerEnergia ()

#pragma mark - localDef
#define MAIL_BODY_MSG @"Buenas! Soy %@, qué tal? Quería comentarte que estuve usando la App Tamago para comerme todo y está genial. Bajatela YA!! Saludos!"

#pragma mark - Propiedades
@property (strong, nonatomic) IBOutlet UIImageView *ImageViewProfileEnergia;
@property (strong, nonatomic) IBOutlet UIProgressView *progressEnergia;
@property (strong, nonatomic) IBOutlet UILabel *labelNameENergy;
@property (strong, nonatomic) IBOutlet UIButton *btnFeed;
@property (strong, nonatomic) IBOutlet UIButton *btnTrain;
@property (strong, nonatomic) IBOutlet UIImageView *imgBringFood;
@property (strong, nonatomic) IBOutlet UIView *ViewRango;
@property (strong, nonatomic) IBOutlet UILabel *labelNivel;
@property (strong, nonatomic) IBOutlet UILabel *labelExp;
@property (strong, nonatomic) MFMailComposeViewController *correo;
@property (strong, nonatomic) ArrayConst *gif;
@property (strong, nonatomic) ArrayConst *train;
@property (strong, nonatomic) ArrayConst *cansado;
@property (weak, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int flag;
@property (assign, nonatomic) int Current;
@property (copy, nonatomic) Success successBlock;
@property (copy, nonatomic) Failure failureBlock;
@property (copy, nonatomic) Success successBlockSavePet;
@property (copy, nonatomic) Failure failureBlockSavePet;
@property (strong, nonatomic) NSDictionary *diccGet;

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
    
    //resetCampos
    self.labelNameENergy.text =@"";
    self.labelExp.text =@"";
    self.labelNivel.text =@"";
    
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

    //fillEat
    self.gif = [[ArrayConst alloc] init];
    [self.gif FILLarray:[Pet sharedInstance]];
    
    //fillTrain
    self.train = [[ArrayConst alloc] init];
    [self.train FILLarray:[Pet sharedInstance]];
    
    //fillExhaust
    self.cansado = [[ArrayConst alloc] init];
    [self.cansado FILLarray:[Pet sharedInstance]];
    
    //delegate
    [Pet sharedInstance].delegate = self;
    
    //lvl
    [[Pet sharedInstance] getLvl1];
    
    //progressCustom?
    [self.progressEnergia setTransform:CGAffineTransformMakeScale(1.0, 7.0)]; //dejó de hacer magia..
}

- (void) viewWillAppear:(BOOL)animated
{
    self.imgBringFood.image = [UIImage imageNamed:[Meal sharedInstance].imagen];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(exhaustGif)
                                                 name:MSG_EXHAUST
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLvlUp)
                                                 name:MSG_LVLUP
                                               object:nil];
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self]; //release observers
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
    if(self.flag==0)
    {
    [self trainGif];
    [self.btnTrain setTitle:@"STOP!" forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: [Pet sharedInstance]
                                                selector: @selector(timeToExercise)
                                                userInfo: nil
                                                 repeats: YES];
    self.flag=1;
    }
    else
    {
        [self.ImageViewProfileEnergia stopAnimating];
        self.flag=0;
    }    
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Servicio__SaveData
-(void) saveGochi_POST
{
    NSDictionary *parameters = [[Pet sharedInstance] fillDictionary];
    [[NetworkManage sharedInstance] POST:@"/pet"
                              parameters:parameters
                                 success:[self successBlockSavePet]
                                 failure:[self failureBlockSavePet]
     ];
}

-(Success) successBlockSavePet
{
    return ^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"%@",responseObject);
    };
}

-(Failure) failureBlockSavePet
{
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"%@",error);
    };
}

#pragma mark - Boton__LOADdata
- (IBAction)loadData:(id)sender
{
    [self getEvents];
}

-(void) getEvents
{
    [[NetworkManage sharedInstance] GET:/*@"/pet/np0114"*/[NSString stringWithFormat:@"/pet/%@",MSG_COD_PET]
                             parameters:nil
                                success:[self successBlock]
                                failure:[self failureBlock]];
}

-(Success)successBlock
{
    __weak typeof(self) weakerSelf = self;
    
    return ^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"%@",responseObject);
        [[Pet sharedInstance] fillPet:responseObject];
        //actualizacion view //weakerSelf.
        weakerSelf.labelNameENergy.text = [Pet sharedInstance].name;
        NSString *auxlvl = [NSString stringWithFormat:@"%d", [[Pet sharedInstance] showLvl]];
        weakerSelf.labelNivel.text = auxlvl;
        NSString *auxexp = [NSString stringWithFormat:@"%d", [[Pet sharedInstance] showExp]];
        weakerSelf.labelExp.text = auxexp;
        weakerSelf.progressEnergia.progress = [[Pet sharedInstance] showEnergy];
    };
}

-(Failure)failureBlock
{
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"%@",error);
    };
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


-(void) eatGift
{
    NSArray *imagenesArray = @[[UIImage imageNamed:self.gif.arrayEat[0]],
                             [UIImage imageNamed:self.gif.arrayEat[1]],
                             [UIImage imageNamed:self.gif.arrayEat[2]],
                             [UIImage imageNamed:self.gif.arrayEat[3]]];
    
    [self.ImageViewProfileEnergia setAnimationImages:imagenesArray];
    [self.ImageViewProfileEnergia setAnimationDuration:0.5f];
    [self.ImageViewProfileEnergia setAnimationRepeatCount:2.0f];
    [self.ImageViewProfileEnergia startAnimating];
}

-(void) trainGif
{
    NSArray *imagenesArrayAux = @[[UIImage imageNamed:self.train.arrayTrain[0]],
                               [UIImage imageNamed:self.train.arrayTrain[1]],
                               [UIImage imageNamed:self.train.arrayTrain[2]],
                               [UIImage imageNamed:self.train.arrayTrain[3]],
                            [UIImage imageNamed:self.train.arrayTrain[4]]];
    
    [self.ImageViewProfileEnergia setAnimationImages:imagenesArrayAux];
    [self.ImageViewProfileEnergia setAnimationDuration:0.5f];
    [self.ImageViewProfileEnergia setAnimationRepeatCount:20.0f];
    [self.ImageViewProfileEnergia startAnimating];
}

-(void) exhaustGif
{
    [self.timer invalidate];
    [self.ImageViewProfileEnergia stopAnimating];
    NSLog(@"Animacion");
    NSArray *imagenesArrayAux2 = @[[UIImage imageNamed:self.cansado.arrayExhaust[0]],
                                   [UIImage imageNamed:self.cansado.arrayExhaust[1]],
                                   [UIImage imageNamed:self.cansado.arrayExhaust[2]],
                                   [UIImage imageNamed:self.cansado.arrayExhaust[3]]];
    
    [self.ImageViewProfileEnergia setAnimationImages:imagenesArrayAux2];
    [self.ImageViewProfileEnergia setAnimationDuration:0.7f];
    [self.ImageViewProfileEnergia setAnimationRepeatCount:1.0f];
    [self.ImageViewProfileEnergia setImage:imagenesArrayAux2.lastObject];
    [self.ImageViewProfileEnergia startAnimating];
}


-(void) moreProgress:(int) value
{
    float valor = value;
    valor = valor/100;
    [UIView animateWithDuration:0.5f animations:^(void)
     {
         [self.progressEnergia setProgress:valor animated:YES];
         if (self.progressEnergia.progress ==1)
         {
             NSLog(@"Full!");
             [self.timer invalidate];
             //[self.btnFeed setEnabled:NO];
             //self.trainbutton enabled?? highlight??
         }
     }];
}

-(void) lessProgress:(int) value
{
    [UIView animateWithDuration:0.5f animations:^(void)
    {
        self.progressEnergia.progress -=0.1;
        if (self.progressEnergia.progress <=0)
        {
            NSLog(@"Empty!");
            [self.timer invalidate];
            //[self.btnTrain setEnabled:NO];
            //[self.btnFeed setEnabled:YES];
        }
    }];
}

#pragma mark - Show
-(void)showLvlUp
{
    self.Current = [[Pet sharedInstance] showLvl];
    
    UIAlertView *message;
    message = [[UIAlertView alloc] initWithTitle:@"LVLUP!"
                                         message:[NSString stringWithFormat:@"%d to %d",self.Current-1,self.Current]
                                        delegate:nil
                               cancelButtonTitle:@"YAY!"
                               otherButtonTitles:nil];
   [message show];
    
    //SAVEDATA_FUNC
    [self saveGochi_POST];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
