//
//  ContactosViewController.h
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactosTableViewCell.h"
#import <AddressBook/AddressBook.h>
#import "ContactManager.h"
#import <MessageUI/MessageUI.h>
#import "Pet.h"

@interface ContactosViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ContactoDelegate, MFMailComposeViewControllerDelegate>

#pragma mark - Propiedades

@end
