//
//  ContactManager.m
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ContactManager.h"
#import "Contact.h"

@implementation ContactManager

__strong static id _sharedObject = nil;
+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^
                  {
                      if(_sharedObject==nil)
                          _sharedObject= [[self alloc] init];
                  });
    return _sharedObject;
}

#pragma mark - Contactos
- (void)obtenerAutorizacion
{
    if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        //popup
        ABAddressBookRequestAccessWithCompletion(self.addressBookRef, ^(bool granted, CFErrorRef error)
                                                 {
                                                     if(error)
                                                     {
                                                         NSLog(@"PRIMER LOGGED!");
                                                     }
                                                     [self obtenerContactos];
                                                 });
    }else if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
                                                 {
                                                     NSLog(@"NORMAL LOGGED!");
                                                     [self obtenerContactos];
                                                 }
    else
    {
       NSLog(@"DENIED!");
    }
}

- (void)obtenerContactos
{
    self.addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    self.arraycontacts = [[NSMutableArray alloc] init];
    
    //contactos
    CFArrayRef allcontacts = ABAddressBookCopyArrayOfAllPeople(self.addressBookRef);
    //cantidad
    CFIndex cantidad = ABAddressBookGetPersonCount(self.addressBookRef);
    for(int i=0; i<cantidad; i++)
    {
        //referencia
        ABRecordRef ref = CFArrayGetValueAtIndex(allcontacts, i);
        //name disponible
        NSString *firstName = (__bridge NSString*)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        //lastname disponible
        NSString *lastname = (__bridge NSString*)ABRecordCopyValue(ref, kABPersonLastNameProperty);
        //company disponible
        NSString *company = (__bridge NSString*)ABRecordCopyValue(ref, kABPersonOrganizationProperty);
        //phones disponibles
        ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(ref, kABPersonPhoneProperty);
        NSArray *phones = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(phoneNumberProperty);
        //agarro el primero
        NSString* mainPhone = @"";
        if(phones && [phones count] > 0)
        {
            mainPhone = phones[0];
        }

        //emails disponibles
        ABMultiValueRef emailProperty = ABRecordCopyValue(ref, kABPersonEmailProperty);
        NSArray *emails = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(emailProperty);
        //agarro el primero again
        NSString* mainEmail = @"";
        if(emails && [emails count] > 0)
        {
            mainEmail = emails[0];
        }
        
        Contact *contacto = [[Contact alloc] initWithNombre:firstName
                                                andApellido:lastname
                                                andTelefono:mainPhone
                                                   andEmail:mainEmail
                                                andCompania:company];
        
        [self.arraycontacts addObject:contacto];
    }
    //Check!
    NSLog(@"CONTACTOS> %d",self.arraycontacts.count);
}





@end
