//
//  Pet.m
//  Tamago
//
//  Created by Nicolas on 11/24/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "Pet.h"
#import "Storage.h"

@interface Pet ()

#pragma mark - LocalDEFINES
#define KEY_NAME @"name"
#define KEY_TYPE @"type"
#define KEY_IMAGEN @"imagen"
#define KEY_LEVEL @"level"
#define KEY_EXP @"exp"
#define KEY_CORD_LAT @"latitud"
#define KEY_CORD_LONG @"longitud"
#define KEY_ENERGY @"energy"

@property (nonatomic) int energy;
@property (nonatomic) int level;
@property (nonatomic) int exp;
@property (nonatomic) int exprequired;
@property (strong, nonatomic) NSDictionary *POST;
@property (strong, nonatomic) NSDictionary *GET;

@end


NSString *const MSG_LVLUP =@"Alocaverna";
NSString *const MSG_EXHAUST =@"Alobestia";
NSString *const MSG_COD_PET =@"np0114";
NSString *const BOOL_1ST_VIEW =@"ViewController3";
NSString *const BOOL_2ND_VIEW =@"ViewControllerEnergia";


@implementation Pet

@synthesize name, imagen, type, level, latitud, longitud, exp, exprequired, energy, code, POST, GET, delegate;

__strong static id _sharedObject = nil;

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^
                {
                    [Pet loadData];
                    if(_sharedObject==nil)
                        _sharedObject= [[self alloc] init];
                });
    return _sharedObject;
}

+(void) loadData
{
    _sharedObject = [Storage loadPet];
}

#pragma mark - Init/EncodeOBJ
- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        [self setName: [coder decodeObjectForKey:KEY_NAME]];
        [self setType: [coder decodeIntForKey:KEY_TYPE]];
        [self setImagen: [coder decodeObjectForKey:KEY_IMAGEN]];
        [self setLevel: [coder decodeIntForKey:KEY_LEVEL]];
        [self setLatitud: [coder decodeFloatForKey: KEY_CORD_LAT]];
        [self setLongitud: [coder decodeFloatForKey:KEY_CORD_LONG]];
         self.energy = [coder decodeIntForKey:KEY_ENERGY];
         self.exp = [coder decodeIntForKey: KEY_EXP];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.name forKey:KEY_NAME];
    [coder encodeInt: self.type forKey:KEY_TYPE];
    [coder encodeObject:self.imagen forKey:KEY_IMAGEN];
    [coder encodeInt: self.level forKey:KEY_LEVEL];
    [coder encodeFloat:self.latitud forKey:KEY_CORD_LAT];
    [coder encodeFloat:self.longitud forKey:KEY_CORD_LONG];
    [coder encodeInt:self.energy forKey:KEY_ENERGY];
    [coder encodeInt:self.exp forKey:KEY_EXP];
}

#pragma mark - ConstCustom
-(instancetype) initWIthNAME:(NSString *)name andType:(mascotaTypes) tipo andLevel:(int) nivel andCode: (NSString*) codigo andLat:(float) latitud andLon:(float)longitud
{
    self = [[RankHelper sharedInstance] allocPet];
    if(self)
    {
        self.code = codigo;
        self.name = name;
        self.type = tipo;
        self.level = nivel;
        self.latitud = latitud;
        self.longitud = longitud;
        switch (tipo)
        {
            case TYPE_CIERVO:
                [self setImagen:@"ciervo_comiendo_1"];
                break;
            case TYPE_GATO:
                [self setImagen:@"gato_comiendo_1"];
                break;
            case TYPE_JIRAFA:
                [self setImagen:@"jirafa_comiendo_1"];
                break;
            case TYPE_LEON:
                [self setImagen:@"leon_comiendo_1"];
                break;
        }
    }
    return self;
}

#pragma mark - petActions
-(void) timeToEat
{
    self.energy +=50;
    [self.delegate moreProgress:self.energy];
}

-(void) timeToExercise
{
    [self calcularExpLvl];
    if(self.energy > 0)
    {
        self.energy -= 10;
        self.exp += 15;
        NSLog(@"-10+15//%d,%d",self.energy,self.exp);
        
        if(self.exp >= self.exprequired)
        {
            self.level +=1;
            [[NSNotificationCenter defaultCenter] postNotificationName:MSG_LVLUP object:nil];
            NSLog(@"%d", self.level);
        }
        
        if(self.energy <=0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:MSG_EXHAUST object:nil];
            NSLog(@"observerSend");
        }
        [self.delegate lessProgress:self.energy];
    }
}

#pragma mark - Metodos horribles
-(BOOL) valEjercitar
{
    return self.energy > 0;
}

-(void) calcularExpLvl
{
    self.exprequired = 100*(int)pow(self.level,2);
    NSLog(@"req: %d",self.exprequired);
}

-(int) showLvl
{
    return self.level;
}

-(int) showEnergy
{
    return self.energy;
}

-(int) showExp
{
    return self.exp;
}

-(void) setEnergia:(int)energia
{
    self.energy = energia;
}

-(void) setExperience:(int) expe
{
    self.exp = expe;
}

-(void) setRequiredExperience:(int) required
{
    self.exprequired = required;
}

-(void) setLevelhardcode:(int) leveleando
{
    self.level = leveleando;
}

#pragma mark - Parseo
-(NSDictionary*)fillDictionary
{
    self.POST = [NSDictionary dictionaryWithObjectsAndKeys:
                [NSString stringWithString: MSG_COD_PET], @"code",
                [NSString stringWithString: self.name], @"name",
                [NSNumber numberWithInt:self.energy], @"energy",
                [NSNumber numberWithInt:self.level], @"level",
                [NSNumber numberWithInt:self.exp], @"experience",
                [NSNumber numberWithInt:self.type], @"pet_type",
                [NSNumber numberWithFloat:self.latitud], @"position_lat",
                [NSNumber numberWithFloat:self.longitud], @"position_lon",
                nil];
    
    return self.POST;
}

-(void)fillPet: (NSDictionary*) dictionaryGet
{
    self.name = [dictionaryGet objectForKey:@"name"];
    self.energy = ((NSNumber*)[dictionaryGet objectForKey:@"energy"]).intValue;
    self.exp = ((NSNumber*)[dictionaryGet objectForKey:@"experience"]).intValue;
    self.level = ((NSNumber*)[dictionaryGet objectForKey:@"level"]).intValue;
    self.type = ((NSNumber*)[dictionaryGet objectForKey:@"pet_type"]).intValue;
    self.latitud = ((NSNumber*)[dictionaryGet objectForKey:@"position_lat"]).floatValue;
    self.longitud = ((NSNumber*)[dictionaryGet objectForKey:@"position_lon"]).floatValue;
}

@end
