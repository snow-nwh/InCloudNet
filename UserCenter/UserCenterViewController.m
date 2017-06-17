//
//  UserCenterViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/20.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *detailTableView;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *detailData;

@end

@implementation UserCenterViewController
{
    CGRect _originFrame;
    CGPoint _originCenter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.headView.backgroundColor = [UIColor greenColor];
    _originFrame = self.headView.frame;
    _originCenter = self.headView.center;
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"全部",@"1号线",@"2号线",@"3号线",@"4号线",@"5号线", nil];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.frame.size.width/3,
                                                                  self.view.frame.size.height)
                                                 style:UITableViewStylePlain];
//    self.tableView.tableHeaderView = self.headView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    
    [self.view addSubview:self.tableView];
    
    self.detailData = [NSMutableArray arrayWithObjects:@"b",@"c",@"d",@"e",@"f",@"g", nil];
    
    self.detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 64, self.view.frame.size.width*2/3, self.view.frame.size.height)
                                                       style:UITableViewStyleGrouped];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.detailTableView.rowHeight = 50;
    self.detailTableView.sectionIndexColor = [UIColor lightGrayColor];
//    self.detailTableView.sectionIndexBackgroundColor = [UIColor blueColor];
    self.detailTableView.sectionIndexMinimumDisplayRowCount = 5;
    
    [self.view addSubview:self.detailTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return 1;
    }
    return self.detailData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.dataSource.count;
    } else {
        return self.detailData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (tableView == self.tableView) {
        cell.backgroundColor = [UIColor lightTextColor];
        NSString *string = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = string;
        
    } else {
        NSString *string = [self.detailData objectAtIndex:indexPath.row];
        cell.textLabel.text = string;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return nil;
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    NSString *string = [self.detailData objectAtIndex:section];
    label.text = string;
    return label;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return nil;
    } else {
        return self.detailData;
    }
}

#pragma mark - UITableViewDelegate


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat y = scrollView.contentOffset.y;
//    NSLog(@"%f",y);
//    if (y < -63.0f) {
//        //下拉
//        _headView.frame = CGRectMake(0,
//                                     y,
//                                    _originFrame.size.width*(_originFrame.size.height -y)/_originFrame.size.height,
//                                    _originFrame.size.height -y);
//        CGPoint centerNew = CGPointMake(_originCenter.x, _originCenter.y+y/2);
//        _headView.center = centerNew;
//        self.navigationController.navigationBar.alpha = 1;
//        
//    }
//    else if(y > 0) {
//        self.navigationController.navigationBar.alpha = 0;
//    }
//    else {
//        //上拉
//        self.navigationController.navigationBar.alpha = 64/10/(y+63);
//    }
//}


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
