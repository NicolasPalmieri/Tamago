//
//  ViewControllerEnergia.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ViewControllerEnergia.h"

@interface ViewControllerEnergia ()

#pragma mark - IBOutlet
@property (strong, nonatomic) IBOutlet UIImageView *ImageViewProfileEnergia;
@property (strong, nonatomic) IBOutlet UIProgressView *progressEnergia;
@property (strong, nonatomic) IBOutlet UILabel *labelNameENergy;
@property (strong, nonatomic) IBOutlet UIButton *btnFeed;
@property (strong, nonatomic) IBOutlet UIButton *btnTrain;
@property (strong, nonatomic) IBOutlet UIImageView *imgBringFood;
@property (strong, nonatomic) IBOutlet UIView *ViewRango;
@property (strong, nonatomic) IBOutlet UILabel *labelNivel;
@property (strong, nonatomic) IBOutlet UILabel *labelExp;
@property (strong, nonatomic) IBOutlet UIButton *btnNotification;
@property (strong, nonatomic) IBOutlet UIButton *btnData;
@property (strong, nonatomic) IBOutlet UIImageView *imgAura;

#pragma mark - Properties
@property (strong, nonatomic) ArrayConst *gif;
@property (strong, nonatomic) ArrayConst *train;
@property (strong, nonatomic) ArrayConst *cansado;
@property (weak, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int flag;
@property (assign, nonatomic) int Current;
@property (copy, nonatomic) Success successBlockLoadPet;
@property (copy, nonatomic) Failure failureBlock;
@property (copy, nonatomic) Success successBlockSavePet;
@property (copy, nonatomic) Success successBlockLoadALL;
@property (strong, nonatomic) NSDictionary *diccGet;
@property (nonatomic) mascotaTypes type;
@property (strong, nonatomic) NSMutableArray *rankArray;
@property (strong, nonatomic) LocationManager *manager;


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
    UIImage* mail_image = [UIImage imageNamed:@"contact"];
    [buttonREF setBackgroundImage:mail_image forState:UIControlStateNormal];
    [buttonREF addTarget:self action:@selector(popContact) forControlEvents:UIControlEventTouchUpInside]; //metodo
    [buttonREF setShowsTouchWhenHighlighted:YES]; // brilla al touch?
    buttonREF.frame = CGRectMake(0, 0, mail_image.size.width-150, mail_image.size.height-150);
    //orig_size excede navbar
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
        
    //Location_pet
    self.manager = [[LocationManager alloc] init];
    [self.manager startUpdate];
    
    //ServicioLOAD disable
    [self.btnData setEnabled:YES];
    
    //actualizacion view LoadRigido
    self.labelNameENergy.text = [Pet sharedInstance].name;
    NSString *auxlvl = [NSString stringWithFormat:@"%d", [[Pet sharedInstance] showLvl]];
    self.labelNivel.text = auxlvl;
    NSString *auxexp = [NSString stringWithFormat:@"%d", [[Pet sharedInstance] showExp]];
    self.labelExp.text = auxexp;
    self.progressEnergia.progress = [[Pet sharedInstance] showEnergy]/100;
    //imagen
    [self asignoImagenLoadtype];
    
    //AURA
    [self auraPichaku];
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
    //progressCustom?
    [self.progressEnergia setTransform:CGAffineTransformMakeScale(1.0, 7.0)]; //dejó de hacer magia..
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

- (IBAction)btnRanking:(id)sender
{
    //push RankingView
    RankViewController *myVista = [[RankViewController alloc] initWithNibName:@"RankViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:myVista animated:YES];
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) popContact
{
    ContactosViewController *myVista = [[ContactosViewController alloc] initWithNibName:@"ContactosViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:myVista animated:YES];
}


#pragma mark - ServicioSAVEData
-(void) saveGochi_POST
{
    NSDictionary *parameters = [[Pet sharedInstance] fillDictionary];
    [[NetworkManage sharedInstance] POST:@"/pet"
                              parameters:parameters
                                 success:[self successBlockSavePet]
                                 failure:[self failureBlock]
     ];
}

-(Success) successBlockSavePet
{
    //__weak typeof(self) weakerSelf = self;
    return ^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"%@",responseObject);
    };
}

#pragma mark - ServicioLOADData
- (IBAction)loadData:(id)sender
{
    [self getEvents];
}

-(void) getEvents
{
    [[NetworkManage sharedInstance] GET:[NSString stringWithFormat:@"/pet/%@",MSG_COD_PET]
                             parameters:nil
                                success:[self successBlockLoadPet]
                                failure:[self failureBlock]];
}

-(Success)successBlockLoadPet
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
        weakerSelf.progressEnergia.progress = [[Pet sharedInstance] showEnergy]/100;
        //imagen
        [weakerSelf asignoImagenLoadtype];
    };
}

-(Failure)failureBlock
{
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"%@",error);
    };
}

-(void) asignoImagenLoadtype
{
    switch ([Pet sharedInstance].type)
    {
        case TYPE_CIERVO:
            self.ImageViewProfileEnergia.image = [UIImage imageNamed:@"ciervo_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"ciervo_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_CIERVO];
            break;
        case TYPE_GATO:
            self.ImageViewProfileEnergia.image = [UIImage imageNamed: @"gato_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"gato_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_GATO];
            break;
        case TYPE_LEON:
            self.ImageViewProfileEnergia.image = [UIImage imageNamed: @"leon_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"leon_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_LEON];
             break;
        case TYPE_JIRAFA:
            self.ImageViewProfileEnergia.image = [UIImage imageNamed: @"jirafa_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"jirafa_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_JIRAFA];
            break;
    }
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

-(void) auraPichaku
{
    NSArray *imagenesArrayAura = @[[UIImage imageNamed:@"Super-1"],
                                   [UIImage imageNamed:@"Super-2"],
                                   [UIImage imageNamed:@"Super-3"]];
    
    [self.imgAura setAnimationImages:imagenesArrayAura];
    [self.imgAura setAnimationDuration:0.2f];
    [self.imgAura setAnimationRepeatCount:0];
    [self.imgAura startAnimating];
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

#pragma mark - Show // SavedataLocal
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
    [Storage savePet:[Pet sharedInstance]];
    //UPGRADE_VIEW
    self.labelNivel.text = [NSString stringWithFormat:@"%d",[[Pet sharedInstance] showLvl]];
    self.labelExp.text = [NSString stringWithFormat:@"%d",[[Pet sharedInstance] showExp]];
    //PUSH_NOTIF_REMOTE
    [PushManager sendPush_toEntire_channel];
    
}


@end
