//
//  CellTableViewCell.h
//  Tamago
//
//  Created by Nicolas on 11/20/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTableViewCell : UITableViewCell

#pragma mark - Propiedades//Imagen-Desc
@property (strong, nonatomic) IBOutlet UIImageView *imgViewCell;
@property (strong, nonatomic) IBOutlet UILabel *lblDesc;

@end
