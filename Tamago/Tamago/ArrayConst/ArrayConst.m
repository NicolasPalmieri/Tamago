//
//  ArrayConst.m
//  Tamago
//
//  Created by Nicolas on 11/21/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ArrayConst.h"

@implementation ArrayConst

-(void)FILLarray:(Pet*) mascota
{
    switch(mascota.type)
        {
            case TYPE_CIERVO:
                self.arrayEat = @[@"ciervo_comiendo_1",@"ciervo_comiendo_2",@"ciervo_comiendo_3",@"ciervo_comiendo_4"];
                self.arrayTrain = @[@"ciervo_ejercicio_1",@"ciervo_ejercicio_2",@"ciervo_ejercicio_3",@"ciervo_ejercicio_4",@"ciervo_ejercicio_5"];
                self.arrayExhaust = @[@"ciervo_exhausto_1",@"ciervo_exhausto_2",@"ciervo_exhausto_3",@"ciervo_exhausto_4"];
                break;
            case TYPE_GATO:
                self.arrayEat = @[@"gato_comiendo_1",@"gato_comiendo_2",@"gato_comiendo_3",@"gato_comiendo_4"];
                self.arrayTrain = @[@"gato_ejercicio_1",@"gato_ejercicio_2",@"gato_ejercicio_3",@"gato_ejercicio_4",@"gato_ejercicio_5"];
                self.arrayExhaust = @[@"gato_exhausto_1",@"gato_exhausto_2",@"gato_exhausto_3",@"gato_exhausto_4"];
                break;
            case TYPE_JIRAFA:
                self.arrayEat = @[@"jirafa_comiendo_1",@"jirafa_comiendo_2",@"jirafa_comiendo_3",@"jirafa_comiendo_4"];
                self.arrayTrain = @[@"jirafa_ejercicio_1",@"jirafa_ejercicio_2",@"jirafa_ejercicio_3",@"jirafa_ejercicio_4",@"jirafa_ejercicio_5"];
                self.arrayExhaust = @[@"jirafa_exhausto_1",@"jirafa_exhausto_2",@"jirafa_exhausto_3",@"jirafa_exhausto_4"];
                break;
            case TYPE_LEON:
                self.arrayEat = @[@"leon_comiendo_1",@"leon_comiendo_2",@"leon_comiendo_3",@"leon_comiendo_4"];
                self.arrayTrain = @[@"leon_ejercicio_1",@"leon_ejercicio_2",@"leon_ejercicio_3",@"leon_ejercicio_4",@"leon_ejercicio_5"];
                self.arrayExhaust = @[@"leon_exhausto_1",@"leon_exhausto_2",@"leon_exhausto_3",@"leon_exhausto_4"];
                break;
        }
    self.arrayEat = [NSArray arrayWithArray:self.arrayEat];
    self.arrayTrain = [NSArray arrayWithArray:self.arrayTrain];
    self.arrayExhaust = [NSArray arrayWithArray:self.arrayExhaust];
}

@end
