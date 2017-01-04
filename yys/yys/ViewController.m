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
#import "resultTableViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) resultTableViewController   *resultController;
@property(nonatomic,strong) NSArray *dataSorce;
@property(nonatomic,strong) NSArray *rightDataSorce;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITableView *rightTableview;
@end

@implementation ViewController{
    int chapterIndex;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    chapterIndex = 0;
    
    
    
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
    

    
    /*------*/
    self.resultController = [[resultTableViewController alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultController];
    self.searchController.searchResultsUpdater = self;
//    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder = @"fuck";
//    self.rightTableview.tableHeaderView = self.searchController.searchBar;
    
    self.navigationItem.titleView = self.searchController.searchBar;
//    self.searchController.searchBar.barStyle = UIBarStyleBlack;
    self.resultController.view.backgroundColor = [UIColor redColor];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    

    

}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar                    // called when text starts editing
{
//            self.rightTableview.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height);
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"search is %@", searchController.searchBar.text);
    
    
    //鬼黄
    NSMutableDictionary *make =  [self backSearchArrayWithSearchText:searchController.searchBar.text];
   NSLog(@"make is %@", make);
    self.resultController.keyword = searchController.searchBar.text;
    self.resultController.searchArray = make;
    [self.resultController.tableView reloadData];
    
}
//水池
-(NSMutableDictionary *)backSearchArrayWithSearchText:(NSString *)searchStr{
//    if ([searchStr isEqualToString:@""]) return nil;
    NSMutableDictionary *groupDIC = [NSMutableDictionary new];
    NSMutableArray *resultArray = [NSMutableArray new];
    if (self.dataSorce) {
#warning fix  神秘线索应该遍历monsterName
        //分别对4个数组进行遍历筛选
        
        for (int i = 0; i<self.dataSorce.count; i++) {
            
            NSString *str;
            switch (i) {
                case 0:
                    str = @"探索";
                    break;
                case 1:
                    str = @"御魂";
                    break;
                case 2:
                    str = @"妖气";
                    break;
                case 3:
                    str = @"神秘";
                    break;
                default:
                    break;
            }
            
            //取出对应的探索、御魂素组
            NSArray *testArray = self.dataSorce[i];
            
            
            
            NSMutableArray      *groupChapter  = [NSMutableArray new];
            //遍历对应数组模型、筛选符合的
            for (offerRewardModel *tempModel in testArray) {
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"monsterCount CONTAINS %@",searchStr];
                //筛选之后的结果
                NSArray *temp = [tempModel.monsterArray filteredArrayUsingPredicate:predicate];
                
                
                
                
                
                if (temp.count != 0) {
                    //这里就是某一章节搜索出来的
                    offerRewardModel *model = [offerRewardModel new];
                    model.chaper = tempModel.chaper;
                    model.monsterArray = (NSMutableArray *)temp;
                    
                    NSMutableArray *mast = [groupDIC objectForKey:str];
                    if (!mast) {
                        mast = [NSMutableArray new];
                    }
                    [mast addObject:model];
                    [groupDIC setObject:mast forKey:str];
//                    NSDictionary *exploreDIC = @{
//                                                 tempModel.chaper:
//                                                     temp
//                                                 
//                                                 };
//                    [groupChapter addObject:model];
                    
//                    NSLog(@"%@过滤之后%@ is %@",str, tempModel.chaper,temp);
                }
                
            }
            if (groupChapter.count) {
                
//                [groupDIC setObject:groupChapter forKey:str];
//                [resultArray addObject:groupDIC];
            }
           
            
//            chapterIndex = i;
            
        }
        
//        chapterIndex = 0;
   /*     //探索筛选
        NSArray *exploreArray = [self.dataSorce.firstObject copy];
        for (offerRewardModel *tempModel in exploreArray) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"monsterCount CONTAINS %@",searchStr];
            NSArray *temp = [tempModel.monsterArray filteredArrayUsingPredicate:predicate];
            if (temp.count != 0) {
                
                NSDictionary *exploreDIC = @{
                                                tempModel.chaper:
                                                temp
                                             
                                                };
               NSLog(@"探索过滤之后%@ is %@", tempModel.chaper,temp);
            }
            
        }
        
        */
        
        
        
    }

    return groupDIC;
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
