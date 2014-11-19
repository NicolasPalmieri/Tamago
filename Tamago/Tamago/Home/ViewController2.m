//
//  ViewController2.m
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3.h"

@interface ViewController2 ()

@property (strong, nonatomic) IBOutlet UITextField *TextFieldpetName;
@property (strong, nonatomic) IBOutlet UILabel *LabelWelcome;
@property (strong, nonatomic) IBOutlet UILabel *labelPetName;
@property (strong, nonatomic) IBOutlet UIButton *buttonToElej;


@end

@implementation ViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)Page2:(id)sender
{
    ViewController3 *myView = [[ViewController3 alloc] initWithNibName:@"ViewController3" bundle:[NSBundle mainBundle] andPetNombre:self.TextFieldpetName.text];
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
