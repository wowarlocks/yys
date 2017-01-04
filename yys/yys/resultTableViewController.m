//
//  resultTableViewController.m
//  yys
//
//  Created by xiong on 2017/1/3.
//  Copyright © 2017年 xiong. All rights reserved.
//

#import "resultTableViewController.h"
#import "rightTableViewCell.h"
#import "offerRewardModel.h"


@interface resultTableViewController ()

@end

@implementation resultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.tableView registerNib:[UINib nibWithNibName:@"rightTableViewCell" bundle:nil] forCellReuseIdentifier:@"rightCell"];
    self.tableView.estimatedRowHeight = 100 ; //44为任意值
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.searchArray allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSMutableDictionary *dic =self.searchArray[section] ;
//    NSArray *test = [dic allValues];
    NSArray *keyArray = [self.searchArray allKeys];
    
   return  [[self.searchArray objectForKey:keyArray[section]] count];
    
    
    
    
    
    
}
//小

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    rightTableViewCell *rightcell =[tableView dequeueReusableCellWithIdentifier:@"rightCell"];
    NSString *str  = [self.searchArray allKeys][indexPath.section];
    NSArray *temp = [self.searchArray objectForKey:str];
    offerRewardModel *model = temp[indexPath.row];
    
    NSString *strs = [NSString new];
    for (monster *mm in model.monsterArray) {
        
        NSString *ko = [NSString stringWithFormat:@"\r\n%@\r\n%@\r\n",mm.monsterName,mm.monsterCount];
        
        
      strs =  [strs stringByAppendingString:ko];
        
        
    }
    

    

    
    
    
    
    
//    monster *temp = self.rightDataSorce[indexPath.row];
    rightcell.monsterName.text = model.chaper;
    rightcell.monsterCount.attributedText = [self colorData:strs];
    
   
    
    return rightcell;
}
- (NSMutableAttributedString *)colorData:(NSString *)withStr{
    NSMutableAttributedString *dataStr = [[NSMutableAttributedString alloc] initWithString:withStr];
    
    for (int i = 0; i < withStr.length - _keyword.length + 1; i++) {
        
        if ([[withStr substringWithRange:NSMakeRange(i, _keyword.length)] isEqualToString:_keyword]) {
            
            NSRange range = NSMakeRange(i,_keyword.length);
            [dataStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location,range.length)];
            
        }
        
        
    }
    return dataStr;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *keyArray = [self.searchArray allKeys];
    
    
    return keyArray[section];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
