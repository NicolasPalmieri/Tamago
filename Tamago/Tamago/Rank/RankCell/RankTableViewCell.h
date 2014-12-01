//
//  RankTableViewCell.h
//  Tamago
//
//  Created by Nicolas on 11/29/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@protocol RankTableViewCelldelegate <NSObject>

@required

- (void)DidSelectedPetMap: (Pet*) mascota;

@end

@interface RankTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgRankCell;
@property (strong, nonatomic) IBOutlet UILabel *lblRankName;
@property (strong, nonatomic) IBOutlet UILabel *lblRankLevel;
@property (strong, nonatomic) Pet *mascota;

#pragma mark - Delegates
@property (weak, nonatomic) id <RankTableViewCelldelegate> delegateMap;

@end
