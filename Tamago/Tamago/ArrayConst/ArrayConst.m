//
//  ArrayConst.m
//  Tamago
//
//  Created by Nicolas on 11/21/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ArrayConst.h"

@implementation ArrayConst

-(void)FILLarray:(int) var
{
    NSArray *auxiliar;
    switch(var)
        {
            case 1:
                auxiliar = @[@"ciervo_comiendo_1",@"ciervo_comiendo_2",@"ciervo_comiendo_3",@"ciervo_comiendo_4"];
                break;
            case 2:
                auxiliar = @[@"gato_comiendo_1",@"gato_comiendo_2",@"gato_comiendo_3",@"gato_comiendo_4"];
                break;
            case 3:
                auxiliar = @[@"jirafa_comiendo_1",@"jirafa_comiendo_2",@"jirafa_comiendo_3",@"jirafa_comiendo_4"];
                break;
            case 4:
                auxiliar = @[@"leon_comiendo_1",@"leon_comiendo_2",@"leon_comiendo_3",@"leon_comiendo_4"];
                break;
        }
    self.array = [NSArray arrayWithArray:auxiliar];
}

@end
