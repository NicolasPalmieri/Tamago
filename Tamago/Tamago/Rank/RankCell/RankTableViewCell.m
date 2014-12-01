//
//  RankTableViewCell.m
//  Tamago
//
//  Created by Nicolas on 11/29/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "RankTableViewCell.h"

@interface RankTableViewCell()

@end


@implementation RankTableViewCell

- (IBAction)btnMapa:(id)sender
{
    if(self.delegateMap)
    {
        [self.delegateMap DidSelectedPetMap:self.mascota];
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
