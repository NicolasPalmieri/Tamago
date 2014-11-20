//
//  ComidaViewController.h
//  Tamago
//
//  Created by Nicolas on 11/20/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComidaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

#pragma mark - Propiedades
@property(strong, nonatomic) NSMutableArray *arreglo;

@end
