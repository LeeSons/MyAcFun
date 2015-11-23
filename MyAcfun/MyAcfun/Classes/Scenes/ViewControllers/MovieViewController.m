//
//  MovieViewController.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "DataManager.h"
#import "PlayViewController.h"
#import "IndexViewController.h"
@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll2Movies;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment2ChangType;
@property (nonatomic, assign)NSInteger currentPageAnima;
@property (nonatomic, assign)NSInteger currentPageMovie;
@property (nonatomic, assign)NSInteger currentPageVer;
@property (nonatomic, assign)NSInteger currentPageTV;
@property (weak, nonatomic) IBOutlet UITableView *table2Anima;
@property (weak, nonatomic) IBOutlet UITableView *table2Movie;
@property (weak, nonatomic) IBOutlet UITableView *table2Ver;
@property (weak, nonatomic) IBOutlet UITableView *table2TV;
@property (nonatomic, strong)NSMutableDictionary *animaDict;
@property (nonatomic, strong)NSMutableDictionary *movieDict;
@property (nonatomic, strong)NSMutableDictionary *verDict;
@property (nonatomic, strong)NSMutableDictionary *TVDict;
- (IBAction)action2ChangeType:(UISegmentedControl *)sender;

@end
static NSString *animaCellIdent = @"movieCell";
@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.table2Anima registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:animaCellIdent];
    [self.table2Movie registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:animaCellIdent];
    [self.table2Ver registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:animaCellIdent];
    [self.table2TV registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:animaCellIdent];
    [self action2ChangeType:nil];
    self.segment2ChangType.backgroundColor = [UIColor colorWithRed:54 / 255.0 green:123 / 255.0 blue:210 / 255.0 alpha:1];
    [self addHeader];
    [self addFooter];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.table2Anima addHeaderWithCallback:^{
        [DataManager loadDataWithPageSize:20 Page:1 Sort:1 Type:1 CallBack:^(id jsonObject) {
            if (jsonObject) {
                vc.animaDict = [[(NSDictionary *)jsonObject objectForKey:@"data"] mutableCopy];
                vc.currentPageAnima = 1;
                [vc.table2Anima headerEndRefreshing];
                [vc.table2Anima reloadData];
            }else{
                NSLog(@"加载失败");
            }
        }];
    }];
    [self.table2Anima headerBeginRefreshing];
    // 添加下拉刷新头部控件
    [self.table2Ver addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [DataManager loadDataWithPageSize:20 Page:1 Sort:1 Type:3 CallBack:^(id jsonObject) {
            if (jsonObject) {
                vc.verDict = [[(NSDictionary *)jsonObject objectForKey:@"data"] mutableCopy];
                [vc.table2Ver headerEndRefreshing];
                [vc.table2Ver reloadData];
            }else{
                NSLog(@"加载失败");
            }
        }];
    }];
    // 添加下拉刷新头部控件
    [self.table2Movie addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [DataManager loadDataWithPageSize:20 Page:1 Sort:1 Type:2 CallBack:^(id jsonObject) {
            if (jsonObject) {
                vc.movieDict = [[(NSDictionary *)jsonObject objectForKey:@"data"] mutableCopy];
                [vc.table2Movie reloadData];
                [vc.table2Movie headerEndRefreshing];
                vc.currentPageMovie = 1;
            }else{
                NSLog(@"加载失败");
            }
        }];
    }];
    // 添加下拉刷新头部控件
    [self.table2TV addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [DataManager loadDataWithPageSize:20 Page:1 Sort:1 Type:4 CallBack:^(id jsonObject) {
            if (jsonObject) {
                vc.TVDict = [[(NSDictionary *)jsonObject objectForKey:@"data"] mutableCopy];
                [vc.table2TV headerEndRefreshing];
                [vc.table2TV reloadData];
            }else{
                NSLog(@"加载失败");
            }
        }];
    }];
    
}

