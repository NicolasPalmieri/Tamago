//
//  Pet.h
//  Tamago
//
//  Created by Nicolas on 11/24/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>

@protocol Petdelegate <NSObject>

@required

-(void) moreProgress:(int) value;
-(void) lessProgress:(int) value;

@end


extern NSString *const MSG_LVLUP;
extern NSString *const MSG_EXHAUST;
extern NSString *const MSG_COD_PET;
extern NSString *const BOOL_1ST_VIEW;
extern NSString *const BOOL_2ND_VIEW;

@interface Pet : NSObject <NSCoding>

typedef enum
{
    TYPE_CIERVO =0,
    TYPE_GATO,
    TYPE_LEON,
    TYPE_JIRAFA
    
} mascotaTypes;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imagen;
@property (strong, nonatomic) NSString *code;
@property (assign, nonatomic) float latitud;
@property (assign, nonatomic) float longitud;
@property (nonatomic) mascotaTypes type;


-(instancetype) initWIthNAME:(NSString *)name andType:(mascotaTypes) tipo andLevel:(int) nivel andCode: (NSString*) codigo andLat:(float) latitud andLon:(float)longitud;

+(instancetype) sharedInstance;
+(void) loadData;

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
