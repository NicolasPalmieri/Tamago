//
//  ContactosTableViewCell.h
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol ContactoDelegate <NSObject>

@required
-(void) mandarUnMail:(NSString*) mail;
-(void) hacerUnaCall:(NSString*) phone;

@end

@interface ContactosTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblCompany;

@property (strong, nonatomic) Contact *micontacto;

@property (weak, nonatomic) id <ContactoDelegate> delegate;

-(void) fillWithContact:(Contact *) con;

@end
