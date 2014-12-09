//
//  Contact.m
//  Tamago
//
//  Created by Nicolas on 12/6/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype) initWithNombre:(NSString *)n
                    andApellido:(NSString *)a
                    andTelefono:(NSString *)t
                       andEmail:(NSString *)e
                    andCompania:(NSString *)c
{
    self = [super init];
    if (self)
    {
        self.email = e;
        self.phone = t;
        self.nombre = [NSString stringWithFormat:@"%@ %@",n,a];
        self.company = c;
    }
    return self;
}

@end
