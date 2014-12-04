//
//  VisitaViewController.m
//  Tamago
//
//  Created by Nicolas on 12/4/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "VisitaViewController.h"
#import "NetworkManage.h"
#import "Pet.h"

@interface VisitaViewController ()

@property (strong, nonatomic) IBOutlet UILabel *lblCode;
@property (strong, nonatomic) IBOutlet UIImageView *imgImagen;
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UILabel *lblLevel;
@property (strong, nonatomic) IBOutlet UILabel *lblEnergy;

@property (copy, nonatomic) Success successBlockLoadVisitPet;
@property (copy, nonatomic) Failure failureBlock;

@property (strong, nonatomic) NSString *code;

@end

@implementation VisitaViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCode:(NSString *)code
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.code = code;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //UPDATE_VIEW
    [self getEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getEvents
{
    [[NetworkManage sharedInstance] GET:[NSString stringWithFormat:@"/pet/%@",self.code]
                             parameters:nil
                                success:[self successBlockLoadVisitPet]
                                failure:[self failureBlock]];
}

-(Success)successBlockLoadVisitPet
{
    __weak typeof(self) weakerSelf = self;
    
    return ^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"%@",responseObject);
        [[Pet sharedInstance] fillPet:responseObject];
        //actualizacion view //weakerSelf.
        if([[Pet sharedInstance].code isEqualToString: weakerSelf.code])
        {
            weakerSelf.lblCode.text = weakerSelf.code;
            weakerSelf.lblNombre.text = [Pet sharedInstance].name;
            NSString *auxlvl = [NSString stringWithFormat:@"%d", [[Pet sharedInstance] showLvl]];
            weakerSelf.lblLevel.text = auxlvl;
            NSString *auxenergy = [NSString stringWithFormat:@"%d", [[Pet sharedInstance] showEnergy]];
            weakerSelf.lblEnergy.text = auxenergy;
            //imagen
            [weakerSelf asignoImagenLoadtype];
        }
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
            self.imgImagen.image = [UIImage imageNamed:@"ciervo_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"ciervo_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_CIERVO];
            break;
        case TYPE_GATO:
            self.imgImagen.image = [UIImage imageNamed: @"gato_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"gato_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_GATO];
            break;
        case TYPE_LEON:
            self.imgImagen.image = [UIImage imageNamed: @"leon_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"leon_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_LEON];
            break;
        case TYPE_JIRAFA:
            self.imgImagen.image = [UIImage imageNamed: @"jirafa_comiendo_1"];
            [[Pet sharedInstance] setImagen:@"jirafa_comiendo_1"];
            [[Pet sharedInstance] setType:TYPE_JIRAFA];
            break;
    }
}


@end
