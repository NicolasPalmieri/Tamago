//
//  Pet.h
//  Tamago
//
//  Created by Nicolas on 11/24/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Petdelegate <NSObject>

@required

-(void) moreProgress:(int) value;
-(void) lessProgress:(int) value;

@end


extern NSString *const MSG_LVLUP;
extern NSString *const MSG_EXHAUST;
extern NSString *const MSG_COD_PET;

@interface Pet : NSObject

typedef enum
{
    TYPE_CIERVO =0,
    TYPE_GATO,
    TYPE_LEON,
    TYPE_JIRAFA
    
} mascotaTypes;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imagen;
@property (nonatomic) mascotaTypes type;

+(instancetype) sharedInstance;

@property (weak, nonatomic) id <Petdelegate> delegate;

-(void) timeToEat;
-(void) timeToExercise;
-(BOOL) valEjercitar;
-(void) calcularExpLvl;
-(void) getLvl1;
-(int) showLvl;
-(NSDictionary*)fillDictionary;
-(void)fillPet: (NSDictionary*) dic;
-(int) showEnergy;
-(int) showExp;

@end
