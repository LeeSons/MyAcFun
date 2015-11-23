//
//  TechnologyTableViewController.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "TechnologyTableViewController.h"
#import "DataManager.h"
#import "Technology.h"
#import "GeneralTableViewCell.h"
#import "PlayViewController.h"
@interface TechnologyTableViewController ()

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, assign)NSInteger currentPage;

@end

@implementation TechnologyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"GeneralTableViewCell" bundle:nil] forCellReuseIdentifier:@"technologyCell"];
    [self addHeaderView];
    [self addFooterView];
}

- (void)addHeaderView{
    __unsafe_unretained typeof(self) vc = self;
    [self.tableView addHeaderWithCallback:^{
        [DataManager loadTECDataWithPageSize:20 Page:1 CallBack:^(id jsonObject) {
            vc.dataArray = [jsonObject[@"data"][@"page"][@"list"] mutableCopy];
            vc.currentPage = 1;
            [vc.tableView reloadData];
            [vc.tableView headerEndRefreshing];
        }];
    }];
    [self.tableView headerBeginRefreshing];
}

- (void)addFooterView{
    __unsafe_unretained typeof(self) vc = self;
    [self.tableView addFooterWithCallback:^{
        [DataManager loadTECDataWithPageSize:20 Page:vc.currentPage + 1 CallBack:^(id jsonObject) {
            NSMutableArray *array = [[NSMutableArray arrayWithArray:jsonObject[@"data"][@"page"][@"list"]] mutableCopy];
            [vc.dataArray addObjectsFromArray:array];
            vc.currentPage++;
            [vc.tableView reloadData];
            [vc.tableView footerEndRefreshing];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"technologyCell" forIndexPath:indexPath];
    Technology *technology = [Technology technologyWithDictionary:_dataArray[indexPath.row]];
    cell.technology = technology;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayViewController *playVC = [PlayViewController sharedPlayViewController];
    Technology *technology = [Technology technologyWithDictionary:_dataArray[indexPath.row]];
    playVC.playId = technology.contentId;
    playVC.playType = 2;
    [self.navigationController pushViewController:playVC animated:YES];
}

#pragma mark - lazyLoad

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
