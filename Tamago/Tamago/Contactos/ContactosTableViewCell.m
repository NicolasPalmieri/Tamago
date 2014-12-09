//
//  ContactosTableViewCell.m
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ContactosTableViewCell.h"

@implementation ContactosTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) fillWithContact:(Contact *)con
{
    self.micontacto = con;
    [self.lblName setText: self.micontacto.nombre];
    [self.lblCompany setText: self.micontacto.company];
    [self.lblEmail setText: self.micontacto.email];
    [self.lblPhone setText: self.micontacto.phone];
}

- (IBAction)btnMAIL:(id)sender
{
    [self.delegate mandarUnMail:self.micontacto.email];
}

- (IBAction)btnCALL:(id)sender
{
    [self.delegate hacerUnaCall:self.micontacto.phone];
}

@end
