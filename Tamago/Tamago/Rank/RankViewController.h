//
//  RankViewController.h
//  Tamago
//
//  Created by Nicolas on 11/29/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankViewController : UIViewController <UITableViewDataSource>

@property(strong, nonatomic) NSMutableArray *arregloRank;
@property(strong, nonatomic) NSArray *arregloSorteado;

@end
