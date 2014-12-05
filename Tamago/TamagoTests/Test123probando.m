//
//  Test123probando.m
//  Tamago
//
//  Created by Nicolas on 12/5/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Pet.h"


@interface Test123probando : XCTestCase

@end

@implementation Test123probando

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) test1EnergyWaste
{
    Pet *mascotest = [Pet sharedInstance];
    [mascotest setEnergia:100];
    int auxilio = 90;
    [mascotest timeToExercise];
    XCTAssertTrue([mascotest showEnergy] == auxilio, @"NOT TODAY!");
}

-(void) test2ExpPlus
{
    Pet *mascotest = [Pet sharedInstance];
    [mascotest setExperience:200];
    int auxilio = 215;
    [mascotest timeToExercise];
    XCTAssertTrue([mascotest showExp] == auxilio, @"NOT TODAY, DIRTBAG!");
    NSLog(@"VOILA!");
}

-(void) test3Lvlup
{
    Pet *mascotest = [Pet sharedInstance];
    [mascotest setLevelhardcode:1];
    [mascotest setExperience:200];
    [mascotest setRequiredExperience:210];
    int auxilio = 215;
    [mascotest timeToExercise];
    XCTAssertTrue([mascotest showLvl] == 2 && [mascotest showExp] == auxilio, @"HOLY SHIET!");
    NSLog(@"LVLUP!");
}

-(void) test4ServiceGET1
{
    
}

-(void) test5ServiceGETALL
{

}

-(void) test6ServicePOSTsome
{
    
}

- (void)testExample{
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
