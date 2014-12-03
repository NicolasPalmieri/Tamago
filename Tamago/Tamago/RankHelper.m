//
//  RankHelper.m
//  Tamago
//
//  Created by Nicolas on 12/3/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "RankHelper.h"
#import "Pet.h"

@interface RankHelper()

@property (strong, nonatomic) Pet *auxpet;
@property (strong, nonatomic) NSArray *auxArray;

@end

@implementation RankHelper

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^
                  {
                      _sharedObject= [[self alloc] init];
                  });
    return _sharedObject;
}

#pragma mark - BlackMagic
-(Pet *)allocPet
{
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"Pet"
                                           inManagedObjectContext:[[DataHelper sharedInstance] managedObjectContext]];
    
    return [[Pet alloc] initWithEntity:ent insertIntoManagedObjectContext:nil];
}

#pragma mark - SQLmeths
-(NSArray*) selectRanking
{
    NSManagedObjectContext *context = [[DataHelper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Pet"
                                   inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:15];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"level" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(void) insertRanking: (NSArray*) object
{
    NSManagedObjectContext *context = [[DataHelper sharedInstance] managedObjectContext];
    
    self.auxArray = object;
    for(Pet* auxpet in self.auxArray)
    {
        Pet *nuevapet = [NSEntityDescription insertNewObjectForEntityForName:@"Pet"
                                                 inManagedObjectContext:context];

        [nuevapet setValue: auxpet.name forKey:@"name"];
        [nuevapet setValue: [NSNumber numberWithFloat:auxpet.latitud] forKey:@"latitud"];
        [nuevapet setValue: [NSNumber numberWithFloat:auxpet.longitud] forKey:@"longitud"];
        [nuevapet setValue: auxpet.code forKey:@"code"];
        [nuevapet setValue: auxpet.imagen forKey:@"imagen"];
        [nuevapet setValue: [NSNumber numberWithInt:[auxpet showLvl]] forKey:@"level"];
        [nuevapet setValue: [NSNumber numberWithInt:auxpet.type] forKey:@"type"];
        [nuevapet setValue: [NSNumber numberWithInt:[auxpet showEnergy]] forKey:@"energy"];
        [nuevapet setValue: [NSNumber numberWithInt:[auxpet showExp]] forKey:@"exp"];
    }
    
    NSError *localerror;
    if (![context save:&localerror])
    { //Guardamos los cambios en el contexto.
        NSLog([NSString stringWithFormat:@"Error, couldn't save: %@", [localerror localizedDescription]]);
        [context rollback];
    }
}

-(void) deleteRanking
{
    NSManagedObjectContext *context = [[DataHelper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Pet"
                                   inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * locations = [context executeFetchRequest:fetchRequest error:&error];
    
    //error handling goes here
    
    for (NSManagedObject * location in locations)
    {
        [context deleteObject:location];
    }
    
    NSError *saveError = nil;
    if (![context save:&saveError])
    { //Guardamos los cambios en el contexto.
        NSLog([NSString stringWithFormat:@"Error, couldn't delete: %@", [saveError localizedDescription]]);
        [context rollback];
    }
}


@end
