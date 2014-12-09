//
//  ContactosViewController.m
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ContactosViewController.h"

#pragma mark - localDef
#define MAIL_BODY_MSG @"Buenas! Soy %@, qué tal? Quería comentarte que estuve usando la App Tamago para comerme todo y está genial. Bajatela YA!! Saludos!"

@interface ContactosViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableContactos;
@property (strong, nonatomic) MFMailComposeViewController *correo;

@end

@implementation ContactosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[ContactManager sharedInstance] obtenerAutorizacion];
    
    //registro celda
    [self.tableContactos registerNib:[UINib nibWithNibName:@"ContactosTableViewCell" bundle:[NSBundle mainBundle]]
             forCellReuseIdentifier:@"ContactosTableViewCell"];
    
    //DATArefresh
    [self.tableContactos reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protocol//meth
-(void) mandarUnMail:(NSString *)mail
{
    NSLog(@"MAILING!");
    [self showMail:mail];
}

-(void) hacerUnaCall:(NSString*)phone
{
    [self doACall:phone];
}

#pragma mark - DATASOURCE//metodos
//cantidad de filas
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ContactManager sharedInstance].arraycontacts.count;
}

//celdas
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ContactosTableViewCell";
    
    ContactosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell)
    {
        cell = [[ContactosTableViewCell alloc] init];
    }
    
    [cell fillWithContact:[ContactManager sharedInstance].arraycontacts[indexPath.row]];
    [cell setDelegate:self];
    
    return cell;
}

//Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Contacts!";
}

#pragma mark - Call
-(void)doACall:(NSString*) telefono
{
    NSString *tel = [[telefono componentsSeparatedByCharactersInSet:
                      [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                     componentsJoinedByString:@""];
    
    NSLog(@"CALLING! %@",tel);
    
    tel = [NSString stringWithFormat:@"tel://%@",tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];    
}

#pragma mark - Mail
-(void)showMail:(NSString*) mail
{
    MFMailComposeViewController *correo = [[MFMailComposeViewController alloc] init];
    correo.mailComposeDelegate = self;
    
    //Subject
    NSString *mailSubj = [[NSString alloc] initWithFormat:@"Que app flipante"];
    [correo setSubject:mailSubj];
    
    //BodyText
    NSString *mailBody = [[NSString alloc] initWithFormat:MAIL_BODY_MSG, [Pet sharedInstance].name];
    [correo setMessageBody:mailBody isHTML:NO];
    
    //To
    [correo setToRecipients:[NSArray arrayWithObject:mail]];
    
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


@end
