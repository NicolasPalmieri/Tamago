//
//  ViewController2.h
//  Tamago
//
//  Created by Nicolas on 11/18/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^Success)(NSURLSessionDataTask*,id);
typedef void (^Failure)(NSURLSessionDataTask*, NSError*);

@interface ViewController2 : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *nick;

- (void) getEvents:(Success) success failure:(Failure) failure;

@end
