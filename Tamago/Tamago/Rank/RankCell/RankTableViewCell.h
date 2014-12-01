//
//  RankTableViewCell.h
//  Tamago
//
//  Created by Nicolas on 11/29/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgRankCell;
@property (strong, nonatomic) IBOutlet UILabel *lblRankName;
@property (strong, nonatomic) IBOutlet UILabel *lblRankLevel;

@end
