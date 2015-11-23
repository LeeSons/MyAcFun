//
//  LeftTableViewController.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "LeftTableViewController.h"
#import "MovieViewController.h"
#import "ArticleTableViewController.h"
#import "TechnologyTableViewController.h"
#import "MusicTableViewController.h"
#import "LeftViewCell.h"
#define width self.view.frame.size.width
@interface LeftTableViewController ()
@property(nonatomic, strong) NSArray *colors;
@property(nonatomic, assign) NSInteger previousRow;
@property(nonatomic, strong) UIStoryboard *sb;
@property(nonatomic, strong) NSArray *row;
@property(nonatomic, strong) NSArray *imgNameArray;
@end
static NSString * const kICSColorsViewControllerCellReuseId = @"typeCell";
@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.row =@[@"番剧",@"文章",@"科技",@"音乐"];
    self.imgNameArray= @[@"fj.jpg",@"wz.jpg",@"kj.jpg",@"yy.jpg"];
    self.sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     [self.tableView registerNib:[UINib nibWithNibName:@"LeftViewCell" bundle:nil] forCellReuseIdentifier:kICSColorsViewControllerCellReuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setBackgroundView];
}

- (void)setBackgroundView{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgView.image = [UIImage imageNamed:@"mbl.jpg"];
    self.tableView.backgroundView = imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    return _row.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kICSColorsViewControllerCellReuseId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.lblMenuType.text = _row[indexPath.row];
    cell.imgTypeDes.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imgNameArray[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MovieViewController *movieVC = [_sb instantiateViewControllerWithIdentifier:@"movieVC"];
        [self.navigationController pushViewController:movieVC animated:YES];
    }else if(indexPath.row == 1){
        ArticleTableViewController *articleVC = [_sb instantiateViewControllerWithIdentifier:@"articleVC"];
        [self.navigationController pushViewController:articleVC animated:YES];
    }else if(indexPath.row == 2){
        TechnologyTableViewController *technologyVC = [_sb instantiateViewControllerWithIdentifier:@"technologyVC"];
        [self.navigationController pushViewController:technologyVC animated:YES];
    }else if(indexPath.row == 3){
        MusicTableViewController *musicVC = [_sb instantiateViewControllerWithIdentifier:@"musicVC"];
        [self.navigationController pushViewController:musicVC animated:YES];
    }
    self.callBackToClose();
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
