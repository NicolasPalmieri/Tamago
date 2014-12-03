//
//  RankViewController.h
//  Tamago
//
//  Created by Nicolas on 11/29/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankTableViewCell.h"
#import "Pet.h"


@interface RankViewController : UIViewController <UITableViewDataSource, RankTableViewCelldelegate>

@property(strong, nonatomic) NSMutableArray *arregloRank;
@property(strong, nonatomic) NSArray *arregloSorteado;
@property(strong, nonatomic) Pet *masc;

@end
