//
//  RankViewController.m
//  Tamago
//
//  Created by Nicolas on 11/29/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "RankViewController.h"
#import "RankTableViewCell.h"
#import "Pet.h"
#import "ViewControllerEnergia.h"
#import "NetworkManage.h"

@interface RankViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableRank;

@end

@implementation RankViewController

#pragma mark - Load
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //registro cellcustom
    [self.tableRank registerNib:[UINib nibWithNibName:@"RankTableViewCell" bundle:[NSBundle mainBundle]]
             forCellReuseIdentifier:@"RankTableViewCell"];
    
    //Array
    self.arregloRank = [[NSMutableArray alloc] init];
    
    //DATArefresh
    [self.tableRank reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    //callGETALL
    [self loadDataALL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Servicio__LoadALLdata
-(void) loadDataALL
{
    [[NetworkManage sharedInstance] GET:[NSString stringWithFormat:@"/pet/all"]
                             parameters:nil
                                success:[self successBlockLoadALL]
                                failure:[self failureBlock]];
}

-(Success) successBlockLoadALL
{
    __weak typeof(self) weakerSelf = self;
    
    return ^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"%@",responseObject);
        
        NSArray* answerArray = (NSArray*)responseObject;
        for (NSDictionary* dictionary in answerArray)
        {
            NSString* nombre = [dictionary objectForKey:@"name"];
            int level = ((NSNumber*)[dictionary objectForKey:@"level"]).intValue;
            mascotaTypes type = ((NSNumber*)[dictionary objectForKey:@"pet_type"]).intValue;
            
            //fillArrayRank with eachPet
            Pet *auxPet = [[Pet alloc] initWIthNAME:nombre andType:type andLevel:level];
            [weakerSelf.arregloRank addObject:auxPet];
        }
        //fillTable
        [weakerSelf.tableRank reloadData];
    };
}

-(Failure)failureBlock
{
    return ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"%@",error);
    };
}

#pragma mark - DATASOURCE//metodos
//cantidad de filas
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arregloRank.count;
}

//celdas
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RankTableViewCell";
    
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell)
    {
        cell = [[RankTableViewCell alloc] init];
    }
    
    [cell.imgRankCell setImage:[UIImage imageNamed:((Pet*)self.arregloRank[indexPath.row]).imagen]];
    [cell.lblRankName setText:((Pet *)self.arregloRank[indexPath.row]).name];
    [cell.lblRankLevel setText:[NSString stringWithFormat:@"%d",((Pet *)self.arregloRank[indexPath.row]).showLvl]];
     
    return cell;
}

//TituloHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"TOP15!";
}


@end
