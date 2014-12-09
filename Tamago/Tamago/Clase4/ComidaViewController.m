//
//  ComidaViewController.m
//  Tamago
//
//  Created by Nicolas on 11/20/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ComidaViewController.h"
#import "ViewControllerEnergia.h"
#import "Meal.h"
#import "CellTableViewCell.h"
#import "FoodProtocol.h"

@interface ComidaViewController ()

#pragma mark - Propiedades
@property(strong, nonatomic) NSString *descripcion;
@property(strong, nonatomic) NSString *imagen;
@property (strong, nonatomic) IBOutlet UITableView *tableViewFood;

#pragma mark - Delegates
@property (weak, nonatomic) id <FoodProtocol> delegateFood;

@end

@implementation ComidaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //fillTabla
    [self llenarTablaArray];
    
    //registro cell
    [self.tableViewFood registerNib:[UINib nibWithNibName:@"CellTableViewCell" bundle:[NSBundle mainBundle]]
       forCellReuseIdentifier:@"CellTableViewCell"];
    
    //DATArefresh
    [self.tableViewFood reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodos
- (void)llenarTablaArray
{
    Meal *comida0 = [[Meal alloc] initWithDESC:@"Pastel" andImagen:@"comida_0"];
    Meal *comida1 = [[Meal alloc] initWithDESC:@"Cake" andImagen:@"comida_1"];
    Meal *comida2 = [[Meal alloc] initWithDESC:@"Helado" andImagen:@"comida_2"];
    Meal *comida3 = [[Meal alloc] initWithDESC:@"Pollo" andImagen:@"comida_3"];
    Meal *comida4 = [[Meal alloc] initWithDESC:@"Hamburguesa" andImagen:@"comida_4"];
    Meal *comida5 = [[Meal alloc] initWithDESC:@"Pescado" andImagen:@"comida_5"];
    Meal *comida6 = [[Meal alloc] initWithDESC:@"Manzana" andImagen:@"comida_6"];
    Meal *comida7 = [[Meal alloc] initWithDESC:@"Salchicha" andImagen:@"comida_7"];
    Meal *comida8 = [[Meal alloc] initWithDESC:@"Pan" andImagen:@"comida_8"];
    
    self.arreglo = [NSMutableArray arrayWithArray:@[comida0,comida1,comida2,comida3,comida4,comida5,comida6,comida7,comida8]];
}

#pragma mark - DATASOURCE//metodos
//cantidad de filas
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arreglo.count;
}

//celdas
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CellTableViewCell";

    CellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell)
    {
        cell = [[CellTableViewCell alloc] init];
    }
    
     [cell.imgViewCell setImage: [UIImage imageNamed:((Meal *) self.arreglo[indexPath.row]).imagen]];
     [cell.lblDesc setText:((Meal *) self.arreglo[indexPath.row]).desc];
    
    return cell;
}

//TituloHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Menu";
}

#pragma mark - DELEGATE//metodos
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate DidSelectedMeal:self.arreglo[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
