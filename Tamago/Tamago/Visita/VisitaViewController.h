//
//  VisitaViewController.h
//  Tamago
//
//  Created by Nicolas on 12/4/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Success)(NSURLSessionDataTask*,id);
typedef void (^Failure)(NSURLSessionDataTask*, NSError*);

@interface VisitaViewController : UIViewController

#pragma mark - Intancias
-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCode:(NSString*) code;

@end
