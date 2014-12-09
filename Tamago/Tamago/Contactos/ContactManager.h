//
//  ContactManager.h
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ContactManager : NSObject

@property(strong, nonatomic) NSMutableArray *arraycontacts;
@property (assign, nonatomic) ABAddressBookRef addressBookRef;

- (void)obtenerAutorizacion;
- (void)obtenerContactos;
+ (instancetype) sharedInstance;
@end
