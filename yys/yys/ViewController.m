//
//  ViewController.m
//  yys
//
//  Created by xiong on 2017/1/2.
//  Copyright © 2017年 xiong. All rights reserved.
//

#import "ViewController.h"
#import "network.h"
#import "TableViewCell.h"
#import "rightTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *dataSorce;
@property(nonatomic,strong) NSArray *rightDataSorce;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITableView *rightTableview;
@end

@implementation ViewController{
    BOOL _isRelate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.rightTableview registerNib:[UINib nibWithNibName:@"rightTableViewCell" bundle:nil] forCellReuseIdentifier:@"rightCell"];
    self.rightTableview.estimatedRowHeight = 44 ; //44为任意值
    self.rightTableview.rowHeight = UITableViewAutomaticDimension;
    [[network manger] checkUpDataSuccees:^(NSArray *array) {
        NSLog(@"array is %@", array);
        self.dataSorce = array;
        [self.tableview reloadData];
    } Error:^(NSError *error) {
        NSLog(@"error is %@", error);
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.tableview) {
       return self.dataSorce.count;
    }else{
        return 1;
    }
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *make = self.dataSorce[section];
    if (tableView == self.tableview) {
        
        return make.count;
    }else{
        return self.rightDataSorce.count;
    }


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableview) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            offerRewardModel *model = self.dataSorce[indexPath.section][indexPath.row];
            cell.name.text = model.chaper;
        return cell;
    }else{
        rightTableViewCell *rightcell =[tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        monster *temp = self.rightDataSorce[indexPath.row];
        rightcell.monsterName.text = temp.monsterName;
        rightcell.monsterCount.text = temp.monsterCount;
        
        
        return rightcell;
    }
    
    


    
    


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        offerRewardModel *model = self.dataSorce[indexPath.section][indexPath.row];
        self.rightDataSorce = model.monsterArray;
        [self.rightTableview reloadData];
        
    }else{

    }




}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableview) {
        if (section == 0) {
            return @"探索";
        }else if (section == 1){
            return @"御魂";
        }else if (section == 2){
            return @"妖气封印";
        }else{
            return @"神秘线索";
        }
    }else{
        return nil;
    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
