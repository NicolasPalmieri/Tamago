//
//  Storage.m
//  Tamago
//
//  Created by Nicolas on 12/2/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Storage.h"

@implementation Storage

//Files

#define COMPLETE_PET_FILE @"pet.txt"
#define DESTINATION_FILE @"~/Library/Application Support/MyApp/"

#pragma mark - Gochis

+(void) savePet:(Pet*) pet
{
    NSString* filePath = [self getLocalFilePathForCompletedPet];
    [NSKeyedArchiver archiveRootObject:pet toFile:filePath];
}

+(Pet*) loadPet
{
    NSString* filePath = [self getLocalFilePathForCompletedPet];
    if([[NSFileManager defaultManager]fileExistsAtPath:filePath])
    {
        Pet* pet = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        return pet;
    }
    return nil;
}

+(NSString*) getLocalFilePathForCompletedPet
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* path = [DESTINATION_FILE stringByExpandingTildeInPath];
    
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [path stringByAppendingPathComponent: COMPLETE_PET_FILE];
}

@end
