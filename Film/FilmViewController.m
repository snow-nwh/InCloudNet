//
//  FilmViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/20.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "FilmViewController.h"
#import "FilmDetailViewController.h"
#import "AFHTTPSessionManager.h"
#import "ImageModel.h"
#import "UIImageView+WebCache.h"
#import "BQWaterLayout.h"
#import "HJCarouselViewLayout.h"

@interface FilmViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) BQWaterLayout *waterLayout;

@end

@implementation FilmViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"娱乐";
    
    [self getData];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.waterLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}



- (BQWaterLayout *)waterLayout {
    if (_waterLayout == nil) {
        //layout内部有设置默认属性
        _waterLayout = [[BQWaterLayout alloc] init];
        _waterLayout.rowSpacing = 5;
        _waterLayout.lineSpacing = 5;
        
        //计算每个item高度方法，必须实现（也可以设计为代理实现）
        __weak typeof(self) weakSelf = self;
        [_waterLayout computeIndexCellSizeWithWidthBlock:^CGSize(NSIndexPath *indexPath) {
            ImageModel *model = weakSelf.dataSource[indexPath.row];
            return CGSizeMake([model.thumbWidth floatValue], [model.thumbHeight floatValue]);
        }];
        //内间距
        _waterLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    }
    return _waterLayout;
}

- (void)getData {
    {
        static int page = 0;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/javascript", nil];
        
        NSString *urlString = [NSString stringWithFormat:@"http://image.so.com/j?q=mobike&sn=%d&pn=50",page++];
        [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            ;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
            NSArray *array = [NSArray arrayWithArray:responseObject[@"list"]];
            for (NSDictionary *dic in array) {
                ImageModel *model = [[ImageModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:model];
            }
            
            [self.collectionView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"错误 -> %@",error.localizedDescription);
        }];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    ImageModel *model = self.dataSource[indexPath.item];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model._thumb]];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 20)/3, (self.view.frame.size.width -20)/3);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.item);
    FilmDetailViewController *detail = [[FilmDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
//    self.hidesBottomBarWhenPushed = YES;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 0, 0, 5);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height) {
        [self getData];
    }
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
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

@end
