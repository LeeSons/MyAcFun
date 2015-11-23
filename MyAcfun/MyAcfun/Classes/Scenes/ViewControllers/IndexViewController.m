//
//  IndexViewController.m
//  MyAcfun
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 李成鹏.com. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexViewCell.h"
#import "ArticleViewCell.h"
#import "TechnologyViewCell.h"
#import "MusicViewCell.h"
#import "DataManager.h"
#import "CustomReusableView.h"
#import "PlayViewController.h"
#import "Arcitle.h"
#import "Music.h"
#import "Technology.h"
#import "MovieViewController.h"
#import "ArticleTableViewController.h"
#import "TechnologyTableViewController.h"
#import "MusicTableViewController.h"
#import "ScrollReusableView.h"
#import "LeftTableViewController.h"
@interface IndexViewController ()<UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)NSMutableDictionary *dataDict;
@property(nonatomic, strong)NSArray *sectionArray;
@property(nonatomic, strong)NSMutableArray *scrollImageArray;
@property(nonatomic, strong)NSMutableArray *scrollTitleArray;
@property(nonatomic, strong)ICSDrawerController *drow;
@property(nonatomic, strong)NSTimer *timer;

@end

@implementation IndexViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifierArticle = @"CellArticle";
static NSString * const reuseIdentifierTec = @"CellTec";
static NSString * const reuseIdentifierMusic = @"CellMusic";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionArray = @[@"番剧推荐",@"文章更新",@"最新科技",@"音乐推荐"];
    self.scrollImageArray = [NSMutableArray array];
    self.scrollTitleArray = [NSMutableArray array];
    self.collectionView.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1];
    // Register cell classes
    [self.collectionView registerClass:[IndexViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[ArticleViewCell class] forCellWithReuseIdentifier:reuseIdentifierArticle];
    [self.collectionView registerClass:[TechnologyViewCell class] forCellWithReuseIdentifier:reuseIdentifierTec];
    [self.collectionView registerClass:[MusicViewCell class] forCellWithReuseIdentifier:reuseIdentifierMusic];
    [self.collectionView registerClass:[CustomReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReusa"];
    [self.collectionView registerClass:[ScrollReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewReusa"];
    [self addHeaderView];
}

- (void)addHeaderView{
    __unsafe_unretained typeof(self) vc = self;
    [self.collectionView addHeaderWithCallback:^{
        [vc loadData];
    }];
    [self.collectionView headerBeginRefreshing];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)loadData{
    if (self.dataDict.count > 0) {
        [self.dataDict removeAllObjects];
    }
    if (self.scrollImageArray.count > 0) {
        [self.scrollImageArray removeAllObjects];
    }
    if (self.scrollTitleArray.count > 0) {
        [self.scrollTitleArray removeAllObjects];
    }
    // 加载番剧：
    [DataManager loadDataWithPageSize:4 Page:1 Sort:1 Type:1 CallBack:^(id jsonObject) {
        if (jsonObject) {
            NSDictionary *tempDic = (NSDictionary *)jsonObject;
            NSMutableArray *tempArray = [NSMutableArray array];
            NSMutableArray *array = tempDic[@"data"][@"list"];
            for (NSDictionary *dict in array) {
                Movie *movie = [Movie movieWithDictionary:dict];
                [tempArray addObject:movie];
            }
            for (int i = 0; i < 2; i++) {
                Movie *movie = tempArray[i];
                [self.scrollImageArray addObject:movie.cover];
                [self.scrollTitleArray addObject:movie.title];
            }
            [self.dataDict setObject:tempArray forKey:self.sectionArray[0]];
            NSLog(@"OK");
            [self loadArticle];
        }else{
            NSLog(@"加载失败，正在重新加载。");
            [self loadData];
        }
    }];
}
- (void)loadArticle{
    // 加载文章
    [DataManager loadArticalDataWithPageSize:4 Page:1 CallBack:^(id jsonObject) {
        if (jsonObject) {
            NSDictionary *tempDic = (NSDictionary *)jsonObject;
            NSMutableArray *tempArray = [NSMutableArray array];
            NSMutableArray *array = tempDic[@"data"][@"page"][@"list"];
            for (NSDictionary *dict in array) {
                Arcitle *article = [Arcitle articleWithDictionary:dict];
                [tempArray addObject:article];
            }
            [self.dataDict setObject:tempArray forKey:self.sectionArray[1]];
            NSLog(@"OK");
            [self loadTec];
        }else{
            NSLog(@"加载失败，正在重新加载。");
            [self loadTec];
        }
    }];
}

- (void)loadTec{
    // 加载科技
    [DataManager loadTECDataWithPageSize:4 Page:1 CallBack:^(id jsonObject) {
        if (jsonObject) {
            NSDictionary *tempDic = (NSDictionary *)jsonObject;
            NSMutableArray *tempArray = [NSMutableArray array];
            NSMutableArray *array = tempDic[@"data"][@"page"][@"list"];
            for (NSDictionary *dict in array) {
                Technology *technology = [Technology technologyWithDictionary:dict];
                [tempArray addObject:technology];
            }
            for (int i = 0; i < 2; i++) {
                Technology *technology = tempArray[i];
                [self.scrollImageArray addObject:technology.cover];
                [self.scrollTitleArray addObject:technology.title];
            }
            [self.dataDict setObject:tempArray forKey:self.sectionArray[2]];
            NSLog(@"OK");
            [self loadMusic];
        }else{
            NSLog(@"加载失败，正在重新加载。");
            [self loadTec];
        }
    }];
}

- (void)loadMusic{
    // 加载音乐
    [DataManager loadMusicDataWithPageSize:4 Page:1 CallBack:^(id jsonObject) {
        if (jsonObject) {
            NSDictionary *tempDic = (NSDictionary *)jsonObject;
            NSMutableArray *tempArray = [NSMutableArray array];
            NSMutableArray *array = tempDic[@"data"][@"page"][@"list"];
            for (NSDictionary *dict in array) {
                Music *music = [Music musicWithDictionary:dict];
                [tempArray addObject:music];
            }
            for (int i = 0; i < 2; i++) {
                Music *music = tempArray[i];
                [self.scrollImageArray addObject:music.cover];
                [self.scrollTitleArray addObject:music.title];
            }
            [self.dataDict setObject:tempArray forKey:self.sectionArray[3]];
            NSLog(@"OK");
            [self.collectionView headerEndRefreshing];
            [self.collectionView reloadData];

        }else{
            NSLog(@"加载失败，正在重新加载。");
            [self loadMusic];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataDict[_sectionArray[section]] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataDict[_sectionArray[indexPath.section]];
    if (indexPath.section == 0) {
        IndexViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        Movie *movie = array[indexPath.row];
        cell.movie = movie;
        return cell;
    }else if (indexPath.section == 2) {
        TechnologyViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierTec forIndexPath:indexPath];
        cell1.contentView.backgroundColor = [UIColor whiteColor];
        Technology *tec = array[indexPath.row];
        cell1.technology = tec;
        return cell1;
    }else if (indexPath.section == 3) {
        MusicViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierMusic forIndexPath:indexPath];
        cell2.contentView.backgroundColor = [UIColor whiteColor];
        Music *music = array[indexPath.row];
        cell2.music = music;
        return cell2;
    }else{
        ArticleViewCell *cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierArticle forIndexPath:indexPath];
        cell3.contentView.backgroundColor = [UIColor whiteColor];
        Arcitle *article = array[indexPath.row];
        cell3.article = article;
        return cell3;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ScrollReusableView *resu = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewReusa" forIndexPath:indexPath];
        if (self.scrollImageArray.count == 0) {
            [self.scrollImageArray addObject:@"http://cdn.aixifan.com/dotnet/artemis/u/cms/www/201505/13170517ry4t.jpg"];
            [self.scrollImageArray addObject:@"http://cdn.aixifan.com/dotnet/artemis/u/cms/www/201506/18165228608q.jpg"];
            [self.scrollImageArray addObject:@"http://cdn.aixifan.com/dotnet/artemis/u/cms/www/201511/07232848rrog3wjj.jpg"];
            [self.scrollImageArray addObject:@"图片一"];
            [self.scrollImageArray addObject:@"图片二"];
            [self.scrollImageArray addObject:@"图片三"];
        }else{
            resu.imageURLArray = _scrollImageArray;
            resu.imageTitleArray = _scrollTitleArray;
            resu.lblTitle.text = _sectionArray[indexPath.section];
            resu.option = ^(NSString *option){
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MovieViewController *movieVC = [sb instantiateViewControllerWithIdentifier:@"movieVC"];
                [self.navigationController pushViewController:movieVC animated:YES];
            };
        }
        return resu;
    }
    CustomReusableView *resu = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReusa" forIndexPath:indexPath];
    resu.lblTitle.text = _sectionArray[indexPath.section];
    resu.option = ^(NSString *option){
        if ([option isEqualToString:@"文章更新"]) {
            ArticleTableViewController *articleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"articleVC"];
            [self.navigationController pushViewController:articleVC animated:YES];
        }else if ([option isEqualToString:@"最新科技"]){
            TechnologyTableViewController *technologyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"technologyVC"];
            [self.navigationController pushViewController:technologyVC animated:YES];
        }else if ([option isEqualToString:@"音乐推荐"]){
            MusicTableViewController *musicVC = [self.storyboard instantiateViewControllerWithIdentifier:@"musicVC"];
            [self.navigationController pushViewController:musicVC animated:YES];
        }
    };
    return resu;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PlayViewController *playVC = [PlayViewController sharedPlayViewController];
    if (indexPath.section == 0) {
        playVC.playType = 0;
        NSArray *array = self.dataDict[_sectionArray[indexPath.section]];
        Movie *movie = array[indexPath.row];
        playVC.playId = movie.Id;
        [self.navigationController pushViewController:playVC animated:YES];
    }else if (indexPath.section == 1) {
        playVC.playType = 1;
        NSArray *array = self.dataDict[_sectionArray[indexPath.section]];
        Arcitle *article = array[indexPath.row];
        playVC.playId = article.contentId;
        [self.navigationController pushViewController:playVC animated:YES];
    }else if (indexPath.section == 2) {
        playVC.playType = 2;
        NSArray *array = self.dataDict[_sectionArray[indexPath.section]];
        Technology *technology = array[indexPath.row];
        playVC.playId = technology.contentId;
        [self.navigationController pushViewController:playVC animated:YES];
    }else if (indexPath.section == 3) {
        playVC.playType = 3;
        NSArray *array = self.dataDict[_sectionArray[indexPath.section]];
        Music *music = array[indexPath.row];
        playVC.playId = music.contentId;
        [self.navigationController pushViewController:playVC animated:YES];
    }
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

//
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return CGSizeMake(windowWidth - 20, 110);
    }
    return CGSizeMake((windowWidth - 30) / 2.0, 140);
}
//
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return 0;
    }
    return 10;
}
//
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(windowWidth, 260);
    }
    return CGSizeMake(windowWidth, 30);
}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//}

- (IBAction)openLeft:(UIBarButtonItem *)sender {
    
}


#pragma mark -lazyLoad
- (NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

@end
