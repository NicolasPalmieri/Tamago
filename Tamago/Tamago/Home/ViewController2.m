//
//  ViewController2.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3.h"
#import "Pet.h"
#import "PushManager.h"
#import "LocationManager.h"

@interface ViewController2 ()

#pragma mark - Propiedades
@property (strong, nonatomic) IBOutlet UITextField *TextFieldpetName;
@property (strong, nonatomic) IBOutlet UILabel *LabelWelcome;
@property (strong, nonatomic) IBOutlet UILabel *labelPetName;
@property (strong, nonatomic) IBOutlet UIButton *buttonToElej;
@property (strong, nonatomic) NSString *val;

@end

@implementation ViewController2

#pragma mark - Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"Home"];
    
    self.nick = [NSMutableArray arrayWithObjects:@"Pablo",@"Marmol",nil]; //valoresArray
}

- (void)viewWillAppear:(BOOL)animated
{
    //PUSH_NOTIF_REMOTE_SUBSCRIBE
    [PushManager subscribe_To_Channel];
    
    //TEST_LOCAL_NOTIF
    [PushManager sendPush_Local];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Self
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Botones
- (IBAction)Page2:(id)sender
{
    [[Pet sharedInstance] setName:self.TextFieldpetName.text]; //asigno nombre

    if ((![self.nick containsObject:[Pet sharedInstance].name])&&([self validarLength:[Pet sharedInstance].name]))
    {
        NSLog(@"Nick accepted");
        [self.nick addObject:[Pet sharedInstance]];//lo agrego al array
        
        //BOOL INTRO_NAME
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOL_1ST_VIEW];
        
        ViewController3 *myView = [[ViewController3 alloc]
                                   initWithNibName:@"ViewController3"
                                   bundle:[NSBundle mainBundle]
                                   andPetNombre:[Pet sharedInstance].name];
        
        [self.navigationController pushViewController:myView animated:YES];
    }
    
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"LogIn"
                                                  message:@"Already in use"
                                                  delegate:nil
                                                  cancelButtonTitle:@"Try Another1"
                                                  otherButtonTitles:nil];
        [alert show];
    
    }
    [self.TextFieldpetName setText:@""];//empty textfield
}


#pragma mark - Validaciones
-(BOOL)validarLength:(NSString *) nombre
{
    BOOL val = NO;
    NSUInteger length = [nombre length];
        //valida longitud
        if(length > 6)
        {
            val = YES;
        }
    return val;
}

// Valida los caracterres del TextField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].length)
    {
        return YES;
    }
    else if(!string.length) //returnexception
    {
        return YES;
    }
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
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