- (void)addFooter{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.table2Anima addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [DataManager loadDataWithPageSize:20 Page:_currentPageAnima + 1 Sort:1 Type:1 CallBack:^(id jsonObject) {
            NSArray *array = jsonObject[@"data"][@"list"];
            if (array.count > 0) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:self.animaDict[@"list"]];
                for (NSDictionary *dict in [jsonObject[@"data"] objectForKey:@"list"]) {
                    [array addObject:dict];
                }
                [vc.animaDict setObject:array forKey:@"list"];
                _currentPageAnima++;
                [vc.table2Anima footerEndRefreshing];
                [vc.table2Anima reloadData];
            }else{
                [vc.table2Anima footerEndRefreshing];
            }
        }];
    }];
    
    [self.table2Movie addFooterWithCallback:^{
        [DataManager loadDataWithPageSize:20 Page:_currentPageMovie + 1 Sort:1 Type:2 CallBack:^(id jsonObject) {
            NSArray *array = jsonObject[@"data"][@"list"];
            if (array.count > 0) {
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.movieDict[@"list"]];
                for (NSDictionary *dict in [jsonObject[@"data"] objectForKey:@"list"]) {
                    [tempArray addObject:dict];
                }
                [vc.movieDict setObject:tempArray forKey:@"list"];
                _currentPageMovie++;
                [vc.table2Movie footerEndRefreshing];
                [vc.table2Movie reloadData];
            }else{
                [vc.table2Movie footerEndRefreshing];
            }
        }];
    }];
    
    [self.table2Ver addFooterWithCallback:^{
        [DataManager loadDataWithPageSize:20 Page:_currentPageMovie + 1 Sort:1 Type:3 CallBack:^(id jsonObject) {
            NSArray *array = jsonObject[@"data"][@"list"];
            if (array.count > 0) {
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.verDict[@"list"]];
                for (NSDictionary *dict in [jsonObject[@"data"] objectForKey:@"list"]) {
                    [tempArray addObject:dict];
                }
                [vc.verDict setObject:tempArray forKey:@"list"];
                _currentPageMovie++;
                [vc.table2Ver footerEndRefreshing];
                [vc.table2Ver reloadData];
            }else{
                [vc.table2Ver footerEndRefreshing];
            }
        }];
    }];
    
    [self.table2TV addFooterWithCallback:^{
        [DataManager loadDataWithPageSize:20 Page:_currentPageMovie + 1 Sort:1 Type:4 CallBack:^(id jsonObject) {
            NSArray *array = jsonObject[@"data"][@"list"];
            if (array.count > 0) {
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.TVDict[@"list"]];
                for (NSDictionary *dict in [jsonObject[@"data"] objectForKey:@"list"]) {
                    [tempArray addObject:dict];
                }
                [vc.TVDict setObject:tempArray forKey:@"list"];
                _currentPageMovie++;
                [vc.table2TV footerEndRefreshing];
                [vc.table2TV reloadData];
            }else{
                [vc.table2TV footerEndRefreshing];
            }
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.table2Anima]) {
        return [[self.animaDict objectForKey:@"list"] count];
    }else if ([tableView isEqual:self.table2Movie]){
        return [[self.movieDict objectForKey:@"list"] count];
    }else if ([tableView isEqual:self.table2Ver]){
        return [[self.verDict objectForKey:@"list"] count];
    }else if([tableView isEqual:self.table2TV]){
        return [[self.TVDict objectForKey:@"list"] count];
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:animaCellIdent forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if ([tableView isEqual:self.table2Anima]) {
        Movie *movie = [Movie movieWithDictionary:self.animaDict[@"list"][indexPath.row]];
        cell.movie = movie;
    }else if ([tableView isEqual:self.table2Movie]){
        Movie *movie = [Movie movieWithDictionary:self.movieDict[@"list"][indexPath.row]];
        cell.movie = movie;
    }else if ([tableView isEqual:self.table2Ver]){
        Movie *movie = [Movie movieWithDictionary:self.verDict[@"list"][indexPath.row]];
        cell.movie = movie;
    }else if ([tableView isEqual:self.table2TV]){
        Movie *movie = [Movie movieWithDictionary:self.TVDict[@"list"][indexPath.row]];
        cell.movie = movie;
    }
    return cell;
}

// 点击进入播放
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayViewController *playVC = [PlayViewController sharedPlayViewController];
    playVC.playType = 0;
    if ([tableView isEqual:self.table2Anima]) {
        Movie *movie = [Movie movieWithDictionary:self.animaDict[@"list"][indexPath.row]];
        playVC.playId = movie.Id;
    }else if ([tableView isEqual:self.table2Movie]){
        Movie *movie = [Movie movieWithDictionary:self.movieDict[@"list"][indexPath.row]];
        playVC.playId = movie.Id;
    }else if ([tableView isEqual:self.table2Ver]){
        Movie *movie = [Movie movieWithDictionary:self.verDict[@"list"][indexPath.row]];
        playVC.playId = movie.Id;
    }else if ([tableView isEqual:self.table2TV]){
        Movie *movie = [Movie movieWithDictionary:self.TVDict[@"list"][indexPath.row]];
        playVC.playId = movie.Id;
    }
    [self.navigationController pushViewController:playVC animated:YES];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }else{
        CGFloat x = scrollView.contentOffset.x;
        NSInteger index = x / (windowWidth * 1.0);
        [self.segment2ChangType setSelectedSegmentIndex:index];
        [self action2ChangeType:self.segment2ChangType];
    }
    
}

// 进入页面就下拉刷新
- (IBAction)action2ChangeType:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [self.table2Anima headerBeginRefreshing];
    }
    if ([sender selectedSegmentIndex] == 1) {
        [self.table2Movie headerBeginRefreshing];
    }
    if ([sender selectedSegmentIndex] == 2) {
        [self.table2Ver headerBeginRefreshing];
    }
    if ([sender selectedSegmentIndex] == 3) {
        [self.table2TV headerBeginRefreshing];
    }
    CGFloat x = [sender selectedSegmentIndex] * windowWidth;
    [self.scroll2Movies setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark -lazyLoad
- (NSMutableDictionary *)animaDict{
    if (!_animaDict) {
        _animaDict = [NSMutableDictionary dictionary];
    }
    return _animaDict;
}
- (NSMutableDictionary *)movieDict{
    if (!_movieDict) {
        _movieDict = [NSMutableDictionary dictionary];
    }
    return _movieDict;
}
- (NSMutableDictionary *)verDict{
    if (!_verDict) {
        _verDict = [NSMutableDictionary dictionary];
    }
    return _verDict;
}
- (NSMutableDictionary *)TVDict{
    if (!_TVDict) {
        _TVDict = [NSMutableDictionary dictionary];
    }
    return _TVDict;
}
@end
