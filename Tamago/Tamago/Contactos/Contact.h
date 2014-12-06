//
//  Contact.h
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *nombre;
@property (strong, nonatomic) NSString *company;

-(instancetype) initWithNombre:(NSString*) n
                   andApellido:(NSString*) a
                   andTelefono:(NSString*) t
                      andEmail:(NSString*) e
                   andCompania:(NSString*) c;

@end
